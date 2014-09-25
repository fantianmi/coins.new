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
%>
<%Map<String,Btc_content> indexmap = (Map<String,Btc_content>)session.getAttribute("indexmap"); %>
<%Btc_stock stock = (Btc_stock)request.getAttribute("stock");
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
<script type="text/javascript">
   $(document).ready(function() {
       $("#usercenter").addClass('selected');
   });
</script>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<jsp:include page="/include/nav.jsp"></jsp:include>
<%
 Map<Integer,Btc_stock> allstockmap = (Map<Integer,Btc_stock>)session.getAttribute("allstockmap");
 Map<Integer,Btc_holding> userholdmap = (Map<Integer,Btc_holding>)session.getAttribute("userholdmap");
 Map<Integer,Btc_order> userordermap = (Map<Integer,Btc_order>)session.getAttribute("userordermap");
 Iterator it = allstockmap.keySet().iterator();
 Btc_holding hold = new Btc_holding();
 Btc_order order = new Btc_order();
 BigDecimal holdamount = new BigDecimal(0);
 BigDecimal orderamount = new BigDecimal(0);
 BigDecimal frozenamount = new BigDecimal(0);
 BigDecimal total = new BigDecimal(0);
 BigDecimal totalCNY = new BigDecimal(0);
 //GFB info
 BigDecimal leftGFB=new BigDecimal(0);
 BigDecimal orderGFB=new BigDecimal(0);
 BigDecimal amountGFB=new BigDecimal(0);
 //ZB info
 BigDecimal leftZB=new BigDecimal(0);
 BigDecimal orderZB=new BigDecimal(0);
 BigDecimal amountZB=new BigDecimal(0);
	 %>
<div class="box2"> 
<jsp:include page="/include/lpanel.jsp"></jsp:include>
  <div class="user_r">
    <div class="u_r_t">
      <div class="u_r_t_l">我的资金管理</div>
      <div class="u_r_t_r">您当前的资金估值为：<b style="font-size:14px; color:red;"><%=request.getAttribute("otherCount").toString() %> </b> LTC。 莱特币余额：<b style="font-size:14px; color:red;"><%=session.getAttribute("ab_cny").toString() %> LTC</b></div>
    </div>
    <div class="u_r_b">
      <ul>
      <li style=" font-weight:bold; background:#eee; color:#333; font-size:14px;"><span>类型</span><span>可用余额</span><span>挂单金额</span><span>总计</span><span>操作</span></li>
					<%
          while(it.hasNext()){
	      	 Integer key = (Integer)it.next();
	      	 stock = allstockmap.get(key);
	      	 if(userholdmap.get(key)!=null){
	      	 	hold = userholdmap.get(key);
	      	 	holdamount = hold.getBtc_stock_amount();
	      	 	if(hold.getFrozen_amount()!=null) frozenamount=hold.getFrozen_amount();
	      	 	else frozenamount=new BigDecimal(0);
	      	 }else{
	      		 holdamount = new BigDecimal(0);
	      	 }
	      	 
	      	 if(userordermap.get(key)!=null){
	      		 order = userordermap.get(key);
	      		 orderamount = order.getBtc_order_amount();	
	      	 }else{
	      		 orderamount = new BigDecimal(0);
	      	 }
	      	 total = orderamount.add(holdamount).add(frozenamount);
	      	 totalCNY = total.multiply(stock.getBtc_stock_price()).setScale(2,BigDecimal.ROUND_HALF_UP);
	      	 if(!stock.getBtc_stock_Eng_name().equals("GFB")){%>
        <li><span><%=stock.getBtc_stock_name() %>/<%=stock.getBtc_stock_Eng_name()%></span><span><%=format.trans(holdamount)%></span><span><%=format.trans(orderamount)%></span><span><%=format.trans(total)%></span><span><a href="coinProcess.do?generalAdr&stockid=<%=stock.getBtc_stock_id() %>"  style="color:red;">充值</a> | <a href="index.do?withdrawStock&stockid=<%=stock.getBtc_stock_id() %>" style="color:#F90;">提现</a> | <a href="index.do?stock&stockId=<%=stock.getBtc_stock_id() %>"  style="color:#00F;">交易</a></span></li>
            <%}else if(stock.getBtc_stock_Eng_name().equals("GFB")){
            	leftGFB=holdamount;
            	orderGFB=orderamount;
            	amountGFB=total;
            }else if(stock.getBtc_stock_Eng_name().equals("ZB")){
            	leftZB=holdamount;
            	orderZB=orderamount;
            	amountZB=total;
            }
          }%>
      </ul>
      <table width="100%" border="0" cellspacing="1" cellpadding="0" style="margin-top:15px; background:#eee;">
  <tr>
    <td width="19%" height="35" align="right" valign="middle" bgcolor="#f9f9f9">可用股份币GFB：</td>
    <td width="11%" align="left" valign="middle" bgcolor="#FFFFFF"> &nbsp;<%=format.trans(leftGFB) %></td>
    <td width="16%" align="right" valign="middle" bgcolor="#f9f9f9">挂单股份币GFB：</td>
    <td width="12%" align="left" valign="middle" bgcolor="#FFFFFF">&nbsp;<%=format.trans(orderGFB) %></td>
    <td width="15%" align="right" valign="middle" bgcolor="#f9f9f9">合计GFB：</td>
    <td width="8%" align="left" valign="middle" bgcolor="#FFFFFF">&nbsp;<%=format.trans(amountGFB) %></td>
    <td width="19%" align="center" valign="middle" bgcolor="#F9F9F9" style="color:#333;">规则详情</td>
  </tr>
  <tr>
    <td height="35" align="right" valign="middle" bgcolor="#f9f9f9">可用紫币ZB：</td>
    <td align="left" valign="middle" bgcolor="#FFFFFF">&nbsp;<%=format.trans(leftZB) %></td>
    <td align="right" valign="middle" bgcolor="#f9f9f9">挂单紫币ZB：</td>
    <td align="left" valign="middle" bgcolor="#FFFFFF">&nbsp;<%=format.trans(leftZB) %></td>
    <td align="right" valign="middle" bgcolor="#f9f9f9">合计紫币ZB：</td>
    <td align="left" valign="middle" bgcolor="#FFFFFF">&nbsp;<%=format.trans(leftZB) %></td>
    <td align="center" valign="middle" bgcolor="#FFFFFF">&nbsp;</td>
  </tr>
</table>

    </div>
  </div>
</div>
<jsp:include page="/include/foothtml.jsp"></jsp:include>
</body>
</html>
