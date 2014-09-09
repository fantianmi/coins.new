package com.mvc.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.entity.Btc_birth;
import com.mvc.entity.Btc_factory;
import com.mvc.entity.Btc_fhDDC;
import com.mvc.entity.Btc_frc_info;
import com.mvc.entity.Btc_frc_rengou;
import com.mvc.entity.Btc_inAll;
import com.mvc.entity.Btc_mail_config;
import com.mvc.entity.Btc_profit;
import com.mvc.entity.Btc_stock;
import com.mvc.entity.Btc_trade_category;
import com.mvc.entity.Btc_user;
import com.mvc.entity.Btc_votestock;
import com.mvc.service.AccountService;
import com.mvc.service.BankService;
import com.mvc.service.BirthService;
import com.mvc.service.CotentService;
import com.mvc.service.DealService;
import com.mvc.service.FactoryService;
import com.mvc.service.FenhongService;
import com.mvc.service.FhOrderService;
import com.mvc.service.FinanceService;
import com.mvc.service.GBservice;
import com.mvc.service.HoldingService;
import com.mvc.service.MailService;
import com.mvc.service.OrderService;
import com.mvc.service.PaycardService;
import com.mvc.service.PoundageService;
import com.mvc.service.ProfitService;
import com.mvc.service.RechargeService;
import com.mvc.service.RechargeStockService;
import com.mvc.service.RengouService;
import com.mvc.service.StockOrderService;
import com.mvc.service.StockService;
import com.mvc.service.TongjiService;
import com.mvc.service.TradeCateService;
import com.mvc.service.UserService;
import com.mvc.service.VoteStockService;
import com.mvc.service.ZhifubaoService;
import com.mvc.util.CookieHelper;
import com.mvc.util.DataUtil;
import com.mvc.util.TJUtil;
import com.mvc.vo.FactoryGBConfigModel;
import com.mvc.vo.GBConfigModel;
import com.mvc.vo.StockModel;

@Controller
@RequestMapping("/index.do")
public class IndexController {
	@Autowired
	private UserService us = new UserService();
	@Autowired
	private RechargeService rs = new RechargeService();
	@Autowired
	private AccountService accountService = new AccountService();
	@Autowired
	private StockService stockService = new StockService();
	@Autowired
	private DealService ds = new DealService();
	@Autowired
	private ProfitService profitService = new ProfitService();
	@Autowired
	private FinanceService fs = new FinanceService();
	@Autowired
	private OrderService os = new OrderService();
	@Autowired
	private MailService mailservice = new MailService();
	@Autowired
	private CotentService contents = new CotentService();
	@Autowired
	private StockOrderService sos = new StockOrderService();
	@Autowired
	private FenhongService fhs = new FenhongService();
	@Autowired
	private TradeCateService tcs = new TradeCateService();
	@Autowired
	private VoteStockService vss = new VoteStockService();
	@Autowired
	private DataUtil dateutil = new DataUtil();
	@Autowired
	private BirthService bs = new BirthService();
	@Autowired
	private BankService banks = new BankService();
	@Autowired
	private TongjiService tongjis = new TongjiService();
	@Autowired
	private PoundageService ps = new PoundageService();
	@Autowired
	private FhOrderService fhos = new FhOrderService();
	@Autowired
	private PaycardService pcs = new PaycardService();
	@Autowired
	private RechargeStockService rss;
	@Autowired
	private GBservice gbs = new GBservice();
	@Autowired
	private FactoryService fas = new FactoryService();
	@Autowired
	private RengouService rengous;
	@Autowired
	private ZhifubaoService zhis;
	@Autowired
	private TJUtil tj;
	@Autowired
	private HoldingService holds;
	

	protected final transient Log log = LogFactory
			.getLog(IndexController.class);

	@RequestMapping
	public String load(ModelMap modelMap, HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		} else {
			List<Object> managerList = us.getManagerList();
			session.setAttribute("managerList", managerList);
			List<Object> inAll_list = fs.getInAll_List();
			List<Object> incomeCNY_list = fs.getBtc_incomeCNY_List();
			List<Object> outcomeCNY_list = fs.getBtc_outcomeCNY_List();
			List<Object> incomeStock_list = fs.getBtc_incomeStock_List();
			List<Object> outcomeSock_list = fs.getBtc_outcomeStock_List();
			BigDecimal incomeCNY = fs.getIncomeCNY_amount();
			BigDecimal outcomeCNY = fs.getOutcomeCNY_amount();
			BigDecimal profit = incomeCNY.subtract(outcomeCNY);
			Btc_inAll inall = fs.getInAll_ByName("CNY");
			/*
			 * total cny
			 */
			BigDecimal totalaccount=accountService.total(0);
			BigDecimal totalorder=os.totalOrder(0,"bid");
			BigDecimal totalwithdraw=rs.totalWithdraw(0);
			
			
			BigDecimal cny_amount=totalaccount.add(totalorder).add(totalwithdraw);
			int user_amount = us.countAllUser();
			session.setAttribute("inAll_list", inAll_list);
			session.setAttribute("incomeCNY_list", incomeCNY_list);
			session.setAttribute("outcomeCNY_list", outcomeCNY_list);
			session.setAttribute("incomeStock_list", incomeStock_list);
			session.setAttribute("outcomeSock_list", outcomeSock_list);
			session.setAttribute("incomeCNY", incomeCNY);
			session.setAttribute("outcomeCNY", outcomeCNY);
			session.setAttribute("profit", profit);
			session.setAttribute("user_amount", user_amount);
			session.setAttribute("cny_amount", cny_amount);
			return "index";
		}
	}

	@RequestMapping(params = "orders")
	public String mOrders(HttpServletRequest request,HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}

		List<Object> listOrder = rs.getByStateForOrders(0);
		request.setAttribute("listOrder", listOrder);
		// fenye

		long countRow = rs.countRow(1);
		request.setAttribute("countRow", countRow);
		int start = 0;
		int count = 50;
		if (request.getParameter("start") != null
				&& request.getParameter("count") != null) {
			start = Integer.parseInt(request.getParameter("start"));
			count = Integer.parseInt(request.getParameter("count"));
		}
		session.setAttribute("czstartNo", start);

		List<Object> listOrderlog = rs.getByStateForOrders(1,start,count);
		request.setAttribute("listOrderlog", listOrderlog);
		return "orders";
	}

	@RequestMapping(params = "withdrawstockorder")
	public String withdrawstockorder(ModelMap modelMap,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		List<Object> list = sos.getBtc_inout_orderByid("未处理", "withdraw");
		List<Object> listlog = sos.getBtc_inout_orderByid("已处理", "withdraw");
		session.setAttribute("stockmap", stockService.getAllBtc_stock());
		session.setAttribute("usermap", us.getUserMap());
		session.setAttribute("stockorderlist", list);
		session.setAttribute("stockorderlistlog", listlog);
		session.setAttribute("type", "withdraw");
		return "stockorders";
	}

	@RequestMapping(params = "withrawCNYorders")
	public String mWithdrawCNYOrders(ModelMap modelMap,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		Map<Integer, Object> usermap = us.getUserMap();
		session.setAttribute("usermap", usermap);
		List<Object> listOrder = rs.getByStateForWithdrawCNYOrders(0);
		session.setAttribute("withdrawCNYorders", listOrder);
		//fenye
		long countRow =rs.countRowWithdraw(1);
        request.setAttribute("countRow", countRow);
        int start = 0;
        int count = 100;
        if(request.getParameter("start")!=null&&request.getParameter("count")!=null){
             start = Integer.parseInt(request.getParameter("start"));
             count = Integer.parseInt(request.getParameter("count"));
        }
        session.setAttribute("txstartNo", start);
		
		
		List<Object> listOrderlog = rs.getByStateForWithdrawCNYOrders(1,start,count);
		request.setAttribute("listOrderlog", listOrderlog);
		return "withrawCNYorders";
	}

	@RequestMapping(params = "login")
	public String loginFirst(ModelMap modelMap, HttpServletRequest request) {
		return "login";
	}

	@RequestMapping(params = "mailconfig")
	public String mailconfig(ModelMap modelMap, HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		Btc_mail_config mailconfig = mailservice.getMailConfig();
		session.setAttribute("mailconfig", mailconfig);
		return "mailconfig";
	}

	@RequestMapping(params = "userlist")
	public String mUser(ModelMap modelMap, HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}

		List<Object> rechargeUserList = us.getRechargeUser();
		List<Object> managerList = us.getManagerList();
		long countRechargeUser = us.countRechargeUser();
		long countAllUser = us.countAllUser();

		// fenye
		int start = 0;
		int count = 100;
		if (request.getParameter("start") != null
				&& request.getParameter("count") != null) {
			start = Integer.parseInt(request.getParameter("start"));
			count = Integer.parseInt(request.getParameter("count"));
		}
		session.setAttribute("startNo", start);
		List<Object> allUserList = us.getAllUser(start, count);
		long countUnRechargeUser = us.countUnRechargeUser();
		if (accountService.getAllUserByMap() != null) {
			Map<Integer, Object> allUserByMap = accountService
					.getAllUserByMap();
			session.setAttribute("allUserByMap", allUserByMap);
		} else {
			session.setAttribute("allUserByMap", null);
		}
		session.setAttribute("rechargeUserList", rechargeUserList);
		session.setAttribute("managerList", managerList);

		session.setAttribute("allUserList", allUserList);

		session.setAttribute("countAllUser", countAllUser);
		session.setAttribute("countRechargeUser", countRechargeUser);
		session.setAttribute("countUnRechargeUser", countUnRechargeUser);
		return "usermanager";
	}

	@RequestMapping(params = "stocklist")
	public String mStock(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		Map<Integer, Object> btc_stock_map = stockService.getBtc_stock();
		session.setAttribute("btc_stock_map", btc_stock_map);
		Map<Integer, Object> all_btc_stock_map = stockService.getAllBtc_stock();
		session.setAttribute("all_btc_stock_map", all_btc_stock_map);
		List<StockModel> stockmlist = new ArrayList<StockModel>();
		Btc_stock stock = new Btc_stock();
		Iterator<Integer> it = btc_stock_map.keySet().iterator();
		while(it.hasNext()){
			int key = (Integer) it.next();
			stock = (Btc_stock)btc_stock_map.get(key);
			StockModel stockm = new StockModel();
			stockm.setEngName(stock.getBtc_stock_Eng_name());
			stockm.setId(stock.getBtc_stock_id());
			stockm.setName(stock.getBtc_stock_name());
			stockm.setPrice(stock.getBtc_stock_price());
			BigDecimal holdingamount = holds.getCountStockHoldAmount(stock.getBtc_stock_id());
			BigDecimal orderamount = os.getCountOrderByStockIdandType(stock.getBtc_stock_id(), "sell");
			BigDecimal amount = holdingamount.add(orderamount);
			
			stockm.setAomount(amount);
			stockmlist.add(stockm);
		}
		session.setAttribute("stockmlist", stockmlist);
		
		return "managerstock";
	}

	@RequestMapping(params = "selfstock")
	public String mSelfstock(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		Map<Integer, Btc_trade_category> selfStockMap = tcs
				.getTradeCateByExstockMap("DDC");
		List<Object> tradecatelist = tcs.getTradeCateList();
		Map<Integer, Object> stock_map = stockService.getBtc_stock();
		session.setAttribute("option", "add");
		session.setAttribute("stock_map", stock_map);
		session.setAttribute("selfStockMap", selfStockMap);
		session.setAttribute("tradecatelist", tradecatelist);
		return "selfstock";
	}

	@RequestMapping(params = "updateselfstock")
	public String updateselfstock(@RequestParam("id") int tradecid,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		Btc_trade_category btc = new Btc_trade_category();
		btc = tcs.getTradeCateByBtcid(tradecid);
		session.setAttribute("btc", btc);
		Map<Integer, Btc_trade_category> selfStockMap = tcs
				.getTradeCateByExstockMap("DDC");
		Map<Integer, Object> stock_map = stockService.getBtc_stock();
		session.setAttribute("option", "update");
		session.setAttribute("stock_map", stock_map);
		session.setAttribute("selfStockMap", selfStockMap);
		return "selfstock";
	}

	@RequestMapping(params = "updateStock")
	public String mSelfstock(@RequestParam("id") Integer btc_stock_id,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		Btc_stock btc_stock = stockService.getBtc_stockById(btc_stock_id);
		session.setAttribute("btc_stock", btc_stock);
		request.setAttribute("updateStock", true);
		return "managerstock";
	}

	@RequestMapping(params = "updateSelfStock")
	public String updateSelfStock(@RequestParam("id") Integer stock_id,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		Btc_stock btc_stock = stockService.getSelfBtc_stockById(stock_id);
		session.setAttribute("Btc_stock", btc_stock);
		request.setAttribute("updateSelfStock", true);
		return "selfstock";
	}

	@RequestMapping(params = "logout")
	public String logout(ModelMap modelMap, HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		CookieHelper cookieHelp = new CookieHelper();
		Cookie cookieName = cookieHelp.removeCookie(request, "uusername");
		Cookie cookiePassword = cookieHelp.removeCookie(request, "upassword");
		response.addCookie(cookieName);
		response.addCookie(cookiePassword);
		session.removeAttribute("uusername");
		session.removeAttribute("uname");
		session.removeAttribute("isRegister2");
		request.setAttribute("msg", "logoutSucess");
		return "index";
	}

	@RequestMapping(params = "buybtc")
	public String buybtc(ModelMap modelmap, HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		if (session.getAttribute("uusername").toString() == null) {
			request.setAttribute("msg", "loginfirst");
			return "index";
		} else {
			String uusername = session.getAttribute("uusername").toString();
			Btc_user user = us.getByUsername(uusername);
			if (user.getUname() == null && user.getUcertification() == null) {
				return "register2";
			} else {
				return "buybtc";
			}
		}
	}

	@RequestMapping(params = "recharge")
	public String recharge(ModelMap modelmap, HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		if (session.getAttribute("uusername").toString() == null) {
			request.setAttribute("msg", "loginfirst");
			return "index";
		} else {
			String uusername = session.getAttribute("uusername").toString();
			Btc_user user = us.getByUsername(uusername);
			if (user.getUname() == null && user.getUcertification() == null) {
				return "register2";
			} else {
				int uid = Integer.parseInt(session.getAttribute("uid")
						.toString());
				List<Object> listOrder = rs.getByUidForOrders(uid);
				modelmap.put("listOrder", listOrder);
				return "rechargeCNY";
			}
		}
	}

	@RequestMapping(params = "setting")
	public String setting(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		Btc_profit btc_profit = profitService.getConfig();
		session.setAttribute("btc_profit", btc_profit);
		Btc_birth bb = bs.getBirth();
		session.setAttribute("birth", bb.getBirth_time());
		return "setting";
	}

	@RequestMapping(params = "allorders")
	public String allorders(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		//fenye

		long wtcountRow = os.countRow();
	      request.setAttribute("wtcountRow", wtcountRow);
	      int wtstart = 0;
	      int wtcount = 20;
	      if(request.getParameter("wtstart")!=null&&request.getParameter("wtcount")!=null){
	           wtstart = Integer.parseInt(request.getParameter("wtstart"));
	           wtcount = Integer.parseInt(request.getParameter("wtcount"));
	      }
	      session.setAttribute("wtstartNo", wtstart);
		List<Object> orderlist = os.getAllOrders(wtstart,wtcount);
		
		
		long countRow = ds.countRow();
        request.setAttribute("countRow", countRow);
        int start = 0;
        int count = 13;
        if(request.getParameter("start")!=null&&request.getParameter("count")!=null){
             start = Integer.parseInt(request.getParameter("start"));
             count = Integer.parseInt(request.getParameter("count"));
        }
        session.setAttribute("jystartNo", start);

		List<Object> deallist = ds.queryDealList(start,count);
		Map<Integer, Object> usermap = us.getUserMap();
		Map<Integer, Object> stockmap = stockService.getBtc_stockAll();
		session.setAttribute("usermap2", usermap);
		session.setAttribute("stockmap2", stockmap);
		session.setAttribute("orderlist", orderlist);
		session.setAttribute("deallist", deallist);
		return "ordermanager";
	}

	@RequestMapping(params = "contentmanager")
	public String contentmanager(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		Map<Integer, Object> stockmap = stockService.getBtc_stockAll();
		session.setAttribute("stockmap2", stockmap);
		return "contentmanager";
	}

	@RequestMapping(params = "contentlist")
	public String contentlist(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		List<Object> list = contents.getAllContent();
		session.setAttribute("contentlist", list);
		Map<Integer, Object> stockmap = stockService.getBtc_stockAll();
		session.setAttribute("stockmap2", stockmap);
		return "contentlist";
	}

	// 2014-3-29######################fenhong+vote#######################################
	@RequestMapping(params = "deliverDDC")
	public String deliverDDC(HttpServletRequest request,
			HttpServletResponse response) throws ParseException {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}

		BigDecimal amount = fhs.getSUM_DDC();
		amount = amount.add(fhs.getSUM_DDCFromOrder());
		if (amount.compareTo(new BigDecimal(8000000)) >= 0) {
			request.setAttribute("msg", "分红币已全部发放完");
			request.setAttribute("href", "index.do?deliverDDC");
			return "deliverDDC";
		}
		
		

		List<Object> fhuserlist = new ArrayList<Object>();
		Map<Integer, Btc_fhDDC> fhusermap = new HashMap<Integer, Btc_fhDDC>();

		
		fhuserlist = fhs.getFhUserAllByList2("未发放");
		fhusermap = fhs.getFhUserAllByMap2("未发放");
		session.setAttribute("fhuserlist", fhuserlist);
		session.setAttribute("fhusermap", fhusermap);
		return "deliverDDC";
	}

	@RequestMapping(params = "ddcpool")
	public String ddcpool(HttpServletRequest request,
			HttpServletResponse response) throws ParseException {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		Btc_stock stock = stockService.getBtc_stockById(10000002);
		BigDecimal amount = fhs.getSUM_DDC();
		amount = amount.add(fhs.getSUM_DDCFromOrder());
		String starttime = bs.getBirth().getBirth_time();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String datenow = format.format(new Date());
		int day = dateutil.getDateSpace(starttime, datenow);
		session.setAttribute("day", day);
		session.setAttribute("ddc", stock);
		session.setAttribute("amountnow", amount);
		return "ddcpool";
	}

	@RequestMapping(params = "votestock")
	public String votestock(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		List<Object> list = vss.getVoteStockAllByStatus("已通过");
		session.setAttribute("votelist", list);
		return "votestock";
	}

	@RequestMapping(params = "voterequest")
	public String voterequest(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		List<Object> list = vss.getVoteStockAllByStatus("等待审核");
		Map<String, Object> usermap = us.getUserMap2();
		request.setAttribute("votelist", list);
		request.setAttribute("usermap", usermap);
		return "voterequest";
	}

	@RequestMapping(params = "updatevotestock")
	public String updatevotestock(@RequestParam("vid") int vid,
			HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		Btc_votestock bvs = vss.getVoteStockByVid(vid);
		List<Object> list = vss.getVoteStockAll();
		session.setAttribute("bvs", bvs);
		session.setAttribute("votelist", list);
		request.setAttribute("updateStock", true);
		return "votestock";
	}

	// 银行管理
	@RequestMapping(params = "bankmanage")
	public String bankmanage(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		List<Object> banklist = new ArrayList<Object>();

		// fenye

		long countRow = banks.countRow("等待系统激活");
		request.setAttribute("countRow", countRow);
		int start = 0;
		int count = 100;
		if (request.getParameter("start") != null
				&& request.getParameter("count") != null) {
			start = Integer.parseInt(request.getParameter("start"));
			count = Integer.parseInt(request.getParameter("count"));
		}
		session.setAttribute("bkmstartNo", start);
		banklist = banks.getBankByStatus("等待系统激活", start, count);
		request.setAttribute("banklist", banklist);
		request.setAttribute("usermap", us.getUserMap());
		return "bankmanage";
	}

	@RequestMapping(params = "zhifubao")
	public String zhifubao(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		List<Object> zhilist = new ArrayList<Object>();

		// fenye

		long countRow = zhis.countRow("等待系统激活");
		request.setAttribute("countRow", countRow);
		int start = 0;
		int count = 100;
		if (request.getParameter("start") != null
				&& request.getParameter("count") != null) {
			start = Integer.parseInt(request.getParameter("start"));
			count = Integer.parseInt(request.getParameter("count"));
		}
		session.setAttribute("zhistartNo", start);

		zhilist = zhis.getZhifubaoByStatus("等待系统激活", start, count);
		request.setAttribute("zhilist", zhilist);
		request.setAttribute("usermap", us.getUserMap());
		return "zhifubao";
	}

	/**
	 * 手续费分红发放中，定义这期发放手续费数量
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ParseException
	 * @throws IOException
	 */
	@RequestMapping(params = "fenhonginput")
	public String inputamount(HttpServletRequest request,
			HttpServletResponse response) throws ParseException, IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		// 开始日期
		String starttime = bs.getBirth().getBirth_time();
		// 计算第几周
		String end = "";
		Map<String, String> timemap = dateutil.getTime("day");
		end = timemap.get("end");
		int days = dateutil.getDateSpace(starttime, end);
		if (days - 7 <= 0) {
			request.setAttribute("msg", "对不起至少一周之后才能发放");
			request.setAttribute("href", "index.do");
			return "index";
		}
		int num = days / 7;

		int season = tj.caculateSeason(num);

		boolean flag = false;
		flag = fhs.isInput(season);
		if (flag) {
			response.sendRedirect("index.do?deliverfenhong2");
			return "index";
		}

		BigDecimal poundageamount = new BigDecimal(tj
				.cacuDeliverAmount(num, starttime).get("poundageamount")
				.toString());
		String endtime = tj.cacuDeliverAmount(num, starttime).get("endtime")
				.toString();
		request.setAttribute("season", season);
		request.setAttribute("poundageamount", poundageamount);
		request.setAttribute("starttime", starttime);
		request.setAttribute("endtime", endtime);
		request.setAttribute("rate",
				new BigDecimal(tj.cacuDeliverAmount(num, starttime).get("rate")
						.toString()));
		return "fenhonginput";
	}

	/**
	 * 发放手续费给每个用户
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping(params = "deliverfenhong2")
	public String deliverfenhong2(HttpServletRequest request,
			HttpServletResponse response) throws ParseException {


		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		// fenye
		long countRow = fhos.countRow("未发放");
		request.setAttribute("countRow", countRow);
		int start = 0;
		int count = 500;
		if (request.getParameter("start") != null
				&& request.getParameter("count") != null) {
			start = Integer.parseInt(request.getParameter("start"));
			count = Integer.parseInt(request.getParameter("count"));
		}
		session.setAttribute("fhstartNo", start);

		List<Object> orderlist = new ArrayList<Object>();

		if (countRow >= 0) {
			orderlist = fhos.getByDeliverstatus("未发放", start, count);
			request.setAttribute("orderlist", orderlist);
		}
		Map<Integer, Object> usermap = us.getUserMap();
		session.setAttribute("usermap", usermap);
		return "deliverfenhong2";
	}

	@RequestMapping(params = "paycard")
	public String paycard(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		List<Object> unuselist = pcs.getPaycardByStatus("未使用");
		List<Object> uselist = pcs.getPaycardByStatus("已使用");
		request.setAttribute("unuselist", unuselist);
		request.setAttribute("uselist", uselist);
		return "paycard";
	}

	@RequestMapping(params = "rechargestockorder")
	public String rechargestockorder(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		if (rss.getAll() != null) {
			List<Object> olist = rss.getAll();
			request.setAttribute("olist", olist);
		}
		Map<Integer, Object> usermap = us.getUserMap();
		Map<Integer, Object> stockmap = stockService.getAllBtc_stock();
		request.setAttribute("stockmap", stockmap);
		request.setAttribute("usermap", usermap);
		return "rechargestockorders";
	}

	@RequestMapping(params = "GBsetting")
	public String GBsetting(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		Btc_frc_info bfi = gbs.getFRC_Info();
		FactoryGBConfigModel gbfm = new FactoryGBConfigModel();
		FactoryGBConfigModel hlfm = new FactoryGBConfigModel();
		FactoryGBConfigModel jffm = new FactoryGBConfigModel();
		GBConfigModel gcm = new GBConfigModel();
		BigDecimal allrengou = gbs.getRengouAmount("购买成功");
		BigDecimal allbuild = gbs.getBuildAmount("已发放");
		// 封装果币配置模型
		gcm.setAbuildamount(allbuild);
		gcm.setArengouamount(allrengou);
		gcm.setAmount(bfi.getAmount());
		gcm.setBuildamount(bfi.getFactory());
		gcm.setRengouamount(bfi.getRengou());
		// 封装完毕
		BigDecimal gbfac = gbs.getBuildAmountByType("造币工厂", "已发放");
		BigDecimal hlfac = gbs.getBuildAmountByType("红利工厂", "已发放");
		BigDecimal jffac = gbs.getBuildAmountByType("积分工厂", "已发放");
		// 封装工厂模型
		Btc_factory gbbf = gbs.getFactoryConfigByType("造币工厂");
		Btc_factory hlbf = gbs.getFactoryConfigByType("红利工厂");
		Btc_factory jfbf = gbs.getFactoryConfigByType("积分工厂");
		// 封装造币工厂
		gbfm.setAbuildamount(gbfac);
		gbfm.setBuildamount(gbbf.getAmount());
		gbfm.setBuildtime(gbbf.getDate());
		gbfm.setEachbuildamount(gbbf.getEachamount());
		gbfm.setUserhaslimit(gbbf.getUserhaslimit());
		gbfm.setType("造币工厂");
		// 封装红利工厂
		hlfm.setAbuildamount(hlfac);
		hlfm.setBuildamount(hlbf.getAmount());
		hlfm.setBuildtime(hlbf.getDate());
		hlfm.setEachbuildamount(hlbf.getEachamount());
		hlfm.setUserhaslimit(hlbf.getUserhaslimit());
		hlfm.setType("红利工厂");
		// 封装积分工厂
		jffm.setAbuildamount(jffac);
		jffm.setBuildamount(jfbf.getAmount());
		jffm.setBuildtime(jfbf.getDate());
		jffm.setEachbuildamount(jfbf.getEachamount());
		jffm.setUserhaslimit(jfbf.getUserhaslimit());
		jffm.setType("积分工厂");
		Map<String, FactoryGBConfigModel> map = new HashMap<String, FactoryGBConfigModel>();
		map.put(gbfm.getType(), gbfm);
		map.put(jffm.getType(), jffm);
		map.put(hlfm.getType(), hlfm);
		// 兑换配置模型
		Map<String, Btc_frc_rengou> rengoumap = new LinkedHashMap<String, Btc_frc_rengou>();
		rengoumap = gbs.getRengou_config();
		// 传到前台
		request.setAttribute("facconfigmap", map);
		request.setAttribute("gbconfig", gcm);
		request.setAttribute("rengoumap", rengoumap);
		return "GBsetting";
	}

	@RequestMapping(params = "buildStockDelivery")
	public String buildStockDelivery(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		// fenye

		long countRow = fas.countRow("等待系统发放");
		request.setAttribute("countRow", countRow);
		int start = 0;
		int count = 100;
		if (request.getParameter("start") != null
				&& request.getParameter("count") != null) {
			start = Integer.parseInt(request.getParameter("start"));
			count = Integer.parseInt(request.getParameter("count"));
		}
		session.setAttribute("zbstartNo", start);

		List<Object> jblist = fas.getBtc_join_buildByStatus("等待系统发放", start,
				count);
		request.setAttribute("jblist", jblist);
		Map<Integer, Object> usermap = us.getUserMap();
		request.setAttribute("usermap", usermap);
		return "buildStockDelivery";
	}

	@RequestMapping(params = "rengoulog")
	public String rengoulog(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (session.getAttribute("userLoginFlag") == null) {
			return "login";
		}
		// 分页
		long countRow = rengous.countRow();
		request.setAttribute("countRow", countRow);
		int start = 0;
		int count = 100;
		if (request.getParameter("start") != null
				&& request.getParameter("count") != null) {
			start = Integer.parseInt(request.getParameter("start"));
			count = Integer.parseInt(request.getParameter("count"));
		}
		session.setAttribute("rglstartNo", start);

		if (rengous.getUserRengouLogList() != null) {
			List<Object> rengoulist = rengous
					.getUserRengouLogList(start, count);
			request.setAttribute("rengoulist", rengoulist);
		}
		Map<Integer, Object> usermap = us.getUserMap();
		request.setAttribute("usermap", usermap);
		return "rengoulog";
	}

	@Test
	public void decimalTest() {
		BigDecimal a = new BigDecimal(4908);
		BigDecimal b = new BigDecimal(80000000);
		BigDecimal c = new BigDecimal(0);
		c = a.divide(b, 10, BigDecimal.ROUND_DOWN);
		System.out.println(c);
	}
}
