package com.mvc.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mvc.entity.Btc_holding;
import com.mvc.entity.Btc_join_build;
import com.mvc.service.FactoryService;
import com.mvc.service.HoldingService;
import com.mvc.util.DataUtil;
import com.mvc.util.HoldingUtil;
@Controller
@RequestMapping("/factory.do")
public class FactoryController {
	@Autowired
	private FactoryService fas;
	@Autowired
	private HoldingService hs;
	@Autowired
	private DataUtil dateutil;
	@Autowired
	private HoldingUtil holdutil;
	protected final transient Log log = LogFactory.getLog(FactoryController.class);
	ResourceBundle stockres=ResourceBundle.getBundle("stock");

	/**
	 * 
	 * 
	 * @param modelmap
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(params="deliverstock")
	public String deliverstock(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String jbids[] = request.getParameterValues("checkbox");
		Btc_holding hold = new Btc_holding();
		int jbid = 0;
		int facStockId=Integer.parseInt(stockres.getString("stock.factory.stockid"));
				
		Btc_join_build bjb = new Btc_join_build();
		String msg = "已发放铸币给下列用户:  ";
		if (jbids != null) {
			for (int i = 0; i < jbids.length; i++) {
				jbid = Integer.parseInt(jbids[i]);
				bjb = fas.getBtc_join_buildByJbid(jbid);
				BigDecimal uget = bjb.getGetamount();
				BigDecimal frozen=bjb.getAmount();
				holdutil.defrozenstock(facStockId, frozen, bjb.getUid());
				holdutil.addMoney(bjb.getUid(), uget);
				bjb.setStatus("系统已发放到您的账户");
				bjb.setGetdate(dateutil.getTimeNow("second"));
				fas.updateBtc_join_build(bjb);
				msg = msg +"'"+ bjb.getUid()+"'";
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("href", "index.do?buildStockDelivery");
		return "buildStockDelivery";
	}
	
	@RequestMapping(params="rejectstock")
	public String rejectstock(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String jbids[] = request.getParameterValues("checkbox");
		int jbid = 0;
		int facStockId=Integer.parseInt(stockres.getString("stock.factory.stockid"));
		Btc_join_build bjb = new Btc_join_build();
		String msg = "已拒绝发放铸币给下列用户:  ";
		if (jbids != null) {
			for (int i = 0; i < jbids.length; i++) {
				jbid = Integer.parseInt(jbids[i]);
				bjb = fas.getBtc_join_buildByJbid(jbid);
				BigDecimal frozen=bjb.getAmount();
				holdutil.defrozenstock(facStockId, frozen, bjb.getUid());
				bjb.setStatus("拒绝发放，非法操作，请联系平台客服人员");
				bjb.setGetdate(dateutil.getTimeNow("second"));
				fas.updateBtc_join_build(bjb);
				msg = msg +"'"+ bjb.getUid()+"'";
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("href", "index.do?buildStockDelivery");
		return "buildStockDelivery";
	}
}
