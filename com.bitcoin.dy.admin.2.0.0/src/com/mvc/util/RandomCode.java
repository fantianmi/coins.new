package com.mvc.util;

import java.util.Random;

import org.junit.Test;
import org.springframework.stereotype.Service;

@Service
public class RandomCode {
	public String random2() {
		String s = "";
		String tex = "";
		Random rn = new Random();
		int n = rn.nextInt(99999);
		tex = "" + n;
		if (tex.length() == 5) {
			s = tex;
		} else {
			s = "23842";
		}
		return s;
	}

	public String getCharAndNumr(int length) {
		String val = "";

		Random random = new Random();
		for (int i = 0; i < length; i++) {
			String charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num"; // 输出字母还是数字
			if ("char".equalsIgnoreCase(charOrNum)) // 字符串
			{
				int choice = random.nextInt(2) % 2 == 0 ? 97 : 97; // 取得大写字母还是小写字母
				int num = choice + random.nextInt(26);
				if(num ==108||num==111)
					num =119;
				val += (char) (num);
				
			} else if ("num".equalsIgnoreCase(charOrNum)) // 数字
			{
				val += String.valueOf(random.nextInt(10));
			}
		}

		return val;
	}
	
	public String getNumr(int length) {
		String val = "";
		
		Random random = new Random();
		for (int i = 0; i < length; i++) {
			String charOrNum = random.nextInt(2) % 2 == 0 ? "num" : "num"; // 输出字母还是数字
			
			if ("char".equalsIgnoreCase(charOrNum)) // 字符串
			{
				int choice = random.nextInt(2) % 2 == 0 ? 65 : 97; // 取得大写字母还是小写字母
				val += (char) (choice + random.nextInt(26));
			} else if ("num".equalsIgnoreCase(charOrNum)) // 数字
			{
				val += String.valueOf(random.nextInt(10));
			}
		}
		
		return val;
	}

	@Test
	public void testRandom2() {
		String s = random2();
		System.out.println(s);

	}
	@Test
	public void testCharAndNum() {
		String s = getCharAndNumr(20);
		System.out.println(s);
	}
	@Test
	public void testNum() {
		String s = getNumr(10);
		System.out.println(s);
	}
}
