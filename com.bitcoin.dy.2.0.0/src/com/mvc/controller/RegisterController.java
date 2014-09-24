package com.mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
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

import com.mvc.entity.Btc_mail_content;
import com.mvc.entity.Btc_profit;
import com.mvc.entity.Btc_user;
import com.mvc.service.ProfitService;
import com.mvc.service.UserService;
import com.mvc.util.AwardsUtil;
import com.mvc.util.MD5Util;
import com.mvc.util.MailUtil;
import com.mvc.util.RandomCode;
import com.mvc.util.ServletUtil;
import com.mvc.vo.RetCode;

@Controller
@RequestMapping("/register.do")
public class RegisterController {
	@Autowired
	private UserService us;
	@Autowired
	private ProfitService profits;
	@Autowired
	private RandomCode rc = new RandomCode();
	@Autowired
	private MailUtil mailUtil;
	@Autowired
	private MD5Util md5util;
	@Autowired
	private AwardsUtil awards;
	
	protected final transient Log log = LogFactory.getLog(RegisterController.class);

	
	@RequestMapping(params = "promote")
	public void promoteRegister(HttpServletResponse response, HttpServletRequest request, ModelMap modelmap) throws IOException{
		request.setCharacterEncoding("utf-8");
		ResourceBundle res = ResourceBundle.getBundle("stock"); 
		HttpSession session = request.getSession();
		
		Btc_user user = (Btc_user)session.getAttribute("globaluser");
		String utpassword = request.getParameter("upassword");
		String uname = request.getParameter("realName");
		
		RetCode ret = RetCode.OK;
		
		if(request.getParameter("identityNo")==null){
			ret=RetCode.IDCARD_EXIST;
			ServletUtil.writeCommonReply("请输入身份证号", ret, response);
			return;
		}
		String identityNo = request.getParameter("identityNo");
		if(us.checkucertificationExist(identityNo)==true){
			ret=RetCode.IDCARD_EXIST;
			ServletUtil.writeCommonReply("身份证已存在", ret, response);
			return;
		}
		Btc_profit profit = profits.getConfig();
		BigDecimal userget = profit.getRegist_get();
		awards.awardStock(user.getUid(), Integer.parseInt(res.getString("stock.registeraward.stockid")), userget);
		
		if(user.getRecommend()!=0){
			awards.awardStock(user.getRecommend(), Integer.parseInt(res.getString("stock.tuijieaward.stockid")), profit.getInviteRegist_get());
			user.setUpstate("已获得");
			us.update(user);
		}
		String ucertificationcategory="中国身份证认证";
		user.setMD5Utpasswod(utpassword);
		user.setUname(uname);
		user.setUcertification(identityNo);
		user.setUcertificationcategory(ucertificationcategory);
		us.update(user);
		ServletUtil.writeCommonReply("谢谢完善资料", ret, response);
	}
	
	@RequestMapping(params = "Login")
	public String gLogin(ModelMap modelMap) {
		return "login";
	}
	
	@RequestMapping(params = "update")
	public String update(HttpServletResponse response, HttpServletRequest request, ModelMap modelMap) {
		HttpSession session = request.getSession();
		String code = (String)session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);  
		if(request.getParameter("kaptcha")==""){
			request.setAttribute("msg", "请输入验证码！");
			request.setAttribute("href", "back");
			return "index";
		}
		if(code.equals(request.getParameter("kaptcha").toString())==false){
			request.setAttribute("msg", "验证码输入错误，请重新输入");
			request.setAttribute("href", "back");
			return "index";
		}
		if(session.getAttribute("globaluser") == null){
			request.setAttribute("msg", "登陆后才能进行此操作！");
			request.setAttribute("href", "index.do");
			return "index";
		}
		if(request.getParameter("email")==""&&request.getParameter("uphone")==""
			&&request.getParameter("usafequestionanswer")==""&&request.getParameter("usafequestion")==""){
			request.setAttribute("msg", "请确认是否填写完全");
			request.setAttribute("href", "back");
			return "index";
		}
		String uemail = request.getParameter("email").toString();
		String uphone = request.getParameter("uphone").toString();
		String usafeq = request.getParameter("usafequestionanswer").toString();
		String usafeqa = request.getParameter("usafequestion").toString();
		Btc_user user = (Btc_user)session.getAttribute("globaluser");
		user.setUemail(uemail);
		user.setUphone(uphone);
		user.setUsafequestion(usafeq);
		user.setUsafequestionanswer(usafeqa);
		us.update(user);
		request.setAttribute("msg", "恭喜您，修改资料成功！");
		request.setAttribute("href", "back");
		return "index";
	}
	
	@RequestMapping(params = "updatepassword")
	public String updatepassword(HttpServletResponse response, HttpServletRequest request, ModelMap modelMap) {
		HttpSession session = request.getSession();
		if(session.getAttribute("globaluser") == null){
			request.setAttribute("msg", "登陆后才能进行此操作！");
			request.setAttribute("href", "index.do");
			return "index";
		}
		if(request.getParameter("opassword")==""&&request.getParameter("npassword")==""
			&&request.getParameter("password2")==""){
			request.setAttribute("msg", "请确认是否填写完全");
			request.setAttribute("href", "back");
			return "index";
		}
		Btc_user user = (Btc_user)session.getAttribute("globaluser");
		String type = request.getParameter("updatetype").toString();
		String opassword = md5util.encode2hex(request.getParameter("opassword").toString());
		String npassword = request.getParameter("npassword").toString();
		if(type.equals("updatepassword")){
			if(!user.getUpassword().equals(opassword)){
				request.setAttribute("msg", "原密码输入错误");
				request.setAttribute("href", "back");
				return "redirect";
			}
			user.setMD5Upassword(npassword);
			us.update(user);
			request.setAttribute("msg", "恭喜您，修改成功！");
			request.setAttribute("href", "back");
			return "redirect";
		}else if(type.equals("updateutpassword")){
			if(!user.getUtpasswod().equals(opassword)){
				request.setAttribute("msg", "原交易密码输入错误");
				request.setAttribute("href", "back");
				return "redirect";
			}
			user.setMD5Utpasswod(npassword);
			us.update(user);
			request.setAttribute("msg", "恭喜您，修改成功！");
			request.setAttribute("href", "back");
			return "redirect";
		}else{
			request.setAttribute("msg", "非法操作！");
			request.setAttribute("href", "back");
			return "redirect";
		}
	}
	
	@RequestMapping(params = "step2")
	public String registerStep2(ModelMap modelMap) {
		return "login";
	}
	
	@RequestMapping(params = "findpass")
	public void findpass(
			@RequestParam("username")String username,
			@RequestParam("type")String type,
			HttpServletResponse response, 
			HttpServletRequest request) throws IOException {
		ResourceBundle res = ResourceBundle.getBundle("host");
		HttpSession session = request.getSession();
		String msg = "";
		String href = "nohref";
		PrintWriter out = response.getWriter();
		response.setContentType("text/xml; charset=UTF-8");// 设置输出信息的格式及字符集
		response.setHeader("Cache-Control", "no-cache");
		if(request.getParameter("username")==null||request.getParameter("username")==""){
			msg="请输入用户名";
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		Btc_user user = new Btc_user();
		if(us.getByUsername(username)==null){
			msg="对不起，您输入的用户名不存在";
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		String rondomcode = rc.random2();
		session.setMaxInactiveInterval(1800);
		Map<String,String> map = new HashMap<String,String>();
		map.put("type", type);
		map.put("code", rondomcode);
		map.put("username", username);
		session.setAttribute("updatecode", map);
		user = us.getByUsername(username);
		//为进行实名认证发送邮件
		String email = user.getUemail();
		String body = "<p>亲爱的"+username+"，您好</p><p>您重置密码的验证号为：<b>"+rondomcode+"</b>，请在三十分钟之内在找回密码的验证框中输入您的验证号然后重置密码</p><p><br /></p><p>"+res.getString("host.title")+"</p>";
		Btc_mail_content content = new Btc_mail_content();
		content.setBtc_mail_content_body(body);
		content.setBtc_mail_content_id(1);
		content.setBtc_mail_content_subject(""+res.getString("host.small.title")+"-找回您的密码");
		content.setBtc_mail_content_use("active");
		
		mailUtil.sendMail(content, user.getUemail());
		msg = "已将验证码发送到了您的邮箱"+email+"，请在三十分钟之内在下框输入您收到的验证码，然后重置密码";
		href= "index.do?resetpass&type="+type;
		out.println("<response>");
		out.println("<href><![CDATA[" + href + "]]></href>");
		out.println("<msg>" + msg + "</msg>");
		out.println("</response>");
		out.close();
		return;
	}
	
	@RequestMapping(params = "resetpass")
	public void resetpass(
			@RequestParam("type")String type,
			@RequestParam("code")String code,
			@RequestParam("password1")String npass,
			HttpServletResponse response, 
			HttpServletRequest request) throws IOException {
		//######################################################################
		String msg = "";
		String href = "nohref";
		PrintWriter out = response.getWriter();
		response.setContentType("text/xml; charset=UTF-8");// 设置输出信息的格式及字符集
		response.setHeader("Cache-Control", "no-cache");
		//#########################################################################
		HttpSession session = request.getSession();
		Map<String,String> map = (Map<String,String>)session.getAttribute("updatecode");
		String musername = map.get("username");
		String mtype = map.get("type");
		String mcode = map.get("code");
		Btc_user user = new Btc_user();
		user = us.getByUsername(musername);
		if(!type.equals(mtype)||!code.equals(mcode)){
			msg="填写信息不正确，请确认";
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		if(type.equals("upass")){
			user.setMD5Upassword(npass);
			us.update(user);
			msg="重置密码成功，点击确认回到首页";
			href="index.do";
			out.println("<response>");
			out.println("<href>" + "<![CDATA[" + href + "]]>" + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}else if(type.equals("utpass")){
			user.setMD5Utpasswod(npass);
			us.update(user);
			msg="重置交易密码成功，点击确认回到登录页面登录";
			href="index.do";
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		msg="非法操作";
		out.println("<response>");
		out.println("<href>" + href + "</href>");
		out.println("<msg>" + msg + "</msg>");
		out.println("</response>");
		out.close();
		return;
	}
}
