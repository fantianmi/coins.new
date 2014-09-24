<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="com.mvc.util.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
<%
FormatUtil format = new FormatUtil();
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/";
Map<String,Btc_content> indexmap = (Map<String,Btc_content>)session.getAttribute("indexmap"); 
Btc_stock stock = (Btc_stock)request.getAttribute("stock");
Btc_user user = new Btc_user();
if(session.getAttribute("globaluser")!=null){
user = (Btc_user)session.getAttribute("globaluser");
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
		        $("#bankmanage").addClass('selected');
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
      <div class="u_r_t_l">我的绑定信息&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size: 0.8em">已进行绑定后在平台可以正常进行充值提现功能</span></div>
      <!--<div class="u_r_t_r">您当前的资金估值为：<b style="font-size:14px; color:red;">0.00</b> 元人民币。 人民币余额：<b style="font-size:14px; color:red;">0.00 元</b></div>--> 
    </div>
    <div class="user1">
    <%
	  Btc_bank bank = (Btc_bank)request.getAttribute("bindinfo");
	  String type="银行卡";
	  if(bank.getBankname().equals("支付宝")){ type="支付宝";}
	  %>
	  <table width="100%" border="0" cellspacing="1" cellpadding="0" style="background:#eee; margin-top:15px;">
    <tbody>
    <tr ><th height="35" align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;"><span>类型</span></th><td height="35" align="center" valign="middle" bgcolor="#FFFFFF"><%=type %></td><th height="35" align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;"><span>银行</span></th><td height="35" align="center" valign="middle" bgcolor="#FFFFFF"><%=bank.getBankname() %></td> </tr>
    <tr><th height="35" align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;"><span>地区</span></th><td height="35" align="center" valign="middle" bgcolor="#FFFFFF"><%=bank.getProvince() %> <%=bank.getCity() %> <%=bank.getTown() %></td><th height="35" align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;"><span>开户行</span></th><td height="35" align="center" valign="middle" bgcolor="#FFFFFF"><%=bank.getDepositbank() %></td> </tr>
    <tr><th height="35" align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;"><span>账号</span></th><td height="35" align="center" valign="middle" bgcolor="#FFFFFF"><%=format.encipherCard(bank.getCard()) %></td><th height="35" align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;"><span>姓名</span></th><td height="35" align="center" valign="middle" bgcolor="#FFFFFF"><%=bank.getName() %></td> </tr>
    <tr><th height="35" align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;"><span>状态</span></th><td height="35" align="center" valign="middle" bgcolor="#FFFFFF"><%=bank.getStatus() %></td><th height="35" align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;"><span>&nbsp;</span></th><td height="35" align="center" valign="middle" bgcolor="#FFFFFF">&nbsp;</td> </tr>
    </tbody>
    </table>
    <br>
    <a href="bank.do?gochange">修改绑定信息 >></a>
    </div>
  </div>
</div>
<jsp:include page="/include/foothtml.jsp"></jsp:include>
</div>
</body>
</html>
