package com.mvc.config;


public class CoinConfig {
	public static String tradecate_1;
	public static String tradecate_2;
	public static String mainCoin;
	
	static {
		try {
			flush();
			startService();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private static void flush() {
		//add by jackmao
		tradecate_1=Config.getString("tradecate_1");
		tradecate_2=Config.getString("tradecate_2");
		mainCoin=Config.getString("main.coin");
	}
	public static String getTradecate_1() {
		return tradecate_1;
	}
	public static String getTradecate_2() {
		return tradecate_2;
	}
	public static String getMainCoin(){
		return mainCoin;
	}

	public static void startService() throws Exception {

	}

}
