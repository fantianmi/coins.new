package com.mvc.vo.pay;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ResourceBundle;

import javax.persistence.Entity;
import com.mvc.service.pay.*;

import org.springframework.beans.factory.annotation.Autowired;

@Entity
@SuppressWarnings("serial")
public class Yeepay implements Serializable {
	@Autowired 
	private PaymentForOnlineService PaymentForOnlineService;
	
	ResourceBundle payres = ResourceBundle.getBundle("pay");
	private String p0_Cmd;
	private String p1_MerId;
	private String p2_Order;
	private String p3_Amt;
	private String p4_Cur;
	private String p5_Pid;
	private String p6_Pcat;
	private String p7_Pdesc;
	private String p8_Url;
	private String p9_SAF;
	private String pa_MP;
	private String pd_FrpId;
	private String pr_NeedResponse;
	private String hmac;
	private String keyValue;
	private String nodeAuthorizationURL;
	public Yeepay(){}
	public Yeepay(BigDecimal amount,String orderID){
		this.p0_Cmd="Buy";
		this.p1_MerId=payres.getString("MerId");
		this.p2_Order=orderID;
		this.p3_Amt=amount.setScale(1,BigDecimal.ROUND_HALF_UP).toString();
		this.p4_Cur="CNY";
		this.p5_Pid=""+amount.toString()+"recharge order";
		this.p6_Pcat="";
		this.p7_Pdesc="";
		this.p8_Url=payres.getString("callbackURL");
		this.p9_SAF="0";
		this.pa_MP=""+amount.toString()+"recharge order";
		this.pd_FrpId="";
		this.pr_NeedResponse="1";
		this.keyValue=payres.getString("keyValue");
		this.hmac=PaymentForOnlineService.getReqMd5HmacForOnlinePayment(p0_Cmd,
				p1_MerId,p2_Order,p3_Amt,p4_Cur,p5_Pid,p6_Pcat,p7_Pdesc,
				p8_Url,p9_SAF,pa_MP,pd_FrpId,pr_NeedResponse,keyValue);
		this.nodeAuthorizationURL=payres.getString("yeepayCommonReqURL");
		
	}
	
	public String getNodeAuthorizationURL() {
		return nodeAuthorizationURL;
	}
	public void setNodeAuthorizationURL(String nodeAuthorizationURL) {
		this.nodeAuthorizationURL = nodeAuthorizationURL;
	}
	public PaymentForOnlineService getPaymentForOnlineService() {
		return PaymentForOnlineService;
	}
	public void setPaymentForOnlineService(
			PaymentForOnlineService paymentForOnlineService) {
		PaymentForOnlineService = paymentForOnlineService;
	}
	public ResourceBundle getPayres() {
		return payres;
	}
	public void setPayres(ResourceBundle payres) {
		this.payres = payres;
	}
	public String getKeyValue() {
		return keyValue;
	}
	public void setKeyValue(String keyValue) {
		this.keyValue = keyValue;
	}
	public String getP0_Cmd() {
		return p0_Cmd;
	}
	public void setP0_Cmd(String p0_Cmd) {
		this.p0_Cmd = p0_Cmd;
	}
	public String getP1_MerId() {
		return p1_MerId;
	}
	public void setP1_MerId(String p1_MerId) {
		this.p1_MerId = p1_MerId;
	}
	public String getP2_Order() {
		return p2_Order;
	}
	public void setP2_Order(String p2_Order) {
		this.p2_Order = p2_Order;
	}
	public String getP3_Amt() {
		return p3_Amt;
	}
	public void setP3_Amt(String p3_Amt) {
		this.p3_Amt = p3_Amt;
	}
	public String getP4_Cur() {
		return p4_Cur;
	}
	public void setP4_Cur(String p4_Cur) {
		this.p4_Cur = p4_Cur;
	}
	public String getP5_Pid() {
		return p5_Pid;
	}
	public void setP5_Pid(String p5_Pid) {
		this.p5_Pid = p5_Pid;
	}
	public String getP6_Pcat() {
		return p6_Pcat;
	}
	public void setP6_Pcat(String p6_Pcat) {
		this.p6_Pcat = p6_Pcat;
	}
	public String getP7_Pdesc() {
		return p7_Pdesc;
	}
	public void setP7_Pdesc(String p7_Pdesc) {
		this.p7_Pdesc = p7_Pdesc;
	}
	public String getP8_Url() {
		return p8_Url;
	}
	public void setP8_Url(String p8_Url) {
		this.p8_Url = p8_Url;
	}
	public String getP9_SAF() {
		return p9_SAF;
	}
	public void setP9_SAF(String p9_SAF) {
		this.p9_SAF = p9_SAF;
	}
	public String getPa_MP() {
		return pa_MP;
	}
	public void setPa_MP(String pa_MP) {
		this.pa_MP = pa_MP;
	}
	public String getPd_FrpId() {
		return pd_FrpId;
	}
	public void setPd_FrpId(String pd_FrpId) {
		this.pd_FrpId = pd_FrpId;
	}
	public String getPr_NeedResponse() {
		return pr_NeedResponse;
	}
	public void setPr_NeedResponse(String pr_NeedResponse) {
		this.pr_NeedResponse = pr_NeedResponse;
	}
	public String getHmac() {
		return hmac;
	}
	public void setHmac(String hmac) {
		this.hmac = hmac;
	}
	
	
	
}
