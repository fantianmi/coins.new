package com.mvc.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mvc.entity.Btc_birth;
import com.mvc.service.BirthService;
@Controller
@RequestMapping("/birth.do")
public class BirthController {
	@Autowired
	private BirthService bs = new BirthService();

	protected final transient Log log = LogFactory.getLog(BirthController.class);

	/**
	 * 生成订单，并从用户帐本中扣除相应费用
	 * 
	 * @param modelmap
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(params="update")
	public String active(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String birth = request.getParameter("birth").trim();
		Btc_birth bb = bs.getBirth();
		bb.setBirth_time(birth);
		bs.updateBtc_birth(bb);
		request.setAttribute("msg", "修改运营起始值日期成功");
		request.setAttribute("href", "index.do?setting");
		return "setting";
	}
}
