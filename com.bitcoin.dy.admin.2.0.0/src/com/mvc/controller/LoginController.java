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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.entity.Btc_user;
import com.mvc.service.AccountService;
import com.mvc.service.ManagerService;
import com.mvc.service.OrderService;
import com.mvc.service.RechargeService;
import com.mvc.service.UserService;
import com.mvc.util.MD5Util;

@Controller
@RequestMapping("/vertify.do")
public class LoginController {
	@Autowired
	private ManagerService managerService;
	@Autowired
	private UserService userService;
	@Autowired
	private MD5Util md5util;
	@Autowired
	private AccountService accounts;
	@Autowired
	private OrderService orders;
	@Autowired
	private RechargeService recharges;
	protected final transient Log log = LogFactory.getLog(LoginController.class);

	@RequestMapping
	public String vertify(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		/**
		 * count cny amount
		 */
		BigDecimal totalaccount=accounts.total(0);
		BigDecimal totalorder=orders.totalOrder(0,"bid");
		BigDecimal totalwithdraw=recharges.totalWithdraw(0);
		session.setAttribute("cny_amount", totalaccount.add(totalorder).add(totalwithdraw));
		
		String btc_manager_username = request.getParameter("btc_manager_username");
		String btc_manager_password = md5util.encode2hex(request.getParameter("btc_manager_password"));
		boolean flag = false;
		flag = managerService.vertify(btc_manager_username, btc_manager_password);
	//###############################
		if(session.getAttribute("msgcode")==null){
			request.setAttribute("msg", "未获取邮箱验证码，请重新输入");
			request.setAttribute("href", "back");
			return "login";
		}
		String msgcode = session.getAttribute("msgcode").toString();
		if(msgcode.equals(request.getParameter("msgcode").toString())==false){
			request.setAttribute("msg", "邮箱验证码错误，请重新输入");
			return "login";
		}
		//
		if(btc_manager_username!=null&&btc_manager_password!=null){
			if (flag == true) {
				request.setAttribute("msg", "登陆成功！");
				request.setAttribute("href", "index.do");
				session.setAttribute("userLoginFlag", "yes");
				session.setAttribute("usernameadmin", btc_manager_username);
				response.sendRedirect("index.do");
				// 回写到客户端
				return "login";
			} else {
				request.setAttribute("msg", "用户名或密码错误！");
				return "login";
			}
		}else{
			request.setAttribute("msg", "用户名或密码错误！");
			return "login";
		}
	}
	
	@RequestMapping(params = "logout")
	public String gLogin(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.removeAttribute("userLoginFlag");
		request.setAttribute("msg", "已成功退出！");
		request.setAttribute("href", "index.do");
		return "login";
	}
	
	@RequestMapping(params = "Register")
	public String gRegister(ModelMap modelMap) {
		return "register";
	}
	
	@RequestMapping(params = "delete")
	public String gRegister(@RequestParam("uid")Integer uid,ModelMap modelMap, HttpServletRequest request) {
		Btc_user btc_user = userService.getByUserId(uid);
		String username = btc_user.getUusername();
		userService.deleteUser(btc_user);
		request.setAttribute("msg", "已删除用户"+username+"");
		request.setAttribute("href", "index.do?userlist");
		return "usermanager";
	}
}
