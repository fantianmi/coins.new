package com.mvc.controller;

import java.math.BigDecimal;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
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
import com.mvc.service.FinanceService;
import com.mvc.service.RechargeService;
import com.mvc.util.HoldingUtil;

@Controller
@RequestMapping("/paysuccess4zhifu.do")
public class PayResult4zhifuController {
	@Autowired
	private RechargeService rs = new RechargeService();
	@Autowired
	private FinanceService financeService = new FinanceService();
	@Autowired
	private HoldingUtil holdutil;
	ResourceBundle payres = ResourceBundle.getBundle("zhifu");
	ResourceBundle stockres = ResourceBundle.getBundle("stock");

	protected final transient Log log = LogFactory
			.getLog(RechargeController.class);

	@RequestMapping
	public String load(ModelMap modelMap, HttpServletRequest request) {
		//获取智付反馈的信息
		//商户号
		String merchant_code	= request.getParameter("merchant_code");
		//通知类型
		String notify_type = request.getParameter("notify_type");
		//通知校验ID
		String notify_id = request.getParameter("notify_id");
		//签名
		String dinpaySign = request.getParameter("sign");
		//商家订单号
		String order_no = request.getParameter("order_no");
		//商家订单时间
		String order_time = request.getParameter("order_time");
		//商家订单金额
		String order_amount = request.getParameter("order_amount");
		//回传参数
		String extra_return_param = request.getParameter("extra_return_param");
		//智付交易定单号
		String trade_no = request.getParameter("trade_no");
		//智付交易时间
		String trade_time = request.getParameter("trade_time");
		//交易状态 SUCCESS 成功  FAILED 失败
		String trade_status = request.getParameter("trade_status");
		//银行交易流水号
		String bank_seq_no = request.getParameter("bank_seq_no");
		/**
		 *签名顺序按照参数名a到z的顺序排序，若遇到相同首字母，则看第二个字母，以此类推，
		*同时将商家支付密钥key放在最后参与签名，组成规则如下：
		*参数名1=参数值1&参数名2=参数值2&……&参数名n=参数值n&key=key值
		**/
		//组织订单信息
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
		String sign = DigestUtils.md5Hex(signInfo); //注意与支付签名不同  此处对String进行加密
		//比较智付返回的签名串与商家这边组装的签名串是否一致
		if(dinpaySign.equals(sign)) {
			/*
			 * do process
			 */
			Btc_rechargeCNY_order bro = rs.getByBillNoForOrders(order_no);
			if (trade_status.equals("FAILED")) {
				bro.setBro_remark("充值失败，请重新充值");
				bro.setBro_state(1);
				rs.updateRechargeCNY_Order(bro);
				request.setAttribute("errormsg","充值操作失败");
				return "payfail";
			}
			
			Btc_inAll btc_inAll = new Btc_inAll();
			Btc_profit profit = new Btc_profit();
			
			if (bro.getBro_state() == 1) {
				request.setAttribute("errormsg", "请勿重复刷新");
				return "payfail";
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
			return "paysuccess";
			//end
		}else
	        {
			//验签失败 业务结束
			request.setAttribute("errormsg", "签名错误");
			return "payfail";
		}
	}
}
