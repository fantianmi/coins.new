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

import com.mvc.entity.Btc_bank;
import com.mvc.entity.Btc_inAll;
import com.mvc.entity.Btc_incomeCNY;
import com.mvc.entity.Btc_user;
import com.mvc.entity.Btc_withdrawCNY_order;
import com.mvc.service.BankService;
import com.mvc.service.UserService;
@Controller
@RequestMapping("/bank.do")
public class BankController {
	@Autowired
	private UserService us = new UserService();
	@Autowired
	private BankService banks = new BankService();

	protected final transient Log log = LogFactory.getLog(BankController.class);

	/**
	 * 生成订单，并从用户帐本中扣除相应费用
	 * 
	 * @param modelmap
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(params="add")
	public String active(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String bankids[] = request.getParameterValues("checkbox");
		
		int bankid = 0;
		Btc_bank bank = new Btc_bank();
		String bro_idToJsp = "已激活开户姓名为";
		if (bankids != null) {
			for (int i = 0; i < bankids.length; i++) {
				bankid = Integer.parseInt(bankids[i]);
				bank = banks.getBankByID(bankid);
				bank.setStatus("已激活");	
				banks.updateBank(bank);
				bro_idToJsp = bro_idToJsp +"'"+ bank.getName()+"'";
				//

			}
		}

		bro_idToJsp = "|" + bro_idToJsp + "|" + "的激活申请";
		request.setAttribute("msg", bro_idToJsp);
		request.setAttribute("href", "index.do?bankmanage");
		return "bankmanage";
	}
	@RequestMapping(params="reject")
	public String reject(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
String bankids[] = request.getParameterValues("checkbox");
		
		int bankid = 0;
		Btc_bank bank = new Btc_bank();
		String bro_idToJsp = "已拒绝开户姓名为";
		if (bankids != null) {
			for (int i = 0; i < bankids.length; i++) {
				bankid = Integer.parseInt(bankids[i]);
				bank = banks.getBankByID(bankid);
				bank.setStatus("激活失败！请联系客服");	
				banks.updateBank(bank);
				bro_idToJsp = bro_idToJsp +"'"+ bank.getName()+"'";
				//

			}
		}

		bro_idToJsp = "|" + bro_idToJsp + "|" + "的激活申请";
		request.setAttribute("msg", bro_idToJsp);
		request.setAttribute("href", "index.do?bankmanage");
		return "bankmanage";
	}
}
