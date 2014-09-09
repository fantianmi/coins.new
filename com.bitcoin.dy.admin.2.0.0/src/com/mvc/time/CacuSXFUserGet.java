package com.mvc.time;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mvc.controller.IndexController;
import com.mvc.entity.Btc_fenhonglog;
import com.mvc.service.FenhongService;
import com.mvc.service.TongjiService;
import com.mvc.util.DataUtil;
import com.mvc.util.TJUtil;
import com.mysql.jdbc.log.Log;

import java.math.BigDecimal;
import java.util.Date;
@Service
public class CacuSXFUserGet{
	@Autowired
	private FenhongService fhs;
	@Autowired
	private TJUtil tj;
	
	public void run(){
		Btc_fenhonglog bfl = fhs.getLatestBtc_fenhonglog();
		BigDecimal rate = bfl.getRate();
		BigDecimal poundageamount = bfl.getFenhong_amount();
		int season = bfl.getFenhong_season();
		BigDecimal deliveramount = new BigDecimal(0);
		if(rate.compareTo(new BigDecimal(1))<=0){
			deliveramount = poundageamount.multiply(rate);
		}else{
			deliveramount = poundageamount;
		}
		if(!fhs.isTongjiFenhong(season)){
			tj.cacuUserGet(deliveramount, season);
			System.out.println("手续费发放统计完毕:"+new Date());
		}
	 }
}
