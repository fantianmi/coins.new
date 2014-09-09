package com.mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

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

import com.mvc.entity.Btc_fenhonglog;
import com.mvc.entity.Btc_fhDDC;
import com.mvc.entity.Btc_fh_order;
import com.mvc.entity.Btc_holding;
import com.mvc.entity.Btc_user;
import com.mvc.service.FenhongService;
import com.mvc.service.FhOrderService;
import com.mvc.service.HoldingService;
import com.mvc.service.UserService;
import com.mvc.util.DataUtil;

@Controller
@RequestMapping("/fenhong.do")
public class FenhongController {
	@Autowired
	private HoldingService holdservice = new HoldingService();
	@Autowired
	private UserService us = new UserService();
	@Autowired
	private FenhongService fhs = new FenhongService();
	@Autowired
	private FhOrderService fhos = new FhOrderService();
	@Autowired
	private DataUtil dateutil;
	
	protected final transient Log log = LogFactory
	.getLog(FenhongController.class);
	
	@RequestMapping
	public String load(ModelMap modelMap, HttpServletRequest request){
		return "index";
	}
	@RequestMapping(params = "deliverDDC")
	public String deliverDDC(ModelMap modelMap, HttpServletRequest request){
		HttpSession session = request.getSession();
		Map<Integer,Btc_fhDDC> fhusermap = new HashMap<Integer,Btc_fhDDC>();
		fhusermap = (Map<Integer,Btc_fhDDC>)session.getAttribute("fhusermap");
		String bwo_id[] = request.getParameterValues("checkbox");
		int uid = 0;
		Btc_user user = new Btc_user();
		Btc_fhDDC tempuser = new Btc_fhDDC();
		Btc_fhDDC buf = new Btc_fhDDC();
		Btc_holding bh = new Btc_holding();
		String bro_idToJsp = "已分发GBP给用户名为";
		SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd");
		String datenow = dd.format(new Date());
		if (bwo_id != null) {
			for (int i = 0; i < bwo_id.length; i++) {
				uid = Integer.parseInt(bwo_id[i]);
				user = us.getByUid(uid);
				tempuser = fhusermap.get(user.getUid());
				tempuser.setFstatus("已发放");
				tempuser.setFftime(datenow);
				fhs.updateFH(tempuser);
				fhusermap.put(user.getUid(), tempuser);
				buf = fhusermap.get(uid);
				if(holdservice.getBtc_holding(uid, 10000002)==null){
					bh.setBtc_stock_amount(buf.getGetddc());
					bh.setBtc_stock_id(10000002);
					bh.setUid(uid);
					holdservice.saveBtc_holding(bh);
				}else{
					bh = holdservice.getBtc_holding(uid, 10000002);
					bh.setBtc_stock_amount(bh.getBtc_stock_amount().add(buf.getGetddc()));
					session.setAttribute("fhusermap", fhusermap);
					holdservice.updateBtc_holding(bh);
				}
				bro_idToJsp = bro_idToJsp + bwo_id[i];
				//
			}
		}
		bro_idToJsp = "|" + bro_idToJsp + "|" + "的账户";
		request.setAttribute("msg", bro_idToJsp);
		request.setAttribute("href", "index.do?deliverDDC");
		return "deliverDDC";
	}
	@RequestMapping(params = "rejectFenhong")
	public String rejectFenhong(ModelMap modelMap, HttpServletRequest request){
		
		String fh_order_id[] = request.getParameterValues("checkbox");
		int fhoid;
		Btc_fh_order order = new Btc_fh_order();
		SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd");
		String datenow = dd.format(new Date());
		String bro_idToJsp = "已拒绝分红给用户名为";
		if (fh_order_id != null) {
			for (int i = 0; i < fh_order_id.length; i++) {
				fhoid = Integer.parseInt(fh_order_id[i]);
				order = fhos.getById(fhoid);
				order.setDelivertime(datenow);
				order.setIsdeliver("已拒绝");
				fhos.updateFhOrder(order);
				bro_idToJsp = bro_idToJsp + fh_order_id[i];
				//
			}
		}
		bro_idToJsp = "|" + bro_idToJsp + "|" + "的账户";
		request.setAttribute("msg", bro_idToJsp);
		request.setAttribute("href", "index.do?deliverfenhong");
		return "deliverfenhong";
	}
	@RequestMapping(params = "deliverFenhong")
	public String deliverFenhong(ModelMap modelMap, HttpServletRequest request){
		
		String fh_order_id[] = request.getParameterValues("checkbox");
		int fhoid;
		Btc_fh_order order = new Btc_fh_order();
		SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd");
		String datenow = dd.format(new Date());
		String bro_idToJsp = "发放成功";
		if (fh_order_id != null) {
			for (int i = 0; i < fh_order_id.length; i++) {
				fhoid = Integer.parseInt(fh_order_id[i]);
				order = fhos.getById(fhoid);
				order.setDelivertime(datenow);
				order.setIsget("未领取");
				order.setIsdeliver("已发放");
				fhos.updateFhOrder(order);
				//
			}
		}
		request.setAttribute("msg", bro_idToJsp);
		request.setAttribute("href", "index.do?deliverfenhong2");
		return "index";
	}
	
	@RequestMapping(params="saveInput")
	public void saveInput(
			@RequestParam("season")int season,
			@RequestParam("rate")BigDecimal rate,
			@RequestParam("poundageamount")BigDecimal poundageamount,
			HttpServletRequest request,HttpServletResponse response) throws IOException{
		/*header*/
		String msg = "";
		String href = "nohref";
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		response.setContentType("text/xml; charset=UTF-8");// 设置输出信息的格式及字符集
		response.setHeader("Cache-Control", "no-cache");
		
		
		
		Btc_fenhonglog fhl = new Btc_fenhonglog();
		fhl.setFenhong_amount(new BigDecimal(request.getParameter("poundageamount").toString()));
		fhl.setFenhong_season(Integer.parseInt(request.getParameter("season")));
		fhl.setRate(new BigDecimal(request.getParameter("rate").toString()));
		fhl.setFenhong_status("未统计");
		fhl.setFenhong_time(dateutil.getTimeNow("second"));
		fhs.saveBtc_fenhonglog(fhl);
		msg="保存第"+season+"期发放分红成功，等待系统定时自动统计，请勿重复添加，再次点击右侧【手续费发放】进行发放";
		out.println("<response>");
		out.println("<href>" + href + "</href>");
		out.println("<msg>" + msg + "</msg>");
		out.println("</response>");
		out.close();
	}
}
