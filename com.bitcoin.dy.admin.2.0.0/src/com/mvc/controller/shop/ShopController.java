package com.mvc.controller.shop;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.entity.Btc_shop;
import com.mvc.service.shop.ShopService;
@Controller
@RequestMapping("/shop.do")
public class ShopController {
	@Autowired
	private ShopService shops = new ShopService();

	protected final transient Log log = LogFactory.getLog(ShopController.class);

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
	public String update(
			@RequestParam("isopen")int isopen,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		Btc_shop shop=shops.getCardById();
		shop.setIsopen(isopen);
		shops.update(shop);
		request.setAttribute("msg", "修改成功");
		request.setAttribute("href", "phonecard.do");
		return "redirect";
	}
}
