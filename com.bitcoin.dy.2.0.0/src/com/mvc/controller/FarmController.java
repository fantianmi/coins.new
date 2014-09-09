package com.mvc.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mvc.entity.Btc_farmer;
import com.mvc.entity.Btc_user;
import com.mvc.service.HoldingService;
import com.mvc.service.farm.FarmerService;
import com.mvc.util.DESUtil;
import com.mvc.util.HoldingUtil;

@Controller
@RequestMapping("/farm.do")
public class FarmController {
	@Autowired
	private FarmerService farms;
	@Autowired
	private HoldingService holds;
	@Autowired
	private HoldingUtil holdutil;
	ResourceBundle res = ResourceBundle.getBundle("farm"); 
	protected final transient Log log = LogFactory.getLog(FarmController.class);
	
	@RequestMapping
	public String load(
			HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException{
		HttpSession session = request.getSession();
		if (session.getAttribute("globaluser") == null) {
			request.setAttribute("msg",  "登陆后才能进行此操作！");
			request.setAttribute("href", "index.do?Login");
			return "redirect";
		}
		String uid=session.getAttribute("uid").toString();
		String ecuid=DESUtil.encrypt(uid);
		ecuid=URLEncoder.encode(ecuid,"utf-8");
		session.setAttribute("ecuid", ecuid);
		if(farms.get(Integer.parseInt(uid))!=null) request.setAttribute("open", "yes");
		return "farm";
	}
	@RequestMapping(params="openfarm")
	public String openFarm(
			HttpServletRequest request,
			HttpServletResponse response
			){
		HttpSession session = request.getSession();
		if(session.getAttribute("globaluser")==null){
			request.setAttribute("msg", "请先登录");
			request.setAttribute("href", "index.do?Login");
			return "redirect";
		}
		Btc_user user=(Btc_user)session.getAttribute("globaluser");
		if(holds.getBtc_holding(user.getUid(), Integer.parseInt(res.getString("frozencoin")))==null||holds.getBtc_holding(user.getUid(), Integer.parseInt(res.getString("frozencoin"))).getBtc_stock_amount().compareTo(new BigDecimal(20))<0){
			request.setAttribute("msg", "对不起，您的余额不足，请先充值");
			request.setAttribute("href", "farm.do");
			return "redirect";
		}
		holdutil.subStock(user.getUid(), Integer.parseInt(res.getString("frozencoin")), new BigDecimal(res.getString("frozenamount")));
		Btc_farmer farmer=new Btc_farmer();
		farmer.setUid(user.getUid());
		farms.save(farmer);
		request.setAttribute("href", "farm.do");
		request.setAttribute("msg", "恭喜您，开通成功");
		return "redirect";
		
	}
}
