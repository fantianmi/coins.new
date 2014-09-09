package com.mvc.controller;


import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
import com.mvc.entity.Btc_deal_list;
import com.mvc.entity.Btc_inout_order;
import com.mvc.entity.Btc_rechargeCNY_order;
import com.mvc.entity.Btc_rechargeStock_order;
import com.mvc.entity.Btc_stock;
import com.mvc.entity.Btc_user;
import com.mvc.entity.Btc_withdrawCNY_order;
import com.mvc.service.AccountService;
import com.mvc.service.DealService;
import com.mvc.service.HoldingService;
import com.mvc.service.RechargeService;
import com.mvc.service.RechargeStockService;
import com.mvc.service.StockOrderService;
import com.mvc.service.StockService;
import com.mvc.service.UserService;
import com.mvc.vo.UserDealModel;
import com.mvc.vo.UserRcnyModel;
import com.mvc.vo.UserStockModel;
import com.mvc.vo.UserWcnyModel;


@Controller
@RequestMapping("/usermanager.do")
public class UserController {
	@Autowired
	private UserService us = new UserService();
	@Autowired
	private HoldingService holdingService = new HoldingService();
	@Autowired
	private StockService stockService = new StockService();
	@Autowired
	private AccountService as = new AccountService();
	@Autowired
	private RechargeService recharges;
	@Autowired
	private DealService deals;
	@Autowired
	private RechargeStockService rechargess;
	@Autowired
	private StockOrderService stockos;
	
	protected final transient Log log = LogFactory
	.getLog(UserController.class);
	
	@RequestMapping
	public String load(ModelMap modelMap, HttpServletRequest request){
		return "index";
	}
	
	@RequestMapping(params = "frozen")
	public String frozen(HttpServletRequest request){
		String user_ids[] = request.getParameterValues("checkboxadmin");
		Btc_user user = new Btc_user();
		String msg = "已冻结用户id分别为：";
		if(user_ids!=null){
			for(int i=0;i<user_ids.length;i++){
				user = us.getByUserId(Integer.parseInt(user_ids[i]));
				user.setUstatus("frozen");
				us.updateUser(user);
				msg = msg + " " + user.getUid() + " ";
			}
		}
		msg = msg + "的用户";
		request.setAttribute("msg", msg);
		request.setAttribute("href", "index.do?userlist");
		return "redirect";
	}
	
	@RequestMapping(params = "cancelFrozen")
	public String cancelFrozen(HttpServletRequest request){
		String user_ids[] = request.getParameterValues("checkbox");
		Btc_user user = new Btc_user();
		String msg = "已对用户id分别为：";
		if(user_ids!=null){
			for(int i=0;i<user_ids.length;i++){
				user = us.getByUserId(Integer.parseInt(user_ids[i]));
				user.setUstatus("active");
				us.updateUser(user);
				msg = msg + " " + user.getUid() + " ";
			}
		}
		msg = msg + "的用户取消冻结";
		request.setAttribute("msg", msg);
		request.setAttribute("href", "index.do?userlist");
		return "redirect";
	}
	
	@RequestMapping(params = "beAdmin")
	public String beAdmin(HttpServletRequest request){
		String user_ids[] = request.getParameterValues("checkbox");
		Btc_user user = new Btc_user();
		String msg = "已对用户id分别为：";
		if(user_ids!=null){
			for(int i=0;i<user_ids.length;i++){
				user = us.getByUserId(Integer.parseInt(user_ids[i]));
				user.setUrole("admin");
				us.updateUser(user);
				msg = msg + " " + user.getUid() + " ";
			}
		}
		msg = msg + "的用户赋予管理员权限";
		request.setAttribute("msg", msg);
		request.setAttribute("href", "index.do?userlist");
		return "redirect";
	}
	
	@RequestMapping(params = "deleteU")
	public String deleteU(HttpServletRequest request){
		String user_ids[] = request.getParameterValues("checkbox");
		Btc_user user = new Btc_user();
		String msg = "已删除用户id分别为：";
		if(user_ids!=null){
			for(int i=0;i<user_ids.length;i++){
				user = us.getByUserId(Integer.parseInt(user_ids[i]));
				msg = msg + " " + user.getUid() + " ";
				us.deleteUser(user);
			}
		}
		msg = msg + "的用户";
		request.setAttribute("msg", msg);
		request.setAttribute("href", "index.do?userlist");
		return "redirect";
	}
	
	@RequestMapping(params = "cancelAdmin")
	public String cancelAdmin(HttpServletRequest request){
		String user_id = request.getParameter("uid").toString();
		Btc_user user = new Btc_user();
		String msg = "已取消用户id分别为：";
		if(user_id!=null){
				user = us.getByUserId(Integer.parseInt(user_id));
				user.setUrole("user");
				us.updateUser(user);
				msg = msg + " " + user.getUid() + " ";
		}
		msg = msg + "的管理员权限";
		request.setAttribute("msg", msg);
		request.setAttribute("href", "index.do?userlist");
		return "redirect";
	}
	
	@RequestMapping(params = "deleteAdmin")
	public String deleteAdmin(HttpServletRequest request){
		String user_ids[] = request.getParameterValues("checkbox");
		Btc_user user = new Btc_user();
		String msg = "已删除用户id分别为：";
		if(user_ids!=null){
			for(int i=0;i<user_ids.length;i++){
				user = us.getByUserId(Integer.parseInt(user_ids[i]));
				msg = msg + " " + user.getUid() + " ";
				us.deleteUser(user);
			}
		}
		msg = msg + "的用户";
		request.setAttribute("msg", msg);
		request.setAttribute("href", "index.do?userlist");
		return "redirect";
	}
	
	@RequestMapping(params = "seeDetail")
	public String seeDetail(@RequestParam("uid")int uid,HttpServletRequest request){
		Btc_user user = us.getByUserId(uid);
		HttpSession session = request.getSession();
		session.setAttribute("username", user.getUusername());
		request.setAttribute("user", user);
		Map<Integer, Object> stock_map = stockService.getBtc_stockAll();
		session.setAttribute("stock_mapall", stock_map);
		Btc_account_book abook = as.getByUidForAcount(uid);
		if(abook == null){
			session.setAttribute("ab_cny", "0.00");
		}else{
			BigDecimal ab_cny_show = abook.getAb_cny().setScale(6, BigDecimal.ROUND_HALF_UP); 
			session.setAttribute("ab_cny", ab_cny_show);
		}
		if(holdingService.getUserholdMap(uid)!=null){
			session.setAttribute("holdmap", holdingService.getUserholdMap(uid));
		}else session.setAttribute("holdmap", null);
		/**
		 * 统计用户交易记录
		 */
		//init()
		List<UserRcnyModel> rcnylistm = new ArrayList<UserRcnyModel>();
		List<UserWcnyModel> wcnylistm = new ArrayList<UserWcnyModel>();
		List<UserStockModel> rstocklistm = new ArrayList<UserStockModel>();
		List<UserStockModel> wstocklistm = new ArrayList<UserStockModel>();
		List<UserDealModel> bdeallistm = new ArrayList<UserDealModel>();
		List<UserDealModel> sdeallistm = new ArrayList<UserDealModel>();
		
		//get list
		List<Object> rcnylist = recharges.getByUidForOrders(uid);
		List<Object> wcnylist = recharges.getWithdrawOrdersByUid(uid);
		List<Object> rstocklist = rechargess.getAllByUid(uid);
		List<Object> wstocklist = stockos.getBtc_inout_orderByUid(uid);
		List<Object> bdeallist = deals.getByBuid(uid);
		List<Object> sdeallist = deals.getBySuid(uid);
		
		Map<Integer,Object> stockmap = stockService.getAllBtc_stock();
		Btc_stock stock = new Btc_stock();
		Btc_deal_list bsdl = new Btc_deal_list();
		Btc_deal_list bbdl = new Btc_deal_list();
		Btc_rechargeCNY_order bro = new Btc_rechargeCNY_order();
		Btc_withdrawCNY_order bwo = new Btc_withdrawCNY_order();
		Btc_inout_order bwso = new Btc_inout_order();
		Btc_rechargeStock_order brso = new Btc_rechargeStock_order();
		
		/**
		 * 封装model
		 */
		//rechargecny
		if(rcnylist!=null){
			for(int i=0;i<rcnylist.size();i++){
				UserRcnyModel urm = new UserRcnyModel();
				bro = (Btc_rechargeCNY_order)rcnylist.get(i);
				urm.setAmount(bro.getBro_recharge_acount());
				urm.setRtime(bro.getBro_recharge_time());
				urm.setRway(bro.getBro_recharge_way());
				urm.setUstatus(bro.getBro_remark());
				urm.setId(bro.getBro_id());
				rcnylistm.add(urm);
			}
			request.setAttribute("rcnylistm", rcnylistm);
		}
		//withdrawcny
		if(wcnylist!=null){
			for(int i=0;i<wcnylist.size();i++){
				UserWcnyModel uwm = new UserWcnyModel();
				bwo = (Btc_withdrawCNY_order)wcnylist.get(i);
				uwm.setId(bwo.getBtc_bwo_id());
				uwm.setBank(bwo.getBtc_bwo_bank());
				uwm.setCard(bwo.getBtc_bwo_card());
				uwm.setKaihubank(bwo.getBtc_bwo_province()+"|"+bwo.getBtc_bwo_city()+"|"+bwo.getBtc_bwo_town()+"");
				uwm.setRname(bwo.getBtc_bwo_rname());
				uwm.setRstatus(bwo.getBtc_bwo_content());
				uwm.setRtime(bwo.getBtc_bwo_time());
				uwm.setWmaount(bwo.getBtc_bwo_amount());
				wcnylistm.add(uwm);
			}
			request.setAttribute("wcnylistm", wcnylistm);
		}
		//rechargestock
		if(rstocklist!=null){
			for(int i=0;i<rstocklist.size();i++){
				UserStockModel ursm = new UserStockModel();
				brso = (Btc_rechargeStock_order)rstocklist.get(i);
				ursm.setId(brso.getId());
				ursm.setAdr(brso.getAdr());
				ursm.setAmount(brso.getAmount());
				ursm.setStatus(brso.getStatus());
				stock = (Btc_stock)stockmap.get(brso.getStockid());
				ursm.setStockName(stock.getBtc_stock_Eng_name());
				ursm.setTime(brso.getDate());
				rstocklistm.add(ursm);
			}
			request.setAttribute("rstocklistm", rstocklistm);
		}
		//withdrawstock
		if(wstocklist!=null){
			for(int i=0;i<wstocklist.size();i++){
				UserStockModel uwsm = new UserStockModel();
				bwso = (Btc_inout_order)wstocklist.get(i);
				uwsm.setAdr(bwso.getBtc_inout_adr());
				uwsm.setAmount(bwso.getBtc_inout_amount());
				uwsm.setStatus(bwso.getBtc_inout_msg());
				stock = (Btc_stock)stockmap.get(bwso.getBtc_stock_id());
				uwsm.setStockName(stock.getBtc_stock_Eng_name());
				uwsm.setTime(bwso.getBtc_inout_time());
				uwsm.setId(bwso.getBtc_inout_order_id());
				wstocklistm.add(uwsm);
			}
			request.setAttribute("wstocklistm", wstocklistm);
		}
		//buylist
		if(bdeallist!=null){
			for(int i=0;i<bdeallist.size();i++){
				UserDealModel ubdm = new UserDealModel();
				bbdl = (Btc_deal_list)bdeallist.get(i);
				stock = (Btc_stock)stockmap.get(bbdl.getBtc_stock_id());
				ubdm.setId(bbdl.getBtc_deal_id());
				ubdm.setAmount(bbdl.getBtc_deal_quantity());
				ubdm.setDuihuane(bbdl.getBtc_deal_total());
				ubdm.setPrice(bbdl.getBtc_deal_Rate());
				ubdm.setStockName(stock.getBtc_stock_Eng_name());
				ubdm.setExstock(bbdl.getBtc_exstock_name());
				bdeallistm.add(ubdm);
			}
			request.setAttribute("bdeallistm", bdeallistm);
		}
		//selllist
		if(sdeallist!=null){
			for(int i=0;i<sdeallist.size();i++){
				UserDealModel ubdm = new UserDealModel();
				bsdl = (Btc_deal_list)sdeallist.get(i);
				stock = (Btc_stock)stockmap.get(bsdl.getBtc_stock_id());
				ubdm.setId(bsdl.getBtc_deal_id());
				ubdm.setAmount(bsdl.getBtc_deal_quantity());
				ubdm.setDuihuane(bsdl.getBtc_deal_total());
				ubdm.setPrice(bsdl.getBtc_deal_Rate());
				ubdm.setStockName(stock.getBtc_stock_Eng_name());
				ubdm.setExstock(bsdl.getBtc_exstock_name());
				sdeallistm.add(ubdm);
			}
			request.setAttribute("sdeallistm", sdeallistm);
		}
		return "userdetail";
	}
	
	@RequestMapping(params = "search")
	public String search(HttpServletRequest request){
		HttpSession session = request.getSession();
		String type = request.getParameter("searchway");
		if(request.getParameter("scontent")==null||request.getParameter("scontent")==""){
			request.setAttribute("msg", "请输入查询内容");
			request.setAttribute("href", "back");
			return "index";
		}
		String content = request.getParameter("scontent");
		List<Object> resultlist = new ArrayList<Object>();
		if(type.equals("byid")){
			resultlist = us.searchUserByid(Integer.parseInt(content));
		}else if(type.equals("byuname")){
			resultlist = us.searchUserByUname(content);
		}else{
			resultlist = us.searchUserByUusername(content);
		}
		session.setAttribute("resultlist", resultlist);
		return "usermanager";
	}
	
	@RequestMapping(params="drechargelog")
	public String drechargelog(
			@RequestParam("uid")int uid,
			HttpServletRequest request,HttpServletResponse response){
		String ids[] = request.getParameterValues("checkbox");
		Btc_rechargeCNY_order bro = new Btc_rechargeCNY_order();
		String msg = "已删除订单号:";
		if(ids!=null){
			for(int i=0;i<ids.length;i++){
				bro = recharges.getByBroIdForOrders(Integer.parseInt(ids[i]));
				msg = msg + bro.getBro_id() + "  ";
				recharges.deleteRechargeCNY_Order(bro);
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("href","usermanager.do?seeDetail&uid="+uid+"");
		return "redirect";
	}
	@RequestMapping(params="dwithdrawlog")
	public String dwithdrawlog(
			@RequestParam("uid")int uid,
			HttpServletRequest request,HttpServletResponse response){
		String ids[] = request.getParameterValues("checkbox");
		Btc_withdrawCNY_order bwo = new Btc_withdrawCNY_order();
		String msg = "已删除订单号:";
		if(ids!=null){
			for(int i=0;i<ids.length;i++){
				bwo = recharges.getWithdrawOrdersByBwo_id(Integer.parseInt(ids[i]));
				msg = msg + bwo.getBtc_bwo_id() + "  ";
				recharges.deleteWithdrawCNY_Order(bwo);
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("href","usermanager.do?seeDetail&uid="+uid+"");
		return "redirect";
	}
	@RequestMapping(params="drechargeslog")
	public String drechargeslog(
			@RequestParam("uid")int uid,
			HttpServletRequest request,HttpServletResponse response){
		String ids[] = request.getParameterValues("checkbox");
		Btc_rechargeStock_order bso = new Btc_rechargeStock_order();
		if(ids!=null){
			for(int i=0;i<ids.length;i++){
				bso = rechargess.getById(Integer.parseInt(ids[i]));
				rechargess.deleteOrder(bso);
			}
		}
		request.setAttribute("msg", "删除成功");
		request.setAttribute("href","usermanager.do?seeDetail&uid="+uid+"");
		return "redirect";
	}
	@RequestMapping(params="dwithdrawslog")
	public String dwithdrawslog(
			@RequestParam("uid")int uid,
			HttpServletRequest request,HttpServletResponse response){
		String ids[] = request.getParameterValues("checkbox");
		Btc_inout_order bio = new Btc_inout_order();
		if(ids!=null){
			for(int i=0;i<ids.length;i++){
				bio = stockos.getBtc_inout_orderByid(Integer.parseInt(ids[i]));
				stockos.deleteStockOrder(bio);
			}
		}
		request.setAttribute("msg", "删除成功");
		request.setAttribute("href","usermanager.do?seeDetail&uid="+uid+"");
		return "redirect";
	}
	@RequestMapping(params="ddeallist")
	public String ddeallist(
			@RequestParam("uid")int uid,
			HttpServletRequest request,HttpServletResponse response){
		String ids[] = request.getParameterValues("checkbox");
		Btc_deal_list bdl = new Btc_deal_list();
		if(ids!=null){
			for(int i=0;i<ids.length;i++){
				bdl = deals.getByDid(Integer.parseInt(ids[i]));
				deals.deleteDealOrder(bdl);
			}
		}
		request.setAttribute("msg", "删除成功");
		request.setAttribute("href","usermanager.do?seeDetail&uid="+uid+"");
		return "redirect";
	}
}
