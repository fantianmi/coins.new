package com.mvc.controller;

import java.io.File;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.mvc.entity.Btc_stock;
import com.mvc.service.StockService;

@Controller
@RequestMapping("/managestock.do")
public class StockController implements ServletContextAware {
	@Autowired
	private StockService stockService = new StockService();

	private ServletContext servletContext;

	protected final transient Log log = LogFactory.getLog(StockController.class);

	public void setServletContext(ServletContext servletContext) { // 实现接口中的setServletContext方法
		this.servletContext = servletContext;
	}

	@RequestMapping
	public String load(ModelMap modelMap, HttpServletRequest request) {
		return "managerstock";
	}

	@RequestMapping(params = "addstock")
	// 将文件上传请求映射到该方法
	public String addstock(
			@RequestParam("file") CommonsMultipartFile mFile,
			HttpServletRequest request, HttpServletResponse response) {
		String baseurl = request.getParameter("baseurl").toString();
		String logoadr = baseurl+"upload/stocklogo/default.jpg";
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String time = format.format(new Date());
		// ########################
		if (!mFile.isEmpty()) {
			String path = this.servletContext.getRealPath("/upload/stocklogo/a/"); // 获取本地存储路径
			File file = new File(path + time + ".jpg"); // 新建一个文件
			logoadr = baseurl+"upload/stocklogo/a"+time+".jpg";
			try {
				mFile.getFileItem().write(file); // 将上传的文件写入新建的文件中
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		String msg = null;
		if (request.getParameter("stock_name") != ""
				&& request.getParameter("stock_price") != ""
				&& request.getParameter("stock_recharge_adr") != ""
				&& request.getParameter("stock_Eng_name") != ""
				&& request.getParameter("stock_exchange_name") != ""
				&& request.getParameter("stock_port") != ""
				&& request.getParameter("stock_pocket_adr") != ""
				&& request.getAttribute("rpcpassword") != ""
				&& request.getParameter("rpcusername") != ""
				&& request.getParameter("rechargezxz") != ""
				&& request.getParameter("tradesxf") != ""
				&& request.getParameter("withdrawzxz") != ""
				&& request.getParameter("withdrawzdz") != ""
			  && request.getParameter("withdrawsxf") != "") {
			String btc_stock_name = request.getParameter("stock_name").toString();
			BigDecimal btc_stock_price = new BigDecimal(request.getParameter(
					"stock_price").toString());
			BigDecimal tradesxf = new BigDecimal(request.getParameter("tradesxf"));
			BigDecimal rechargezxz = new BigDecimal(request.getParameter("rechargezxz"));
			BigDecimal withdrawzxz = new BigDecimal(request.getParameter("withdrawzxz"));
			BigDecimal withdrawzdz = new BigDecimal(request.getParameter("withdrawzdz"));
			BigDecimal withdrawsxf = new BigDecimal(request.getParameter("withdrawsxf"));
			/*
			 * is trade  0 no 1yes
			 */
			int istrade=Integer.parseInt(request.getParameter("istrade"));
			
			
			String btc_stock_recharge_adr = request
					.getParameter("stock_recharge_adr").toString();
			String btc_stock_Eng_name = request.getParameter("stock_Eng_name")
					.toString();
			String btc_stock_exchange_name = request.getParameter(
					"stock_exchange_name").toString();
			String btc_stock_port = request.getParameter("stock_port").toString();
			String btc_stock_pocket_adr = request.getParameter("stock_pocket_adr")
					.toString();
			String rpcusername = request.getParameter("rpcusername").toString();
			String rpcpassword = request.getParameter("rpcpassword").toString();
			Btc_stock btc_stock = new Btc_stock();
			btc_stock.setBtc_stock_Eng_name(btc_stock_Eng_name);
			btc_stock.setBtc_stock_exchange_name(btc_stock_exchange_name);
			btc_stock.setBtc_stock_name(btc_stock_name);
			btc_stock.setBtc_stock_price(btc_stock_price);
			btc_stock.setBtc_stock_recharge_adr(btc_stock_recharge_adr);
			btc_stock.setBtc_stock_port(btc_stock_port);
			btc_stock.setBtc_stock_pocket_adr(btc_stock_pocket_adr);
			btc_stock.setRpcpassword(rpcpassword);
			btc_stock.setRpcusername(rpcusername);
			btc_stock.setIs_real_stock("1");
			btc_stock.setIstrade(istrade);
			btc_stock.setCaninout(1);
			// 保存logo路径
			btc_stock.setLogoadr(logoadr);
			btc_stock.setTradesxf(tradesxf);
			btc_stock.setRechargezxz(rechargezxz);
			btc_stock.setWithdrawzdz(withdrawzdz);
			btc_stock.setWithdrawzxz(withdrawzxz);
			btc_stock.setWithdrawsxf(withdrawsxf);
			stockService.saveStock(btc_stock);
			msg = "已创建" + btc_stock.getBtc_stock_Eng_name() + "成功！";
			request.setAttribute("msg", msg);
			request.setAttribute("href", "index.do?stocklist");
			return "managerstock";
		} else {
			msg = "未填写完整信息，请重新填写";
			request.setAttribute("msg", msg);
			request.setAttribute("href", "index.do?stocklist");
			return "managerstock";
		}
	}

	@RequestMapping(params = "updateStock")
	public String updateStock(
			@RequestParam("file") CommonsMultipartFile mFile,
			HttpServletRequest request,
			HttpServletResponse response) {
		String baseurl = request.getParameter("baseurl").toString();
		String logoadr = request.getParameter("logoadr").toString();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String time = format.format(new Date());
		// ########################
		if (!mFile.isEmpty()) {
			String path = this.servletContext.getRealPath("upload/stocklogo/a/"); // 获取本地存储路径
			File file = new File(path + time + ".jpg"); // 新建一个文件
			logoadr = baseurl+"upload/stocklogo/a"+time+".jpg";
			try {
				mFile.getFileItem().write(file); // 将上传的文件写入新建的文件中
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		String msg = null;
		if (request.getParameter("stock_name") != ""
				&& request.getParameter("stock_price") != ""
				&& request.getParameter("stock_recharge_adr") != ""
				&& request.getParameter("stock_Eng_name") != ""
				&& request.getParameter("stock_exchange_name") != ""
				&& request.getParameter("stock_port") != ""
				&& request.getParameter("stock_pocket_adr") != ""
				&& request.getParameter("rpcpassword") != ""
				&& request.getParameter("rpcusername") != ""
			  && request.getParameter("rechargezxz") != ""
			  && request.getParameter("tradesxf") != ""
				&& request.getParameter("withdrawzxz") != ""
				&& request.getParameter("withdrawzdz") != ""
				&& request.getParameter("withdrawsxf") != "") {
			int btc_stock_id = Integer.parseInt(request
					.getParameter("btc_stock_id").toString());
			Btc_stock btc_stock = stockService.getBtc_stockById(btc_stock_id);
			String btc_stock_name = request.getParameter("stock_name")
					.toString();
			BigDecimal btc_stock_price = new BigDecimal(request
					.getParameter("stock_price").toString());
			BigDecimal tradesxf = new BigDecimal(request.getParameter("tradesxf"));
			BigDecimal rechargezxz = new BigDecimal(request.getParameter("rechargezxz"));
			BigDecimal withdrawzxz = new BigDecimal(request.getParameter("withdrawzxz"));
			BigDecimal withdrawzdz = new BigDecimal(request.getParameter("withdrawzdz"));
			BigDecimal withdrawsxf = new BigDecimal(request.getParameter("withdrawsxf"));
			/*
			 * is trade  0 no 1yes
			 */
			int istrade=Integer.parseInt(request.getParameter("istrade"));
			String btc_stock_recharge_adr = request
					.getParameter("stock_recharge_adr").toString();
			String btc_stock_Eng_name = request
					.getParameter("stock_Eng_name").toString();
			String btc_stock_exchange_name = request
					.getParameter("stock_exchange_name").toString();
			String btc_stock_port = request.getParameter("stock_port")
					.toString();
			String btc_stock_pocket_adr = request
					.getParameter("stock_pocket_adr").toString();
			String rpcusername = request.getParameter("rpcusername")
					.toString();
			String rpcpassword = request.getParameter("rpcpassword")
					.toString();
			btc_stock.setBtc_stock_Eng_name(btc_stock_Eng_name);
			btc_stock.setBtc_stock_exchange_name(btc_stock_exchange_name);
			btc_stock.setBtc_stock_name(btc_stock_name);
			btc_stock.setBtc_stock_price(btc_stock_price);
			btc_stock.setBtc_stock_recharge_adr(btc_stock_recharge_adr);
			btc_stock.setBtc_stock_pocket_adr(btc_stock_pocket_adr);
			btc_stock.setBtc_stock_port(btc_stock_port);
			btc_stock.setRpcpassword(rpcpassword);
			btc_stock.setRpcusername(rpcusername);
			btc_stock.setIstrade(istrade);
			btc_stock.setLogoadr(logoadr);
			btc_stock.setTradesxf(tradesxf);
			btc_stock.setRechargezxz(rechargezxz);
			btc_stock.setWithdrawzdz(withdrawzdz);
			btc_stock.setWithdrawzxz(withdrawzxz);
			btc_stock.setWithdrawsxf(withdrawsxf);
			stockService.updateStock(btc_stock);
			msg = "已修改" + btc_stock.getBtc_stock_Eng_name() + "成功！";
			request.setAttribute("msg", msg);
			request.setAttribute("href", "index.do?stocklist");
			return "index";
		} else {
			msg = "未填写完整信息，请重新填写";
			request.setAttribute("msg", msg);
			request.setAttribute("href", "index.do?stocklist");
			return "index";
		}
	}

	@RequestMapping(params = "updateselfStock")
	public String updateselfStock(HttpServletRequest request) {
		String msg = null;
		if (request.getParameter("Btc_stock_name") != ""
				&& request.getParameter("Btc_stock_Eng_name") != ""
				&& request.getParameter("Btc_stock_exchange_name") != ""
				&& request.getParameter("Btc_stock_recharge_adr") != ""
				&& request.getParameter("Btc_stock_price") != ""
				&& request.getParameter("btc_selftsock_count") != ""
				&& request.getParameter("btc_selftsock_port") != ""
				&& request.getParameter("Btc_stock_pocket_adr") != ""
				&& request.getParameter("rpcusername") != ""
				&& request.getParameter("rpcpassword") != null) {
			int Btc_stock_id = Integer.parseInt(request.getParameter("Btc_stock_id")
					.toString());
			Btc_stock stock = stockService.getSelfBtc_stockById(Btc_stock_id);

			String Btc_stock_name = request.getParameter("Btc_stock_name").toString();
			String Btc_stock_Eng_name = request.getParameter("Btc_stock_Eng_name")
					.toString();
			String Btc_stock_exchange_name = request.getParameter(
					"Btc_stock_exchange_name").toString();
			String Btc_stock_recharge_adr = request.getParameter(
					"Btc_stock_recharge_adr").toString();
			String Btc_stock_pocket_adr = request
					.getParameter("Btc_stock_pocket_adr").toString();
			String rpcusername = request.getParameter("rpcusername").toString();
			String rpcpassword = request.getParameter("rpcpassword").toString();

			BigDecimal Btc_stock_price = new BigDecimal(request.getParameter(
					"Btc_stock_price").toString());

			stock.setBtc_stock_Eng_name(Btc_stock_Eng_name);
			stock.setBtc_stock_exchange_name(Btc_stock_exchange_name);
			stock.setBtc_stock_name(Btc_stock_name);
			stock.setBtc_stock_price(Btc_stock_price);
			stock.setBtc_stock_recharge_adr(Btc_stock_recharge_adr);
			stock.setBtc_stock_pocket_adr(Btc_stock_pocket_adr);
			stock.setRpcpassword(rpcpassword);
			stock.setRpcusername(rpcusername);

			stockService.updateSelfStock(stock);
			msg = "已修改" + stock.getBtc_stock_Eng_name() + "成功！";
			request.setAttribute("msg", msg);
			request.setAttribute("href", "index.do?selfstock");
			return "index";
		} else {
			msg = "未填写完整信息，请重新填写";
			request.setAttribute("msg", msg);
			request.setAttribute("href", "index.do?selfstock");
			return "index";
		}
	}

	@RequestMapping(params = "delete")
	public String deletestock(@RequestParam("id") Integer btc_stock_id,
			HttpServletRequest request) {
		Btc_stock btc_stock = stockService.getBtc_stockById(btc_stock_id);
		String name = btc_stock.getBtc_stock_name();
		stockService.deleteStock(btc_stock);
		request.setAttribute("msg", "删除币种：" + name + "成功");
		request.setAttribute("href", "index.do?stocklist");
		return "managerstock";
	}

	@RequestMapping(params = "deleteSelf")
	public String deleteselfStock(@RequestParam("id") Integer stock_id,
			HttpServletRequest request) {
		Btc_stock stock = stockService.getBtc_stockById(stock_id);
		String name = stock.getBtc_stock_name();
		stockService.deleteSelfStock(stock);
		request.setAttribute("msg", "删除币种：" + name + "成功");
		request.setAttribute("href", "index.do?selfstock");
		return "index";
	}
}
