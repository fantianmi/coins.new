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

import com.mvc.entity.Btc_holding;
import com.mvc.service.HoldingService;
import com.mvc.util.DESUtil;
import com.mvc.util.HoldingUtil;
import com.mvc.util.JsonUtils;
@Controller
@RequestMapping("/checkBothCoinAndRemove.do")
public class checkBothCoinAndRemove {
	ResourceBundle res = ResourceBundle.getBundle("farm"); 
	@Autowired
	private HoldingService holds;
	@Autowired
	private HoldingUtil holdutil;
	protected final transient Log log = LogFactory.getLog(checkBothCoinAndRemove.class);

	@RequestMapping
	public void load(
			@RequestParam("data")String data,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		data = DESUtil.decrypt(data);
		String s[]=data.split("#");
		int tuid=Integer.parseInt(s[0]);
		BigDecimal zzcoin=new BigDecimal(s[1]);
		BigDecimal toolcoin=new BigDecimal(s[2]);
		
		JSONObject obj = new JSONObject();
		Btc_holding hold1 = new Btc_holding();
		Btc_holding hold2 = new Btc_holding();
		hold1=holds.getBtc_holding(tuid, Integer.parseInt(res.getString("zzstockid")));
		hold2=holds.getBtc_holding(tuid, Integer.parseInt(res.getString("toolstockid")));
		if(hold1==null){
			obj.put("flag",1);
			obj.put("msg", ""+res.getString("zzstockname")+" hold not enough");
			response.getWriter().write(JsonUtils.object2json(obj));
		    response.getWriter().flush();
		    response.getWriter().close();
		    return;
		}
		if(hold2==null){
			obj.put("flag", 2);
			obj.put("msg", ""+res.getString("toolstockname")+" hold not enough");
			response.getWriter().write(JsonUtils.object2json(obj));
			response.getWriter().flush();
			response.getWriter().close();
			return;
		}
		if(hold1.getBtc_stock_amount().compareTo(zzcoin)<0){
			obj.put("flag",1);
			obj.put("msg", ""+res.getString("zzstockname")+" hold not enough");
			response.getWriter().write(JsonUtils.object2json(obj));
		    response.getWriter().flush();
		    response.getWriter().close();
		    return;
		}
		if(hold2.getBtc_stock_amount().compareTo(toolcoin)<0){
			obj.put("flag", 2);
			obj.put("msg", ""+res.getString("toolstockname")+" hold not enough");
			response.getWriter().write(JsonUtils.object2json(obj));
			response.getWriter().flush();
			response.getWriter().close();
			return;
		}
		holdutil.subStock(tuid, Integer.parseInt(res.getString("zzstockid")), zzcoin);
		holdutil.subStock(tuid, Integer.parseInt(res.getString("toolstockid")), toolcoin);
		obj.put("flag", 0);
		obj.put("msg", "success");
		response.getWriter().write(JsonUtils.object2json(obj));
	    response.getWriter().flush();
	    response.getWriter().close();
	}
}
