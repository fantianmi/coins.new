package com.mvc.controller;


import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.entity.Btc_account_book;
import com.mvc.entity.Btc_holding;
import com.mvc.entity.Btc_stock;
import com.mvc.entity.Btc_user;
import com.mvc.service.AccountService;
import com.mvc.service.HoldingService;
import com.mvc.service.StockService;
import com.mvc.service.UserService;
import com.mvc.vo.UserHold;

@Controller
@RequestMapping("/holding.do")
public class HoldingController {
	@Autowired
	private UserService users;
	@Autowired
	private AccountService acounts;
	@Autowired
	private HoldingService holds;
	@Autowired
	private StockService stocks;
	
	protected final transient Log log = LogFactory.getLog(HoldingController.class);
	
	@RequestMapping(params="cny")
	public String manage(
			HttpServletRequest request,
			HttpServletResponse response){
		request.setAttribute("currentCoin", "人民币");
		HttpSession session=request.getSession();
		if(session.getAttribute("usermap")==null){
			session.setAttribute("usermap", users.getUserMap());
		}
		if(session.getAttribute("stockmap")==null){
			session.setAttribute("stockmap", stocks.getAllBtc_stock());
		}
		Map<Integer,Object> usermap=users.getUserMap();
		// fenye
		int start = 0;
		int count = 100;
		if (request.getParameter("start") != null
				&& request.getParameter("count") != null) {
			start = Integer.parseInt(request.getParameter("start"));
			count = Integer.parseInt(request.getParameter("count"));
		}
		session.setAttribute("holdStartNO", start);
		long countHold = 0;
		if(acounts.getAll()!=null)countHold=acounts.getAll().size();
		request.setAttribute("countHold", countHold);
		// fenye
		List<Object> acountlist=acounts.getAll(start,count);
		Btc_account_book acount=new Btc_account_book();
		Btc_user user=new Btc_user();
		List<UserHold> userListVo=new ArrayList<UserHold>();
		//pack
		for(int i=0;i<acountlist.size();i++){
			acount=(Btc_account_book)acountlist.get(i);
			UserHold userVo=new UserHold();
			if(usermap.get(acount.getUid())==null)continue;
			user=(Btc_user)usermap.get(acount.getUid());
			userVo.setAmount(acount.getAb_cny());
			userVo.setCoinname("人民币");
			userVo.setId(user.getUid());
			userVo.setName(user.getUname());
			userVo.setUsername(user.getUusername());
			userListVo.add(userVo);
		}
		request.setAttribute("userListVo", userListVo);
		return "holding";
	}
	@RequestMapping(params="coin")
	public String coin(
			@RequestParam("stockid")int stockid,
			HttpServletRequest request,
			HttpServletResponse response){
		Btc_stock stock=stocks.getSelfBtc_stockById(stockid);
		request.setAttribute("stockid", stockid);
		request.setAttribute("currentCoin", stock.getBtc_stock_name());
		
		HttpSession session=request.getSession();
		if(session.getAttribute("stockmap")==null){
			session.setAttribute("stockmap", stocks.getAllBtc_stock());
		}
		if(session.getAttribute("usermap")==null){
			session.setAttribute("usermap", users.getUserMap());
		}
		Map<Integer,Object> usermap=users.getUserMap();
		
		// fenye
		int start = 0;
		int count = 100;
		if (request.getParameter("start") != null
				&& request.getParameter("count") != null) {
			start = Integer.parseInt(request.getParameter("start"));
			count = Integer.parseInt(request.getParameter("count"));
		}
		session.setAttribute("holdcoinStartNO", start);
		long countHold = 0;
		if(holds.getAll(stockid)!=null)countHold=holds.getAll(stockid).size();
		request.setAttribute("countHold", countHold);
		// fenye
		List<Object> acountlist=holds.getAll(stockid,start,count);
		Btc_holding acount=new Btc_holding();
		Btc_user user=new Btc_user();
		List<UserHold> userListVo=new ArrayList<UserHold>();
		//pack
		for(int i=0;i<acountlist.size();i++){
			acount=(Btc_holding)acountlist.get(i);
			UserHold userVo=new UserHold();
			if(usermap.get(acount.getUid())==null)continue;
			user=(Btc_user)usermap.get(acount.getUid());
			userVo.setAmount(acount.getBtc_stock_amount());
			userVo.setCoinname(stock.getBtc_stock_name());
			userVo.setId(user.getUid());
			userVo.setName(user.getUname());
			userVo.setUsername(user.getUusername());
			userListVo.add(userVo);
		}
		request.setAttribute("userListVo", userListVo);
		return "holdingstock";
	}
}
