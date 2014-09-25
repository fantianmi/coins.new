package com.mvc.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.entity.Btc_holding;
import com.mvc.entity.Btc_inout_order;
import com.mvc.entity.Btc_profit;
import com.mvc.entity.Btc_stock;
import com.mvc.entity.Btc_user;
import com.mvc.service.HoldingService;
import com.mvc.service.StockOrderService;
import com.mvc.service.StockService;
import com.mvc.util.MD5Util;
@Controller
@RequestMapping("/stockorders.do")
public class StockOrderController {
	@Autowired
	private HoldingService holdingService = new HoldingService();
	@Autowired
	private StockOrderService stockOrderService = new StockOrderService();
	@Autowired
	private MD5Util md5util;
	@Autowired
	private StockService stocks;

	protected final transient Log log = LogFactory.getLog(StockOrderController.class);

	/**
	 * 生成订单，并从用户帐本中扣除相应费用
	 * 
	 * @param modelmap
	 * @param request
	 * @param response
	 * @return
	 */
	
	@RequestMapping(params="cancelByUser")
	public String cancel(@RequestParam("id")int orderid,HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		if(session.getAttribute("globaluser")==null){
			request.setAttribute("msg", "登陆超时，请重新登陆");
			request.setAttribute("href", "index.do");
			return "index";
		}
		Btc_user user = (Btc_user)session.getAttribute("globaluser");
		int uid = user.getUid();
		Btc_inout_order order = stockOrderService.getBtc_inout_orderByid(orderid);
		if(uid!=order.getUid()){
			request.setAttribute("msg", "非法操作！");
			request.setAttribute("href", "index.do");
			return "index";
		}
		order.setBtc_inout_status("已处理");
		order.setBtc_inout_msg("用户自己取消订单");
		stockOrderService.updateStockOrder(order);
		
		int stock_id = Integer.parseInt(request.getAttribute("stockId").toString());
		Btc_holding userhold = holdingService.getBtc_holding(uid, stock_id);
		BigDecimal amount = order.getBtc_inout_amount();
		
		userhold.setBtc_stock_amount(userhold.getBtc_stock_amount().add(amount));
		holdingService.updateBtc_holding(userhold);
		request.setAttribute("msg", "已成功撤销订单");
		request.setAttribute("href", "index.do?usercenter");
		return "index";
	}
	
}
