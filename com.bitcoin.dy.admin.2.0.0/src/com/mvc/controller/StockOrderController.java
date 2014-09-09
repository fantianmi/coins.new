package com.mvc.controller;

import java.io.IOException;
import java.math.BigDecimal;

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
import com.mvc.entity.Btc_inAll;
import com.mvc.entity.Btc_incomeStock;
import com.mvc.entity.Btc_inout_order;
import com.mvc.entity.Btc_stock;
import com.mvc.entity.Btc_user;
import com.mvc.service.FinanceService;
import com.mvc.service.HoldingService;
import com.mvc.service.StockOrderService;
import com.mvc.service.StockService;
import com.mvc.service.UserService;
import com.mvc.util.PocketApi;
@Controller
@RequestMapping("/stockorders.do")
public class StockOrderController {
	@Autowired
	private PocketApi pocketApi = new PocketApi();
	@Autowired
	private UserService us = new UserService();
	@Autowired
	private HoldingService holdingService = new HoldingService();
	@Autowired
	private StockOrderService stockOrderService = new StockOrderService();
	@Autowired
	private StockService stocks = new StockService();
	@Autowired
	private FinanceService financeService = new FinanceService();
	@Autowired
	private HoldingService holds = new HoldingService();

	protected final transient Log log = LogFactory.getLog(StockOrderController.class);

	/**
	 * 生成订单，并从用户帐本中扣除相应费用
	 * 
	 * @param modelmap
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(params="makeOrder")
	public String makeOrder(HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		String type = request.getParameter("type");
		String bwo_id[] = request.getParameterValues("checkbox");
		Btc_inout_order bio = new Btc_inout_order();
		Btc_inAll btc_inAll = new Btc_inAll();
		Btc_stock stock = new Btc_stock();
		
		String bro_idToJsp = "已处理订单号为";
		if(type.equals("withdraw")){
			if (bwo_id != null) {
				for (int i = 0; i < bwo_id.length; i++) {
					bio = stockOrderService.getBtc_inout_orderByid(Integer.parseInt(bwo_id[i]));
					BigDecimal withdrawAmount = bio.getBtc_inout_amount();
					withdrawAmount = withdrawAmount.subtract(bio.getBtc_inout_poundage());
					//##########################################
					stock = stocks.getBtc_stockById(bio.getBtc_stock_id());
					String rpcusername = stock.getRpcusername();
					String rpcpassword = stock.getRpcpassword();
					String rpcpocketadr = stock.getBtc_stock_pocket_adr();
					String rpcport = stock.getBtc_stock_port();
					String adr = bio.getBtc_inout_adr();
					double amount = withdrawAmount.doubleValue();
					pocketApi.withdrawOrder(rpcusername, rpcpassword, rpcpocketadr, rpcport, adr, amount);
					//##########################################
					bio.setBtc_inout_status("已处理");
					bio.setBtc_inout_msg("已将" + withdrawAmount + "到充值到您的钱包，请查收(扣除手续费)");
					stockOrderService.updateStockOrder(bio);
					bro_idToJsp = bro_idToJsp + bwo_id[i];
					//
					Btc_user user = us.getByUserId(bio.getUid());
					Btc_incomeStock incomestock = new Btc_incomeStock();
					incomestock.setBtc_incomeStock_amount(bio.getBtc_inout_poundage());
					incomestock.setBtc_incomeStock_name(stock.getBtc_stock_name());
					incomestock.setBtc_incomeStock_reason(user.getUusername()
							+ "进行山寨币提现了" + bio.getBtc_inout_amount());
					
					incomestock.setBtc_incomeStock_time(bio.getBtc_inout_time());
	
					financeService.saveIncomeStock(incomestock);
	
					btc_inAll = financeService.getInAll_ByName(stock.getBtc_stock_Eng_name());
					btc_inAll.setBtc_inAll_amount(btc_inAll.getBtc_inAll_amount().subtract(
							bio.getBtc_inout_amount().subtract(bio.getBtc_inout_poundage())));
					financeService.updateInAll(btc_inAll);
	
				}
			}
		}
		bro_idToJsp = "|" + bro_idToJsp + "|" + "的订单";
		request.setAttribute("msg", bro_idToJsp);
		request.setAttribute("href", "index.do?withdrawstockorder");
		return "index";
	}
	@RequestMapping(params="cancelByUser")
	public String cancel(@RequestParam("id")int orderid,HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		if(session.getAttribute("uid")==null){
			request.setAttribute("msg", "登陆超时，请重新登陆");
			request.setAttribute("href", "index.do");
			return "index";
		}
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		Btc_inout_order order = stockOrderService.getBtc_inout_orderByid(orderid);
		if(uid!=order.getUid()){
			request.setAttribute("msg", "非法操作！");
			request.setAttribute("href", "index.do");
			return "index";
		}
		order.setBtc_inout_status("已处理");
		order.setBtc_inout_msg("用户自己取消订单");
		stockOrderService.updateStockOrder(order);
		
		int stock_id = Integer.parseInt(session.getAttribute("stockId").toString());
		Btc_holding userhold = holdingService.getBtc_holding(uid, stock_id);
		BigDecimal amount = order.getBtc_inout_amount();
		
		userhold.setBtc_stock_amount(userhold.getBtc_stock_amount().add(amount));
		holdingService.updateBtc_holding(userhold);
		request.setAttribute("msg", "已成功撤销订单");
		request.setAttribute("href", "index.do");
		return "index";
	}
	
	@RequestMapping(params="cancelByAdmin")
	public String cancelByAdmin(HttpServletRequest request,
			HttpServletResponse response) {
		String type = request.getParameter("type");
		String bwo_id[] = request.getParameterValues("checkbox");
		Btc_inout_order bio = new Btc_inout_order();
		
		String msg = "已处理订单号为";
		if(type.equals("withdraw")){
			if (bwo_id != null) {
				for (int i = 0; i < bwo_id.length; i++) {
					bio = stockOrderService.getBtc_inout_orderByid(Integer.parseInt(bwo_id[i]));
					BigDecimal withdrawAmount = bio.getBtc_inout_amount();
					//##########################################
					Btc_holding hold = holds.getBtc_holding(bio.getUid(), bio.getBtc_stock_id());
					hold.setBtc_stock_amount(hold.getBtc_stock_amount().add(withdrawAmount));
					holds.updateBtc_holding(hold);
					//##########################################
					bio.setBtc_inout_status("已处理");
					bio.setBtc_inout_msg("不能给您提现，已将" + withdrawAmount + "到返回到您的平台账户中，具体原因请联系平台客服人员");
					stockOrderService.updateStockOrder(bio);
					msg = msg + "【"+bwo_id[i]+"】";
				}
			}
		}
		msg = msg + "的订单";
		request.setAttribute("msg", msg);
		request.setAttribute("href", "index.do?withdrawstockorder");
		return "index";
	}
}
