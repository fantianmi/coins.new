package com.mvc.controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.mvc.entity.Btc_content;
import com.mvc.entity.Btc_user;
import com.mvc.service.CotentService;
import com.mvc.service.UserService;
import com.mvc.util.FormatUtil;


@Controller
@RequestMapping("/search.do")
public class SearchController {
	@Autowired
	private CotentService contents = new CotentService();
	@Autowired
	private UserService us;
	@Autowired
	private FormatUtil format;
	
	protected final transient Log log = LogFactory
	.getLog(SearchController.class);
	
	@RequestMapping
	public void search(HttpServletRequest request,HttpServletResponse response) throws IOException{
		PrintWriter out = response.getWriter();
		response.setContentType("text/xml; charset=UTF-8");// 设置输出信息的格式及字符集
		response.setHeader("Cache-Control", "no-cache");
		
		HttpSession session = request.getSession();
		
		String type = request.getParameter("searchway");
		if(request.getParameter("scontent")==null||request.getParameter("scontent")==""){
			request.setAttribute("msg", "请输入查询内容");
			request.setAttribute("href", "back");
			return;
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
		Map<Integer,Btc_account_book> accountMap = (Map<Integer,Btc_account_book>)session.getAttribute("allUserByMap");
		Btc_user user=new Btc_user();
		String resultString="";
		if(resultlist!=null){
			for(int i=0;i<resultlist.size();i++){
				user=(Btc_user)resultlist.get(i);
				resultString=resultString+"<tr><td><input type='checkbox' name='checkbox' value='"+user.getUid()+"'/></td><td><span style='float:left'>"+user.getUid()+"</span><span style='float:right; margin-right:10px'><a href='usermanager.do?seeDetail&uid="+user.getUid()+"'>"+user.getUusername()+"</span></td><td><span style='float:left'>"+format.transRole(user.getUrole())+"</span>&nbsp;&nbsp;<span style='float:right; margin-right:10px'>"+user.getUphone()+"</span></td><td><span style='float:left'>"+user.getUsdtime()+"</span><span style='float:right;margin-right:10px;'>"+format.transStatus(user.getUstatus())+"</span></td><td><span style='float:left'>"+user.getUcertification()+"</span><span style='float:right;margin-right:10px'>"+user.getUname()+"</span></td></tr>";
			}
		}else{resultString="<tr><td colspan=4>暂无数据</td></tr>";}
		out.println("<response>");
		out.println("<resultString>" + "<![CDATA[" + resultString + "]]>"
				+ "</resultString>");
		out.println("</response>");
		out.close();
		return;
	}
}
