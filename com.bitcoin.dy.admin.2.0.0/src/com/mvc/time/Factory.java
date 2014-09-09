package com.mvc.time;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.ResourceBundle;

import org.springframework.beans.factory.annotation.Autowired;

import com.mvc.controller.BankController;
import com.mvc.entity.Btc_join_build;
import com.mvc.service.FactoryService;
import com.mvc.service.GBservice;
import com.mvc.util.DataUtil;
import com.mvc.util.HoldingUtil;
@Service
public class Factory{
	@Autowired
	private DataUtil dateutil = new DataUtil();
	@Autowired
	private GBservice gbs = new GBservice();
	@Autowired
	private HoldingUtil holdutil;
	ResourceBundle res = ResourceBundle.getBundle("stock");
	protected final transient Log log = LogFactory.getLog(Factory.class);
	@Autowired
	private FactoryService fcs = new FactoryService();
	public void gbfcbuild() {
		if(dateutil.getDay()!=1){
			log.info("--------------------------today is not sunday, bank should not be run-------------------------");
			return;
		}
		int stockid=Integer.parseInt(res.getString("stock.factory.stockid"));
		//检查是否有人加入铸币，如果没有直接退出
		if(fcs.getAllBtc_join_buildByTime("造币工厂","铸币中")==null){
			log.info("--------------------------no one in Building--------------------------------");
			return;
		}
		//初始化
		Btc_join_build bjb = new Btc_join_build();
		//获取今日参加铸币的用户
		List<Object> buildlist = fcs.getAllBtc_join_buildByTime("造币工厂","铸币中");
		//给每个用户分配铸币成果 其中b=用户持币数x用户效率值x0.0001
		BigDecimal b = new BigDecimal(1);
		BigDecimal getamount = new BigDecimal(0);
		for(int i=0;i<buildlist.size();i++){
			bjb = (Btc_join_build)buildlist.get(i);
			b= bjb.getAmount().multiply(new BigDecimal(0.005));
			getamount = b;
			bjb.setGetamount(getamount);
			bjb.setStatus("等待系统发放");
			holdutil.defrozenstock(stockid, bjb.getAmount(), bjb.getUid());
			fcs.updateBtc_join_build(bjb);
		}
		log.info(new Date()+"系统已统计完毕--银行利息");
	}
}
