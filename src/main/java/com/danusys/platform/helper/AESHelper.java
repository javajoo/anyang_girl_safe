package com.danusys.platform.helper;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class AESHelper {
    // key는 16바이트로 구성 되어야 한다.
    static public String encryptAES(String s, String key) throws Exception {
        String encrypted = null;
        try {
            SecretKeySpec skeySpec = new SecretKeySpec(key.getBytes(), "AES");
            
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
            
            encrypted = byteArrayToHex(cipher.doFinal(s.getBytes()));
            return encrypted;
        } catch (Exception e) {
            throw e;
        }
    }
    
    // key는 16 바이트로 구성 되어야 한다.
    static public String decryptAES(String s, String key) throws Exception {
        String decrypted = null;
        try {
            SecretKeySpec skeySpec = new SecretKeySpec(key.getBytes(), "AES");
            
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.DECRYPT_MODE, skeySpec);
            decrypted = new String(cipher.doFinal(hexToByteArray(s)));
            return decrypted;
        } catch (Exception e) {
            throw e;
        }
    }
    
    static private byte[] hexToByteArray(String s) {
        byte[] retValue = null;
        if (s != null && s.length() != 0) {
            retValue = new byte[s.length() / 2];
            for (int i = 0; i < retValue.length; i++) {
                retValue[i] = (byte) Integer.parseInt(s.substring(2 * i, 2 * i + 2), 16);
            }
        }
        return retValue;
    }
    
    static private String byteArrayToHex(byte buf[]) {
        StringBuffer strbuf = new StringBuffer(buf.length * 2);
        for (int i = 0; i < buf.length; i++) {
            if (((int) buf[i] & 0xff) < 0x10) {
                strbuf.append("0");
            }
            strbuf.append(Long.toString((int) buf[i] & 0xff, 16));
        }
        
        return strbuf.toString();
    }
}
