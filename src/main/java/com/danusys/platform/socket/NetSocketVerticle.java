package com.danusys.platform.socket;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.net.SocketException;
import java.net.SocketTimeoutException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
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
	private String hostname = "127.0.0.1";//"172.20.14.6";//"211.220.152.67";
    private int port = 10021;

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
		/*else {
			System.out.println("2");
			result = msgParseDuc(msg);
			emitEventDuc(result, netSocket);
		}*/
		return result;
	}
	

	public void emitEventDuc(String msg, NetSocket netSocket) {
		netSocket.write(msg);
	}
	
	
	
	public void smartEvent(String msg, NetSocket netSocket) {
		msg.replaceAll("\\r|\\n", "");
		String[] msgArray = msg
				.split(",");
		Map<String,Object> map = new HashMap<String,Object>();
		if (msgArray.length == 3) {
			String sensorId = msgArray[1];
			
			map.put("sensorId", sensorId);
			map.put("division", "samrt");
			map.put("egergency", "1");

			try {
				
				
				JsonObject obj = new JsonObject(map);
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
		else if(msgArray.length == 5){
			String sensorId = msgArray[1];
			String pointY = msgArray[3];
			String pointX = msgArray[4];
			
			map.put("sensorId", sensorId);
			map.put("emergency", "1");
			map.put("pointY", pointY);
			map.put("pointX", pointX);
			try {
			
				NetSocketVerticle.this.baseService
						.baseUpdate("girlSafe.updateEmergency", map);
				NetSocketVerticle.this.baseService
						.baseInsert("girlSafe.insertEvent", map);
				/*List<Map<String,Object>> eventList = NetSocketVerticle.this.baseService
						.baseSelectList("girlSafe.getHwInfo",map);
				Map<String,Object> event = CommonUtil.ListToMap(eventList);*/
				JsonObject obj = new JsonObject(map);
				NetSocketVerticle.logger.info(obj
						.toString());

				NetSocketVerticle.this.webSocketVerticle
						.getIo().sockets()
						.emit("response", obj);

//				netSocket.write("00000");
//				netSocket.write("\n");
				NetSocketVerticle.logger
						.info("received socket message 4: OK");
			} catch (SocketException e) {
//				netSocket.write("11111");
//				netSocket.write("\n");
				NetSocketVerticle.logger
						.info("received socket message 6: ERROR"
								+ e.getMessage());
				NetSocketVerticle.logger.error(
						"handle SocketException : {} ",
						new Object[] { e.getMessage() });
			} catch (SocketTimeoutException e) {
//				netSocket.write("11111");
//				netSocket.write("\n");
				NetSocketVerticle.logger
						.info("received socket message 6: ERROR"
								+ e.getMessage());
				NetSocketVerticle.logger.error(
						"handle SocketTimeoutException : {} ",
						new Object[] { e.getMessage() });
			} catch (Exception e) {
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
	
	public void sensorEvent(String msg, NetSocket netSocket) {
		msg.replaceAll("\\r|\\n", "");
		String[] msgArray = msg.split(",");
		Map<String,Object> map = new HashMap<String,Object>();
		
		if (msgArray.length == 5) {
			String sensorId = "";
			
			
			try {
				sensorId = msgArray[1];
				
				map.put("sensorId", sensorId);
				map.put("emergency", "1");
				
				/*List<Map<String,Object>> eventList = NetSocketVerticle.this.baseService
						.baseSelectList("girlSafe.getHwInfo",map);
				Map<String,Object> event = CommonUtil.ListToMap(eventList);*/
				JsonObject obj = new JsonObject(map);
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
		else if(msgArray.length > 7){
			String smartId = msgArray[4];
			String sensorId = msgArray[6];
			String status = Integer.toString(Integer.parseInt(msgArray[7],16));
			String bat = Integer.toString(Integer.parseInt(msgArray[8],16));
		
			map.put("smartId", smartId);
			map.put("sensorId", sensorId);
			map.put("status", status);
			map.put("bat", bat);
			try {
				NetSocketVerticle.this.baseService
				.baseUpdate("girlSafe.updateSensorStat", map);
				List<Map<String,Object>> eventList = NetSocketVerticle.this.baseService
				.baseSelectList("girlSafe.getHwInfo",map);
				Map<String,Object> event = CommonUtil.ListToMap(eventList);
				
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
			} catch (SocketException e) {
//				netSocket.write("11111");
//				netSocket.write("\n");
				NetSocketVerticle.logger
						.info("received socket message 6: ERROR"
								+ e.getMessage());
				NetSocketVerticle.logger.error(
						"handle SocketException : {} ",
						new Object[] { e.getMessage() });
			} catch (SocketTimeoutException e) {
//				netSocket.write("11111");
//				netSocket.write("\n");
				NetSocketVerticle.logger
						.info("received socket message 6: ERROR"
								+ e.getMessage());
				NetSocketVerticle.logger.error(
						"handle SocketTimeoutException : {} ",
						new Object[] { e.getMessage() });
			} catch (Exception e) {
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
	
	private void send(Object msg){
    	ObjectMapper objectMapper = new ObjectMapper();
    	Socket socket = null;
    	BufferedWriter oos = null;
    	try{ // 서버가 가동되지 않는 환경에서는 막아둘 것
    		
        	socket = new Socket(hostname , port);
        	
        	oos = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), "utf-8"));//한글

        	String value = objectMapper.writeValueAsString(msg);
        	value = new String(value.getBytes("utf-8"), "utf-8");
			oos.write(value+"\0\n"+null);
			oos.flush();
			oos.close();
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

}