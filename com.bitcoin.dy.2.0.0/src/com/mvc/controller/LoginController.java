package com.mvc.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.mvc.entity.Btc_account_book;
import com.mvc.entity.Btc_user;
import com.mvc.service.AccountService;
import com.mvc.service.CotentService;
import com.mvc.service.HoldingService;
import com.mvc.service.OrderService;
import com.mvc.service.StockService;
import com.mvc.service.UserService;
import com.mvc.util.MD5Util;
import com.mvc.vo.NaviStockModel;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping({ "/vertify.do" })
public class LoginController {

	@Autowired
	private UserService us;

	@Autowired
	private StockService stockService;
	@Autowired
	private CotentService contents;
	@Autowired
	private HoldingService holds;
	@Autowired
	private AccountService acounts;
	@Autowired
	private OrderService orders;
	protected final transient Log log = LogFactory
			.getLog(LoginController.class);

	@RequestMapping
	public String vertify(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		session.setAttribute("newslist", contents.getNewsLimit());
		session.setAttribute("newslistall", contents.getNewsCAll());
		session.setAttribute("indexmap", contents.getIndexContent(10000001));
		Map<Integer, Object> allstockmap = stockService.getBtc_stockByState(1);
		session.setAttribute("allstockmap", allstockmap);
		Map<Integer, Object> stockmap = stockService.getBtc_stockMapbyId();
		session.setAttribute("stockmap", stockmap);
		session.setAttribute("stoc_kmap", stockmap);
		Map<String, NaviStockModel> stock_map_navigation = stockService
				.getCoins4CNY();
		session.setAttribute("stock_map_navigation", stock_map_navigation);
		int user_amount = us.countAllUser();
		session.setAttribute("user_amount", user_amount);
		String uusername = request.getParameter("uusername");
		String upassword = request.getParameter("upassword");

		boolean flag = false;
		if (this.us.getByUsername(uusername) == null) {
			request.setAttribute("msg", "用户名不存在");
			request.setAttribute("href", "back");
			return "redirect";
		}
		Btc_user vuser = this.us.getByUsername(uusername);
		flag = MD5Util.validate(upassword, vuser.getUpassword());
		if ((uusername != null) && (upassword != null)) {
			if (flag) {
				session.setAttribute("globaluser", vuser);
				session.setAttribute("uid", vuser.getUid());
				Btc_account_book abook = acounts.getByUidForAcount(vuser
						.getUid());
				if (abook == null) {
					session.setAttribute("ab_cny", "0.00");
				} else {
					BigDecimal ab_cny_show = abook.getAb_cny().setScale(2,
							BigDecimal.ROUND_HALF_UP);
					session.setAttribute("ab_cny", ab_cny_show);
				}
				Map<Integer, Object> stock_map = stockService.getBtc_stock();
				session.setAttribute("stock_map", stock_map);

				if (holds.getBtc_holding(vuser.getUid()) != null) {
					List<Object> btc_holding_list = holds.getBtc_holding(vuser
							.getUid());
					session.setAttribute("btc_holding_list", btc_holding_list);
					Map<Integer, Object> btc_holding_map = holds
							.getBtc_holdingToMapByUid(vuser.getUid());
					session.setAttribute("btc_holding_map", btc_holding_map);
				} else {
					session.setAttribute("btc_holding_list", null);
					session.setAttribute("btc_holding_map", null);
				}
				Map<Integer, Object> userholdmap = holds
						.getBtc_holdingToMapByUid(vuser.getUid());
				session.setAttribute("userholdmap", userholdmap);
				Map<Integer, Object> userordermap = orders
						.getUserSellingOrdersToMapByUid(vuser.getUid());
				session.setAttribute("userordermap", userordermap);

				response.sendRedirect("index.do");
				return "index";
			}
			request.setAttribute("msg", "用户名或者密码错误");
			request.setAttribute("href", "index.do");
			return "redirect";
		}
		return "redirect";
	}
	@RequestMapping(params = { "Login" })
	public String gLogin(ModelMap modelMap) {
		return "login";
	}

	@RequestMapping(params = { "Register" })
	public String register(ModelMap modelMap) {
		return "register";
	}

	@RequestMapping(params = { "qqLogin" })
	public void qqLogin(ModelMap modelMap) {
	}
}