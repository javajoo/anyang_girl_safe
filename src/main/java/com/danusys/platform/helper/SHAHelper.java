package com.danusys.platform.helper;

import java.security.MessageDigest;
import org.apache.commons.codec.binary.Base64;

public class SHAHelper {
	public static String encryptPassword(String password, String id) throws Exception {

		if (password == null) {
		    return "";
		}
	
		byte[] hashValue = null; // 해쉬값
	
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		
		md.reset();
		md.update(id.getBytes());
		
		hashValue = md.digest(password.getBytes());
	
		return new String(Base64.encodeBase64(hashValue));
    }
}