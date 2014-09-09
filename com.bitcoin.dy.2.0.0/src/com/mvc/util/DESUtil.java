package com.mvc.util;

import java.io.IOException;
import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

import org.apache.log4j.Logger;
import org.junit.Test;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
 * 类说明
 * 
 * @creator zhw
 * @create-time 2013-11-27 下午04:35:17
 */
public class DESUtil {

	private static Logger logger = Logger.getLogger(DESUtil.class);
	
	private final static String KEY = "guobwang"; // 使用前8个字节作为秘钥内容

	public static byte[] desEncrypt(byte[] encryptBytes) {
		SecureRandom sr = new SecureRandom();
		DESKeySpec dks;
		byte[] encryptedData = null;
		try {
			dks = new DESKeySpec(KEY.getBytes());
			SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
			SecretKey key = keyFactory.generateSecret(dks);
			Cipher cipher = Cipher.getInstance("DES");
			cipher.init(Cipher.ENCRYPT_MODE, key, sr);
			encryptedData = cipher.doFinal(encryptBytes);
		} catch (Exception e) {
			logger.error("加密信息异常",e);
		} 
		return encryptedData;
	}

	public static byte[] desDecrypt(byte[] decryptBytes) {
		SecureRandom sr = new SecureRandom();
		DESKeySpec dks = null;
		Cipher cipher = null;
		byte[] decryptedData = null;
		try {
			dks = new DESKeySpec(KEY.getBytes());
			cipher = Cipher.getInstance("DES");
			SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
			SecretKey key = keyFactory.generateSecret(dks);
			cipher.init(Cipher.DECRYPT_MODE, key, sr);
			decryptedData = cipher.doFinal(decryptBytes);
		} catch (Exception e) {
			logger.error("解密信息异常",e);
		}
		return decryptedData;
	}

	public static String encrypt(String input){
		return base64Encode(desEncrypt(input.getBytes()));
	}

	public static String decrypt(String input){
		byte[] result = base64Decode(input);
		return new String(desDecrypt(result));
	}

	public static String base64Encode(byte[] s) {
		if (s == null)
			return null;
		return new BASE64Encoder().encode(s);
	}

	public static byte[] base64Decode(String s) {
		if (s == null) {
			return null;
		}
		byte[] base64Data = null;
		try {
			base64Data = new BASE64Decoder().decodeBuffer(s);
		} catch (IOException e) {
			logger.error("base64解密信息异常",e);
		}
		return base64Data;
	}

	public static void main(String args[]) {
		try {
			System.out.println(DESUtil.encrypt("96"));
			System.out.println(DESUtil.decrypt("IburupfEBHw="));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@Test
	public void splitString(){
		String uid="QTtUGkriw+M=";
		System.out.println(this.decrypt(uid));
	}
}
