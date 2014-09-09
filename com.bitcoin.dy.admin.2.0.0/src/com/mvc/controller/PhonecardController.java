package com.mvc.controller;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.entity.Btc_phonecard;
import com.mvc.service.shop.PhonecardService;
import com.mvc.service.shop.ShopService;
import com.mvc.service.UserService;
import com.mvc.util.DataUtil;

@Controller
@RequestMapping("/phonecard.do")
public class PhonecardController {
	@Autowired
	private PhonecardService phones;
	@Autowired
	private ShopService shops;
	@Autowired
	private UserService users;
	@Autowired
	private DataUtil datautil;
	ResourceBundle res = ResourceBundle.getBundle("msg");
	
	
	protected final transient Log log = LogFactory.getLog(PhonecardController.class);

	@RequestMapping
	public String load(HttpServletRequest request){
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		//fenye
		long countRow = 0;
		if(phones.getCard(0, true)!=null)countRow=phones.getCard(0, true).size();
        
        int start = 0;
        int count = 100;
        
        if(request.getParameter("start")!=null&&request.getParameter("count")!=null){
        	start = Integer.parseInt(request.getParameter("start"));
        	count = Integer.parseInt(request.getParameter("count"));
        }
        session.setAttribute("pcardstartNo", start);
        if(phones.getCard(0, false)!=null){
        	List<Object> sellinglist=phones.getCard(0, false);
        	request.setAttribute("sellinglist", sellinglist);
        	
        }
        List<Object> selledlist=phones.getCard(0, true,start,count);

        request.setAttribute("countRow", countRow);
		
		Map<Integer,Object> usermap = users.getUserMap();
		request.setAttribute("selledlist", selledlist);
		request.setAttribute("usermap", usermap);
		request.setAttribute("season", phones.getLatestSeason());
		request.setAttribute("isopen", shops.getCardById().getIsopen());
		return "phonecard";
	}
	
	@RequestMapping(params="add")
	public String add(
			HttpServletRequest request,
			@RequestParam("cardnum")String cardnum,
			@RequestParam("cardprice")BigDecimal cardprice,
			@RequestParam("season")String season
			){
		Btc_phonecard card = new Btc_phonecard();
		card.setCard(cardnum);
		card.setPrice(cardprice);
		card.setSeason(season);
		card.setSdtime(datautil.getTimeNow("second"));
		phones.save(card);
		request.setAttribute("msg",res.getString("operator.sucess") );
		request.setAttribute("href", "phonecard.do");
		return "redirect";
	}
	@RequestMapping(params="delete")
	public String delete(
			HttpServletRequest request
			){
		String ids[] = request.getParameterValues("checkbox");
		Btc_phonecard card = new Btc_phonecard();
		if (ids != null) {
			for (int i = 0; i < ids.length; i++) {
				int id=Integer.parseInt(ids[i]);
				card=phones.getCardById(id);
				phones.delete(card);
			}
		}
		request.setAttribute("msg",res.getString("operator.sucess") );
		request.setAttribute("href", "phonecard.do");
		return "redirect";
	}
}
