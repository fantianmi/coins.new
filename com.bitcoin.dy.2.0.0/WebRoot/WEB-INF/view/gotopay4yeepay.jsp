<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mvc.vo.pay.*"%>
<%!	String formatString(String text){ 
			if(text == null) return ""; 
			return text;
		}
%>
<%
	Yeepay yeepay = (Yeepay)request.getAttribute("yeepay");
	request.setCharacterEncoding("utf-8");
	String keyValue   		     		= formatString(yeepay.getKeyValue());
	String nodeAuthorizationURL  	= formatString(yeepay.getNodeAuthorizationURL());  	// 交易请求地址
	// 商家设置用户购买商品的支付信息
	String    p0_Cmd 		     			= formatString(yeepay.getP0_Cmd());                               									// 在线支付请求，固定值 ”Buy”
	String    p1_MerId 		    		= formatString(yeepay.getP1_MerId()); 		// 商户编号
	String    p2_Order           	= formatString(yeepay.getP2_Order());           					// 商户订单号
	String	  p3_Amt           	 	= formatString(yeepay.getP3_Amt());      	   							// 支付金额
	String	  p4_Cur    		 			= formatString(yeepay.getP4_Cur());	   		   							// 交易币种
	String	  p5_Pid 		     			= formatString(yeepay.getP5_Pid());	       	   						// 商品名称
	String	  p6_Pcat  		     		= formatString(yeepay.getP6_Pcat());	       	   					// 商品种类
	String 	  p7_Pdesc   		 			= formatString(yeepay.getP7_Pdesc());		   								// 商品描述
	String 	  p8_Url 	         		= formatString(yeepay.getP8_Url()); 		       						// 商户接收支付成功数据的地址
	String 	  p9_SAF 		     			= formatString(yeepay.getP9_SAF()); 			   							// 需要填写送货信息 0：不需要  1:需要
	String 	  pa_MP 			 				= formatString(yeepay.getPa_MP());
	String    pd_FrpId           	= formatString(yeepay.getPd_FrpId()); 
	// 银行编号必须大写
	pd_FrpId = pd_FrpId.toUpperCase();
	String 	  pr_NeedResponse    	= formatString(yeepay.getPr_NeedResponse()); 
	String 	  hmac 			     			= formatString(yeepay.getHmac());
%>
<html>
	<head>
		<title></title>
	</head>
	<!-- <body> -->
	<body onLoad="document.yeepay.submit();">
		<form name="yeepay" action='<%=nodeAuthorizationURL%>' method='POST'>
			<input type='hidden' name='p0_Cmd'   value='<%=p0_Cmd%>'>
			<input type='hidden' name='p1_MerId' value='<%=p1_MerId%>'>
			<input type='hidden' name='p2_Order' value='<%=p2_Order%>'>
			<input type='hidden' name='p3_Amt'   value='<%=p3_Amt%>'>
			<input type='hidden' name='p4_Cur'   value='<%=p4_Cur%>'>
			<input type='hidden' name='p5_Pid'   value='<%=p5_Pid%>'>
			<input type='hidden' name='p6_Pcat'  value='<%=p6_Pcat%>'>
			<input type='hidden' name='p7_Pdesc' value='<%=p7_Pdesc%>'>
			<input type='hidden' name='p8_Url'   value='<%=p8_Url%>'>
			<input type='hidden' name='p9_SAF'   value='<%=p9_SAF%>'>
			<input type='hidden' name='pa_MP'    value='<%=pa_MP%>'>
			<input type='hidden' name='pd_FrpId' value='<%=pd_FrpId%>'>
			<input type="hidden" name="pr_NeedResponse"  value="<%=pr_NeedResponse%>">
			<input type='hidden' name='hmac'     value='<%=hmac%>'>
		</form>
	</body>
</html>