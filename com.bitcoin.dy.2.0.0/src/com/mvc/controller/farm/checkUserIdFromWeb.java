package com.mvc.controller.farm;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.service.UserService;
import com.mvc.util.DESUtil;
import com.mvc.util.JsonUtils;
@Controller
@RequestMapping("/checkUserIdFromWeb.do")
public class checkUserIdFromWeb {
	@Autowired
	private UserService users;
	protected final transient Log log = LogFactory.getLog(checkUserIdFromWeb.class);

	@RequestMapping
	public void load(
			@RequestParam("userId")String userId,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		log.info("后台接受到一次请求checkUserId");
		int uid=Integer.parseInt(DESUtil.decrypt(userId));
		JSONObject obj = new JSONObject();
		if(users.getByUid(uid)==null){
			obj.put("flag", 1);
		}else{
			obj.put("flag", 0);
		}
		response.getWriter().write(JsonUtils.object2json(obj));
	    response.getWriter().flush();
	    response.getWriter().close();
	}
}
