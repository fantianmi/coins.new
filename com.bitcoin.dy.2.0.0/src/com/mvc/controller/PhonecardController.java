package com.mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.entity.Btc_phonecard;
import com.mvc.entity.Btc_shop;
import com.mvc.entity.Btc_user;
import com.mvc.service.PhonecardService;
import com.mvc.service.StockService;
import com.mvc.service.shop.ShopService;
import com.mvc.util.DataUtil;
import com.mvc.util.HoldingUtil;
import com.mvc.util.MD5Util;

@Controller
@RequestMapping("/phonecard.do")
public class PhonecardController {
	@Autowired
	private MD5Util md5util;
	@Autowired
	private PhonecardService phones;
	@Autowired
	private StockService stocks;
	@Autowired
	private HoldingUtil holdutil;
	@Autowired
	private DataUtil datautil;
	@Autowired
	private ShopService shops;
	
	ResourceBundle res = ResourceBundle.getBundle("msg");
	
	
	protected final transient Log log = LogFactory.getLog(PhonecardController.class);

	@RequestMapping
	public String load(HttpServletRequest request){
		HttpSession session = request.getSession();
		if(session.getAttribute("globaluser")==null){
			request.setAttribute("msg",res.getString("login.first"));
			request.setAttribute("href","index.do");
			return "redirect";
		}
		Btc_user user = (Btc_user)session.getAttribute("globaluser");
		List<Object> list = phones.getCard(user.getUid(),null);
		Map<Integer,Object> stockmap=stocks.getBtc_stock();
		request.setAttribute("list", list);
		request.setAttribute("stockmap", stockmap);
		return "phonecardshop";
	}
	@RequestMapping(params="buycard")
	public void buycard(
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam("amount")BigDecimal amount,
			@RequestParam("price")BigDecimal price,
			@RequestParam("stockid")int stockid
			) throws IOException{
		String href = "nohref";
		PrintWriter out = response.getWriter();
		response.setContentType("text/xml; charset=UTF-8");// 设置输出信息的格式及字符集
		response.setHeader("Cache-Control", "no-cache");
		HttpSession session = request.getSession();
		if(session.getAttribute("globaluser")==null){
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + res.getString("login.first") + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		Btc_shop shop=shops.getCardById();
		if(shop.getIsopen()==0){
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>商城暂未开放</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		String season=phones.getLatestSeason();
		
		Btc_user user = (Btc_user)session.getAttribute("globaluser");
		if(season!="nodata"){
			if(phones.getCard(user.getUid(),season)!=null){
				out.println("<response>");
				out.println("<href>" + href + "</href>");
				out.println("<msg>对不起，您已经购买过了</msg>");
				out.println("</response>");
				out.close();
				return;
			}
		}
		
		if(phones.getKucun().compareTo(new BigDecimal(0))<=0){
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>库存不足</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		if(holdutil.subStock(user.getUid(), stockid, amount)==true){
			List<Object> cardlist=phones.getCard(0, false,null);
			Btc_phonecard card = (Btc_phonecard)cardlist.get(0);
			card.setUid(user.getUid());
			card.setUsetime(datautil.getTimeNow("second"));
			card.setStockid(stockid);
			phones.update(card);
			out.println("<response>");
			out.println("<href>parentreload</href>");
			out.println("<msg> 购买成功</msg>");
			out.println("</response>");
			out.close();
			return;
		}else{
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>对不起，您的余额不足</msg>");
			out.println("</response>");
			out.close();
			return;
		}
	}
}
