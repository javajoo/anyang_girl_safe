package com.danusys.platform.socket;

import java.util.Properties;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Component;
import org.vertx.java.core.Handler;
import org.vertx.java.core.Vertx;
import org.vertx.java.core.http.HttpServer;
import org.vertx.java.core.json.JsonObject;

import com.nhncorp.mods.socket.io.SocketIOServer;
import com.nhncorp.mods.socket.io.SocketIOSocket;
import com.nhncorp.mods.socket.io.impl.DefaultSocketIOServer;

@Component
public class WebSocketVerticle extends DefaultEmbeddableVerticle {

	private static Logger logger = LogManager
			.getLogger(WebSocketVerticle.class);
	@Resource(name = "config")
	private Properties config;
	private int websocket_port = 10023;
	private SocketIOServer io;

	public void start(Vertx vertx) {
		try {
			this.websocket_port = Integer.parseInt(this.config.getProperty(
					"websocket_port").trim());
		} catch (Exception e) {
			logger.info(
					"websocket_port exception : {}===={}",
					new Object[] {
							this.config.getProperty("websocket_port").trim(),
							e.getMessage() });
			this.websocket_port = 10023;
		}
		HttpServer server = vertx.createHttpServer();
		logger.info(" ==== WebSocket Server Start ==== {}",
				new Object[] { Integer.valueOf(this.websocket_port) });
		this.io = new DefaultSocketIOServer(vertx, server);
		this.io.sockets().onConnection(new Handler<SocketIOSocket>() {
			public void handle(final SocketIOSocket socket) {
				socket.emit("welcome");
					
				socket.on("msg", new Handler<JsonObject>() {
					public void handle(JsonObject msg) {
						socket.emit("msg", msg);
						WebSocketVerticle.logger.info("get message : "
								+ msg.getString("msg"));
					}
				});
			}
		});
		server.listen(this.websocket_port);
	}

	public SocketIOServer getIo() {
		return this.io;
	}

	public void sendMsg(JsonObject msg) {
		if (this.io != null) {
			logger.info("get message : " + msg.getString("msg"));
			this.io.sockets().emit("response", msg);
		}
	}

}
