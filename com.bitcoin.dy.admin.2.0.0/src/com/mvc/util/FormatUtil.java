package com.mvc.util;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;
import org.springframework.stereotype.Service;


@Service
public class FormatUtil {
	public String trans(BigDecimal in){
		String out;
		out = new DecimalFormat("0.00######").format(in.doubleValue());
		return out;
	}
	
	public String num2percent(BigDecimal in){
		String out;
		out = new DecimalFormat("0.00######").format(in.multiply(new BigDecimal(100)).doubleValue());
		if(in.compareTo(new BigDecimal(0))<0){
			out = "-"+out;
		}else{
			out = "+"+out;
		}
		return out;
	}
	public String transDate(String idate) throws ParseException{
		SimpleDateFormat dd = new SimpleDateFormat("yyyy/MM/dd");
		DateFormat df = new SimpleDateFormat("yyyy/MM/dd");
		Date date = df.parse(idate);
		
		String out;
		out = dd.format(date);
		return out;
	}
	
	public String transDateToHours(String idate) throws ParseException{
		return idate.substring(idate.length()-8,idate.length());
	}
	public String transBank(String in){
		String out="";
		if(in.equals("ZFB")){
			out="平台支付宝";
		}
		return out;
	}
	
	public String transGameResult(int rs){
		if(rs==1)return "胜";
		else if(rs==0)return "平";
		else if(rs==-1)return "负";
		else return "未赛";
	}
	public String tansTradeType(String in){
		if(in.equals("bid")) return "买";
		else return "卖";
	}
	public String transRole(String in){
		if(in.equals("admin"))return "管理员";
		else return "普通会员";
	}
	public String transStatus(String in){
		if(in.equals("frozen"))return "冻结";
		else return "正常";
	}
	public String transTradeStatus(int in){
		if(in==1)return "开启";
		else return "关闭";
	}
	public String transShop(int i){
		if(i==0)return "关闭商场";
		else return "打开商场";
	}
	@Test
	public void transDateToHours() throws ParseException{
		String a = this.transDateToHours("2014/06/18 10:36:55");
		System.out.println(a);
	}
}
