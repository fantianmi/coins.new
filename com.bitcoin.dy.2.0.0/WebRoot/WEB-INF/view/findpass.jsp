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
				<form class="rnd5" action="#" method="post">
					<p><input type="text" name="username" id="usernameinput" size="22" placeholder="您注册的用户名"/></p>
					<br/>
					<p><input type="button"  onclick="" class="btn black" value="确认" id="checkbtn" style="width:80px"/></p>
				</form>
				<br/>
				<h2>温馨提示</h2>
          <p>请按照提示找回您的密码，验证码会发送到您的注册邮箱中，请注意查收您的邮箱，获得验证码。</p>
          <p>其他问题请及时联系平台客服人员，我们会全力为您解答！</p>
    </div>
  </div>
</div>
<script type="text/javascript">
document.getElementById("checkbtn").onclick=function(){
	var type = '<%=request.getAttribute("type")%>';
	var username = document.getElementById('usernameinput').value;
	var url = 'register.do?findpass&username='+username+'&type='+type+'&n='+Math.random();
	buttondo(url);
}
</script>	
<jsp:include page="/include/foothtml.jsp"></jsp:include>
</body>
</html>
