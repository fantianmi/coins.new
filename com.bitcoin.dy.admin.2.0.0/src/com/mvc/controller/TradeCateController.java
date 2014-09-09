package com.mvc.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.entity.Btc_bank;
import com.mvc.entity.Btc_trade_category;
import com.mvc.entity.Btc_user;
import com.mvc.service.BankService;
import com.mvc.service.HoldingService;
import com.mvc.service.StockOrderService;
import com.mvc.service.TongjiService;
import com.mvc.service.TradeCateService;
import com.mvc.service.UserService;
@Controller
@RequestMapping("/tradecate.do")
public class TradeCateController {
	@Autowired
	private UserService us = new UserService();
	@Autowired
	private BankService banks = new BankService();
	@Autowired
	private TradeCateService tradecate = new TradeCateService();

	protected final transient Log log = LogFactory.getLog(TradeCateController.class);

	/**
	 * 生成订单，并从用户帐本中扣除相应费用
	 * 
	 * @param modelmap
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(params="add")
	public String createbank(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String tradec_exstock = request.getParameter("tradec_exstock").toString();
		BigDecimal tradec_price = new BigDecimal(request.getParameter("tradec_price").toString());
		int tradec_stockid = Integer.parseInt(request.getParameter("tradec_stockid").toString());
		Btc_trade_category btc = new Btc_trade_category();
		btc.setTradec_exstock(tradec_exstock);
		btc.setTradec_price(tradec_price);
		btc.setTradec_stockid(tradec_stockid);
		tradecate.saveBtc_trade_category(btc);
		request.setAttribute("msg", "添加成功");
		request.setAttribute("href", "index.do?selfstock");
		return "selfstock";
	}
	
	@RequestMapping(params="update")
	public String update(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int tradecid = Integer.parseInt(request.getParameter("tradecid").toString());
		String tradec_exstock = request.getParameter("tradec_exstock").toString();
		BigDecimal tradec_price = new BigDecimal(request.getParameter("tradec_price").toString());
		int tradec_stockid = Integer.parseInt(request.getParameter("tradec_stockid").toString());
		Btc_trade_category btc = new Btc_trade_category();
		btc = tradecate.getTradeCateByBtcid(tradecid);
		btc.setTradec_exstock(tradec_exstock);
		btc.setTradec_price(tradec_price);
		btc.setTradec_stockid(tradec_stockid);
		tradecate.updateBtc_trade_category(btc);
		request.setAttribute("msg", "修改成功");
		request.setAttribute("href", "index.do?selfstock");
		return "selfstock";
	}
	@RequestMapping(params="delete")
	public String deleteBank(@RequestParam("id")int tradecid, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		Btc_trade_category btc = new Btc_trade_category();
		btc = tradecate.getTradeCateByBtcid(tradecid);
		tradecate.deleteBtc_trade_category(btc);
		request.setAttribute("msg", "删除成功！");
		request.setAttribute("href", "index.do?selfstock");
		return "selfstock";
	}
}
