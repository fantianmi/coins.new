package com.mvc.controller.farm;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.mvc.util.DESUtil;
import com.mvc.util.HoldingUtil;
import com.mvc.util.JsonUtils;
@Controller
@RequestMapping("/addAwardCoin.do")
public class addAwardCoin {
	ResourceBundle res = ResourceBundle.getBundle("farm"); 
	@Autowired
	private HoldingUtil holdutil;
	protected final transient Log log = LogFactory.getLog(addAwardCoin.class);

	@RequestMapping
	public void load(
			@RequestParam("data")String data,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		data = DESUtil.decrypt(data);
		String s[]=data.split("#");
		int tuid=Integer.parseInt(s[0]);
		BigDecimal zzcoin=new BigDecimal(s[1]);
		JSONObject obj = new JSONObject();
		holdutil.addStock(tuid, Integer.parseInt(res.getString("zzstockid")), zzcoin);
		obj.put("flag", 0);
		obj.put("msg", "success");
		response.getWriter().write(JsonUtils.object2json(obj));
	    response.getWriter().flush();
	    response.getWriter().close();
	}
}
