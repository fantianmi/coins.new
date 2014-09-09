package com.mvc.controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ResourceBundle;

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

import com.mvc.entity.Btc_factory;
import com.mvc.entity.Btc_holding;
import com.mvc.entity.Btc_join_build;
import com.mvc.entity.Btc_user;
import com.mvc.service.FactoryService;
import com.mvc.service.GBservice;
import com.mvc.service.HoldingService;
import com.mvc.util.DataUtil;
import com.mvc.util.FormatUtil;
import com.mvc.util.HoldingUtil;

@Controller
@RequestMapping("/factory.do")
public class FactoryController {
	@Autowired
	private HoldingService holdings = new HoldingService();
	@Autowired
	private HoldingUtil holdutil;
	@Autowired
	private DataUtil datas = new DataUtil();
	@Autowired
	private GBservice gbs = new GBservice();
	@Autowired
	private FactoryService facs = new FactoryService();
	@Autowired
	private FormatUtil format;
	ResourceBundle res = ResourceBundle.getBundle("stock");

	protected final transient Log log = LogFactory.getLog(FactoryController.class);
	
	@RequestMapping(params = "joinbuild")
	public void rengou(
			ModelMap modelMap, HttpServletRequest request,
			@RequestParam("putamount")BigDecimal putamount,
			HttpServletResponse response) throws IOException, ParseException {
		ResourceBundle res = ResourceBundle.getBundle("stock");
		HttpSession session = request.getSession();
		int stockid=Integer.parseInt(res.getString("stock.factory.stockid"));
		String msg = "";
		String href = "nohref";
		PrintWriter out = response.getWriter();
		response.setContentType("text/xml; charset=UTF-8");// 设置输出信息的格式及字符集
		response.setHeader("Cache-Control", "no-cache");
		if(session.getAttribute("globaluser")==null){
			msg = "登陆超时，请重新登陆";
			href = "index.do";
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		if(datas.getDay()!=2){
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>对不起，请在星期一存款</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		Btc_user user = (Btc_user)session.getAttribute("globaluser");
		Btc_factory bf = gbs.getFactoryConfigByType("造币工厂");
		BigDecimal userlimit = bf.getUserhaslimit();
		//###########################################
		Btc_holding hold = holdings.getBtc_holding(user.getUid(), Integer.parseInt(res.getString("stock.factory.stockid")));
		if(holdings.getBtc_holding(user.getUid(), Integer.parseInt(res.getString("stock.factory.stockid")))==null){
			msg = "对不起，您的持有数量小于"+format.trans(userlimit)+",没有资格申请存款";
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		if(facs.getBtc_join_buildByTime(user.getUid())!=null){
			msg = "非法操作！";
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		if(hold.getBtc_stock_amount().compareTo(userlimit)<0){
			msg = "对不起，您的持有数量小于"+userlimit+",没有资格申请存款";
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		if(putamount.compareTo(userlimit)<0){
			msg = "请存入大于"+userlimit+"";
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		if(hold.getBtc_stock_amount().compareTo(putamount)<0){
			msg = "对不起，请存入小于"+format.trans(hold.getBtc_stock_amount())+"";
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		Btc_join_build jb = new Btc_join_build();
		jb.setAmount(putamount);
		jb.setDate(datas.getTimeNow("second"));
		jb.setStatus("铸币中");
		jb.setUid(user.getUid());
		jb.setType("造币工厂");
		BigDecimal xl = new BigDecimal(1);
		//frozen stock
		if(!holdutil.frozenstock(stockid, putamount, user.getUid())){
			msg = "存款失败";
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		//保存用户的效率
		jb.setXl(xl);
		facs.saveBtc_join_build(jb);
		msg = "存款成功";
		out.println("<response>");
		out.println("<href>reload</href>");
		out.println("<msg>" + msg + "</msg>");
		out.println("</response>");
		out.close();
	}
//	@RequestMapping(params = "joinbuild")
//	public void rengou(
//			ModelMap modelMap, HttpServletRequest request,
//			HttpServletResponse response) throws IOException, ParseException {
//		ResourceBundle res = ResourceBundle.getBundle("stock");
//		HttpSession session = request.getSession();
//		int stockid=Integer.parseInt(res.getString("stock.factory.stockid"));
//		String msg = "";
//		String href = "nohref";
//		PrintWriter out = response.getWriter();
//		response.setContentType("text/xml; charset=UTF-8");// 设置输出信息的格式及字符集
//		response.setHeader("Cache-Control", "no-cache");
//		if(session.getAttribute("globaluser")==null){
//			msg = "登陆超时，请重新登陆";
//			href = "index.do";
//			out.println("<response>");
//			out.println("<href>" + href + "</href>");
//			out.println("<msg>" + msg + "</msg>");
//			out.println("</response>");
//			out.close();
//			return;
//		}
//		
//		//can join?  starttime<join<endtime
//		String starttime=res.getString("factory.build.time");
//		String endtime=res.getString("join.build.time");
//		String join=datas.getTimeNow("justtime");
//		if(!datas.comparetime(join, starttime)&&!datas.comparetime(endtime, join)){
//			out.println("<response>");
//			out.println("<href>" + href + "</href>");
//			out.println("<msg>对不起，今天的存入时间已过，存入时间为每天:"+starttime+"~"+endtime+"</msg>");
//			out.println("</response>");
//			out.close();
//			return;
//		}
//		Btc_user user = (Btc_user)session.getAttribute("globaluser");
//		Btc_factory bf = gbs.getFactoryConfigByType("造币工厂");
//		BigDecimal userlimit = bf.getUserhaslimit();
//		//###########################################
//		Btc_holding hold = holdings.getBtc_holding(user.getUid(), Integer.parseInt(res.getString("stock.factory.stockid")));
//		if(holdings.getBtc_holding(user.getUid(), Integer.parseInt(res.getString("stock.factory.stockid")))==null){
//			msg = "对不起，您的持有数量小于"+userlimit+",没有资格申请存款";
//			out.println("<response>");
//			out.println("<href>" + href + "</href>");
//			out.println("<msg>" + msg + "</msg>");
//			out.println("</response>");
//			out.close();
//			return;
//		}
//		if(facs.getBtc_join_buildByTime(user.getUid())!=null){
//			msg = "非法操作！";
//			out.println("<response>");
//			out.println("<href>" + href + "</href>");
//			out.println("<msg>" + msg + "</msg>");
//			out.println("</response>");
//			out.close();
//			return;
//		}
//		if(hold.getBtc_stock_amount().compareTo(userlimit)<0){
//			msg = "对不起，您的持有数量小于"+userlimit+",没有资格申请存款";
//			out.println("<response>");
//			out.println("<href>" + href + "</href>");
//			out.println("<msg>" + msg + "</msg>");
//			out.println("</response>");
//			out.close();
//			return;
//		}
//		Btc_join_build jb = new Btc_join_build();
//		jb.setAmount(hold.getBtc_stock_amount());
//		jb.setDate(datas.getTimeNow("second"));
//		jb.setStatus("铸币中");
//		jb.setUid(user.getUid());
//		jb.setType("造币工厂");
//		BigDecimal xl = new BigDecimal(1);
//		//计算用户的效率值 xl=1+(b-1000)/1000(取整)*0.1
//		BigDecimal b = new BigDecimal(0);
//		b = hold.getBtc_stock_amount().subtract(new BigDecimal(10000));
//		b = b.divide(new BigDecimal(10000),0,BigDecimal.ROUND_DOWN);
//		b = b.multiply(new BigDecimal(0.1));
//		xl = xl.add(b);
//		
//		//frozen stock
//		if(!holdutil.frozenstock(stockid, hold.getBtc_stock_amount(), user.getUid())){
//			msg = "存款失败";
//			out.println("<response>");
//			out.println("<href>" + href + "</href>");
//			out.println("<msg>" + msg + "</msg>");
//			out.println("</response>");
//			out.close();
//			return;
//		}
//		//保存用户的效率
//		jb.setXl(xl);
//		facs.saveBtc_join_build(jb);
//		//############################################
//		msg = "存款成功";
//		href = "refresh";
//		out.println("<response>");
//		out.println("<href>" + href + "</href>");
//		out.println("<msg>" + msg + "</msg>");
//		out.println("</response>");
//		out.close();
//	}
}
