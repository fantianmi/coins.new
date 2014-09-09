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
import com.mvc.util.JsonUtils;
@Controller
@RequestMapping("/getBothCoin.do")
public class getBothCoin {
	ResourceBundle res = ResourceBundle.getBundle("farm"); 
	@Autowired
	private HoldingService holds;
	protected final transient Log log = LogFactory.getLog(getBothCoin.class);

	@RequestMapping
	public void load(
			@RequestParam("data")String data,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		data = DESUtil.decrypt(data);
		int uid=Integer.parseInt(data);
		JSONObject obj = new JSONObject();
		Btc_holding zzhold=holds.getBtc_holding(uid, Integer.parseInt(res.getString("zzstockid")));
		Btc_holding toolhold=holds.getBtc_holding(uid, Integer.parseInt(res.getString("toolstockid")));
		BigDecimal zzAmount=new BigDecimal(0);
		BigDecimal toolAmount=new BigDecimal(0);
		
		if(zzhold!=null)zzAmount=zzhold.getBtc_stock_amount();
		if(toolAmount!=null)toolAmount=toolhold.getBtc_stock_amount();
		String outdata=zzAmount.toString()+"#"+toolAmount.toString();
		outdata=DESUtil.encrypt(outdata);
		obj.put("data",outdata);
		obj.put("flag", 0);
		obj.put("msg", "success");
		response.getWriter().write(JsonUtils.object2json(obj));
	    response.getWriter().flush();
	    response.getWriter().close();
	}
}
