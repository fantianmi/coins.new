package com.mvc.controller;

import java.io.IOException;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mvc.entity.Btc_mail_content;
import com.mvc.entity.Btc_user;
import com.mvc.service.UserService;
import com.mvc.util.DataUtil;
import com.mvc.util.MailUtil;
import com.mvc.util.ServletUtil;
import com.mvc.util.ValidUtils;
import com.mvc.vo.RetCode;


@Controller
@RequestMapping("/open.do")
public class OpenController {
	@Autowired
	private UserService userServ;
	@Autowired
	private MailUtil mailUtil;
	@Autowired
	private DataUtil dataUtil;
	@RequestMapping(params="reg1")
	public void reg1(HttpServletRequest request,HttpServletResponse response) throws IOException{
		ResourceBundle hostres = ResourceBundle.getBundle("host"); 
		String regUserName=request.getParameter("regUserName");
		String regPassword=request.getParameter("regPassword");
		RetCode ret = RetCode.OK;
		Btc_user user=new Btc_user();
		if(userServ.checkEmailExist(regUserName)){
			ret=RetCode.USER_EXIST;
			ServletUtil.writeCommonReply(null, ret, response);
			return;
		}else if(!ValidUtils.emailFormat(regUserName)){
			ret=RetCode.EMAIL_ERROR;
			ServletUtil.writeCommonReply(null, ret, response);
			return;
		}
		//基本信息保存
		user.setUusername(regUserName);
		user.setUemail(regUserName);
		user.setMD5Upassword(regPassword);
		//角色状态保存
		user.setUrole("user");
		String validatecode=regUserName+dataUtil.getNoSpaceTime();
		user.setUvalidateCode(validatecode);
		user.setUstatus("active");
		//保存ddz信息
		user.setGrade(0);
		user.setHead("0.gif");
		user.setUsdtime(dataUtil.getTimeNow("second"));
		//保存推荐人信息
		int recommended_user_id = 0;
		try {
			String recommend = request.getParameter("r");
			// String recommend = null;
			if (recommend == null || "null".equals(recommend))
				recommend = (String) request.getSession(true).getAttribute(
						"recommend");
			if (recommend != null) {
				recommended_user_id = Integer.parseInt(recommend);
			}
		} catch (NumberFormatException e) {

		}
		user.setRecommend(recommended_user_id);
		userServ.save(user);
		//邮件通知
		String body="欢迎注册"+hostres.getString("host.title")+"，您的账号是："+regUserName+"";
		Btc_mail_content content = new Btc_mail_content();
		content.setBtc_mail_content_body(body);
		content.setBtc_mail_content_id(1);
		content.setBtc_mail_content_subject(""+hostres.getString("host.title")+"帐号激活邮件");
		content.setBtc_mail_content_use("active");
		mailUtil.sendMail(content, user.getUemail());
		ServletUtil.writeCommonReply("注册成功!", ret, response);
	}
	
	@RequestMapping(params="chcekregname")
	public void chcekregname(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String email=request.getParameter("email");
		RetCode ret = RetCode.OK;
		if(userServ.checkEmailExist(email)){
			ret=RetCode.USER_EXIST;
		}
		ServletUtil.writeCommonReply(null, ret, response);
	}
}
