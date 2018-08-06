package com.danusys.platform.helper;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.KeyManagementException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.UnrecoverableKeyException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;






import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.HttpResponseException;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicHeader;
import org.apache.http.ssl.SSLContexts;
import org.apache.http.util.EntityUtils;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.json.JSONObject;

import com.danusys.platform.web.JSONResult;
import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.rte.fdl.idgnr.impl.Base64;

public class HttpHelper {
	private final static String TAG = HttpHelper.class.getSimpleName();
	private static HttpHelper instance;
	private static HttpClient mClient = new DefaultHttpClient();
	private static ObjectMapper mObjectMapper = new ObjectMapper();
	
	public HttpHelper() {
		try { // SSL 처리 고민할 것
			TrustManager easyTrustManager = new X509TrustManager() {
	            public X509Certificate[] getAcceptedIssuers() {
	                // no-op
	                return null;
	            }

	            public void checkServerTrusted(X509Certificate[] chain,
	                    String authType) throws CertificateException {
	            }

	            public void checkClientTrusted(X509Certificate[] chain,
	                    String authType) throws CertificateException {
	            }
	        };
	        
	        SSLContext sslcontext = SSLContext.getInstance("TLS");
	        
	        sslcontext.init(null, new TrustManager[] { easyTrustManager }, null);
	        
            SSLSocketFactory socketFactory = new SSLSocketFactory(sslcontext,SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
            
            Scheme sch = new Scheme("https", 443, socketFactory);
            mClient.getConnectionManager().getSchemeRegistry().register(sch);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public synchronized static HttpHelper getInstance() {
		if(instance == null) {
			instance = new HttpHelper();
		}
		return instance;
	}

	public interface JSONRequestCallBack {
		void onSuccess(String response, JSONResult result);
		void onFailure(int statusCode, Throwable e, String response);
		void onFinish();
	}
	
	public void sendHttpRequest(final String url, JSONObject params, String method, final JSONRequestCallBack callback){
		System.out.println("sendHttpRequest() start!!!");
		String contentType = "";
		StringEntity entity = null;
		
//		System.out.println("================http request================");
		if(params != null && params.length() > 0) {
			contentType = "application/json";
			try {
				entity = new StringEntity(params.toString(), "utf-8");
			} catch (Exception e1) {
				System.out.println("UnsupportedEncodingException");
				//e1.printStackTrace();
			}
		} 
		
		// add http header
		Header[] header = getHeader(url, method, entity);
		
//		for(int i=0; i<header.length; i++) {
//			System.out.println("request header : " + header[i].getName() + " : " + header[i].getValue());
//		}
//		System.out.println("================http request================");
		
		HttpResponse response = null;
		BufferedReader rd = null;
		try{
			if(method.toUpperCase().equals("POST")) {
				System.out.println("sendHttpRequest() POST!!!");
				HttpPost post = new HttpPost(url);
				for(int i = 0; i < header.length; i++)
					post.addHeader(header[i]);
				post.setEntity(entity);
				response = mClient.execute(post);
			} else if(method.toUpperCase().equals("PUT")) {
				HttpPut post = new HttpPut(url);
				for(int i = 0; i < header.length; i++)
					post.addHeader(header[i]);
				post.setEntity(entity);
				response = mClient.execute(post);
			} else if(method.toUpperCase().equals("DELETE")) {
				HttpDelete post = new HttpDelete(url);
				for(int i = 0; i < header.length; i++)
					post.addHeader(header[i]);
				response = mClient.execute(post);
			} else {
				HttpGet post = new HttpGet(url);
				for(int i = 0; i < header.length; i++)
					post.addHeader(header[i]);
				response = mClient.execute(post);
			}
			
			rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
		    String line = "";
		    while ((line = rd.readLine()) != null) {
		    	System.out.println(line);
		    }
		} catch(Exception ex){
			ex.printStackTrace();
		} finally {
			try {
				System.out.println("sendHttpRequest!! close~!");
				//response.getEntity().getContent().close();
				rd.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	private Header[] getHeader(String url, String method, StringEntity entity) {
		String customDate = getCustomDate();
		
		String accessKeyID = "a2e7737d-860f-4768-b696-7c0c06ef8de1";
		String secretAccessKey = "4e904ea1-5594-447e-944f-a025960520e8";
		
		String signature = "";
		if(entity == null) {
			signature = hmacSha1Digest(getStringToSign(method, "", "", customDate, url), secretAccessKey);
		} else {
			try {
				signature = hmacSha1Digest(getStringToSign(method, EntityUtils.toString(entity), "application/json", customDate, url), secretAccessKey);
			} catch (ParseException e) {
				System.out.println("ParseException");
			} catch (IOException e) {
				System.out.println("IOException");
			}
		}

		String authorization = "PWS " + accessKeyID + ":" + signature;
		authorization = "PWS a2e7737d-860f-4768-b696-7c0c06ef8de1:G23U2ux5LYOiV9aot69t+BFuCi8=";
		Header[] headers = {
			    new BasicHeader("x-custom-date", customDate)
			    ,new BasicHeader("Authorization", authorization)
			};
		
		return headers;
	}
	
	private String getStringToSign(String method, String content, String contentType, String customDate, String url) {
		String result = "";
		try {
			URL aUrl = new URL(url);
			
			result = method + "\n" + 
					getCryptoMD5String(content) + "\n" + 
					contentType + "\n" + 
					customDate + "\n" +
					aUrl.getPath();
			
			//result = "test_daedol";
			
			result = new String(result.getBytes("utf-8"), "utf-8");
//			System.out.println("content : " + content);
//			System.out.println("content MD5 : " + getCryptoMD5String(content));
//			System.out.println("stringToSign : " + result);
		} catch(UnsupportedEncodingException e) {
			System.out.println("UnsupportedEncodingException");
		} catch (MalformedURLException e) {
			System.out.println("MalformedURLException");
		}
		
		return result;
	}
	
	private String getCustomDate() {
		String customDate = "";
		
		Date now = new Date();
		SimpleDateFormat format = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'", Locale.US);
		format.setTimeZone(TimeZone.getTimeZone("GMT"));
		customDate = format.format(now);
		
		return customDate;
	}

	/**
	 * 
	 * @param original
	 * @param key
	 * @return "" if fails
	 */
	public static String hmacSha1Digest(String original, String key) {
		return hmacSha1Digest(original.getBytes(), key.getBytes());
	}

	/**
	 * 
	 * @param original
	 * @param key
	 * @return "" if fails
	 */
	public static String hmacSha1Digest(byte[] original, byte[] key) {
		try {
			Mac mac = Mac.getInstance("HmacSHA1");
			mac.init(new SecretKeySpec(key, "HmacSHA1"));
			byte[] rawHmac = mac.doFinal(original);
			return new String(Base64.encode(rawHmac));
		} catch (NoSuchAlgorithmException e) {
			System.out.println("NoSuchAlgorithmException");
		} catch (InvalidKeyException e) {
			System.out.println("InvalidKeyException");
		} catch (IllegalArgumentException e) {
			System.out.println("IllegalArgumentException");
		}
		return "";
	}

	public static String getCryptoMD5String(String value) {
		String result = "";
        if(value != null && !value.equals("")) {
        	MessageDigest md;
			try {
				md = MessageDigest.getInstance("MD5");
				byte[] ret = md.digest(value.getBytes());
	            result = new String(Base64.encode(ret));    
			} catch (NoSuchAlgorithmException e) {
				System.out.println("NoSuchAlgorithmException");
			}
        }
        return result;	
    }
}
