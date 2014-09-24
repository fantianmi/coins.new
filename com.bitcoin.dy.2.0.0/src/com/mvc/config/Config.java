package com.mvc.config;

import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.util.List;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;

import com.mvc.vo.RetCode;


public class Config {
	private static ThreadLocal<RetCode> tRetCode = new ThreadLocal<RetCode>();
	private static ThreadLocal<String> tErrorString = new ThreadLocal<String>();
	private static Configuration config;
	
	public static void loadDataSource() throws ConfigurationException {
		URL configUrl = Thread.currentThread().getContextClassLoader().getResource("stock.properties");
		System.out.println("load config from " + configUrl.getFile());
		config = new PropertiesConfiguration(configUrl.getFile());  
	}
	
	public static void setRetCode(RetCode ret) {
		tRetCode.set(ret);
	}

	static {
		try {
			loadDataSource();
		} catch (ConfigurationException e) {
			e.printStackTrace();
		}
	}


	public static void setErrorMsg(String error) {
		tErrorString.set(error);
	}
	
	public static String getErrorMsg() {
		return tErrorString.get();
	}
	
	
	public static String getString(String key) {
		String value = config.getString(key);
		try {
			value = new String(value.getBytes("ISO-8859-1"),"UTF-8");
			return value;
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	public static Boolean getBoolean(String key) {
		return config.getBoolean(key, false);
	}
	
	public static int getInt(String key) {
		return config.getInt(key);
	}
	
	public static double getDouble(String key) {
		return config.getDouble(key);
	}
	
	public static List getList(String key) {
		return config.getList(key);
	}
	
	public static void main(String[] args) throws Exception {
		String file ="D:/eclipse/eclipse-jee/workplace/ggjucheng.keepmoving/branches/km-coins-v1/km-coins/src/main/resources/main.properties";
		PropertiesConfiguration config = new PropertiesConfiguration(file);
		//config.setEncoding("UTF-8");
		//config.setFileName(file);
		String value = config.getString("system.email");
		value = new String(value.getBytes("ISO-8859-1"),"UTF-8");
		System.out.println(value);
	}

}
