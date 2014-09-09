package com.mvc.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.entity.Btc_bank;
import com.mvc.entity.Btc_inAll;
import com.mvc.entity.Btc_incomeCNY;
import com.mvc.entity.Btc_trade_category;
import com.mvc.entity.Btc_user;
import com.mvc.entity.Btc_votehistory;
import com.mvc.entity.Btc_votestock;
import com.mvc.entity.Btc_withdrawCNY_order;
import com.mvc.service.BankService;
import com.mvc.service.HoldingService;
import com.mvc.service.StockOrderService;
import com.mvc.service.TongjiService;
import com.mvc.service.TradeCateService;
import com.mvc.service.UserService;
import com.mvc.service.VoteHistoryService;
import com.mvc.service.VoteStockService;
@Controller
@RequestMapping("/votestock.do")
public class VoteStockController {
	@Autowired
	private VoteStockService vss = new VoteStockService();
	@Autowired
	private UserService us = new UserService();
	@Autowired
	private VoteHistoryService vhs = new VoteHistoryService();

	protected final transient Log log = LogFactory.getLog(VoteStockController.class);

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
	public String createbank(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String vstockfullName = request.getParameter("vstockfullName").toString();
		String vstockEngname = request.getParameter("vstockEngname").toString();
		String vstockname = request.getParameter("vstockname").toString();
		Btc_votestock bvs = new Btc_votestock();
		bvs.setVamount(0);
		bvs.setVstockfullName(vstockfullName);
		bvs.setVstockEngname(vstockEngname);
		bvs.setVstockname(vstockname);
		bvs.setUsername("管理员");
		bvs.setVstatus("已通过");
		vss.saveBtc_votestock(bvs);
		request.setAttribute("msg", "添加成功");
		request.setAttribute("href", "index.do?votestock");
		return "votestock";
	}
	
	@RequestMapping(params="update")
	public String update(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int vid = Integer.parseInt(request.getParameter("vid").toString());
		String vstockfullName = request.getParameter("vstockfullName").toString();
		String vstockEngname = request.getParameter("vstockEngname").toString();
		String vstockname = request.getParameter("vstockname").toString();
		Btc_votestock bvs = new Btc_votestock();
		bvs = vss.getVoteStockByVid(vid);
		bvs.setVstockfullName(vstockfullName);
		bvs.setVstockEngname(vstockEngname);
		bvs.setVstockname(vstockname);
		vss.updateBtc_votestock(bvs);
		request.setAttribute("msg", "修改成功");
		request.setAttribute("href", "index.do?votestock");
		return "votestock";
	}
	
	@RequestMapping(params="agreevote")
	public String agreevote(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String vids[] = request.getParameterValues("checkbox");
		int vid = 0;
		Btc_votestock vote = new Btc_votestock();
		String msg = "已同意以下币种的上币投票申请：";
		if (vids != null) {
			for (int i = 0; i < vids.length; i++) {
				vid = Integer.parseInt(vids[i]);
				vote = vss.getVoteStockByVid(vid);
				vote.setVstatus("已通过");
				vss.updateBtc_votestock(vote);
				msg = msg + vote.getVstockname()+" ";
			}
		}

		request.setAttribute("msg", msg);
		request.setAttribute("href", "index.do?voterequest");
		return "voterequest";
	}
	
	@RequestMapping(params="rejectvote")
	public String rejectvote(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String vids[] = request.getParameterValues("checkbox");
		int vid = 0;
		Btc_votestock vote = new Btc_votestock();
		String msg = "已拒绝以下币种的上币投票申请：";
		if (vids != null) {
			for (int i = 0; i < vids.length; i++) {
				vid = Integer.parseInt(vids[i]);
				vote = vss.getVoteStockByVid(vid);
				vote.setVstatus("已拒绝");
				vss.updateBtc_votestock(vote);
				msg = msg + vote.getVstockname()+" ";
			}
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("href", "index.do?voterequest");
		return "voterequest";
	}
	
	@RequestMapping(params="votestock")
	public String votestock(@RequestParam("vid")int vid,HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute("uusername") == null) {
			request.setAttribute("msg", "登陆后才能进行此操作！");
			request.setAttribute("href", "index.do");
			return "login";
		}
		Btc_user user = us.getByUsername(session.getAttribute("uusername").toString());
		int uid = user.getUid();
		if(vhs.getHistroyByUidAndVid(uid, vid)!=null){
			request.setAttribute("msg", "对不起，您已经投过该币票了！");
			request.setAttribute("href", "back");
			return "votestock";
		}
		
		Btc_votestock bvs = new Btc_votestock();
		bvs = vss.getVoteStockByVid(vid);
		bvs.setVamount(bvs.getVamount()+1);
		vss.updateBtc_votestock(bvs);
		Btc_votehistory bvh = new Btc_votehistory();
		bvh.setVh_uid(uid);
		bvh.setVh_vid(vid);
		vhs.saveBtc_votehistory(bvh);
		request.setAttribute("msg", "恭喜您，投票成功");
		request.setAttribute("href", "index.do?votestock");
		return "votestock";
	}
	
	@RequestMapping(params="delete")
	public String deleteBank(@RequestParam("vid")int vid, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		Btc_votestock bvs = new Btc_votestock();
		bvs = vss.getVoteStockByVid(vid);
		vss.deleteBtc_votestock(bvs);
		request.setAttribute("msg", "删除成功！");
		request.setAttribute("href", "index.do?votestock");
		return "votestock";
	}
}
