package com.mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.entity.Btc_factory;
import com.mvc.entity.Btc_frc_info;
import com.mvc.service.GBservice;
import com.mvc.time.Factory;
@Controller
@RequestMapping("/GB.do")
public class GBController {
	@Autowired
	private GBservice gbs = new GBservice();
	
	protected final transient Log log = LogFactory.getLog(GBController.class);

	/**
	 * 
	 * 
	 * @param modelmap
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(params="saveGBconfig")
	public void saveGBconfig(
	@RequestParam("amount") String amount,
	@RequestParam("factory") String factory,
	@RequestParam("rengou") String rengou,
	HttpServletRequest request,
	HttpServletResponse response
	) throws IOException
	{
		String msg = "";
		String href = "nohref";
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		response.setContentType("text/xml; charset=UTF-8");// 设置输出信息的格式及字符集
		response.setHeader("Cache-Control", "no-cache");
		BigDecimal bamount = new BigDecimal(amount);
		BigDecimal bfactory = new BigDecimal(factory);
		BigDecimal brengou = new BigDecimal(rengou);
		Btc_frc_info bfi = gbs.getFRC_Info();
		bfi.setAmount(bamount);
		bfi.setFactory(bfactory);
		bfi.setRengou(brengou);
		gbs.updateBtc_frc_info(bfi);
		msg = "保存造币配置参数成功";
		out.println("<response>");
		out.println("<href>" + href + "</href>");
		out.println("<msg>" + msg + "</msg>");
		out.println("</response>");
		out.close();
	}
	@RequestMapping(params="savefacconfig")
	public void savefacconfig(
			@RequestParam("amount") String amount,
			@RequestParam("date") String date,
			@RequestParam("eachamount") String eachamount,
			@RequestParam("type") String type,
			@RequestParam("userhaslimit") String userhaslimit,
			HttpServletRequest request,
			HttpServletResponse response
	) throws IOException
	{
		String msg = "";
		String href = "nohref";
		BigDecimal bamount = new BigDecimal(amount);
		BigDecimal beachamount = new BigDecimal(eachamount);
		BigDecimal buserhaslimit = new BigDecimal(userhaslimit);
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		response.setContentType("text/xml; charset=UTF-8");// 设置输出信息的格式及字符集
		response.setHeader("Cache-Control", "no-cache");
		Btc_factory bf = gbs.getFactoryConfigByType(type);
		bf.setAmount(bamount);
		bf.setDate(date);
		bf.setEachamount(beachamount);
		bf.setUserhaslimit(buserhaslimit);
		gbs.updateBtc_factory(bf);
		//######################################################################
		msg = "保存"+type+"配置参数成功";
		out.println("<response>");
		out.println("<href>" + href + "</href>");
		out.println("<msg>" + msg + "</msg>");
		out.println("</response>");
		out.close();
	}
}
