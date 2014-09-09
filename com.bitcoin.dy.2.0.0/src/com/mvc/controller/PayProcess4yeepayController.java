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
@RequestMapping("/payprocess4yeepay.do")
public class PayProcess4yeepayController {
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
	ResourceBundle payres = ResourceBundle.getBundle("pay");
	ResourceBundle stockres = ResourceBundle.getBundle("stock");

	protected final transient Log log = LogFactory
			.getLog(RechargeController.class);

	@RequestMapping
	public void rechargeCNY(ModelMap modelMap, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		
		String keyValue   = format.formatString(payres.getString("keyValue"));   // 商家密钥
		String r0_Cmd 	  = format.formatString(request.getParameter("r0_Cmd")); // 业务类型
		String p1_MerId   = format.formatString(payres.getString("MerId"));   // 商户编号
		String r1_Code    = format.formatString(request.getParameter("r1_Code"));// 支付结果
		String r2_TrxId   = format.formatString(request.getParameter("r2_TrxId"));// 易宝支付交易流水号
		String r3_Amt     = format.formatString(request.getParameter("r3_Amt"));// 支付金额
		String r4_Cur     = format.formatString(request.getParameter("r4_Cur"));// 交易币种
		String r5_Pid     = new String(format.formatString(request.getParameter("r5_Pid")).getBytes("iso-8859-1"),"utf-8");// 商品名称
		String r6_Order   = format.formatString(request.getParameter("r6_Order"));// 商户订单号
		String r7_Uid     = format.formatString(request.getParameter("r7_Uid"));// 易宝支付会员ID
		String r8_MP      = new String(format.formatString(request.getParameter("r8_MP")).getBytes("iso-8859-1"),"utf-8");// 商户扩展信息
		String r9_BType   = format.formatString(request.getParameter("r9_BType"));// 交易结果返回类型
		String hmac       = format.formatString(request.getParameter("hmac"));// 签名数据
		
		boolean isOK = false;
		isOK = PaymentForOnlineService.verifyCallback(hmac,p1_MerId,r0_Cmd,r1_Code, 
				r2_TrxId,r3_Amt,r4_Cur,r5_Pid,r6_Order,r7_Uid,r8_MP,r9_BType,keyValue);
		if(isOK) {
			//在接收到支付结果通知后，判断是否进行过业务逻辑处理，不要重复进行业务逻辑处理
			if(r1_Code.equals("1")) {
				// 产品通用接口支付成功返回-浏览器重定向
				if(r9_BType.equals("1")) {
					out.println("callback方式:产品通用接口支付成功返回-浏览器重定向");
					// 产品通用接口支付成功返回-服务器点对点通讯
				} else if(r9_BType.equals("2")) {
					// 如果在发起交易请求时	设置使用应答机制时，必须应答以"success"开头的字符串，大小写不敏感
					out.println("SUCCESS");
				  // 产品通用接口支付成功返回-电话支付返回		
				}
			}
		} else {
			out.println("交易签名被篡改!");
		}
		
		Btc_rechargeCNY_order bro = rs.getByBillNoForOrders(r6_Order);
		if (!r1_Code.equals("1")) {
			bro.setBro_remark("充值失败，请重新充值");
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
		response.sendRedirect("paysuccess.do");
	}
}
