package com.mvc.vo.pay;

import java.io.Serializable;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ResourceBundle;
import javax.persistence.Entity;

import org.springframework.beans.factory.annotation.Autowired;

import com.mvc.util.MD5Util;
@Entity
@SuppressWarnings("serial")
public class Zhifu implements Serializable {
	ResourceBundle payres = ResourceBundle.getBundle("zhifu");
	@Autowired
	private MD5Util md5util;
	
	private String input_charset;
	private String interface_version;
	private String merchant_code;
	private String notify_url;
	private String order_amount;
	private String order_no;
	private String order_time;
	private String sign_type;;
	private String product_code;
	private String product_desc;
	private String product_name;
	private String product_num;
	private String return_url;
	private String service_type;
	private String show_url;
	private String extend_param;
	private String extra_return_param;
	private String bank_code;
	private String client_ip;
	private String sign;
	private String key;
	
	public Zhifu(){}
	public Zhifu(BigDecimal amount,String BillNo){
		this.input_charset ="UTF-8";
		this.interface_version = "V3.0";
		this.merchant_code =payres.getString("merchant_code");
		this.notify_url = payres.getString("notify_url");
		this.key = payres.getString("key");
		this.order_amount=amount.toString();
		this.order_no=BillNo;
		Date now = new Date();
		SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		this.order_time=dd.format(now);
		this.sign_type = "MD5";
		this.product_code ="";
		this.product_desc ="";
		this.product_name = ""+amount+"元充值订单";
		this.product_num = "";
		this.return_url = payres.getString("return_url");
		this.service_type = "direct_pay";
		this.show_url = "";
		this.extend_param ="";
		this.extra_return_param ="";
		this.bank_code ="";
		this.client_ip ="";
		/*
		**
		 ** 签名顺序按照参数名a到z的顺序排序，若遇到相同首字母，则看第二个字母，以此类推，同时将商家支付密钥key放在最后参与签名，
		 ** 组成规则如下：
		 ** 参数名1=参数值1&参数名2=参数值2&……&参数名n=参数值n&key=key值
		 **/
		StringBuffer signSrc= new StringBuffer();
		if(!"".equals(this.bank_code)) {
			signSrc.append("bank_code=").append(this.bank_code).append("&");
		}
		if(!"".equals(this.client_ip)) {
			signSrc.append("client_ip=").append(this.client_ip).append("&");
		}
		if(!"".equals(this.extend_param)) {
			signSrc.append("extend_param=").append(this.extend_param).append("&");
		}
		if(!"".equals(this.extra_return_param)) {
			signSrc.append("extra_return_param=").append(this.extra_return_param).append("&");
		}
		if (!"".equals(this.input_charset)) {
			signSrc.append("input_charset=").append(this.input_charset).append("&");
		}
		if (!"".equals(this.interface_version)) {
			signSrc.append("interface_version=").append(this.interface_version).append("&");
		}
		if (!"".equals(this.merchant_code)) {
			signSrc.append("merchant_code=").append(this.merchant_code).append("&");
		}
		if(!"".equals(this.notify_url)) {
			signSrc.append("notify_url=").append(this.notify_url).append("&");
		}
		if(!"".equals(this.order_amount)) {
			signSrc.append("order_amount=").append(this.order_amount).append("&");
		}
		if(!"".equals(this.order_no)) {
			signSrc.append("order_no=").append(this.order_no).append("&");
		}
		if(!"".equals(this.order_time)) {
			signSrc.append("order_time=").append(this.order_time).append("&");
		}
		if(!"".equals(this.product_code)) {
			signSrc.append("product_code=").append(this.product_code).append("&");
		}
		if(!"".equals(this.product_desc)) {
			signSrc.append("product_desc=").append(this.product_desc).append("&");
		}
		if(!"".equals(this.product_name)) {
			signSrc.append("product_name=").append(this.product_name).append("&");
		}
		if(!"".equals(this.product_num)) {
			signSrc.append("product_num=").append(this.product_num).append("&");
		}
		if(!"".equals(this.return_url)) {
			signSrc.append("return_url=").append(this.return_url).append("&");
		}
		if(!"".equals(this.service_type)) {
			signSrc.append("service_type=").append(this.service_type).append("&");
		}
		if(!"".equals(this.show_url)) {
			signSrc.append("show_url=").append(this.show_url).append("&");
		}
		signSrc.append("key=").append(this.key);
		String singInfo =signSrc.toString();
		this.sign = md5util.encode2hex(singInfo);
		
	}
	
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public ResourceBundle getPayres() {
		return payres;
	}
	public void setPayres(ResourceBundle payres) {
		this.payres = payres;
	}
	public String getInput_charset() {
		return input_charset;
	}
	public void setInput_charset(String input_charset) {
		this.input_charset = input_charset;
	}
	public String getInterface_version() {
		return interface_version;
	}
	public void setInterface_version(String interface_version) {
		this.interface_version = interface_version;
	}
	public String getMerchant_code() {
		return merchant_code;
	}
	public void setMerchant_code(String merchant_code) {
		this.merchant_code = merchant_code;
	}
	public String getNotify_url() {
		return notify_url;
	}
	public void setNotify_url(String notify_url) {
		this.notify_url = notify_url;
	}
	public String getOrder_amount() {
		return order_amount;
	}
	public void setOrder_amount(String order_amount) {
		this.order_amount = order_amount;
	}
	public String getOrder_no() {
		return order_no;
	}
	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}
	public String getOrder_time() {
		return order_time;
	}
	public void setOrder_time(String order_time) {
		this.order_time = order_time;
	}
	public String getSign_type() {
		return sign_type;
	}
	public void setSign_type(String sign_type) {
		this.sign_type = sign_type;
	}
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public String getProduct_desc() {
		return product_desc;
	}
	public void setProduct_desc(String product_desc) {
		this.product_desc = product_desc;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_num() {
		return product_num;
	}
	public void setProduct_num(String product_num) {
		this.product_num = product_num;
	}
	public String getReturn_url() {
		return return_url;
	}
	public void setReturn_url(String return_url) {
		this.return_url = return_url;
	}
	public String getService_type() {
		return service_type;
	}
	public void setService_type(String service_type) {
		this.service_type = service_type;
	}
	public String getShow_url() {
		return show_url;
	}
	public void setShow_url(String show_url) {
		this.show_url = show_url;
	}
	public String getExtend_param() {
		return extend_param;
	}
	public void setExtend_param(String extend_param) {
		this.extend_param = extend_param;
	}
	public String getExtra_return_param() {
		return extra_return_param;
	}
	public void setExtra_return_param(String extra_return_param) {
		this.extra_return_param = extra_return_param;
	}
	public String getBank_code() {
		return bank_code;
	}
	public void setBank_code(String bank_code) {
		this.bank_code = bank_code;
	}
	public String getClient_ip() {
		return client_ip;
	}
	public void setClient_ip(String client_ip) {
		this.client_ip = client_ip;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	
}
