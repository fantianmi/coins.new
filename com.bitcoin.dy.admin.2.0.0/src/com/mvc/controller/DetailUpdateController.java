package com.mvc.controller;


import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.entity.Btc_account_book;
import com.mvc.entity.Btc_user;
import com.mvc.service.AccountService;
import com.mvc.service.HoldingService;
import com.mvc.service.UserService;
import com.mvc.util.HoldingUtil;


@Controller
@RequestMapping("/detail.do")
public class DetailUpdateController {
	@Autowired
	private UserService us = new UserService();
	@Autowired
	private HoldingService hs = new HoldingService();
	@Autowired
	private AccountService as;
	@Autowired
	private HoldingUtil holdutil;
	
	protected final transient Log log = LogFactory
	.getLog(DetailUpdateController.class);
	
	@RequestMapping(params="changehold")
	public String add(
			@RequestParam("stockid")int stockid,
			@RequestParam("uid")int uid,
			@RequestParam("amount")BigDecimal amount,
			ModelMap modelMap, HttpServletRequest request){
		if(request.getParameter("amount")==""){
			request.setAttribute("msg", "表单不能为空！");
			request.setAttribute("href", "back");
		}
		holdutil.setStock(uid, stockid, amount);
		request.setAttribute("msg", "修改余额成功！");
		request.setAttribute("href", "usermanager.do?seeDetail&uid="+uid+"");
		return "index";
		
	}
	
	@RequestMapping(params="changecny")
	public String changecny(ModelMap modelMap, HttpServletRequest request){
		if(request.getParameter("amount")==""){
			request.setAttribute("msg", "表单不能为空！");
			request.setAttribute("href", "back");
		}
		int uid = Integer.parseInt(request.getParameter("uid").toString());
		BigDecimal amount = new BigDecimal(request.getParameter("amount").toString());
		Btc_account_book account = new Btc_account_book();
		if(as.getByUidForAcount(uid)==null){
			account.setAb_cny(amount);
			account.setUid(uid);
			as.saveAccount_Book(account);
		}else{
			account = as.getByUidForAcount(uid);
			account.setAb_cny(amount);
			as.updateAccount_Book(account);
		}
		request.setAttribute("msg", "修改余额成功！");
		request.setAttribute("href", "usermanager.do?seeDetail&uid="+uid+"");
		return "index";
		
	}
	
	@RequestMapping(params="changedetail")
	public String update(ModelMap modelMap, HttpServletRequest request){
		if(request.getParameter("uid")==""&&
				request.getParameter("uname")==""&&request.getParameter("ucid")==""&&
				request.getParameter("email")==""&&request.getParameter("uphone")==""){
			request.setAttribute("msg", "表单不能为空！");
			request.setAttribute("href", "back");
			
		}
		int uid = Integer.parseInt(request.getParameter("uid").toString());
		String uname = request.getParameter("uname").toString();
		String ucid = request.getParameter("ucid").toString();
		String email = request.getParameter("email").toString();
		String uphone = request.getParameter("uphone").toString();
		Btc_user user = new Btc_user();
		user = us.getByUid(uid);
		user.setUname(uname);
		user.setUcertification(ucid);
		user.setUemail(email);
		user.setUphone(uphone);
		us.updateUser(user);
		request.setAttribute("msg", "修改用户资料成功！");
		request.setAttribute("href", "usermanager.do?seeDetail&uid="+uid+"");
		return "index";
	}
}
