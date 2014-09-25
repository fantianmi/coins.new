<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="com.mvc.util.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%
ResourceBundle res = ResourceBundle.getBundle("host"); 
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
	<title><%=res.getString("host.title")%></title>
	<jsp:include page="/include/htmlsrc.jsp" ></jsp:include>
	<!-- coins_new -->
  <link href="coins_new/css/zy.css" rel="stylesheet" type="text/css" />
</head>
<body>
<script src="yanzheng/jquery-1.4.4.min.js" type="text/javascript"></script>
	<script src="yanzheng/formValidator-4.1.1.js" type="text/javascript"></script>
	<script src="yanzheng/formValidatorRegex.js" type="text/javascript"></script>
	<script language="javascript" src="yanzheng/DateTimeMask.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		$.formValidator.initConfig({formID:"form1",mode:'AlertTip',onError:function(msg){alert(msg)}});
		$("#password1").formValidator().inputValidator({min:1,onError:"密码不能为空,请确认"});
		$("#password2").formValidator().inputValidator({min:1,onError:"重复密码不能为空,请确认"}).compareValidator({desID:"password1",operateor:"=",onError:"2次密码不一致,请确认"});
	});
	</script>
	
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<jsp:include page="/include/nav.jsp"></jsp:include>
<div class="box2"> 
  <div class="user_r">
    <div class="u_r_t">
      <div class="u_r_t_l"><%=res.getString("host.small.title") %>安全中心</div>
      <div class="u_r_t_r">首先请验证您的身份信息才能找回密码，请输入您要找回的用户名，然后点击确认，我们会把验证信息发到您的邮箱或者手机中，请注意查收</div>
    </div>
    <div class="u_r_b">
				<h1>找回您的<%if(request.getParameter("type").equals("utpass")){%>交易<%} %>密码</h1>
				<form action="register.do?resetpass" name="form1" id="form1">
					<input type="hidden" name="type" value="<%=request.getAttribute("type").toString() %>">
				<table>
					<tr>
					<td>验证码</td><td><input name="code" type="text" class="sz" placeholder="请输入您收到的email验证码"/></td>
					</tr>
					<tr>
					<td>重置密码</td><td><input id="password1" name="password1" type="password" class="sz"/></td>
					</tr>
					<tr>
					<td>确认密码</td><td><input id="password2" name="password2" type="password" class="sz"/></td>
					</tr>
					<tr>
					<td colspan="2" style="text-align: center"><input type="button" onclick="submitForm2('form1')" value="确认" class="btn black" id="checkbtn" style="width:80px"/></td>
					</tr>
				</table>
				</form>
				<br/>
				<h2>温馨提示</h2>
          <p>请按照提示找回您的密码，验证码会发送到您的注册邮箱中，请注意查收您的邮箱，获得验证码。</p>
          <p>其他问题请及时联系平台客服人员，我们会全力为您解答！</p>
    </div>
  </div>
</div>
<jsp:include page="/include/foothtml.jsp"></jsp:include>
</body>
</html>
