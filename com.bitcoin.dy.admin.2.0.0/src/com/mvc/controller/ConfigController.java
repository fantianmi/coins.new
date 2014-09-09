package com.mvc.controller;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mvc.entity.Btc_mail_config;
import com.mvc.entity.Btc_profit;
import com.mvc.service.MailService;
import com.mvc.service.ProfitService;

@Controller
@RequestMapping("/config.do")
public class ConfigController {
	@Autowired
	private ProfitService profitService = new ProfitService();
	@Autowired
	private MailService mailservice = new MailService();
	
	protected final transient Log log = LogFactory
	.getLog(ConfigController.class);
	
	@RequestMapping
	public String load(ModelMap modelMap, HttpServletRequest request){
		return "index";
	}
	
	@RequestMapping(params = "updateMail")
	public String updateMail(ModelMap modelMap, HttpServletRequest req){
		
		Btc_mail_config config = mailservice.getMailConfig();
		
		String btc_mail_hostName = req.getParameter("mail_hostName").toString().trim();
		String btc_mail_imap_adr = req.getParameter("mail_imap_adr").toString().trim();
		String btc_mail_password = req.getParameter("mail_password").toString().trim();
		String btc_mail_pop_adr = req.getParameter("mail_pop_adr").toString().trim();
		String btc_mail_smtp_adr = req.getParameter("mail_smtp_adr").toString().trim();
		String btc_mail_username = req.getParameter("mail_username").toString().trim();
		String btc_wangzhi = req.getParameter("wangzhi").toString().trim();
		String btc_mail_adr = req.getParameter("mail_adr").toString().trim();
		
		config.setBtc_mail_adr(btc_mail_adr);
		config.setBtc_mail_hostName(btc_mail_hostName);
		config.setBtc_mail_imap_adr(btc_mail_imap_adr);
		config.setBtc_mail_password(btc_mail_password);
		config.setBtc_mail_pop_adr(btc_mail_pop_adr);
		config.setBtc_mail_smtp_adr(btc_mail_smtp_adr);
		config.setBtc_mail_username(btc_mail_username);
		config.setBtc_wangzhi(btc_wangzhi);
		
		mailservice.updateMailConfig(config);
		
		req.setAttribute("msg", "修改邮箱配置成功！");
		req.setAttribute("href", "index.do?mailconfig");
		return "setting";
	}
	
	@RequestMapping(params = "updateConfig")
	public String recharge_btc(HttpServletRequest request, HttpServletResponse response){
		Btc_profit btc_profit = profitService.getConfig();
		if(request.getParameter("btc_profit_rechargeCNY_limit")!=null){
			btc_profit.setBtc_profit_rechargeCNY_limit(new BigDecimal(request.getParameter("btc_profit_rechargeCNY_limit")));
		}
		if(request.getParameter("btc_profit_profit_inviteUser_get")!=null){
			btc_profit.setBtc_profit_profit_inviteUser_get(new BigDecimal(request.getParameter("btc_profit_profit_inviteUser_get").toString()));
		}
		if(request.getParameter("btc_profit_profit_rechargeStock_get")!=null){
			btc_profit.setBtc_profit_profit_rechargeStock_get(new BigDecimal(request.getParameter("btc_profit_profit_rechargeStock_get").toString()));
		}
		if(request.getParameter("btc_profit_profit_trade_get")!=null){
			btc_profit.setBtc_profit_profit_trade_get(new BigDecimal(request.getParameter("btc_profit_profit_trade_get")));
		}
		if(request.getParameter("btc_profit_rechargeCNY_poundage")!=null){
			btc_profit.setBtc_profit_rechargeCNY_poundage(new BigDecimal(request.getParameter("btc_profit_rechargeCNY_poundage")));
		}
		if(request.getParameter("btc_profit_withdrawCNY_limit_min")!=null){
			btc_profit.setBtc_profit_withdrawCNY_limit_min(new BigDecimal(request.getParameter("btc_profit_withdrawCNY_limit_min").toString()));
		}
		if(request.getParameter("btc_profit_withdrawCNY_poundage")!=null){
			btc_profit.setBtc_profit_withdrawCNY_poundage(new BigDecimal(request.getParameter("btc_profit_withdrawCNY_poundage").toString()));
		}
		if(request.getParameter("btc_profit_rechargeStock_limit")!=null){
			btc_profit.setBtc_profit_rechargeStock_limit(new BigDecimal(request.getParameter("btc_profit_rechargeStock_limit").toString()));
		}
		if(request.getParameter("btc_profit_rechargeStock_poundage")!=null){
			btc_profit.setBtc_profit_rechargeStock_poundage(new BigDecimal(request.getParameter("btc_profit_rechargeStock_poundage").toString()));
		}
		if(request.getParameter("btc_profit_withdrawStock_limit_min")!=null){
			btc_profit.setBtc_profit_withdrawStock_limit_min(new BigDecimal(request.getParameter("btc_profit_withdrawStock_limit").toString()));
		}
		if(request.getParameter("btc_profit_withdrawStock_limit_max")!=null){
			btc_profit.setBtc_profit_withdrawStock_limit_max(new BigDecimal(request.getParameter("btc_profit_withdrawStock_limit_max").toString()));
		}
		if(request.getParameter("btc_profit_withdrawCNY_limit_max")!=null){
			btc_profit.setBtc_profit_withdrawCNY_limit_max(new BigDecimal(request.getParameter("btc_profit_withdrawCNY_limit_max").toString()));
		}
		if(request.getParameter("btc_profit_withdrawStock_poundage")!=null){
			btc_profit.setBtc_profit_withdrawStock_poundage(new BigDecimal(request.getParameter("btc_profit_withdrawStock_poundage").toString()));
		}
		if(request.getParameter("btc_profit_trade_poundage")!=null){
			btc_profit.setBtc_profit_trade_poundage(new BigDecimal(request.getParameter("btc_profit_trade_poundage").toString()));
		}
		if(request.getParameter("inviteRegist_get")!=null){
			btc_profit.setInviteRegist_get(new BigDecimal(request.getParameter("inviteRegist_get").toString()));
		}
		if(request.getParameter("regist_get")!=null){
			btc_profit.setRegist_get(new BigDecimal(request.getParameter("regist_get").toString()));
		}
		if(request.getParameter("rechargecny_get")!=null){
			btc_profit.setRechargecny_get(new BigDecimal(request.getParameter("rechargecny_get").toString()));
		}
		if(request.getParameter("isjiaoyi")!=null){
			btc_profit.setIsjiaoyi(request.getParameter("isjiaoyi").toString());
		}
		if(request.getParameter("rechargecny_getpgc")!=null){
			btc_profit.setRechargecny_getpgc(new BigDecimal(request.getParameter("rechargecny_getpgc").toString()));
		}
		if(request.getParameter("tjduihuan")!=null){
			btc_profit.setTjduihuan(new BigDecimal(request.getParameter("tjduihuan").toString()));
		}
		profitService.updateConfig(btc_profit);
		request.setAttribute("msg", "修改成功！");
		request.setAttribute("href", "index.do?setting");
		return "setting";
	}
}
