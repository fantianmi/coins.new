package com.mvc.controller;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.entity.Btc_content;
import com.mvc.service.CotentService;
import com.mvc.service.UserService;


@Controller
@RequestMapping("/content.do")
public class ContentController {
	@Autowired
	private CotentService contents = new CotentService();
	@Autowired
	private UserService us;
	ResourceBundle res=ResourceBundle.getBundle("host");
	
	protected final transient Log log = LogFactory
	.getLog(ContentController.class);
	
	@RequestMapping(params="add")
	public String add(ModelMap modelMap, HttpServletRequest request){
		HttpSession session = request.getSession();
		String title = "";
		String type = "";
		int stock_id = 0;
		String content = "";
		Btc_content bc = new Btc_content();
		if(request.getParameter("btc_content_title")!=""&&request.getParameter("btc_content_type")!=""
			&&request.getParameter("btc_content_stock_id")!=""
			&&request.getParameter("btc_content_msg")!=""){
			title = request.getParameter("btc_content_title").toString();
			type = request.getParameter("btc_content_type").toString();
			stock_id = Integer.parseInt(request.getParameter("btc_content_stock_id").toString());
			content = request.getParameter("btc_content_msg").toString();
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			String time = format.format(new Date());
			
			bc.setBtc_content_title(title);
			bc.setBtc_content_type(type);
			bc.setBtc_content_stock_id(stock_id);
			bc.setBtc_content_msg(content);
			bc.setBtc_content_time(time);
			bc.setAuthor(res.getString("host.author"));
			contents.saveContent(bc);
			request.setAttribute("msg", "添加"+title+"成功！");
			request.setAttribute("href", "index.do?contentlist");
			return "contentlist";
		}
		
		request.setAttribute("msg", "请确认是否填写完整");
		request.setAttribute("href", "index.do?contentmanager");
		return "contentmanager";
		
	}
	
	@RequestMapping(params="update")
	public String update(@RequestParam("contentid")int id, ModelMap modelMap, HttpServletRequest request){
		String title = "";
		String type = "";
		int stock_id = 0;
		String content = "";
		Btc_content bc = contents.getContentByid(id);
		if(request.getParameter("btc_content_title")!=""&&request.getParameter("btc_content_type")!=""
			&&request.getParameter("btc_content_stock_id")!=""
				&&request.getParameter("btc_content_msg")!=""){
			title = request.getParameter("btc_content_title").toString();
			type = request.getParameter("btc_content_type").toString();
			stock_id = Integer.parseInt(request.getParameter("btc_content_stock_id").toString());
			content = request.getParameter("btc_content_msg").toString();
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			String time = format.format(new Date());
			
			bc.setBtc_content_title(title);
			bc.setBtc_content_type(type);
			bc.setBtc_content_stock_id(stock_id);
			bc.setBtc_content_msg(content);
			bc.setBtc_content_time(time);
			contents.updateContent(bc);
			request.setAttribute("msg", "修改"+title+"成功！");
			request.setAttribute("href", "index.do?contentlist");
			return "contentlist";
		}
		
		request.setAttribute("msg", "请确认是否填写完整");
		request.setAttribute("href", "index.do?contentmanager");
		return "contentmanager";
	}
	
	@RequestMapping(params="delete")
	public String delete(@RequestParam("contentid")int id, ModelMap modelMap, HttpServletRequest request){
			Btc_content bc = contents.getContentByid(id);
			request.setAttribute("msg", "删除"+bc.getBtc_content_title()+"成功！");
			request.setAttribute("href", "index.do?contentlist");
			contents.deleteContent(bc);
			return "contentlist";
	}
	
	@RequestMapping(params="edite")
	public String edite(@RequestParam("contentid")int id, ModelMap modelMap, HttpServletRequest request){
		HttpSession session = request.getSession();
		Btc_content bc = contents.getContentByid(id);
		request.setAttribute("editflag", true);
		session.setAttribute("bc", bc);
		request.setAttribute("href", "index.do?contentmanager");
		return "contentmanager";
	}
}
