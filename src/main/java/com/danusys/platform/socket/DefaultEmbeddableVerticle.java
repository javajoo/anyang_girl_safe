package com.danusys.platform.socket;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.NoSuchBeanDefinitionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.vertx.java.core.Vertx;
import org.vertx.java.core.impl.DefaultVertx;

public abstract class DefaultEmbeddableVerticle implements EmbeddableVerticle {
	@Autowired
	protected BeanFactory beanFactory;

	@PostConstruct
	public void runVerticle() {
		Vertx vertx = null;
		try {
			vertx = (Vertx) this.beanFactory.getBean(Vertx.class);
		} catch (NoSuchBeanDefinitionException e) {
			if (host() != null) {
				if (port() != -1) {
					vertx = new DefaultVertx(port(), host());
				} else {
					vertx = new DefaultVertx(host());
				}
			} else {
				vertx = new DefaultVertx();
			}
		}
		((DefaultEmbeddableVerticle) this.beanFactory.getBean(getClass()))
				.start(vertx);
	}

	public String host() {
		return null;
	}

	public int port() {
		return -1;
	}
}
