package com.mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;
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

import com.mvc.config.CoinConfig;
import com.mvc.entity.Btc_account_book;
import com.mvc.entity.Btc_holding;
import com.mvc.entity.Btc_inout_order;
import com.mvc.entity.Btc_rechargeStock_order;
import com.mvc.entity.Btc_stock;
import com.mvc.entity.Btc_user;
import com.mvc.service.AccountService;
import com.mvc.service.HoldingService;
import com.mvc.service.RechargeStockService;
import com.mvc.service.StockOrderService;
import com.mvc.service.StockService;
import com.mvc.util.AccountBookUtil;
import com.mvc.util.DataUtil;
import com.mvc.util.HoldingUtil;
import com.mvc.util.MD5Util;
import com.mvc.util.PocketApi;
@Controller
@RequestMapping("/coinProcess.do")
public class CoinController {
	@Autowired
	private PocketApi pocketApi = new PocketApi();
	@Autowired
	private StockService stocks = new StockService();
	@Autowired
	private RechargeStockService rss = new RechargeStockService();
	@Autowired
	private HoldingService hs = new HoldingService();
	@Autowired
	private DataUtil datautil;
	@Autowired
	private HoldingUtil holdUtil;
	@Autowired
	private HoldingService holdingServ;
	@Autowired
	private AccountBookUtil accountBookUtil;
	@Autowired
	private AccountService accountServ;
	@Autowired
	private StockOrderService stockOrderServ;

	protected final transient Log log = LogFactory.getLog(CoinController.class);

	/**
	 * 生成订单，并从用户帐本中扣除相应费用
	 * 
	 * @param modelmap
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(params="generalAdr")
	public String createOrder(
			@RequestParam("stockid")int stockid, 
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("globaluser")==null){
			request.setAttribute("msg", "登陆超时，请重新登陆");
			request.setAttribute("href", "index.do");
			return "index";
		}
		Btc_user user = (Btc_user)session.getAttribute("globaluser");
		if (user.getUname() == null) {
			response.sendRedirect("index.do?register2");
			return null;
		}
		Btc_stock stock = new Btc_stock();
		stock = stocks.getBtc_stockById(stockid);
		String rpcusername = stock.getRpcusername();
		String rpcpassword = stock.getRpcpassword();
		String rpcpocketadr = stock.getBtc_stock_pocket_adr();
		String rpcport = stock.getBtc_stock_port();
		String username = user.getUusername();
		String adr = pocketApi.generalpaymentsadr(rpcusername, rpcpassword, rpcpocketadr, rpcport, username);
		if(adr==null){
			adr = stock.getBtc_stock_recharge_adr();
		}
		request.setAttribute("stock", stock);
		request.setAttribute("rechargeadr", adr);
		if(rss.getAllByUid(user.getUid(), stockid)!=null){
			request.setAttribute("orderlist", rss.getAllByUid(user.getUid(), stockid));
		}
		return "rechargeStock";
	}
	
	@RequestMapping(params="syn")
	public void syn(
			@RequestParam("stockid")int stockid, 
			@RequestParam("adr")String adr, 
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		//##############################################
		String msg = "";
		String href = "nohref";
		PrintWriter out = response.getWriter();
		response.setContentType("text/xml; charset=UTF-8");// 设置输出信息的格式及字符集
		response.setHeader("Cache-Control", "no-cache");
		//#############################################
		HttpSession session = request.getSession();
		if(session.getAttribute("globaluser")==null){
			msg = "登陆超时，请重新登陆";
			href= "index.do";
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		Btc_user user = (Btc_user)session.getAttribute("globaluser");
		Btc_stock stock = new Btc_stock();
		stock = stocks.getBtc_stockById(stockid);
		String rpcusername = stock.getRpcusername();
		String rpcpassword = stock.getRpcpassword();
		String rpcpocketadr = stock.getBtc_stock_pocket_adr();
		String rpcport = stock.getBtc_stock_port();
		String username = user.getUusername();
		
		double amount = pocketApi.getAccountInfo(rpcusername, rpcpassword, rpcpocketadr, rpcport, username);
		BigDecimal bamount = new BigDecimal(amount);
		Btc_rechargeStock_order brso = new Btc_rechargeStock_order();
		//配置的充值最小金额
		BigDecimal rechargezxz = stock.getRechargezxz();
		
		BigDecimal amountlog = rss.getOrderAmount(user.getUid(), "已同步到平台账户", stockid);
		if(bamount.subtract(amountlog).compareTo(rechargezxz)<0){
			msg = "同步完成，同步金额0.00,创建订单失败，请确认充值了"+rechargezxz+"个以上币之后再点击";
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		//创建订单
		BigDecimal ramount = bamount.subtract(amountlog);
		brso.setAdr(adr);
		brso.setAmount(ramount);
		brso.setDate(datautil.getTimeNow("second"));
		brso.setStatus("已同步到平台账户");
		brso.setStockid(stockid);
		brso.setUid(user.getUid());
		rss.saveOrder(brso);
		//记录平台收入
		accountBookUtil.addStockAccount(stock.getBtc_stock_Eng_name(), ramount);
		
		//如果stockid=莱特币（1001）main.coin
		int mainCoinId=Integer.parseInt(CoinConfig.getMainCoin());
		if(stockid==mainCoinId){
			holdUtil.addMoney(user.getUid(), ramount);
			msg = "同步完成，同步金额"+ramount+",请在您的账户中查收";
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		//修改用户持有量
		Btc_holding hold = new Btc_holding();
		if(hs.getBtc_holding(user.getUid(), stockid)==null){
			hold.setBtc_stock_amount(ramount);
			hold.setBtc_stock_id(stockid);
			hold.setUid(user.getUid());
			hs.saveBtc_holding(hold);
			msg = "同步完成，同步金额"+ramount+",请在您的账户中查收";
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}else{
			hold = hs.getBtc_holding(user.getUid(), stockid);
			hold.setBtc_stock_amount(hold.getBtc_stock_amount().add(ramount));
			hs.updateBtc_holding(hold);
			msg = "同步完成，同步金额"+ramount+"，请在您的账户中查收";
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}
	}
	
	//虚拟币提现
	@RequestMapping(params="withdrawStock")
	public String createOrder(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		if(session.getAttribute("globaluser")==null){
			request.setAttribute("msg", "登陆超时，请重新登陆");
			request.setAttribute("href", "index.do");
			return "redirect";
		}
		if(request.getParameter("btc_inout_adr")==""&&request.getParameter("btc_inout_amount")==""&&
				request.getParameter("utpassword")==""&&
					request.getParameter("stockId")==""){
			request.setAttribute("msg", "对不起，请确认表单是否填完整");
			return "redirect";
		}
		Btc_user user = (Btc_user)session.getAttribute("globaluser");
		String utpassword = MD5Util.encode2hex(request.getParameter("utpassword"));
		if(user.getUtpasswod().equals(utpassword)==false){
			request.setAttribute("msg", "交易密码错误");
			request.setAttribute("href", "back");
			return "redirect";
		}
		int uid = user.getUid();
		int stock_id = Integer.parseInt(request.getParameter("stockId").toString());
		int mainStockId=Integer.parseInt(CoinConfig.getMainCoin());
		BigDecimal amount = new BigDecimal(request.getParameter("btc_inout_amount").toString());
		if(stock_id!=mainStockId){
			Btc_holding userhold = holdingServ.getBtc_holding(uid, stock_id);
			if(userhold==null){
				request.setAttribute("msg", "对不起，您账户中余额不足，请确认");
				request.setAttribute("href", "back");
				return "redirect";
			}
			if(userhold.getBtc_stock_amount().compareTo(amount)==-1){
				request.setAttribute("msg", "对不起，您账户中余额不足，请确认");
				request.setAttribute("href", "back");
				return "redirect";
			}
		}else{
			Btc_account_book account=accountServ.getByUidForAcount(uid);
			if(account==null){
				request.setAttribute("msg", "对不起，您账户中余额不足，请确认");
				request.setAttribute("href", "back");
				return "redirect";
			}
			BigDecimal coinLeft=account.getAb_cny();
			if(coinLeft.compareTo(amount)<0){
				request.setAttribute("msg", "对不起，您账户中余额不足，请确认");
				request.setAttribute("href", "back");
				return "redirect";
			}
		}
		
		Btc_stock stock = stocks.getBtc_stockById(stock_id);
		
		BigDecimal withdrawzdz = stock.getWithdrawzdz();
		BigDecimal withdrawzxz = stock.getWithdrawzxz();
		
		if (amount.compareTo(withdrawzxz) == -1) {
			request.setAttribute("msg", "提现金额少于" + withdrawzxz
					+ "元，系统不予受理，请重新输入");
			request.setAttribute("href", "back");
			return "redirect";
		}
		if (amount.add(stockOrderServ.getCountBtc_inout_orderByUid(user.getUid(), stock_id)).compareTo(
				withdrawzdz) == 1) {
			request.setAttribute("msg", "对不起，您输入的提现金额超过了您今天的提取上限，请重新输入");
			request.setAttribute("href", "back");
			return "redirect";
		}
		String adr = request.getParameter("btc_inout_adr").toString();
		BigDecimal poundage = stock.getWithdrawsxf();
		SimpleDateFormat format = new SimpleDateFormat(
		"yyyy/MM/dd HH:mm:ss");
		String time = format.format(new Date());
		Btc_inout_order order = new Btc_inout_order();
		order.setBtc_inout_adr(adr);
		order.setBtc_inout_amount(amount);
		order.setBtc_inout_msg("系统正在处理，请耐心等待");
		order.setBtc_inout_status("未处理");
		order.setBtc_inout_time(time);
		order.setBtc_inout_type("withdraw");
		order.setBtc_stock_id(stock_id);
		order.setUid(uid);
		order.setBtc_inout_poundage(poundage);
		stockOrderServ.saveStockOrder(order);
		
		//如果stockid=莱特币，则按照人民币处理
		if(stock_id==Integer.parseInt(CoinConfig.getMainCoin())){
			holdUtil.subMoney(uid, amount);
		}else{
			holdUtil.subStock(uid, stock_id, amount);
		}
		request.setAttribute("msg", "提现申请提交成功，请耐心等待");
		request.setAttribute("href", "index.do?usercenter");
		return "redirect";
	}
}
