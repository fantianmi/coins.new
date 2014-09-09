package com.mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mvc.entity.Btc_inAll;
import com.mvc.entity.Btc_incomeCNY;
import com.mvc.entity.Btc_profit;
import com.mvc.entity.Btc_rechargeCNY_order;
import com.mvc.service.AccountService;
import com.mvc.service.FinanceService;
import com.mvc.service.HoldingService;
import com.mvc.service.ProfitService;
import com.mvc.service.RechargeService;
import com.mvc.service.UserService;
import com.mvc.service.pay.PaymentForOnlineService;
import com.mvc.util.FormatUtil;
import com.mvc.util.HoldingUtil;
import com.mvc.util.MD5Util;

@Controller
@RequestMapping("/payprocess4zhifu.do")
public class PayProcess4zhifuController {
	@Autowired
	private UserService us = new UserService();
	@Autowired
	private AccountService as = new AccountService();
	@Autowired
	private RechargeService rs = new RechargeService();
	@Autowired
	private HoldingService holdingService = new HoldingService();
	@Autowired
	private FinanceService financeService = new FinanceService();
	@Autowired
	private ProfitService profitService = new ProfitService();
	@Autowired
	private MD5Util md5util;
	@Autowired
	private FormatUtil format;
	@Autowired
	private HoldingUtil holdutil;
	ResourceBundle payres = ResourceBundle.getBundle("zhifu");
	ResourceBundle stockres = ResourceBundle.getBundle("stock");

	protected final transient Log log = LogFactory
			.getLog(RechargeController.class);

	@RequestMapping
	public void load(ModelMap modelMap, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		String merchant_code	= request.getParameter("merchant_code");
		String notify_type = request.getParameter("notify_type");
		String notify_id = request.getParameter("notify_id");
		String interface_version = request.getParameter("interface_version");
		String sign_type = request.getParameter("sign_type");
		String dinpaySign = request.getParameter("sign");
		String order_no = request.getParameter("order_no");
		String order_time = request.getParameter("order_time");
		String order_amount = request.getParameter("order_amount");
		String extra_return_param = request.getParameter("extra_return_param");
		String trade_no = request.getParameter("trade_no");
		String trade_time = request.getParameter("trade_time");
		String trade_status = request.getParameter("trade_status");
		String bank_seq_no = request.getParameter("bank_seq_no");
		StringBuilder signStr = new StringBuilder();
		if(null != bank_seq_no && !bank_seq_no.equals("")) {
			signStr.append("bank_seq_no=").append(bank_seq_no).append("&");
		}
		if(null != extra_return_param && !extra_return_param.equals("")) {
			signStr.append("extra_return_param=").append(extra_return_param).append("&");
		}
		signStr.append("interface_version=V3.0").append("&");
		signStr.append("merchant_code=").append(merchant_code).append("&");
		if(null != notify_id && !notify_id.equals("")) {
			signStr.append("notify_id=").append(notify_id).append("&notify_type=").append(notify_type).append("&");
		}
		signStr.append("order_amount=").append(order_amount).append("&");
		signStr.append("order_no=").append(order_no).append("&");
		signStr.append("order_time=").append(order_time).append("&");
		signStr.append("trade_no=").append(trade_no).append("&");
		signStr.append("trade_status=").append(trade_status).append("&");
		if(null != trade_time && !trade_time.equals("")) {
			signStr.append("trade_time=").append(trade_time).append("&");
		}
		String key=payres.getString("key");
		signStr.append("key=").append(key);
		String signInfo = signStr.toString();
		//将组装好的信息MD5签名
		String sign =md5util.encode2hex(signInfo); 
		System.out.println("************"+sign+"*********************");
		System.out.println("************"+dinpaySign+"*********************");
		if(!dinpaySign.equals(sign)){
			System.out.println("md5码不匹配");
			out.println("SUCCESS");
			return;
		}
		/**
		 * process start
		 */
		Btc_rechargeCNY_order bro = rs.getByBillNoForOrders(order_no);
		if (trade_status.equals("FAILED")) {
			bro.setBro_remark("充值失败，请重新充值");
			bro.setBro_state(1);
			rs.updateRechargeCNY_Order(bro);
			out.println("SUCCESS");
			out.close();
			return;
		}
		
		Btc_inAll btc_inAll = new Btc_inAll();
		Btc_profit profit = new Btc_profit();
		
		if (bro.getBro_state() == 1) {
			out.println("SUCCESS");
			out.close();
			return;
		}
		holdutil.addMoney(bro.getUid(), bro.getBro_recharge_acount());
		bro.setBro_remark("已充值" + bro.getBro_recharge_acount() + "元到您的平台账户");
		bro.setBro_state(1);
		rs.updateRechargeCNY_Order(bro);
		
		if (bro.getBro_recharge_acount().compareTo(new BigDecimal(10)) >= 0
				&& profit.getRechargecny_getpgc().compareTo(new BigDecimal(0)) >= 0) {
			BigDecimal award = profit.getRechargecny_getpgc();
			holdutil.addStock(bro.getUid(), Integer.parseInt(stockres.getString("cny.rechargeaward.stockid")), award);
		}

		BigDecimal rechargeCNY_poundage = bro.getBro_factorage();
		Btc_incomeCNY btc_incomeCNY = new Btc_incomeCNY();
		btc_incomeCNY.setBtc_incomeCNY_amount(rechargeCNY_poundage);
		btc_incomeCNY.setBtc_incomeCNY_reason(bro.getUid() + "进行人民币充值了"
				+ bro.getBro_recharge_acount());
		btc_incomeCNY.setBtc_incomeCNY_time(bro.getBro_recharge_time());
		financeService.saveIncomeCNY(btc_incomeCNY);
		
		btc_inAll = financeService.getInAll_ByName("CNY");
		btc_inAll.setBtc_inAll_amount(btc_inAll.getBtc_inAll_amount().add(bro.getBro_recharge_acount()));
		financeService.updateInAll(btc_inAll);
		out.println("SUCCESS");
		out.close();
	}
}
