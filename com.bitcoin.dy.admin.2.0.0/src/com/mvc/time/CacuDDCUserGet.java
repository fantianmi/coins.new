package com.mvc.time;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mvc.entity.Btc_fhDDC;
import com.mvc.entity.Btc_stock;
import com.mvc.entity.Btc_tongji;
import com.mvc.entity.Btc_user;
import com.mvc.service.BirthService;
import com.mvc.service.FenhongService;
import com.mvc.service.StockService;
import com.mvc.service.TongjiService;
import com.mvc.service.UserService;
import com.mvc.util.DataUtil;
import com.mvc.util.TJUtil;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
@Service
public class CacuDDCUserGet{
	@Autowired
	private FenhongService fhs;
	@Autowired
	private TJUtil tj;
	@Autowired
	private DataUtil dateutil;
	@Autowired
	private BirthService bs;
	@Autowired
	private StockService stockService;
	@Autowired
	private TongjiService tongjis = new TongjiService();
	@Autowired
	private UserService us;
	
	public void run() throws ParseException{
		List<Object> alluser = us.getAllUser();
		String start = "";
		String end = "";
		Map<String, String> timemap = dateutil.getTime("day");
		start = timemap.get("start");
		end = timemap.get("end");

		// 计算第几周，统计发放分红币数量
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

		Btc_fhDDC btc_fhDDC = new Btc_fhDDC();
		// 获得当前分红币的价格 2.5+im*0.5 = price 交易额500+150*im
		Btc_stock ddc = stockService.getBtc_stockById(10000002);
		BigDecimal ddcprice = ddc.getBtc_stock_price();
		BigDecimal im = new BigDecimal(0);
		im = ddcprice.subtract(new BigDecimal(2.5)).divide(new BigDecimal(0.5))
				.setScale(0, BigDecimal.ROUND_HALF_UP);
		// 交易额满足条件(封顶10000)
		BigDecimal jiaoyie = im.multiply(new BigDecimal(750)).add(
				new BigDecimal(2500));
		if (jiaoyie.compareTo(new BigDecimal(10000)) >= 0) {
			jiaoyie = new BigDecimal(10000);
		}
		// 获得分红币个数
		BigDecimal jm = new BigDecimal(0);
		// 开始统计，如果满足交易额的用户就赠送分红币
		Btc_user user = new Btc_user();
		boolean flag = false;
		SimpleDateFormat dd = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		datenow = dd.format(new Date());

		flag = tongjis.getByTypeAndDate("fenhongbi", end);
		BigDecimal jiaoyieamount = new BigDecimal(0);
		BigDecimal deliamount = new BigDecimal(0);
		if (flag != true) {
			for (int i = 0; i < alluser.size(); i++) {
				user = (Btc_user) alluser.get(i);
				if (fhs.getCountTradeamountYestoday(user.getUid(), start) != null) {
					BigDecimal total = fhs.getCountTradeamountYestoday(
							user.getUid(), start);
					System.out.println(total);
					if (fhs.getCountTradeamountYestoday(user.getUid(), start)
							.compareTo(jiaoyie) >= 0) {
						jm = fhs.getCountTradeamountYestoday(user.getUid(),
								start).divide(jiaoyie)
								.setScale(6, BigDecimal.ROUND_HALF_UP);
						jiaoyieamount = jiaoyieamount.add(fhs
								.getCountTradeamountYestoday(user.getUid(),
										start));
						deliamount = deliamount.add(jm);
					}
				}
			}
		}
		if (flag != true) {
			for (int i = 0; i < alluser.size(); i++) {
				user = (Btc_user) alluser.get(i);
				if (fhs.getCountTradeamountYestoday(user.getUid(), start) != null) {
					BigDecimal total = fhs.getCountTradeamountYestoday(
							user.getUid(), start);
					System.out.println(total);
					if (fhs.getCountTradeamountYestoday(user.getUid(), start)
							.compareTo(jiaoyie) >= 0) {
						BigDecimal userjiaoyie = fhs
								.getCountTradeamountYestoday(user.getUid(),
										start);
						if (deliamount.compareTo(totalAmount) <= 0) {
							jm = fhs.getCountTradeamountYestoday(user.getUid(),
									start).divide(jiaoyie)
									.setScale(6, BigDecimal.ROUND_HALF_UP);
						} else {
							jm = userjiaoyie.divide(jiaoyieamount).multiply(
									totalAmount);
						}
						btc_fhDDC.setGetddc(jm);
						btc_fhDDC.setJiaoyie(userjiaoyie);
						btc_fhDDC.setRegisttme(user.getUsdtime());
						btc_fhDDC.setUcertification(user.getUcertification());
						btc_fhDDC.setUid(user.getUid());
						btc_fhDDC.setUname(user.getUname());
						btc_fhDDC.setUrole(user.getUrole());
						btc_fhDDC.setUstatus(user.getUstatus());
						btc_fhDDC.setUusername(user.getUusername());
						btc_fhDDC.setTjtime(datenow);
						btc_fhDDC.setFstatus("未发放");
						fhs.saveFH(btc_fhDDC);
					}
				}
			}
			Btc_tongji tongji = new Btc_tongji();
			tongji.setTongji_time(datenow);
			tongji.setTongji_type("fenhongbi");
			tongjis.saveTongji(tongji);
		}
	 }
}
