package com.mvc.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mvc.entity.Btc_rechargeCNY_order;
import com.mvc.service.CotentService;
import com.mvc.service.RechargeService;
import com.mvc.service.StockService;
import com.mvc.service.TradeCateService;
import com.mvc.service.UserService;
import com.mvc.util.MD5Util;
import com.mvc.vo.NaviStockModel;

@Controller
@RequestMapping("/paysuccess.do")
public class PayResultController {
	@Autowired
	private CotentService contents = new CotentService();
	@Autowired
	private UserService us = new UserService();
	@Autowired
	private StockService stockService = new StockService();
	@Autowired
	private TradeCateService tradecates;
	@Autowired
	private MD5Util md5util;
	@Autowired
	private RechargeService rs;

	protected final transient Log log = LogFactory
			.getLog(RechargeController.class);

	@RequestMapping
	public String load(ModelMap modelMap, HttpServletRequest request) {
		return "paysuccess";
	}
}
