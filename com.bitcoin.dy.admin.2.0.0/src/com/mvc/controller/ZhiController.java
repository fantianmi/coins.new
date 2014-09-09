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
import com.mvc.entity.Btc_zhifubao;
import com.mvc.service.BankService;
import com.mvc.service.UserService;
import com.mvc.service.ZhifubaoService;
@Controller
@RequestMapping("/zhi.do")
public class ZhiController {
	@Autowired
	private UserService us = new UserService();
	@Autowired
	private ZhifubaoService zhis = new ZhifubaoService();

	protected final transient Log log = LogFactory.getLog(ZhiController.class);

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
	public void active(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String ids[] = request.getParameterValues("checkbox");
		
		int id = 0;
		Btc_zhifubao zhi = new Btc_zhifubao();
		String msg = "已激活开户姓名为";
		if (ids != null) {
			for (int i = 0; i < ids.length; i++) {
				id = Integer.parseInt(ids[i]);
				zhi = zhis.getzhifubaoId(id);
				zhi.setStatus("已激活");	
				zhis.updateZhi(zhi);
				msg = msg +"' "+ zhi.getCard()+" '";
				//

			}
		}

		msg = "|" + msg + "|" + "的激活申请";
		request.setAttribute("msg", msg);
		response.sendRedirect("index.do?zhifubao");
	}
}
