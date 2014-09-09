package com.mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;
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

import com.mvc.entity.Btc_mail_content;
import com.mvc.entity.Btc_user;
import com.mvc.service.UserService;
import com.mvc.util.MailUtil;
import com.mvc.util.RandomCode;


@Controller
@RequestMapping("/msg.do")
public class SendMsgController {
	@Autowired
	private RandomCode rc = new RandomCode();
	@Autowired
	private UserService us = new UserService();
	@Autowired
	private MailUtil mailutil;

	protected final transient Log log = LogFactory.getLog(SendMsgController.class);
	
	@RequestMapping(params = "sendforpost")
	public void sendforpost(
			ModelMap modelMap, HttpServletRequest request,
			HttpServletResponse response) throws ParseException, IOException {
		HttpSession session = request.getSession();
		ResourceBundle res = ResourceBundle.getBundle("host");
		PrintWriter out = response.getWriter();
		response.setContentType("text/xml; charset=UTF-8");// 设置输出信息的格式及字符集
		response.setHeader("Cache-Control", "no-cache");
		String msg = "";
		session.setMaxInactiveInterval(3600);
		
		Btc_user user = (Btc_user)session.getAttribute("globaluser");
		
		String rondomcode = rc.random2();
		session.setAttribute("msgcode", rondomcode);
		String content="您本次的验证码为："+rondomcode+"-请勿将验证码转告他人【"+res.getString("host.small.title")+"】";
		
		String email = user.getUemail();
		Btc_mail_content mail = new Btc_mail_content();
		mail.setBtc_mail_content_body(content);
		mail.setBtc_mail_content_id(1);
		mail.setBtc_mail_content_subject(""+res.getString("host.small.title")+"-验证码");
		mail.setBtc_mail_content_use("active");
		
		mailutil.sendMail(mail, user.getUemail());
		msg = "已将验证码发送到了您的邮箱"+email+"";
		out.println(msg);
		out.close();
	}

}
