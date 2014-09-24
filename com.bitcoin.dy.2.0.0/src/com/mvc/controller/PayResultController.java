package com.mvc.controller;


import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/paysuccess.do")
public class PayResultController {

	protected final transient Log log = LogFactory
			.getLog(RechargeController.class);

	@RequestMapping
	public String load(ModelMap modelMap, HttpServletRequest request) {
		return "paysuccess";
	}
}
