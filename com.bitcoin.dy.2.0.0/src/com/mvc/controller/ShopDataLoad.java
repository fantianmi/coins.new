package com.mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mvc.service.PhonecardService;
import com.mvc.service.shop.ShopService;
import com.mvc.util.FormatUtil;


@Controller
@RequestMapping("/loadshop.do")
public class ShopDataLoad {
	
	@Autowired
	private PhonecardService phones;
	@Autowired
	private ShopService shops;
	@Autowired
	private FormatUtil format;
	protected final transient Log log = LogFactory.getLog(ShopDataLoad.class);

	@RequestMapping(params = "getcard")
	public void getcard(
			ModelMap modelMap, HttpServletRequest request,
			HttpServletResponse response) throws ParseException, IOException {
		
		BigDecimal dayamount = phones.getAmount("day");
		BigDecimal amount = phones.getAmount("amount");
		BigDecimal kucun = phones.getKucun();
		String isopenstr=format.transShop(shops.getCardById().getIsopen());
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/xml; charset=UTF-8");// 设置输出信息的格式及字符集
		response.setHeader("Cache-Control", "no-cache");
		out.println("<response>");
		out.println("<dayamount><![CDATA[" + dayamount + "]]></dayamount>");
		out.println("<amount><![CDATA[" + amount + "]]></amount>");
		out.println("<kucun><![CDATA[" + kucun + "]]></kucun>");
		out.println("<isopenstr><![CDATA[" + isopenstr + "]]></isopenstr>");
		out.println("</response>");
		out.close();
	}
}
