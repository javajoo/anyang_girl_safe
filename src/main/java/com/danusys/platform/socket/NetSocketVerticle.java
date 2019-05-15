package com.danusys.platform.socket;

import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.net.SocketException;
import java.net.SocketTimeoutException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;

import org.apache.commons.codec.binary.Base64;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Component;
import org.vertx.java.core.Handler;
import org.vertx.java.core.Vertx;
import org.vertx.java.core.buffer.Buffer;
import org.vertx.java.core.json.JsonObject;
import org.vertx.java.core.net.NetServer;
import org.vertx.java.core.net.NetSocket;

import com.danusys.cmm.util.CommonUtil;
import com.danusys.cmm.util.JsonUtil;
import com.danusys.platform.west.service.GirlSafeService;
import com.danusys.platform.west.service.GirlSafeVO;



import com.danusys.service.BaseService;
import com.danusys.sms.api.ApiClass;
import com.danusys.sms.api.ApiResult;
import com.danusys.sms.service.SmsInfoService;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Component
public class NetSocketVerticle extends DefaultEmbeddableVerticle {
	private static Logger logger = LogManager
			.getLogger(NetSocketVerticle.class);
	private static String delimeterMsg = "\036";
	private static String delimeter1F = "\037";
	private static String fclt_st_update_yn = "N";
	@Resource(name = "config")
	private Properties config;
	private int event_port = 10026;
	@Resource(name = "webSocketVerticle")
	private WebSocketVerticle webSocketVerticle;
	private NetServer netServer;
	@Autowired
    private BaseService baseService;
	private String smsServer = "58.76.192.101";//"172.20.14.6";//"211.220.152.67";
    private int smsPort = 10032;
    private String gisServer = "58.76.192.118";//"172.20.14.41";//"172.20.14.6";//"211.220.152.67";
    private int gisPort = 9000;
    private String appHostname = "58.76.192.101";//"49.236.137.134";//"172.20.14.6";//"211.220.152.67";
    private int appPort = 10024;
    @Resource(name="smsInfoService")
    private SmsInfoService smsInfoService;

	public void start(Vertx vertx) {
		try {
			this.event_port = Integer.parseInt(this.config.getProperty(
					"event_port").trim());
		} catch (Exception e) {
			logger.info(
					"event_port exception : {}===={}",
					new Object[] {
							this.config.getProperty("event_port").trim(),
							e.getMessage() });
			this.event_port = 10026;
		}
		logger.info(" ==== NetSocket Server Start ==== {}",
				new Object[] { Integer.valueOf(this.event_port) });
		this.netServer = vertx.createNetServer();
		this.netServer.connectHandler(new Handler<NetSocket>() {
			public void handle(final NetSocket netSocket) {
				NetSocketVerticle.logger.info("connect : "
						+ netSocket.remoteAddress());

				netSocket.dataHandler(new Handler<Buffer>() {
					@Autowired
					public void handle(Buffer buffer) {
						
						byte[] lengthChk = buffer.getBytes();
						String result;
						result = buffer.toString("UTF-8");
						System.out.println(result);
						checkEvent(result, netSocket);
					}
				});
				netSocket.closeHandler(new Handler<Void>() {
					public void handle(Void arg0) {
						NetSocketVerticle.logger.info("closed : "
								+ netSocket.remoteAddress());
					}
				});
			}
		}).listen(this.event_port);

		Runtime.getRuntime().addShutdownHook(new Thread() {
			@Override
			public void run() {
				synchronized (netServer) {
					netServer.close();
				}
			}
		});

	}
	
	public String checkEvent(String msg, NetSocket netSocket) {
		String result = "";		
		msg = msg.replaceAll("\\r|\\n", "");
		
		if (msg.contains("SMART")) {
			result = msg;
			smartEvent(result, netSocket);
		}
		else if(msg.contains("SENSOR")){
			result = msg;
			sensorEvent(result, netSocket);
		}
		else if(msg.contains("TEST")){
			result = msg;
			testEvent(result, netSocket);
		}
		else if(msg.contains("CLEAR")){
			result = msg;
			eventClear(result, netSocket);
		}
		else if(msg.contains("SMS")){
			result = msg;
			smsInsert(result, netSocket);
		}
		else {
//			testGis(msg, netSocket);
//			System.out.println("2");
//			result = msgParseDuc(msg);
//			emitEventDuc(result, netSocket);
		}
		return result;
	}
	

	public void emitEventDuc(String msg, NetSocket netSocket) {
		netSocket.write(msg);
	}
	
//	public void testGis(String msg, NetSocket netSocket) {
//		Map<String,Object> map = new HashMap<String,Object>();
//	    String[] msgArray = msg
//	      .split(":");
//	    SimpleDateFormat sf = new SimpleDateFormat("yyyy:MM:dd:HH:mm:ss");
//	    String rslt = sf.format(new Date());
//	    String pointX = "126.953631";
//	    String pointY = "37.387792";
//	    String name = "홍길동";
//	    String phoneNumber = "01012345678";
//	    String address = "주소입니다.";
//	    String age = "30";
//	    String protName = "활빈당";
//	    String protPhoneNumber = "01045678901";
//	    String protAddress = "보호자 주소입니다.";
//	    String protRelation = "보호자 관계";
//	    String time = rslt;
//	    String endYN = msgArray[1];
//	    String serviceType = msgArray[0];
//	    String driverKind = "0";
//	    String type = "112";
//	    String aptName = "푸르지오아파트1단지";
//	    String carNumber = "65허1234";
//	    String purpose = "스토커";
//
//	    if ("G".equals(msgArray[0])) {
//	      map.put("pointX", pointX);
//	      map.put("pointY", pointY);
//	      map.put("name", name);
//	      map.put("phoneNumber", phoneNumber);
//	      map.put("address", address);
//	      map.put("age", age);
//	      map.put("protName", protName);
//	      map.put("protPhoneNumber", protPhoneNumber);
//	      map.put("protAddress", protAddress);
//	      map.put("protRelation", protRelation);
//	      map.put("time", time);
//	      map.put("endYN", endYN);
//	      map.put("serviceType", serviceType);
//	      send(map);
//	    }
//	    else if ("T".equals(msgArray[0])) {
//	      map.put("pointX", pointX);
//	      map.put("pointY", pointY);
//	      map.put("name", name);
//	      map.put("phoneNumber", phoneNumber);
//	      map.put("driverKind", driverKind);
//	      map.put("type", type);
//	      map.put("time", time);
//	      map.put("endYN", endYN);
//	      map.put("serviceType", serviceType);
//	      send(map);
//	    }
//	    else if ("P".equals(msgArray[0])) {
//	      map.put("pointX", pointX);
//	      map.put("pointY", pointY);
//	      map.put("name", name);
//	      map.put("phoneNumber", phoneNumber);
//	      map.put("address", address);
//	      map.put("aptName", aptName);
//	      map.put("carNumber", carNumber);
//	      map.put("purpose", purpose);
//	      map.put("protName", protName);
//	      map.put("protPhoneNumber", protPhoneNumber);
//	      map.put("protAddress", protAddress);
//	      map.put("protRelation", protRelation);
//	      map.put("time", time);
//	      map.put("endYN", endYN);
//	      map.put("serviceType", serviceType);
//	      send(map);
//	    }
//	  }
	
	
	
	public void smartEvent(String msg, NetSocket netSocket) {
		msg.replaceAll("\\r|\\n", "");
		String[] msgArray = msg
				.split(",");
		Map<String,Object> map = new HashMap<String,Object>();
		String sensorId = msgArray[1];
		
		map.put("sensorId", sensorId);
		List<Map<String,Object>> eventList = NetSocketVerticle.this.baseService
				.baseSelectList("girlSafe.getEvent",map);
		if (msgArray.length == 3) {
			
			map.put("division", "smart");
			map.put("emergency", "1");

			try {
				
				sendSms(eventList);
				sendGis(eventList);
				Map<String,Object> event = eventList.get(0);
				JsonObject obj = new JsonObject(event);
				//send(obj);
				NetSocketVerticle.logger.info(obj
						.toString());

				NetSocketVerticle.this.webSocketVerticle
						.getIo().sockets()
						.emit("response", obj);

//				netSocket.write("00000");
//				netSocket.write("\n");
				NetSocketVerticle.logger
						.info("received socket message 4: OK");
			}  catch (Exception e) {
//				netSocket.write("11111");
//				netSocket.write("\n");
				NetSocketVerticle.logger
						.info("received socket message 63: ERROR"
								+ e.getMessage());
				NetSocketVerticle.logger.error(
						"handle Exception : {} ",
						new Object[] { e.getMessage() });
			}
		}
//		else if(msgArray.length == 5){
//			String pointY = msgArray[3];
//			String pointX = msgArray[4];
//			
//			map.put("emergency", "1");
//			map.put("pointY", pointY);
//			map.put("pointX", pointX);
//			try {
//			
//				NetSocketVerticle.this.baseService
//						.baseUpdate("girlSafe.updateEmergency", map);
//				NetSocketVerticle.this.baseService
//						.baseInsert("girlSafe.insertEvent", map);
//				/*List<Map<String,Object>> eventList = NetSocketVerticle.this.baseService
//						.baseSelectList("girlSafe.getHwInfo",map);
//				Map<String,Object> event = CommonUtil.ListToMap(eventList);*/
//				sendSms(eventList);
//				JsonObject obj = new JsonObject(map);
//				NetSocketVerticle.logger.info(obj
//						.toString());
//
//				NetSocketVerticle.this.webSocketVerticle
//						.getIo().sockets()
//						.emit("response", obj);
//
////				netSocket.write("00000");
////				netSocket.write("\n");
//				NetSocketVerticle.logger
//						.info("received socket message 4: OK");
//			} catch (SocketException e) {
////				netSocket.write("11111");
////				netSocket.write("\n");
//				NetSocketVerticle.logger
//						.info("received socket message 6: ERROR"
//								+ e.getMessage());
//				NetSocketVerticle.logger.error(
//						"handle SocketException : {} ",
//						new Object[] { e.getMessage() });
//			} catch (SocketTimeoutException e) {
////				netSocket.write("11111");
////				netSocket.write("\n");
//				NetSocketVerticle.logger
//						.info("received socket message 6: ERROR"
//								+ e.getMessage());
//				NetSocketVerticle.logger.error(
//						"handle SocketTimeoutException : {} ",
//						new Object[] { e.getMessage() });
//			} catch (Exception e) {
////				netSocket.write("11111");
////				netSocket.write("\n");
//				NetSocketVerticle.logger
//						.info("received socket message 6: ERROR"
//								+ e.getMessage());
//				NetSocketVerticle.logger.error(
//						"handle Exception : {} ",
//						new Object[] { e.getMessage() });
//			}
//		}
		else {
//			netSocket.write("11111");
//			netSocket.write("\n");
			NetSocketVerticle.logger
					.info("received socket message 7: ERROR");
		}
	}
	
	public void sensorEvent(String msg, NetSocket netSocket) {
		msg.replaceAll("\\r|\\n", "");
		String[] msgArray = msg.split(",");
		Map<String,Object> map = new HashMap<String,Object>();
		String sensorId = msgArray[1];
		
		map.put("sensorId", sensorId);
		List<Map<String,Object>> eventList = NetSocketVerticle.this.baseService
				.baseSelectList("girlSafe.getEvent",map);
		if (msgArray.length == 5) {
			try {
				map.put("emergency", "1");
				/*List<Map<String,Object>> eventList = NetSocketVerticle.this.baseService
						.baseSelectList("girlSafe.getHwInfo",map);*/
				sendSms(eventList);
				sendGis(eventList);
				Map<String,Object> event = eventList.get(0);
				JsonObject obj = new JsonObject(event);
				NetSocketVerticle.logger.info(obj
						.toString());

				NetSocketVerticle.this.webSocketVerticle
						.getIo().sockets()
						.emit("response", obj);

//				netSocket.write("00000");
//				netSocket.write("\n");
				NetSocketVerticle.logger
						.info("received socket message 4: OK");
			}  catch (Exception e) {
//				netSocket.write("11111");
//				netSocket.write("\n");
				NetSocketVerticle.logger
						.info("received socket message 6: ERROR"
								+ e.getMessage());
				NetSocketVerticle.logger.error(
						"handle Exception : {} ",
						new Object[] { e.getMessage() });
			}
		}
//		else if(msgArray.length > 7){
//			String smartId = msgArray[4];
//			sensorId = msgArray[6];
//			String status = Integer.toString(Integer.parseInt(msgArray[7],16));
//			String bat = Integer.toString(Integer.parseInt(msgArray[8],16));
//		
//			map.put("smartId", smartId);
//			map.put("sensorId", sensorId);
//			map.put("status", status);
//			map.put("bat", bat);
//			try {
//				NetSocketVerticle.this.baseService
//				.baseUpdate("girlSafe.updateSensorStat", map);
////				List<Map<String,Object>> eventList = NetSocketVerticle.this.baseService
////				.baseSelectList("girlSafe.getHwInfo",map);
////				Map<String,Object> event = CommonUtil.ListToMap(eventList);
//				
//				JsonObject obj = new JsonObject(map);
//				NetSocketVerticle.logger.info(obj
//						.toString());
//
//				NetSocketVerticle.this.webSocketVerticle
//						.getIo().sockets()
//						.emit("response", obj);
//
////				netSocket.write("00000");
////				netSocket.write("\n");
//				NetSocketVerticle.logger
//						.info("received socket message 4: OK");
//			} catch (SocketException e) {
////				netSocket.write("11111");
////				netSocket.write("\n");
//				NetSocketVerticle.logger
//						.info("received socket message 6: ERROR"
//								+ e.getMessage());
//				NetSocketVerticle.logger.error(
//						"handle SocketException : {} ",
//						new Object[] { e.getMessage() });
//			} catch (SocketTimeoutException e) {
////				netSocket.write("11111");
////				netSocket.write("\n");
//				NetSocketVerticle.logger
//						.info("received socket message 6: ERROR"
//								+ e.getMessage());
//				NetSocketVerticle.logger.error(
//						"handle SocketTimeoutException : {} ",
//						new Object[] { e.getMessage() });
//			} catch (Exception e) {
////				netSocket.write("11111");
////				netSocket.write("\n");
//				NetSocketVerticle.logger
//						.info("received socket message 6: ERROR"
//								+ e.getMessage());
//				NetSocketVerticle.logger.error(
//						"handle Exception : {} ",
//						new Object[] { e.getMessage() });
//			}
//			}		
		else {
//			netSocket.write("11111");
//			netSocket.write("\n");
			NetSocketVerticle.logger
					.info("received socket message 7: ERROR");
		}
	}
	
	public void testEvent(String msg, NetSocket netSocket) {
		msg.replaceAll("\\r|\\n", "");
		String[] msgArray = msg.split(",");
		Map<String,Object> map = new HashMap<String,Object>();
		String sensorId = msgArray[1];
		
		map.put("sensorId", sensorId);
		List<Map<String,Object>> eventList = NetSocketVerticle.this.baseService
				.baseSelectList("girlSafe.getEvent",map);
		if (msgArray.length == 5) {
			try {
				map.put("emergency", "2");
				/*List<Map<String,Object>> eventList = NetSocketVerticle.this.baseService
						.baseSelectList("girlSafe.getHwInfo",map);*/
				sendGis(eventList);
				Map<String,Object> event = eventList.get(0);
				JsonObject obj = new JsonObject(event);
				NetSocketVerticle.logger.info(obj
						.toString());

				NetSocketVerticle.this.webSocketVerticle
						.getIo().sockets()
						.emit("response", obj);

//				netSocket.write("00000");
//				netSocket.write("\n");
				NetSocketVerticle.logger
						.info("received socket message 4: OK");
			}  catch (Exception e) {
//				netSocket.write("11111");
//				netSocket.write("\n");
				NetSocketVerticle.logger
						.info("received socket message 6: ERROR"
								+ e.getMessage());
				NetSocketVerticle.logger.error(
						"handle Exception : {} ",
						new Object[] { e.getMessage() });
			}
		}
		else {
//			netSocket.write("11111");
//			netSocket.write("\n");
			NetSocketVerticle.logger
					.info("received socket message 7: ERROR");
		}
	}
	
	
	public void eventClear(String msg, NetSocket netSocket) {
		msg.replaceAll("\\r|\\n", "");
		String[] msgArray = msg.split(",");
		Map<String,Object> map = new HashMap<String,Object>();
		String sensorId = msgArray[0];
		map.put("sensorId", sensorId);
		List<Map<String,Object>> eventList = NetSocketVerticle.this.baseService
				.baseSelectList("girlSafe.getClearEvent",map);
		if (msgArray.length == 3) {
			try {
				map.put("emergency", "0");
				/*List<Map<String,Object>> eventList = NetSocketVerticle.this.baseService
						.baseSelectList("girlSafe.getHwInfo",map);
*/
				sendGis(eventList);
				
				Map<String,Object> event = eventList.get(0);
				JsonObject obj = new JsonObject(event);
				NetSocketVerticle.logger.info(obj
						.toString());
				NetSocketVerticle.this.webSocketVerticle
						.getIo().sockets()
						.emit("response", obj);

//				netSocket.write("00000");
//				netSocket.write("\n");
				NetSocketVerticle.logger
						.info("received socket message 4: OK");
			}  catch (Exception e) {
//				netSocket.write("11111");
//				netSocket.write("\n");
				NetSocketVerticle.logger
						.info("received socket message 6: ERROR"
								+ e.getMessage());
				NetSocketVerticle.logger.error(
						"handle Exception : {} ",
						new Object[] { e.getMessage() });
			}
		}
		else {
//			netSocket.write("11111");
//			netSocket.write("\n");
			NetSocketVerticle.logger
					.info("received socket message 7: ERROR");
		}
	}
	
	
	public void smsInsert(String msg, NetSocket netSocket) {
		msg.replaceAll("\\r|\\n", "");
		String[] msgArray = msg.split(",");
		Map<String,Object> map = new HashMap<String,Object>();
		String name = msgArray[1];
		String content = msgArray[2];
		String sName = msgArray[3];
		String sPhoneNumber = msgArray[4];
		String phoneNumber = msgArray[5];
		if (msgArray.length == 6) {
			try {
				map.put("name", name);
				map.put("content", content);
				map.put("sName", sName);
				map.put("sPhoneNumber", sPhoneNumber);
				map.put("phoneNumber", phoneNumber);
				/*List<Map<String,Object>> eventList = NetSocketVerticle.this.baseService
						.baseSelectList("girlSafe.getHwInfo",map);
*/
				NetSocketVerticle.this.baseService
				.baseUpdate("girlSafe.insertSmsLog", map);
				
				
//				netSocket.write("00000");
//				netSocket.write("\n");
				NetSocketVerticle.logger
						.info("received socket message 4: OK");
			}  catch (Exception e) {
//				netSocket.write("11111");
//				netSocket.write("\n");
				NetSocketVerticle.logger
						.info("received socket message 6: ERROR"
								+ e.getMessage());
				NetSocketVerticle.logger.error(
						"handle Exception : {} ",
						new Object[] { e.getMessage() });
			}
		}
		else {
//			netSocket.write("11111");
//			netSocket.write("\n");
			NetSocketVerticle.logger
					.info("received socket message 7: ERROR");
		}
	}
	
	String UnitoStr(String uni)
	{
		String str = "" ;
		String msg = uni;
		String[] str1 = msg.split(" ");
				
		int chk = (Integer.parseInt(str1[2],16)+Integer.parseInt(str1[3],16));
		int chklength = (str1.length + 4);
		if(chk == chklength){
			for(int i=0;i<str1.length;i++){
				if((3 < i && i < 7) || i == str1.length){
					str += str1[i];
				}
				else{
					str += str1[i]+" ";
				}
			}
		}
		return str ;
	}
	
	String byteArrayToHex(byte[] a) {
	    StringBuilder sb = new StringBuilder();
	    for(final byte b: a)
	        sb.append(String.format("%02x ", b&0xff));
	    return sb.toString();
	}
	
	private void sendSms(List<Map<String,Object>> eventList){
    	
    	Socket socket = null;
    	BufferedWriter oos = null;
    	try{ // 서버가 가동되지 않는 환경에서는 막아둘 것
    		Map<String, Object> result = new HashMap<String, Object>();
    		String msg;
        	for(int i=0 ;i<eventList.size();i++){
	        	result = eventList.get(i);
	        	
	        	String name = (String)result.get("name");
	        	String content = name+"님 센서에 침입 감지가 되었습니다.";
	        	String rcvId = (String)result.get("sName");
		    	String rcvMobl = (String)result.get("sPhoneNumber");
		    	String phoneNumber = (String)result.get("phoneNumber");
		    	if(rcvMobl != null){
		        	socket = new Socket(smsServer , smsPort);
		        	oos = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), "utf-8"));//한글
		        	msg = "SAF,"+name+","+content+","+rcvId+","+rcvMobl+","+phoneNumber;
		        	System.out.println("asdfasdf||||||||||||||||"+msg);
		        	oos.write(msg);
					oos.flush();
					oos.close();
		    	}
        	}
    	}catch(Exception exx){
    		exx.printStackTrace();
    	}finally{
    		try{
    			oos.close();
    		}catch(Exception e){}

    		try{
    			socket.close();
    		}catch(Exception e){}
    	}
    }
	
	private Map<String, Integer> NowToJson()
    {
    	SimpleDateFormat sf = new SimpleDateFormat("yyyy:MM:dd:HH:mm:ss");
        String rslt = sf.format(new Date());
        
        Map<String, Integer> map = new HashMap<String, Integer>();
        
        String[] temp = rslt.split(":");

        map.put("year", Integer.parseInt(temp[0]));
        map.put("month", Integer.parseInt(temp[1]));
        map.put("day", Integer.parseInt(temp[2]));
        map.put("hour", Integer.parseInt(temp[3]));
        map.put("minute", Integer.parseInt(temp[4]));
        map.put("second", Integer.parseInt(temp[5]));
        
        return map;
    }
	
	
	
	 private void sendGis(List<Map<String,Object>> eventList) throws Exception {
		    ObjectMapper objectMapper = new ObjectMapper();
		    Socket socket = null;
		    BufferedWriter oos = null;
		    Map<String, Object> result = new HashMap<String, Object>();
		    Map<String, Object> msg = new HashMap<String, Object>();
		    SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		    String rslt = sf.format(new Date());
		    result = eventList.get(0);
		    String a = (String) (result.get("sensorConn"));
        	int b = Integer.parseInt(a);
        	
        	String type;
        	String name = (String) result.get("name");
		    String phoneNumber = (String) result.get("phoneNumber");
		    String address = (String) result.get("adres");
		    String birth = (String)result.get("birth");
		    String protName = (String) result.get("sName");
        	String protPhoneNumber = (String) result.get("sPhoneNumber");
        	String protRelation = (String) result.get("realationName");
        	String picture = (String) result.get("picture");
        	int no = (int) result.get("no");
        	String strNo = Integer.toString(no);
        	
        	int emergency = (int) result.get("emergency");
        	if(emergency > 1){
        		type = "테스트";
        	}
        	else{
        		type = "응급상황";
        	}
        	String pointX;
        	String pointY;
        	if(picture == null || "".equals(picture)){
        		picture="empty";
        	}
        	String basePicture = getBase64String(picture,"");
        	if(b > 0){
        		pointX = Double.toString((double)result.get("pointX"));
	        	pointY = Double.toString((double)result.get("pointY"));
        	}
        	else{
        		pointX = Double.toString((double)result.get("mPointX"));
	        	pointY = Double.toString((double)result.get("mPointY"));
        	}
//		    String rslt = sf.format(new Date());
        	if(name != null){
		    try
		    {
		    	msg.put("no",strNo);
	        	msg.put("name", name);
	        	msg.put("phoneNumber", phoneNumber);
	        	msg.put("address", address);
	        	msg.put("birth", birth);
	        	msg.put("type", type);
	        	msg.put("serviceType", "G");
	        	msg.put("time", rslt);
	        	//msg.put("picture",basePicture);
	        	msg.put("picture",basePicture);
	        	if(protPhoneNumber != null){
		        	msg.put("protName", protName);
		        	msg.put("protPhoneNumber", protPhoneNumber);
		        	msg.put("protRelation", protRelation);
	        	}
	        	else{
	        		msg.put("protName", " ");
		        	msg.put("protPhoneNumber", " ");
		        	msg.put("protRelation", " ");
	        	}
	        	msg.put("pointX",pointX);
	        	msg.put("pointY",pointY);
	        	if(emergency < 1){
	        		msg.put("endYN", "Y");
	        	}
	        	else{
	        		msg.put("endYN", "N");
	        	}
	        	System.out.println("aaaa||||||||"+msg);
		    	
		      socket = new Socket(this.gisServer, this.gisPort);

		      oos = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), "utf-8"));

		      String value = objectMapper.writeValueAsString(msg);
		      value = new String(value.getBytes("utf-8"), "utf-8");
		      oos.write(value+""+null);
		      oos.flush();
		      oos.close();
		    } catch (Exception exx) {
		      exx.printStackTrace();
		      try
		      {
		        oos.close();
		      } catch (Exception localException1) {
		      }
		      try {
		        socket.close();
		      }
		      catch (Exception localException2)
		      {
		      }
		    }
		    finally
		    {
		      try
		      {
		        oos.close();
		      } catch (Exception localException3) {
		      }
		      try {
		        socket.close();
		      } catch (Exception localException4) {
		      }
		    }
        	}
		  }
	 
	 
//	 private void sendGis(List<Map<String,Object>> eventList) throws Exception {
//		ObjectMapper objectMapper = new ObjectMapper();
//		Socket socket = null;
//		BufferedWriter oos = null;
//		Map<String, Object> result = new HashMap<String, Object>();
//		Map<String, Object> msg = new HashMap<String, Object>();
//		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		String rslt = sf.format(new Date());
//		result = eventList.get(0);
//		String a = (String) (result.get("sensorConn"));
//		int b = Integer.parseInt(a);
//		
//		String name = (String) result.get("name");
//		String phoneNumber = (String) result.get("phoneNumber");
//		String address = (String) result.get("adres");
//		String birth = (String)result.get("birth");
//		String protName = (String) result.get("sName");
//     	String protPhoneNumber = (String) result.get("sPhoneNumber");
//     	String protRelation = (String) result.get("realation");
//     	String picture = (String) result.get("picture");
//     	String endYN;
//     	int no = (int) result.get("no");
//     	String strNo = Integer.toString(no);
//     	
//     	int emergency = (int) result.get("emergency");
//     	String pointX;
//     	String pointY;
//     	String basePicture = getBase64String(picture,"");
//     	String resultMsg = "";
//     	if(b > 0){
//     		pointX = Double.toString((double)result.get("pointX"));
//	        	pointY = Double.toString((double)result.get("pointY"));
//     	}
//     	else{
//     		pointX = Double.toString((double)result.get("mPointX"));
//	        	pointY = Double.toString((double)result.get("mPointY"));
//     	}
////		    String rslt = sf.format(new Date());
//		    try
//		    {
//	        	if(protPhoneNumber == null){
//	        		protName = " ";
//	        		protPhoneNumber = " ";
//	        		protRelation = " ";
//	        	}
//	        	if(emergency < 1){
//	        		endYN = "Y";
//	        	}
//	        	else{
//	        		endYN = "N";
//	        	}
//	        	resultMsg = "<?xml version=\"1.0\" encoding=\"UTF-16\" ?>"+
//	        	"<ngvms:envelope xmlns:ngvms=\"http://schema.danusys.com/ngvms/envelope\" recipient=\"0\" timestamp=\"0\">"+
//	        	"<SET_EMERGENCY_STATE_START_REQ>"+
//	        	"<serviceType>G</serviceType>"+
//	        	"<pointY>"+pointY+"</pointY>"+
//	        	"<pointX>"+pointX+"</pointX>"+
//	        	"<picture>"+basePicture+"</picture>"+
//	        	"<name>"+name+"</name>"+
//	        	"<phoneNumber>"+phoneNumber+"</phoneNumber>"+
//	        	"<address>"+address+"</address>"+
//	        	"<birth>"+birth+"</birth>"+
//	        	"<protName>"+protName+"</protName>"+
//	        	"<protPhoneNumber>"+protPhoneNumber+"</protPhoneNumber>"+
//	        	"<protRelation>"+protRelation+"</protRelation>"+
//	        	"<time>"+rslt+"</time>"+
//	        	"<endYN>"+endYN+"</endYN>"+
//	        	"<no>"+strNo+"</no>"+
//	        	"</SET_EMERGENCY_STATE_START_REQ>"+
//	        	"</ngvms:envelope>";
//	        	
//	        	System.out.println("aaaa||||||||"+resultMsg);
//		    	
//		      socket = new Socket(this.gisServer, this.gisPort);
//
//		      oos = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), "utf-8"));
//
////		      String value = objectMapper.writeValueAsString(msg);
////		      value = new String(value.getBytes("utf-8"), "utf-8");
//		      oos.write(resultMsg);
//		      oos.flush();
//		      oos.close();
//		    } catch (Exception exx) {
//		      exx.printStackTrace();
//		      try
//		      {
//		        oos.close();
//		      } catch (Exception localException1) {
//		      }
//		      try {
//		        socket.close();
//		      }
//		      catch (Exception localException2)
//		      {
//		      }
//		    }
//		    finally
//		    {
//		      try
//		      {
//		        oos.close();
//		      } catch (Exception localException3) {
//		      }
//		      try {
//		        socket.close();
//		      } catch (Exception localException4) {
//		      }
//		    }
//		  }
//	 
	 
	 	public static String getBase64String(String fileName,String imageString) throws Exception{
            //String filePathName = "C:\\picture\\";
	 		String filePathName = CommonUtil.getHomePath();
	 		System.out.println(filePathName);
	 		System.out.println(fileName.length());
	        if(!"empty".equals(fileName))
	        {
//	                String fileExtName = filePathName.substring( filePathName.lastIndexOf(".") + 1);
                FileInputStream inputStream = null;
                ByteArrayOutputStream byteOutStream = null;
     
                try
                {
                    File file = new File(filePathName+fileName);
     
                    if( file.exists() )
                    {
                        inputStream = new FileInputStream( file );
                        byteOutStream = new ByteArrayOutputStream();
     
                        int len = 0;
                        byte[] buf = new byte[1024];
                        while( (len = inputStream.read( buf )) != -1 ) {
                            byteOutStream.write(buf, 0, len);
                        }
     
                        byte[] fileArray = byteOutStream.toByteArray();
                        imageString = new String(Base64.encodeBase64(fileArray));
                    }
	                }
	                catch( IOException e)
	                {
	                    e.printStackTrace();
	                }
	                finally
	                {
	                    inputStream.close();
	                    byteOutStream.close();
	                }
	        }
	        else{
	            FileInputStream inputStream = null;
                ByteArrayOutputStream byteOutStream = null;
     
                try
                {
                	fileName = "default_woman.jpg";
                    File file = new File(filePathName+fileName);
     
                    if( file.exists() )
                    {
                        inputStream = new FileInputStream( file );
                        byteOutStream = new ByteArrayOutputStream();
     
                        int len = 0;
                        byte[] buf = new byte[1024];
                        while( (len = inputStream.read( buf )) != -1 ) {
                            byteOutStream.write(buf, 0, len);
                        }
     
                        byte[] fileArray = byteOutStream.toByteArray();
                        imageString = new String(Base64.encodeBase64(fileArray));
                    }
                }
                catch( IOException e)
                {
                    e.printStackTrace();
                }
                finally
                {
                    inputStream.close();
                    byteOutStream.close();
                }
            }
	        System.out.println("QQQQQQQQ||||||||||||||||"+imageString);
	        return imageString;
	    }

	
//	private Map<String, Object> sendSms1(List<Map<String,Object>> eventList) throws IOException{
//		Random random = new Random();
//		Map<String, Object> result = new HashMap<String, Object>();
//		Map<String, Object> map_ret = new HashMap<String, Object>();
//		Map<String, Object> param = new HashMap<String, Object>();
//		List<Map<String, Object>> info =  new ArrayList<Map<String, Object>>();
//		for(int i=0 ;i<eventList.size();i++){
//        	result = eventList.get(i);
//       	if(result.get("sPhoneNumber") != null){
//		    	result = info.get(0);
//		    	String name = (String)result.get("name");
//		    	String smsCd = String.valueOf(random.nextInt());
//				char pSmsState = 'Y';
//				String content = name+"님 센서에 침입 감지가 되었습니다.";
//		    	String sesUserId = "admin";
//		    	String rcvId = (String)result.get("sName");
//		    	String rcvMobl = (String)result.get("sPhoneNumber");
//		    	String phoneNumber = (String)result.get("phoneNumber");
//		    	
//				Map<String, Object> map = new HashMap<String, Object>();
//				map.put("SMS_CD", smsCd);
//				map.put("SMS_STATE", pSmsState);
//				map.put("CONTENT", content);
//				map.put("SEND_ID", sesUserId);
//				map.put("RCV_ID", rcvId);
//				map.put("RCV_MOBL", rcvMobl);
//				//map.put("UPD_USER_ID", sesUserId);
//				
//				logger.debug(" ===== send() map >>>>> {}", new Object[] { map });
//				try
//				{		  
//					String api_id = "danu";
//					String api_key = "6fdc23b16b34710e772458a75e35e501";	// 환결설정에서 확인 가능한 SMS API KEY
//		
//					ApiClass api = new ApiClass(api_id, api_key);
//					String _UNIQUE_KEY_ = api.getNonce();
//					String _CALLBACK_NUM_ = "070-7167-0747";
//					String _PHONE_NUM_ = rcvMobl;
//					System.out.println("============_UNIQUE_KEY_: "+_UNIQUE_KEY_);
//		
//					// 단문 발송 테스트
//					String arr[] = new String[7];
//					arr[0] = "sms";								// 발송 타입 sms or lms
//					arr[1] = _UNIQUE_KEY_;				// 결과 확인을 위한 KEY ( 중복되지 않도록 생성하여 전달해 주시기 바랍니다. )
//					arr[2] = "_TITLE_";							//  LMS 발송시 제목으로 사용 SMS 발송시는 수신자에게 내용이 보이지 않음.
//					arr[3] = content; //"_MESSAGE_";					// 본문 (90byte 제한)
//					arr[4] = _CALLBACK_NUM_;			// 발신 번호
//					arr[5] = _PHONE_NUM_;				// 수신 번호
//					arr[6] = "0";									//예약 일자 "2013-07-30 12:00:00" 또는 "0" 0또는 빈값(null)은 즉시 발송 
//					
//					String responseXml = api.send(arr);
//					System.out.println("response xml : \n" + responseXml);
//					
//					ApiResult res = api.getResult(responseXml);
//					System.out.println(" ===== result : code["+res.getCode()+"], msg["+res.getMesg()+"]");
//					if(res.getCode().compareTo("0000")!=0){
//						System.out.println(res.getMesg());
//					    map_ret.put("session", Integer.valueOf(0));
//					    map_ret.put("msg", res.getMesg());
//					}else{
//						this.smsInfoService.send(map);
//					    map_ret.put("session", Integer.valueOf(1));
//					    map_ret.put("msg", "발송이 완료되었습니다.");
//					}
//				    System.out.println("=======================================================");
//				}
//				catch (DataIntegrityViolationException e)
//				{
//					logger.error("update DataIntegrityViolationException : {}", new Object[] { e.getMessage() });
//				}		  
//		    	catch (Exception e)
//		    	{
//		    		map_ret.put("session", Integer.valueOf(0));
//		    		map_ret.put("msg", "알수 없는 에러입니다.");
//		    		this.logger.error("update Exception : {}", new Object[] { e.getMessage() });
//		    	} 
//	    	}
//		}
//      return map_ret;
//	}
	 
//	 private void send(Object msg) {
//		    ObjectMapper objectMapper = new ObjectMapper();
//		    Socket socket = null;
//		    BufferedWriter oos = null;
//		    try
//		    {
//		      socket = new Socket(this.gisServer, this.gisPort);
//
//		      oos = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), "utf-8"));
//
//		      String value = objectMapper.writeValueAsString(msg);
//		      value = new String(value.getBytes("utf-8"), "utf-8");
//		      //JsonTurilMapToJson(map);
//		      oos.write(value);
//		      oos.flush();
//		      oos.close();
//		    } catch (Exception exx) {
//		      exx.printStackTrace();
//		      try
//		      {
//		        oos.close();
//		      } catch (Exception localException1) {
//		      }
//		      try {
//		        socket.close();
//		      }
//		      catch (Exception localException2)
//		      {
//		      }
//		    }
//		    finally
//		    {
//		      try
//		      {
//		        oos.close();
//		      } catch (Exception localException3) {
//		      }
//		      try {
//		        socket.close();
//		      } catch (Exception localException4) {
//		      }
//		    }
//		  }
	 	
	 	public void sendApp(String msg){
			Socket socket = null;
	    	BufferedWriter oos = null;
	    	try{ // 서버가 가동되지 않는 환경에서는 막아둘 것
	    		
	        	socket = new Socket(appHostname , appPort);
	        	oos = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), "utf-8"));//한글
	        	
				oos.write(msg);
				oos.flush();
				// 2019.05.14 KMH 여성안심서비스 수정
				//oos.close();
	    	}catch(Exception exx){
	    		exx.printStackTrace();
	    	}finally{
	    		try{
	    			oos.close();
	    		}catch(Exception e){}

	    		try{
	    			socket.close();
	    		}catch(Exception e){}
	    	}
	    }

}