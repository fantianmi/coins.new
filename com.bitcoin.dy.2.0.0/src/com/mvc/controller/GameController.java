package com.mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
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

import com.mvc.entity.Btc_holding;
import com.mvc.entity.Btc_user;
import com.mvc.service.HoldingService;
import com.mvc.service.UserService;
import com.mvc.vo.GameModel;


@Controller
@RequestMapping("/game.do")
public class GameController {
	@Autowired
	private UserService us;
	ResourceBundle res = ResourceBundle.getBundle("ddz");
	@Autowired
	private HoldingService hs;
	protected final transient Log log = LogFactory.getLog(GameController.class);
	
	@RequestMapping
	public String game(
			@RequestParam("room")int room,
			HttpServletRequest request,HttpServletResponse response){
		HttpSession session = request.getSession();
		if(session.getAttribute("globaluser")==null){
			request.setAttribute("msg", "登陆后才能进行此操作！");
			request.setAttribute("href", "login.do");
			return "login";
		}
		Btc_user user = (Btc_user)session.getAttribute("globaluser");
		user = us.getByUid(user.getUid());
		GameModel gm = new GameModel();
		session.setAttribute("globaluser", user);
		if(room==5){
			request.setAttribute("ddz", "ddz_5");
		}else if(room==10){
			request.setAttribute("ddz", "ddz_10");
		}else{
			request.setAttribute("ddz", "ddz_1");
		}
		int ddzstockid=Integer.parseInt(res.getString("game.stock.id"));
		if(hs.getBtc_holding(user.getUid(),ddzstockid)==null){
			gm.setAccountyue(new BigDecimal(0));
		}else{
			Btc_holding hold = hs.getBtc_holding(user.getUid(), ddzstockid);
			gm.setAccountyue(hold.getBtc_stock_amount());
		}
		gm.setGameYue(user.getGrade());
		request.setAttribute("gamemodel", gm);
		if((user.getGrade()<100&&room==1)||(user.getGrade()<500&&room==5)||(user.getGrade()<1000&&room==10)){
			request.setAttribute("yuebuzu", true);
			return "ddz";
		}
		return "ddz";
	}
	
	@RequestMapping(params="ingrade")
	public String ingrade(
			@RequestParam("hamount")String amount,
			HttpServletRequest request,HttpServletResponse response){
		HttpSession session = request.getSession();
		if(session.getAttribute("globaluser")==null){
			request.setAttribute("msg", "登陆后才能进行此操作！");
			request.setAttribute("href", "login.do");
			return "login";
		}
		Btc_user user = (Btc_user)session.getAttribute("globaluser");
		user = us.getByUid(user.getUid());
		if(hs.getBtc_holding(user.getUid(), Integer.parseInt(res.getString("game.stock.id")))==null){
			request.setAttribute("msg", "您的账户中没有足够的"+res.getString("game.stock.name")+"进行转入"+amount+"操作");
			request.setAttribute("href", "back");
			return "game";
		}
		Btc_holding hold = hs.getBtc_holding(user.getUid(), Integer.parseInt(res.getString("game.stock.id")));
		
		if(hold.getBtc_stock_amount().compareTo(new BigDecimal(amount))<0){
			request.setAttribute("msg", "您的账户中没有足够的"+res.getString("game.stock.name")+"进行转入"+amount+"操作");
			request.setAttribute("href", "back");
			return "game";
		}
		
		//update btc_holding
		hold.setBtc_stock_amount(hold.getBtc_stock_amount().subtract(new BigDecimal(amount)));
		hs.updateBtc_holding(hold);
		
		int iamount = Integer.parseInt(amount);
		//update btc_user
		user.setGrade(user.getGrade()+iamount);
		us.updateUser(user);
		
		request.setAttribute("msg", "成功转如入"+amount+"个"+res.getString("game.stock.name")+"到游戏积分");
		request.setAttribute("href", "game.do?room=1");
		return "redirect";
	}
	@RequestMapping(params="outgrade")
	public String outgrade(
			@RequestParam("gamount")String amount,
			HttpServletRequest request,HttpServletResponse response){
		HttpSession session = request.getSession();
		if(session.getAttribute("globaluser")==null){
			request.setAttribute("msg", "登陆后才能进行此操作！");
			request.setAttribute("href", "login.do");
			return "login";
		}
		Btc_user user = (Btc_user)session.getAttribute("globaluser");
		user = us.getByUid(user.getUid());
		int iamount = Integer.parseInt(amount);
		if(iamount>user.getGrade()){
			request.setAttribute("msg", "您的游戏中没有足够的积分可以进行转出"+amount+"个"+res.getString("game.stock.name")+"操作");
			request.setAttribute("href", "back");
			return "redirect";
		}
		//update btc_user
		user.setGrade(user.getGrade()-iamount);
		us.updateUser(user);
		session.setAttribute("globaluser", user);
		
		//update btc_holding
		Btc_holding hold = hs.getBtc_holding(user.getUid(), Integer.parseInt(res.getString("game.stock.id")));
		hold.setBtc_stock_amount(hold.getBtc_stock_amount().add(new BigDecimal(amount)));
		hs.updateBtc_holding(hold);
		request.setAttribute("msg", "成功转出"+amount+"个"+res.getString("game.stock.name")+"");
		request.setAttribute("href", "game.do?room=1");
		return "game";
	}
	@RequestMapping(params="checkyue")
	public void checkyue(HttpServletRequest request, HttpServletResponse response) throws IOException{
		HttpSession session = request.getSession();
		/*
		 * init out header
		 */
		String msg = "nomsg";
		String href = "nohref";
		PrintWriter out = response.getWriter();
		response.setContentType("text/xml; charset=UTF-8");// 设置输出信息的格式及字符集
		response.setHeader("Cache-Control", "no-cache");
		
		
		if(session.getAttribute("globaluser")==null){
			msg = "登陆超时，请先登录";
			href = "login.do";
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		Btc_user user = (Btc_user)session.getAttribute("globaluser");
		user = us.getByUid(user.getUid());
		if(user.getGrade()<=0){
			msg = "您的游戏积分不足0，请充值后再玩";
			href = "game.do";
			out.println("<response>");
			out.println("<href>" + href + "</href>");
			out.println("<msg>" + msg + "</msg>");
			out.println("</response>");
			out.close();
			return;
		}
		out.println("<response>");
		out.println("<href>" + href + "</href>");
		out.println("<msg>" + msg + "</msg>");
		out.println("</response>");
		out.close();
	}
}
