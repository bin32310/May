package com.may.controller;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Encrypt {

	private static final Logger logger = LoggerFactory.getLogger(Encrypt.class);
	public static void main(String[] args) {
		
		// SHA-256 사용 연습
		
		Encrypt en = new Encrypt();
		
		// pw
		String pw = "password";
		logger.debug("pw : " + pw);
		
		// Salt 생성
		String salt = en.getSalt();
		logger.debug("salt : " + salt);

		// 최종 us_pw 생성
		String us_pw = en.getEncrypt(pw, salt);
		
		
	}
	
	public String getSalt() {
		
		// 1. Random, byte 객체 생성
		SecureRandom random = new SecureRandom();
		byte[] salt = new byte[20];
		
		// 2. 난수 생성
		random.nextBytes(salt);
		
		// 3. byte To String (10진수의 문자열로 변경)
		StringBuffer sb = new StringBuffer();
		for(byte b : salt) {
			sb.append(String.format("%02x", b));
		};
		
		return sb.toString();
		
	}
	
	public String getEncrypt(String pw, String salt) {
		
		String result = "";
		try {
			// 1. SHA256 알고리즘 객체 생성
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			
			// 2. pw와 salt가 합쳐진 문자열에 SHA256 적용
			logger.debug("pw + salt 적용 전 : " + pw + salt);
			md.update((pw+salt).getBytes());
			byte[] pwSalt = md.digest();
			
			// 3. byte To String (10진수의 문자열로 변경)
			StringBuffer sb = new StringBuffer();
			for(byte b : pwSalt) {
				sb.append(String.format("%02x", b));
			}
			
			result = sb.toString();
			logger.debug("pw + salt 적용 후 : " + result);
			
		}catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
