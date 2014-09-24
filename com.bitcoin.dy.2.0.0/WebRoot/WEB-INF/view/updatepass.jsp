<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="com.mvc.util.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%
ResourceBundle res = ResourceBundle.getBundle("host"); 
String updatetype = "";
if(request.getAttribute("updatetype")!=null){
	updatetype = request.getAttribute("updatetype").toString();
}
String title=null;
String forgetUrl=null;
String menuId=null;
if(updatetype.equals("updatepassword")){
	title="登陆密码重置";
	forgetUrl="index.do?findpass&type=upass";
	menuId="#loginPassReset";
}else{
	title="交易密码重置";
	forgetUrl="index.do?findpass&type=utpass";
	menuId="#tradePassReset";
}
%>  
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
	<title><%=res.getString("host.title")%></title>
	<jsp:include page="/include/htmlsrc.jsp" ></jsp:include>
	<!-- coins_new -->
  <link href="coins_new/css/zy.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript">
    $(document).ready(function() {
        $('<%=menuId%>').addClass('selected');
    });
 </script>
</head>
<body>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<jsp:include page="/include/nav.jsp" ></jsp:include>
 <div class="box2"> 
  <jsp:include page="/include/lpanel.jsp" ></jsp:include>
  <div class="user_r">
    <div class="u_r_t">
      <div class="u_r_t_l"><%=title%></div>
    </div>
    <div class="user1">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:15px;">
      <form action="register.do?updatepassword" method="post" name="updatePass" id="updatePass">
       <input type="hidden" name="updatetype" value="<%=updatetype %>"/>
        <tr>
          <td width="37%" height="40" align="right" style="color:#333; font-weight:bold;">原 密 码：</td>
          <td width="63%" style="padding-left:10px;"><input name="opassword" id="oldPassword" type="password" style="width:200px; height:25px; line-height:25px; color:#666; border:1px solid #ddd;"/> <a href="<%=forgetUrl%>">忘记交易密码？</a></td>
        </tr>
        <tr>
          <td height="40" align="right" style="color:#333; font-weight:bold;">新 密 码：</td>
          <td style="padding-left:10px;"><input size="22" id="newPassword" name="npassword"  type="password" style="width:200px; height:25px; line-height:25px; color:#666; border:1px solid #ddd;"/></td>
        </tr>
        <tr>
          <td height="40" align="right" style="color:#333; font-weight:bold;">确认新密码：</td>
          <td style="padding-left:10px;"><input id="newPassword2" name="password2" type="password" style="width:200px; height:25px; line-height:25px; color:#666; border:1px solid #ddd;"/></td>
        </tr>
        <tr>
          <td height="40" align="right" style="color:#333; font-weight:bold;"></td>
          <td style="padding-left:10px;"><input type="button" value="确认修改" onclick="resetPassword()" style="margin-top:15px; font-family:微软雅黑; color:#333; padding:0px 10px; font-size:12px;" /></td>
        </tr>
        </form>
      </table>
    </div>
  </div>
</div>
<jsp:include page="/include/foothtml.jsp"></jsp:include>
</body>
</html>
