package com.mvc.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import com.mvc.entity.Btc_user;
import com.mvc.service.UserService;
import com.mvc.util.CookieHelper;
import com.mvc.util.MD5Util;

@Controller
@RequestMapping("/register.do")
public class RegisterController {
	@Autowired
	private UserService us;
	protected final transient Log log = LogFactory.getLog(RegisterController.class);
	@Autowired
	private MD5Util md5util;

	@RequestMapping
	public String registerStep1(HttpServletRequest request, HttpServletResponse response,  ModelMap modelMap) throws IOException {
		Btc_user userVertify = new Btc_user();
		Btc_user user = new Btc_user();
		String uusername = request.getParameter("uusername");
		String upassword = request.getParameter("upassword");
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		String usdtime = format.format(new Date());
		String uemail = request.getParameter("uemail");
		userVertify = us.getByUsername(uusername);
		if(userVertify==null){
			CookieHelper cookieHelp = new CookieHelper();
			Cookie cookieName = null;
			Cookie cookiePassword = null;
			cookieName = cookieHelp.createCookie("uusername", uusername,604800);
			cookiePassword = cookieHelp.createCookie("upassword",upassword, 604800);
			// 回写到客户端
			response.addCookie(cookieName);
			response.addCookie(cookiePassword);
			
			user.setUusername(uusername);
			user.setUpassword(upassword);
			user.setUsdtime(usdtime);
			user.setUemail(uemail);
			try{
				us.register_step1(user);
				request.setAttribute("msg", "registerSucess");
				return "index";
			}
			catch(Exception e){
				log.error(e.getMessage());
				modelMap.put("regisetState", "注册失败，请确认信息填写准确！");
				return "register";
			}
		}else{
			request.setAttribute("msg", "对不起，该用户名已被注册！");
			return "register";
		}
	}
	
	@RequestMapping(params = "Login")
	public String gLogin(ModelMap modelMap) {
		return "login";
	}
	
	@RequestMapping(params = "step2")
	public String registerStep2(ModelMap modelMap) {
		return "login";
	}
}
