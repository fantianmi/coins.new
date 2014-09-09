package com.mvc.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mvc.entity.Btc_deal_list;
import com.mvc.entity.Btc_inout_order;
import com.mvc.entity.Btc_order;
import com.mvc.entity.Btc_rechargeStock_order;
import com.mvc.service.DealService;
import com.mvc.service.OrderService;
import com.mvc.service.RechargeStockService;
import com.mvc.service.StockOrderService;
@Controller
@RequestMapping("/order.do")
public class OrderController {
	@Autowired
	private OrderService orders;
	@Autowired
	private DealService deals;
	@Autowired
	private RechargeStockService rstocks;
	@Autowired
	private StockOrderService wstocks;

	protected final transient Log log = LogFactory.getLog(OrderController.class);

	@RequestMapping(params="deleteorder")
	public void deleteorder(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String ids[] = request.getParameterValues("checkbox");
		int id = 0;
		Btc_order order = new Btc_order();
		if (ids != null) {
			for (int i = 0; i < ids.length; i++) {
				id = Integer.parseInt(ids[i]);
				order = orders.getByIdForBTCOrders(id);
				orders.deleteOrder(order);
			}
		}
		request.setAttribute("msg", "删除成功");
		response.sendRedirect("index.do?allorders");
	}
	@RequestMapping(params="ddeallist")
	public void ddeallist(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String ids[] = request.getParameterValues("checkbox");
		int id = 0;
		Btc_deal_list bdl = new Btc_deal_list();
		if (ids != null) {
			for (int i = 0; i < ids.length; i++) {
				id = Integer.parseInt(ids[i]);
				bdl = deals.getByDid(id);
				deals.deleteDealOrder(bdl);
			}
		}
		request.setAttribute("msg", "删除成功");
		response.sendRedirect("index.do?allorders");
	}
	
	@RequestMapping(params="drechargestocko")
	public void drechargestocko(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String ids[] = request.getParameterValues("checkbox");
		int id = 0;
		Btc_rechargeStock_order bro = new Btc_rechargeStock_order();
		if (ids != null) {
			for (int i = 0; i < ids.length; i++) {
				id = Integer.parseInt(ids[i]);
				bro = rstocks.getById(id);
				rstocks.deleteOrder(bro);
			}
		}
		request.setAttribute("msg", "删除成功");
		response.sendRedirect("index.do?rechargestockorder");
	}
	@RequestMapping(params="dwithdrawstocko")
	public void dwithdrawstocko(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String ids[] = request.getParameterValues("checkbox");
		int id = 0;
		Btc_inout_order bwo = new Btc_inout_order();
		if (ids != null) {
			for (int i = 0; i < ids.length; i++) {
				id = Integer.parseInt(ids[i]);
				bwo = wstocks.getBtc_inout_orderByid(id);
				wstocks.deleteStockOrder(bwo);
			}
		}
		request.setAttribute("msg", "删除成功");
		response.sendRedirect("index.do?withdrawstockorder");
	}
}
