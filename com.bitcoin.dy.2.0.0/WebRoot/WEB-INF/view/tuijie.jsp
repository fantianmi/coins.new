<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="com.mvc.util.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
<%ResourceBundle stockres = ResourceBundle.getBundle("stock"); %>  
<%Map<String,Btc_content> indexmap = (Map<String,Btc_content>)session.getAttribute("indexmap"); 
 Btc_stock stock = (Btc_stock)request.getAttribute("stock");
 Btc_profit profit =(Btc_profit)request.getAttribute("profit");
 BigDecimal holding = new BigDecimal(0);
 if(request.getAttribute("holding")!=null){
	 Btc_holding hold = (Btc_holding)request.getAttribute("holding");
	 holding = hold.getBtc_stock_amount();
 }
 Btc_user user = new Btc_user();
if(session.getAttribute("globaluser")!=null){
user = (Btc_user)session.getAttribute("globaluser");
}
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
	<script type="text/javascript">
    $(document).ready(function() {
        $("#tuijie").addClass('selected');
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
      <div class="u_r_t_l">欢迎进行推广</div>
    </div>
    <div class="user1">
      <div class="reset1" style="margin-top:10px;">您的推广链接为：<b style="color:red;"><%=res.getString("host.small.title")%>  <%=basePath%>reg.jsp?id=<%=request.getAttribute("uid").toString() %></b><br>
        <span style="color:#06F;">请将上面链接复制后发给您要推荐的人，通过该链接注册的用户在平台进行充值交易后您将获得平台股份币作为您平台的交易手续费分红凭证，获取丰厚回报</span> </div>
      <table width="100%" border="0" cellspacing="1" cellpadding="0" style="margin-top:15px; background:#eee;">
        <tr>
          <td height="30" colspan="4" bgcolor="#FFFFFF" style="text-indent:10px; font-weight:600; font-size:14px;">您成功推荐的用户</td>
        </tr>
        <tr>
          <td width="24%" height="30" align="center" valign="middle" bgcolor="#f9f9f9" style="font-weight:bold; color:#333;">用户名</td>
          <td width="23%" align="center" valign="middle" bgcolor="#f9f9f9" style="font-weight:bold; color:#333;">用户注册时间</td>
          <td width="27%" align="center" valign="middle" bgcolor="#f9f9f9" style="font-weight:bold; color:#333;">实名认证状态</td>
          <td width="26%" align="center" valign="middle" bgcolor="#f9f9f9" style="font-weight:bold; color:#333;">是否获得的推广该用户奖励</td>
        </tr>
        <%if(request.getAttribute("invitelist")==null){%>
        <tr>
          <td height="30" align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
        </tr>
        <%}else{
        	List<TuijieViewModel> userlist = (List<TuijieViewModel>)request.getAttribute("invitelist");
	      	TuijieViewModel user2 = new TuijieViewModel();
	      	for(int i=0;i<userlist.size();i++){
	      		 user2 = userlist.get(i);%>
	      		 <tr>
	            <td><%=user2.getUsername() %></td>
	            <td><%=user2.getUsdtime() %></td>
	            <td><%=user2.getIsAuthRealName()%></td>
	            <td><%=user2.getIsGetTGaward()%></td>
	          </tr>
	      	 <%}} %>
      </table>
    </div>
  </div>
</div>
<jsp:include page="/include/foothtml.jsp"></jsp:include>
</div>
</body>
</html>
