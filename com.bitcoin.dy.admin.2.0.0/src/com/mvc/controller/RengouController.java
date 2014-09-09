package com.mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.entity.Btc_frc_rengou;
import com.mvc.service.GBservice;
import com.mvc.util.DataUtil;
@Controller
@RequestMapping("/rengou.do")
public class RengouController {

	protected final transient Log log = LogFactory.getLog(RengouController.class);
	@Autowired
	private GBservice gbs = new GBservice();
	@Autowired
	private DataUtil datautil = new DataUtil();

	/**
	 * 生成订单，并从用户帐本中扣除相应费用
	 * 
	 * @param modelmap
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(params="update")
	public void update(
			@RequestParam("amount")String amount,
			@RequestParam("eachamount")String eachamount,
			@RequestParam("price")String price,
			@RequestParam("season")String season,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String msg = "";
		String href = "nohref";
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		response.setContentType("text/xml; charset=UTF-8");// 设置输出信息的格式及字符集
		response.setHeader("Cache-Control", "no-cache");
		
		BigDecimal bamount = new BigDecimal(amount);
		BigDecimal beachamount = new BigDecimal(eachamount);
		BigDecimal bprice = new BigDecimal(price);
		
		Btc_frc_rengou bfr = gbs.getRengou_configBySeason(season);
		bfr.setAmount(bamount);
		bfr.setEachamount(beachamount);
		bfr.setPrice(bprice);
		gbs.updateBtc_frc_rengou(bfr);
		msg = "修改"+season+"兑换配置成功";
		//####################################################
		out.println("<response>");
		out.println("<href>" + href + "</href>");
		out.println("<msg>" + msg + "</msg>");
		out.println("</response>");
		out.close();
	}
	
	@RequestMapping(params="add")
	public void add(
			@RequestParam("amount")String amount,
			@RequestParam("eachamount")String eachamount,
			@RequestParam("price")String price,
			@RequestParam("season")String season,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String msg = "";
		String href = "nohref";
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		response.setContentType("text/xml; charset=UTF-8");// 设置输出信息的格式及字符集
		response.setHeader("Cache-Control", "no-cache");
		
		BigDecimal bamount = new BigDecimal(amount);
		BigDecimal beachamount = new BigDecimal(eachamount);
		BigDecimal bprice = new BigDecimal(price);
		
		Btc_frc_rengou bfr = new Btc_frc_rengou();
		bfr.setAmount(bamount);
		bfr.setEachamount(beachamount);
		bfr.setPrice(bprice);
		bfr.setDamount(bamount);
		bfr.setDate(datautil.getTimeNow("second"));
		bfr.setSeason(season);
		bfr.setStatus("发放中");
		gbs.saveBtc_frc_rengou(bfr);
		href="index.do?GBsetting";
		msg = "添加"+season+"兑换配置成功，之前的兑换将作废";
		//####################################################
		out.println("<response>");
		out.println("<href>" + href + "</href>");
		out.println("<msg>" + msg + "</msg>");
		out.println("</response>");
		out.close();
	}
}
