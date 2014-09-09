package com.mvc.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mvc.entity.Btc_account_book;
import com.mvc.entity.Btc_holding;
import com.mvc.entity.Btc_inAll;
import com.mvc.entity.Btc_incomeCNY;
import com.mvc.entity.Btc_profit;
import com.mvc.entity.Btc_rechargeCNY_order;
import com.mvc.entity.Btc_user;
import com.mvc.entity.Btc_withdrawCNY_order;
import com.mvc.service.AccountService;
import com.mvc.service.FinanceService;
import com.mvc.service.HoldingService;
import com.mvc.service.ProfitService;
import com.mvc.service.RechargeService;
import com.mvc.service.UserService;
import com.mvc.util.CookieHelper;
import com.mvc.util.FormatUtil;

@Controller
@RequestMapping("/rechargetouser.do")
public class RechargeController {
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
	private FormatUtil format;

	protected final transient Log log = LogFactory
			.getLog(RechargeController.class);

	@RequestMapping
	public String load(ModelMap modelMap, HttpServletRequest request) {
		return "index";
	}

	@RequestMapping(params = "logout")
	public String logout(ModelMap modelMap, HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		CookieHelper cookieHelp = new CookieHelper();
		Cookie cookieName = cookieHelp.removeCookie(request, "uusername");
		Cookie cookiePassword = cookieHelp.removeCookie(request, "upassword");
		response.addCookie(cookieName);
		response.addCookie(cookiePassword);
		session.removeAttribute("uusername");
		session.removeAttribute("uname");
		session.removeAttribute("isRegister2");
		request.setAttribute("msg", "logoutSucess");
		return "index";
	}

	@RequestMapping(params = "buybtc")
	public String buybtc(ModelMap modelmap, HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (session.getAttribute("uusername").toString() == null) {
			request.setAttribute("msg", "loginfirst");
			return "index";
		} else {
			String uusername = session.getAttribute("uusername").toString();
			Btc_user user = us.getByUsername(uusername);
			if (user.getUname() == null && user.getUcertification() == null) {
				return "register2";
			} else {
				return "buybtc";
			}
		}
	}

	@RequestMapping(params = "makeWithdrawCNY")
	public String makeWithdrawCNY(HttpServletRequest request,
			HttpServletResponse response) {
		String bwo_id[] = request.getParameterValues("checkbox");
		Btc_withdrawCNY_order bwo = new Btc_withdrawCNY_order();
		Btc_inAll btc_inAll = new Btc_inAll();
		String bro_idToJsp = "已处理订单号为";
		if (bwo_id != null) {
			for (int i = 0; i < bwo_id.length; i++) {
				bwo = rs.getByBwoIdForWithdrawCNYOrders(Integer.parseInt(bwo_id[i]));
				BigDecimal withdrawAmount = bwo.getBtc_bwo_amount();
				withdrawAmount = withdrawAmount.subtract(bwo.getBtc_bwo_poundage());
				bwo.setBtc_bwo_state(1);
				bwo.setBtc_bwo_content("已将" + format.trans(withdrawAmount) + "到您的平台账户(扣除手续费后的余额)");
				SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				String btc_bwo_handle_time = format.format(new Date());
				bwo.setBtc_bwo_handle_time(btc_bwo_handle_time);
				rs.updateWithdrawCNY(bwo);
				bro_idToJsp = bro_idToJsp + bwo_id[i];
				//
				Btc_user user = us.getByUserId(bwo.getUid());
				BigDecimal withdrawCNY_poundage = bwo.getBtc_bwo_poundage();
				Btc_incomeCNY btc_incomeCNY = new Btc_incomeCNY();
				btc_incomeCNY.setBtc_incomeCNY_amount(withdrawCNY_poundage);
				btc_incomeCNY.setBtc_incomeCNY_reason(user.getUusername()
						+ "进行人民币提现了" + bwo.getBtc_bwo_amount());
				btc_incomeCNY.setBtc_incomeCNY_time(bwo.getBtc_bwo_time());

				financeService.saveIncomeCNY(btc_incomeCNY);

				btc_inAll = financeService.getInAll_ByName("CNY");
				btc_inAll.setBtc_inAll_amount(btc_inAll.getBtc_inAll_amount().subtract(
						bwo.getBtc_bwo_amount().subtract(bwo.getBtc_bwo_poundage())));
				financeService.updateInAll(btc_inAll);

			}
		}

		bro_idToJsp = "|" + bro_idToJsp + "|" + "的订单";
		request.setAttribute("msg", bro_idToJsp);
		request.setAttribute("href", "index.do?withrawCNYorders");
		return "withrawCNYorders";
	}

	@RequestMapping(params = "rejectWithdrawCNY")
	public String rejectWithdrawCNY(HttpServletRequest request,
			HttpServletResponse response) {
		String bwo_id[] = request.getParameterValues("checkbox");
		Btc_withdrawCNY_order bwo = new Btc_withdrawCNY_order();
		Btc_account_book ab_acount = new Btc_account_book();
		String bro_idToJsp = "已拒绝订单号为";
		if (bwo_id != null) {
			for (int i = 0; i < bwo_id.length; i++) {
				bwo = rs.getByBwoIdForWithdrawCNYOrders(Integer.parseInt(bwo_id[i]));
				bwo.setBtc_bwo_state(1);
				bwo.setBtc_bwo_content("您填写的订单不符合规范，请联系客服并重新提交，申请提现金额"
						+ format.trans(bwo.getBtc_bwo_amount()) + "已自动返入您的账户中(不收取任何手续费)");
				SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				String btc_bwo_handle_time = format.format(new Date());
				bwo.setBtc_bwo_handle_time(btc_bwo_handle_time);
				rs.updateWithdrawCNY(bwo);
				bro_idToJsp = bro_idToJsp + bwo_id[i];
				//
				Btc_user user = us.getByUserId(bwo.getUid());
				ab_acount = as.getByUidForAcount(user.getUid());
				ab_acount.setAb_cny(ab_acount.getAb_cny().add(bwo.getBtc_bwo_amount()));
				as.updateAccount_Book(ab_acount);
			}
		}

		bro_idToJsp = "|" + bro_idToJsp + "|" + "的订单";
		request.setAttribute("msg", bro_idToJsp);
		request.setAttribute("href", "index.do?withrawCNYorders");
		return "withrawCNYorders";
	}

	@RequestMapping(params = "deleteWithdrawCNY")
	public String deleteWithdrawCNY(HttpServletRequest request,
			HttpServletResponse response) {
		String bwo_id[] = request.getParameterValues("checkbox");
		Btc_withdrawCNY_order bwo = new Btc_withdrawCNY_order();
		Btc_account_book ab_acount = new Btc_account_book();
		String bro_idToJsp = "已删除订单号为";
		if (bwo_id != null) {
			for (int i = 0; i < bwo_id.length; i++) {
				bwo = rs.getByBwoIdForWithdrawCNYOrders(Integer.parseInt(bwo_id[i]));
				bro_idToJsp = bro_idToJsp + bwo_id[i];
				//
				Btc_user user = us.getByUserId(bwo.getUid());
				ab_acount = as.getByUidForAcount(user.getUid());
				ab_acount.setAb_cny(ab_acount.getAb_cny().add(bwo.getBtc_bwo_amount()));
				as.updateAccount_Book(ab_acount);
				rs.deleteWithdrawCNY_Order(bwo);
			}
		}

		bro_idToJsp = "|" + bro_idToJsp + "|" + "的订单";
		request.setAttribute("msg", bro_idToJsp);
		request.setAttribute("href", "index.do?withrawCNYorders");
		return "withrawCNYorders";
	}
	
	@RequestMapping(params = "dwithdrawcnyo")
	public String dwithdrawcnyo(HttpServletRequest request,
			HttpServletResponse response) {
		String ids[] = request.getParameterValues("checkbox");
		Btc_withdrawCNY_order bwo = new Btc_withdrawCNY_order();
		if (ids != null) {
			for (int i = 0; i < ids.length; i++) {
				bwo = rs.getByBwoIdForWithdrawCNYOrders(Integer.parseInt(ids[i]));
				rs.deleteWithdrawCNY_Order(bwo);
			}
		}
		
		String msg = "删除成功";
		request.setAttribute("msg", msg);
		request.setAttribute("href", "index.do?withrawCNYorders");
		return "withrawCNYorders";
	}

	@RequestMapping(params = "CNY")
	public String recharge(ModelMap modelmap, HttpServletRequest request,
			HttpServletResponse response) {
		String bro_id[] = request.getParameterValues("checkbox");
		Btc_rechargeCNY_order bro = new Btc_rechargeCNY_order();
		Btc_account_book bab = new Btc_account_book();
		Btc_inAll btc_inAll = new Btc_inAll();
		String bro_idToJsp = "已处理订单号为";
		if (bro_id != null) {
			for (int i = 0; i < bro_id.length; i++) {
				bro = rs.getByBroIdForOrders(Integer.parseInt(bro_id[i]));
				BigDecimal rechargeAmount = bro.getBro_recharge_acount();
				rechargeAmount = rechargeAmount.subtract(bro.getBro_factorage());
				bro.setBro_state(1);
				bro.setBro_remark("已充值" + format.trans(rechargeAmount) + "到您的平台账户(已扣除手续费)");
				rs.updateRechargeCNY_Order(bro);
				bro = rs.getByBroIdForOrders(Integer.parseInt(bro_id[i]));
				int uid = bro.getUid();
				Btc_account_book babflag = as.getByUidForAcount(uid);
				if (babflag == null) {
					bab.setUid(uid);
					bab.setAb_cny(rechargeAmount);
					as.saveAccount_Book(bab);
				} else {
					bab = as.getByUidForAcount(uid);
					bab.setAb_cny(babflag.getAb_cny().add(rechargeAmount));
					as.updateAccount_Book(bab);
				}
				bro_idToJsp = bro_idToJsp + bro_id[i];
				//
				Btc_user user = us.getByUserId(bro.getUid());
				us.updateUser(user);
				//判断是否存在推荐人
				Btc_user tuijieren = new Btc_user();
				if(user.getUinvite_username()!=null){
					tuijieren = us.getByUsername(user.getUinvite_username());
					Btc_profit bf = profitService.getConfig();
					BigDecimal ugetrate = bf.getBtc_profit_profit_inviteUser_get();
					BigDecimal uget = rechargeAmount.multiply(ugetrate);
					Btc_holding hold = new Btc_holding();
					if(holdingService.getBtc_holding(tuijieren.getUid(), 10000002)==null){
						hold.setBtc_stock_amount(uget);
						hold.setBtc_stock_id(10000002);
						hold.setUid(tuijieren.getUid());
						holdingService.saveBtc_holding(hold);
					}else{
						hold = holdingService.getBtc_holding(tuijieren.getUid(), 10000002);
						hold.setBtc_stock_amount(hold.getBtc_stock_amount().add(uget));
						holdingService.updateBtc_holding(hold);
					}
				}
			
				Btc_profit btc_profit = profitService.getConfig();
				BigDecimal rechargeCNY_poundage = bro.getBro_factorage();
				Btc_incomeCNY btc_incomeCNY = new Btc_incomeCNY();
				btc_incomeCNY.setBtc_incomeCNY_amount(rechargeCNY_poundage);
				btc_incomeCNY.setBtc_incomeCNY_reason(user.getUusername() + "进行人民币充值了"
						+ bro.getBro_recharge_acount());
				btc_incomeCNY.setBtc_incomeCNY_time(bro.getBro_recharge_time());

				financeService.saveIncomeCNY(btc_incomeCNY);
				if (user.getUinvite_username() != null && user.getUpstate() == null) {
					user.setUpstate("推广人已获分红币");
					us.updateUser(user);
					// 推广人获利分红点
					Btc_user btc_invite_user = us.getByUsername(user
							.getUinvite_username());
					BigDecimal get_stock_amount = bro.getBro_recharge_acount().multiply(
							btc_profit.getBtc_profit_profit_inviteUser_get());
					if (holdingService.getBtc_holding(btc_invite_user.getUid(), 10000002) != null) {
						Btc_holding btc_holding = holdingService.getBtc_holding(
								btc_invite_user.getUid(), 10000002);
						BigDecimal stock_amount = btc_holding.getBtc_stock_amount();
						stock_amount = stock_amount.add(get_stock_amount);
						btc_holding.setBtc_stock_amount(stock_amount);
						holdingService.updateBtc_holding(btc_holding);
					} else {
						Btc_holding btc_holding = new Btc_holding();
						btc_holding.setBtc_stock_amount(get_stock_amount);
						btc_holding.setBtc_stock_id(10000002);
						btc_holding.setUid(btc_invite_user.getUid());
						holdingService.saveBtc_holding(btc_holding);
					}
					btc_inAll = financeService.getInAll_ByName("BSC");
					BigDecimal btc_inAll_amount = btc_inAll.getBtc_inAll_amount();
					btc_inAll_amount = btc_inAll_amount.add(get_stock_amount);
					btc_inAll.setBtc_inAll_amount(btc_inAll_amount);
					financeService.updateInAll(btc_inAll);
				}
				btc_inAll = financeService.getInAll_ByName("CNY");
				btc_inAll.setBtc_inAll_amount(btc_inAll.getBtc_inAll_amount().add(
						bro.getBro_recharge_acount()));
				financeService.updateInAll(btc_inAll);
			}
		}
		bro_idToJsp = "|" + bro_idToJsp + "|" + "的订单";
		request.setAttribute("msg", bro_idToJsp);
		request.setAttribute("href", "index.do?orders");
		return "orders";
	}
	
	@RequestMapping(params = "rejectCNY")
	public String rejectCNY(HttpServletRequest request,
			HttpServletResponse response) {
		String bro_id[] = request.getParameterValues("checkbox");
		Btc_rechargeCNY_order bro = new Btc_rechargeCNY_order();
		String bro_idToJsp = "已拒绝充值--订单号为";
		if (bro_id != null) {
			for (int i = 0; i < bro_id.length; i++) {
				bro = rs.getByBroIdForOrders(Integer.parseInt(bro_id[i]));
				bro.setBro_state(1);
				bro.setBro_remark("由于平台未收到您的汇款，请确认后再次申请或联系客服人员");
				rs.updateRechargeCNY_Order(bro);
				bro = rs.getByBroIdForOrders(Integer.parseInt(bro_id[i]));
				bro_idToJsp = bro_idToJsp + bro_id[i];
			}
		}
		bro_idToJsp = "|" + bro_idToJsp + "|" + "的订单";
		request.setAttribute("msg", bro_idToJsp);
		request.setAttribute("href", "index.do?orders");
		return "orders";
	}
	
	@RequestMapping(params = "deleteOrders")
	public String deleteOrders(HttpServletRequest request,
			HttpServletResponse response) {
		String bro_id[] = request.getParameterValues("checkbox");
		Btc_rechargeCNY_order bro = new Btc_rechargeCNY_order();
		String bro_idToJsp = "已删除--订单号为   ";
		if (bro_id != null) {
			for (int i = 0; i < bro_id.length; i++) {
				bro = rs.getByBroIdForOrders(Integer.parseInt(bro_id[i]));
				rs.deleteRechargeCNY_Order(bro);
				bro = rs.getByBroIdForOrders(Integer.parseInt(bro_id[i]));
				bro_idToJsp = bro_idToJsp + bro_id[i]+"    ";
			}
		}
		bro_idToJsp =   bro_idToJsp + "的订单";
		request.setAttribute("msg", bro_idToJsp);
		request.setAttribute("href", "index.do?orders");
		return "orders";
	}
}
