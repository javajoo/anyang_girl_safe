package com.danusys.platform.helper;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javapns.Push;
import javapns.notification.PushNotificationPayload;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
//import org.apache.jasper.tagplugins.jstl.core.ForEach;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.google.android.gcm.server.Constants;
import com.google.android.gcm.server.Message;
import com.google.android.gcm.server.Message.Builder;
import com.google.android.gcm.server.MulticastResult;
import com.google.android.gcm.server.Result;
import com.google.android.gcm.server.Sender;

public class PushGateServer {
	private Map<String, Object> infoMap;

	private final String API_KEY = "AIzaSyBb0niWPreO0iLXNQmF-uNrgSf531yoCHI";
	private final String password = "1234";

    private static final int DEFAULT_TIME_TO_LIVE = 60 * 20; // 10 min
    private static final int DEFAULT_RETRIES = 5;

    private static final String RESULT_STATUS = "status";
    private static final String RESULT_ERROR_CODE = "error_code";

    private static final String RESULT_SUCCESS_COUNT = "success_count";
    private static final String RESULT_FAIL_COUNT = "fail_count";
    private static final String RESULT_ERROR_COUNT = "error_count";
    private static final String RESULT_TOTAL_COUNT = "total_count";
    private static final String RESULT_CANONICAL_ID_COUNT = "canonical_id_count";
    private static final String RESULT_MULTICAST_IDS = "multicast_ids";
    private static final String RESULT_RAW_RESULTS = "raw_results";

    private static final String STATUS_SUCCESS = "success";
    private static final String STATUS_ERROR = "error";

    private static final String ERROR_ILLEGAL_ARGS = "illegal_argument";

    @SuppressWarnings({
            "unchecked", "rawtypes"
    })
	
	public PushGateServer(String msg, String pid, List<String> devices, String url)
	{
		Map<String, String> dataMap = new HashMap<String, String>();
		try {
			if(url.startsWith("APNS://")) {
				dataMap.put("message", msg);  
			}
			else
				dataMap.put("message", URLEncoder.encode(msg, "UTF-8"));
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dataMap.put("pid", pid);
		dataMap.put("type", "alarm"); 

		infoMap = new HashMap<String, Object>();
		infoMap.put("DATA", dataMap);
		infoMap.put("DEVICES", devices);
		infoMap.put("URL", url);
	}
	
	public void Run() throws Exception {

		Map<String, Object> contents = null;
		
		try
		{
			contents = (Map<String, Object>) getUrlContents(infoMap);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				String resMsg = (String)contents.get(RESULT_STATUS);
				System.out.println("result msg=[" + resMsg + "]");
	
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public Object getUrlContents(Map infoMap) throws Exception {

        Map<String, Object> result = new HashMap<String, Object>();

        // get data
        Map<String, String> data = (Map<String, String>) infoMap.get("DATA");
        List<String> deviceList = (List<String>) infoMap.get("DEVICES");

		String strUrl = (String) infoMap.get("URL");

		if (strUrl == null) {
			throw new IllegalArgumentException("URL is null!!");
		}

		if(strUrl.startsWith("APNS://")){
			System.out.println("[apns] : well be handle by " + getClass());
			String message = (String) data.get("message");
			String pid = (String) data.get("pid");
			String keystore = null;
			Map extraData  = (Map) infoMap.get("EXTRA_DATA");
			
			PushNotificationPayload apns;
			System.out.println("[apns] : recev device list size is " + (deviceList != null ? deviceList.size() : 0));
			String OS = System.getProperty("os.name", "generic").toLowerCase(Locale.ENGLISH);
		    if (OS.indexOf("win") >= 0) {
		    	keystore = "C:/safeguide/key/apns_prod.p12";
		    } else {
		    	keystore = "/tmp/safeguide/key/apns_prod.p12";
		    }
			try {

				apns = new PushNotificationPayload(message, 0, "sound.WAV");
				apns.addCustomDictionary("title", "안심귀가알림");
				apns.addCustomDictionary("PID", pid);
				if(extraData != null) {
					Set<String> keys = extraData.keySet();
					for(String key : keys) {
						apns.addCustomDictionary(key, (String) extraData.get(key));
					}
				}

				Push.payload(apns, keystore, password, true, 20, deviceList);
			} catch (Exception e) {
				e.printStackTrace();
			}

			result.put(RESULT_STATUS, STATUS_SUCCESS);
		}
		else {
			String url = "https://gcm-http.googleapis.com/gcm/send";
			
			JSONObject json = new JSONObject(); 
			JSONObject json1 = new JSONObject();    
			JSONArray jsonArray = new JSONArray();
			
			for (String regId  : deviceList) {
				jsonArray.add(regId);
			}
			 
		    json.put("registration_ids",jsonArray);   
			 
			// populate message
			String msg = "안심귀가알림";
			json1.put("title", URLEncoder.encode(msg, "UTF-8"));
			
	        if (data != null) {
	            Set<String> keys = data.keySet();
	            for (String key : keys) {
	            	System.out.println("add data--->key=" + key + " data=" + data.get(key));
	            	json1.put(key, data.get(key));
	            }
	        }
			
			json.put("data", json1);         
			 
			final CloseableHttpClient httpClient = HttpClientBuilder.create().build();
			
			try{
				//Create POST request
				final HttpPost request = new HttpPost(url);     
				request.setHeader("Content-type", "application/json"); 
				request.setHeader("Authorization", "Key="+API_KEY);    
				StringEntity params = new StringEntity(json.toString());        
				request.setEntity(params);      
				
				// get response from server
				HttpResponse response = httpClient.execute(request);       
				String mresult = EntityUtils.toString(response.getEntity());        
			 
				System.out.println("result........" +mresult); 
		        result.put(RESULT_STATUS, STATUS_SUCCESS);
			}catch (Exception ex) {     
		        result.put(RESULT_STATUS, STATUS_ERROR);
				ex.printStackTrace();  
			} finally{     
				if(httpClient != null){         
					try {      
			          httpClient.close();    
			        } catch (IOException e) { 
			               e.printStackTrace();       
			        }       
				}  
			}

	        System.out.println("<<<<<<<<<<<<<<<<<<<<< gcm finish..");
	        
	        // build push message
	        Builder builder = new Builder();

	        if (data != null) {
	            Set<String> keys = data.keySet();
	            for (String key : keys) {
	            	System.out.println("add data--->key=" + key + " data=" + data.get(key));
	                builder.addData(key, data.get(key));
	            }
	        }
		}

        return result;		
	}
	
}
