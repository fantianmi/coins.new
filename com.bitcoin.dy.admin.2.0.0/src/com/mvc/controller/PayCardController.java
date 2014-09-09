package com.mvc.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.entity.Btc_paycard;
import com.mvc.entity.Btc_user;
import com.mvc.service.PaycardService;
import com.mvc.service.UserService;
import com.mvc.util.RandomCode;
@Controller
@RequestMapping("/paycard.do")
public class PayCardController {
	@Autowired
	private RandomCode rdc = new RandomCode();
	@Autowired
	private PaycardService pcds = new PaycardService();
	@Autowired
	private UserService us = new UserService();

	protected final transient Log log = LogFactory.getLog(PayCardController.class);

	/**
	 * 生成订单，并从用户帐本中扣除相应费用
	 * 
	 * @param modelmap
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(params="general")
	public String general(
			@RequestParam("mianzhi")String mianzhi,
			@RequestParam("num")int num,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String paycardnum = "";
		String paycardpassword = "";
		BigDecimal paycardvalue = new BigDecimal(mianzhi);
		Btc_paycard paycard = new Btc_paycard();
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		String time="";
		for(int i=0;i<num;i++){
			paycardnum = rdc.getNumr(10);
			paycardpassword = rdc.getCharAndNumr(15);
			time = format.format(new Date());
			paycard.setPaycard_mianzhi(paycardvalue);
			paycard.setPaycard_num(paycardnum);
			paycard.setPaycard_password(paycardpassword);
			paycard.setPaycard_gtime(time);
			paycard.setPaycard_usestatus("未使用");
			pcds.savePaycard(paycard);
		}
		request.setAttribute("msg", "生成成功");
		request.setAttribute("href", "index.do?paycard");
		return "index";
	}
	@RequestMapping(params="fenfa")
	public String fenfa(
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String msg = "";
		if(request.getParameter("fname")==null){
			msg = "请输入内容";
			request.setAttribute("msg", msg);
			request.setAttribute("href", "index.do?paycard");
			return "paycard";
		}
		String fname = request.getParameter("fname");
		if(us.getByUsername(fname)==null){
			msg = "对不起，该用户名不存在";
			request.setAttribute("msg", msg);
			request.setAttribute("href", "index.do?paycard");
			return "paycard";
		}
		Btc_user user = us.getByUsername(fname);
		msg = "已将下列面值的点卡分配给用户:"+user.getUusername()+"";
		String cardids[] = request.getParameterValues("checkbox");
		Btc_paycard card = new Btc_paycard();
		int cardid = 0;
		if (cardids != null) {
			for (int i = 0; i < cardids.length; i++) {
				cardid = Integer.parseInt(cardids[i]);
				card = pcds.getPaycardById(cardid);
				card.setPaycard_user(user.getUusername());
				pcds.updatepaycard(card);
				msg = msg + card.getPaycard_id()+":"+card.getPaycard_mianzhi()+"元  ";
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("href", "index.do?paycard");
		return "paycard";
	}
	
	@RequestMapping(params="delete")
	public String delete(
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String cardids[] = request.getParameterValues("checkbox");
		Btc_paycard card = new Btc_paycard();
		int cardid = 0;
		String msg = "已删除以下卡号的充值卡:";
		if (cardids != null) {
			for (int i = 0; i < cardids.length; i++) {
				cardid = Integer.parseInt(cardids[i]);
				card = pcds.getPaycardById(cardid);
				msg = msg + card.getPaycard_num()+" ";
				pcds.deletepaycard(card);
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("href", "index.do?paycard");
		return "paycard";
	}
}
