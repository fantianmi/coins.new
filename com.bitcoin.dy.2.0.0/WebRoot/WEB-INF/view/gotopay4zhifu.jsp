<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, org.apache.commons.codec.digest.DigestUtils" %>
<%@page import="com.mvc.vo.pay.*"%>
<%
Zhifu zhifu = (Zhifu)request.getAttribute("zhifu");
String sign=zhifu.getSign();
String merchant_code=zhifu.getMerchant_code();
String bank_code=zhifu.getBank_code();
String order_no=zhifu.getOrder_no();
String order_amount=zhifu.getOrder_amount();
String service_type=zhifu.getService_type();
String input_charset=zhifu.getInput_charset();
String notify_url=zhifu.getNotify_url();
String interface_version=zhifu.getInterface_version();
String sign_type=zhifu.getSign_type();
String order_time=zhifu.getOrder_time();
String product_name=zhifu.getProduct_name();
String client_ip=zhifu.getClient_ip();
String extend_param=zhifu.getExtend_param();
String extra_return_param=zhifu.getExtra_return_param();
String product_code=zhifu.getProduct_code();
String product_desc=zhifu.getProduct_desc();
String product_num=zhifu.getProduct_num();
String return_url=zhifu.getReturn_url();
String show_url=zhifu.getShow_url();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body onLoad="document.dinpayForm.submit();">
<form name="dinpayForm" method="post" action="http://www.ywhfszx.cn/pay/pay.dinpay.com.php">
   <input type="hidden" name="sign" value="<%=sign%>" />
	<input type="hidden" name="merchant_code" value="<%=merchant_code%>" />
	<input type="hidden" name="bank_code" value="<%=bank_code%>"/>
	<input type="hidden" name="order_no" value="<%=order_no%>"/>
	<input type="hidden" name="order_amount" value="<%=order_amount%>"/>
	<input type="hidden" name="service_type" value="<%=service_type%>"/>
	<input type="hidden" name="input_charset" value="<%=input_charset%>"/>
	<input type="hidden" name="notify_url" value="<%=notify_url%>">
	<input type="hidden" name="interface_version" value="<%=interface_version%>"/>
	<input type="hidden" name="sign_type" value="<%=sign_type%>"/>
	<input type="hidden" name="order_time" value="<%=order_time%>"/>
	<input type="hidden" name="product_name" value="<%=product_name%>"/>
	<input Type="hidden" Name="client_ip" value="<%=client_ip%>"/>
	<input Type="hidden" Name="extend_param" value="<%=extend_param%>"/>
	<input Type="hidden" Name="extra_return_param" value="<%=extra_return_param%>"/>
	<input Type="hidden" Name="product_code" value="<%=product_code%>"/>
	<input Type="hidden" Name="product_desc" value="<%=product_desc%>"/>
	<input Type="hidden" Name="product_num" value="<%=product_num%>"/>
	<input Type="hidden" Name="return_url" value="<%=return_url%>"/>
	<input Type="hidden" Name="show_url" value="<%=show_url%>"/>
</form>
</body>
</html>