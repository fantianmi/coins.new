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
	public String formatString(String text){ 
		if(text == null) {
			return ""; 
		}
		return text;
	}
	
	public String num2percent(BigDecimal in){
		String out;
		out = new DecimalFormat("0.00######").format(in.multiply(new BigDecimal(100)).doubleValue());
		if(in.compareTo(new BigDecimal(0))<0){
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
	public String transShop(int i){
		if(i==0)return "暂未开放";
		else return "正在销售";
	}
	
	public String transfactory(String in){
		String out="";
		if(in.equals("铸币中")) out="等待系统发放利息";
		else if(in.equals("等待系统发放")) out="利息已统计完成，等待发放";
		else out="利息已发放到您的帐户";
		return out;
	}
	
	public String encipherUsername(String username){
		return username.substring(0, 3)+"*****";
	}
	public String encipherCard(String card){
		return "*****"+card.substring(card.length()-4, card.length());
	}
	
	public String transDateToHours(String idate) throws ParseException{
		return idate.substring(idate.length()-8,idate.length());
	}
	
	public String transGameName(String gname){
		if(gname.equals("luckwheel")) return "幸运大转盘	";
		else return "暂无名称";
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
	
	public String num2color(BigDecimal in){
		if(in.compareTo(new BigDecimal(0))<0){
			return "sell-color";
		}else{
			return "buy-color";
		}
	}
	
	public String transDDZroom(String in){
		if(in.equals("ddz_1"))return "两倍房间";
		else if(in.equals("ddz_5"))return "十倍房间";
		else return "二十倍房间";
	}
	public String transDDZ2Grede(String in){
		if(in.equals("ddz_1"))return "100";
		else if(in.equals("ddz_5"))return "500";
		else return "1000";
	}
	
	@Test
	public void transDateToHours() throws ParseException{
		String a = this.transDateToHours("2014/06/18 10:36:55");
		System.out.println(a);
	}
}
