package com.mvc.controller;


import java.math.BigDecimal;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.mvc.entity.Btc_account_book;
import com.mvc.entity.Btc_award;
import com.mvc.entity.Btc_frc_info;
import com.mvc.entity.Btc_frc_rengou;
import com.mvc.entity.Btc_frc_rengou_log;
import com.mvc.entity.Btc_holding;
import com.mvc.entity.Btc_stock;
import com.mvc.entity.Btc_user;
import com.mvc.service.AccountService;
import com.mvc.service.GBservice;
import com.mvc.service.ProfitService;
import com.mvc.service.RengouService;
import com.mvc.service.StockService;
import com.mvc.service.UserService;
import com.mvc.service.common.AwardService;
import com.mvc.util.DataUtil;
import com.mvc.util.HoldingUtil;
import com.mvc.util.MD5Util;

@Controller
@RequestMapping("/rengou.do")
public class RengouController {
	@Autowired
	private RengouService rengous = new RengouService();
	@Autowired
	private StockService stocks = new StockService();
	@Autowired
	private HoldingUtil holdutil;
	@Autowired
	private AccountService acounts = new AccountService();
	@Autowired
	private DataUtil datas = new DataUtil();
	@Autowired
	private GBservice gbs = new GBservice();
	@Autowired
	private MD5Util md5util;
	@Autowired
	private UserService us;
	@Autowired
	private ProfitService profits;
	@Autowired
	private AwardService awards;

	protected final transient Log log = LogFactory.getLog(RengouController.class);
	
	@RequestMapping(params = "rengou")
	public String rengou(
			@RequestParam("amount") String amount,
			ModelMap modelMap, HttpServletRequest request,
			HttpServletResponse response) {
		ResourceBundle res = ResourceBundle.getBundle("stock"); 
		HttpSession session = request.getSession();
		//操作前确认信息###############################################################
		if(session.getAttribute("globaluser")==null){
			request.setAttribute("msg", "登陆超时，请重新登陆");
			request.setAttribute("href", "index.do");
			return "index";
		}
		Btc_user user = (Btc_user)session.getAttribute("globaluser");
		if(request.getParameter("utpassword")==""){
			request.setAttribute("msg", "请输入交易密码！");
			request.setAttribute("href", "back");
			return "index";
		}
		if(md5util.encode2hex(request.getParameter("utpassword")).equals(user.getUtpasswod())==false){
			request.setAttribute("msg", "交易密码输入错误！");
			request.setAttribute("href", "back");
			return "index";
		}
		if(rengous.getLatestRengouconfig()==null){
			request.setAttribute("msg", "对不起，兑换还没有开始");
			request.setAttribute("href", "back");
			return "index";
		}
		
		//get ip
    String ip = request.getHeader("x-forwarded-for");  
    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
        ip = request.getHeader("Proxy-Client-IP");  
    }  
    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
        ip = request.getHeader("WL-Proxy-Client-IP");  
    }  
    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
        ip = request.getRemoteAddr();  
    }  
		System.out.println("ip="+ip);
		
		//process rengou
		Btc_frc_rengou bfr = new Btc_frc_rengou();
		bfr = rengous.getLatestRengouconfig();
		String season = bfr.getSeason();
		boolean flag = rengous.isIpRengou(ip, season);
		if(flag==true){
			request.setAttribute("msg", "对不起，该ip已经兑换");
			request.setAttribute("href", "back");
			return "index";
		}
		BigDecimal userbuyamount = new BigDecimal(amount);
		BigDecimal eachget = bfr.getEachamount();
		BigDecimal leftamount = bfr.getAmount();
		BigDecimal userbuyamountlog = rengous.getUserRengouamount(user.getUid(), season);
		BigDecimal usercanbuy = eachget.subtract(userbuyamountlog);
		BigDecimal price = bfr.getPrice();
		BigDecimal userpayamount =price.multiply(userbuyamount);
		Btc_account_book account = new Btc_account_book();
		account = acounts.getByUidForAcount(user.getUid());
		BigDecimal useryue = account.getAb_cny();
		if(useryue.compareTo(userpayamount)<0){
			request.setAttribute("msg", "对不起，您的余额不足");
			request.setAttribute("href", "back");
			return "index";
		}
		if(usercanbuy.compareTo(userbuyamount)<0){
			request.setAttribute("msg", "对不起，非法操作，您输入的数量大于您还可以购买的数量");
			request.setAttribute("href", "back");
			return "index";
		}
		if(usercanbuy.compareTo(new BigDecimal(0))<=0){
			request.setAttribute("msg", "对不起，您的配额已经全部兑换完");
			request.setAttribute("href", "back");
			return "index";
		}
		if(leftamount.compareTo(userbuyamount)<0){
			request.setAttribute("msg", "对不起，"+season+"发放的"+res.getString("stock.rengou1.name")+"剩余不足，您最多还可以购买"+leftamount+"个"+res.getString("stock.rengou1.name")+"，请重新输入");
			request.setAttribute("href", "back");
			return "index";
		}
		//保存订单
		Btc_frc_rengou_log bfrl = new Btc_frc_rengou_log();
		bfrl.setAmount(userbuyamount);
		bfrl.setDate(datas.getTimeNow("second"));
		bfrl.setSeason(season);
		bfrl.setStutus("购买成功");
		bfrl.setUid(user.getUid());
		bfrl.setPrice(price);
		bfrl.setPayamount(userpayamount);
		bfrl.setUip(ip);
		rengous.saveBtc_frc_rengou_log(bfrl);
		
		Btc_stock stock = new Btc_stock();
		stock = stocks.getBtc_stockByStockname(res.getString("stock.rengou1.eng"));
		
		//在存在推荐人的情况下执行这个操作
		if(user.getUinvite_username()!=null){
			int awardstockid=Integer.parseInt(res.getString("stock.tjduihuan.stockid"));
			Btc_user inviter=us.getByUsername(user.getUinvite_username());
			BigDecimal amount2inviter=profits.getConfig().getTjduihuan();
			if(awards.get(inviter.getUid(),""+user.getUid()+"兑换推广赠送")==null){
				holdutil.addStock(inviter.getUid(), awardstockid,amount2inviter );
			}
			Btc_award award=new Btc_award();
			award.setCoinamount(amount2inviter);
			award.setCoinid(awardstockid);
			award.setReason(""+user.getUid()+"兑换推广赠送");
			award.setTime(datas.getTimeNow("second"));
			award.setUid(inviter.getUid());
			awards.save(award);
		}
		
		//扣除用户账户中的余额
		account.setAb_cny(account.getAb_cny().subtract(userpayamount));
		session.setAttribute("ab_cny", account.getAb_cny());
		acounts.updateAccount_Book(account);
		//用户账户充币
		holdutil.addStock(user.getUid(), stock.getBtc_stock_id(), userbuyamount);
		//更改这期的兑换总数
		bfr.setAmount(bfr.getAmount().subtract(userbuyamount));
		gbs.updateBtc_frc_rengou(bfr);
		//更改造币总量
		Btc_frc_info bfi = gbs.getFRC_Info();
		bfi.setRengou(bfi.getRengou().subtract(userbuyamount));
		gbs.updateBtc_frc_info(bfi);
		request.setAttribute("msg", "恭喜，成功兑换"+userbuyamount+"个"+res.getString("stock.rengou1.name")+"");
		request.setAttribute("href", "index.do?rengou");
		return "rengou";
	}
}
