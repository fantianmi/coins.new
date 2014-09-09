package com.mvc.util;

import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mvc.entity.Btc_fenhonglog;
import com.mvc.entity.Btc_fh_order;
import com.mvc.entity.Btc_holding;
import com.mvc.service.BirthService;
import com.mvc.service.FenhongService;
import com.mvc.service.FhOrderService;
import com.mvc.service.PoundageService;

@Service
public class TJUtil {
	@Autowired
	private BirthService bs = new BirthService();
	@Autowired
	private DataUtil dateutil = new DataUtil();
	@Autowired
	private FenhongService fhs = new FenhongService();
	@Autowired
	private PoundageService ps = new PoundageService();
	@Autowired
	private FhOrderService fhos = new FhOrderService();
	
	
	public int caculateSeason(int num) throws ParseException {
		
		int mseason = 0;
		int season = 0;
		if (num == 1) {
			season = 1;
		} else if (num == 2) {
			season = 2;
		} else if (num == 3) {
			season = 3;
		} else if (num >= 4) {
			if (num != 4) {
				mseason = num;
				season = mseason;
			} else {
				season = 4;
			}
		}
		return season;
	}

	public Map<String,Object> cacuDeliverAmount(int num,String starttime) throws ParseException {
		Map<String,Object>map = new HashMap<String, Object>();
		// 计算第几周
		String endtime = "2014-00-00";
		BigDecimal poundageamount = new BigDecimal(0);
		BigDecimal rate = new BigDecimal(1);
		if (num == 1) {
			endtime = dateutil.getTimeAfterGivenDay(starttime, 7);
			poundageamount = ps.getInAll_ByTimearea(starttime, endtime);
		} else if (num == 2) {
			starttime = dateutil.getTimeAfterGivenDay(starttime, 7);
			endtime = dateutil.getTimeAfterGivenDay(starttime, 7);
			poundageamount = ps.getInAll_ByTimearea(starttime, endtime);
		} else if (num == 3) {
			starttime = dateutil.getTimeAfterGivenDay(starttime, 14);
			endtime = dateutil.getTimeAfterGivenDay(starttime, 7);
			poundageamount = ps.getInAll_ByTimearea(starttime, endtime);
		} else if (num >= 4) {
			if (num != 4) {
				int startweek = num - 1;
				int endweek = num;
				int startday = startweek * 7;
				int endday = endweek * 7;
				starttime = dateutil.getTimeAfterGivenDay(starttime, startday);
				endtime = dateutil.getTimeAfterGivenDay(starttime, endday);
				poundageamount = ps.getInAll_ByTimearea(starttime, endtime);
			}
		}
		map.put("endtime", endtime);
		map.put("poundageamount", poundageamount);
		map.put("rate", rate);
		return map;
	}
	
	public void cacuUserGet(BigDecimal deliveramount,int season){
		BigDecimal amount = fhs.getSUM_DDC();
		amount = amount.add(fhs.getSUM_DDCFromOrder());
		Map<Integer,Btc_holding> holdmap = new HashMap<Integer,Btc_holding>();
		if(fhs.getAllddcholder()!=null){
			holdmap = fhs.getAllddcholder();
		}
		BigDecimal userholdddc = new BigDecimal(1);
		Btc_holding userhold = new Btc_holding();
		BigDecimal userget = new BigDecimal(0);
		Btc_fh_order order = new Btc_fh_order();
		BigDecimal rate = new BigDecimal(1);
		MathContext mc = new MathContext(2, RoundingMode.HALF_DOWN);
		java.util.Iterator<Integer> it = holdmap.keySet().iterator();
		while(it.hasNext()){
			int key = it.next();
			userhold = holdmap.get(key);
			userholdddc = userhold.getBtc_stock_amount();
			rate = userholdddc.divide(amount,mc);
			userget = deliveramount.multiply(rate);
			order.setAmount(userget);
			order.setUid(userhold.getUid());
			order.setIsdeliver("未发放");
			order.setSeason(season);
			fhos.saveFhOrder(order);
		}
		Btc_fenhonglog bfl =new Btc_fenhonglog();
		bfl.setFenhong_amount(deliveramount);
		bfl.setFenhong_season(season);
		bfl.setFenhong_status("已统计");
		bfl.setFenhong_time(dateutil.getTimeNow("second"));
		fhs.saveBtc_fenhonglog(bfl);
	}
	
	public BigDecimal cacuDeliveryDDCamount() throws ParseException{
		String starttime = bs.getBirth().getBirth_time();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String datenow = format.format(new Date());
		int day = dateutil.getDateSpace(starttime, datenow);
		BigDecimal num = new BigDecimal(Integer.toString(day));

		BigDecimal totalAmount = new BigDecimal(30000);
		num = num.divide(new BigDecimal(28), 10, BigDecimal.ROUND_HALF_DOWN);
		if (num.compareTo(new BigDecimal(1)) <= 0) {
		} else {
			if (num.compareTo(new BigDecimal(1)) > 0
					&& num.compareTo(new BigDecimal(2)) <= 0) {
				totalAmount = totalAmount.multiply(new BigDecimal(0.8));
			} else {
				totalAmount = totalAmount.multiply(new BigDecimal(0.8));
				int b = num.intValue();
				b = b - 1;
				for (int i = 0; i < b; i++) {
					totalAmount = totalAmount.multiply(new BigDecimal(0.9));
				}
			}
		}
		return totalAmount;
	}
	
	
}
