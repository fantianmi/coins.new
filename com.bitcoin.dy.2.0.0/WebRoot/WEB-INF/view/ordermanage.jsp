<%@page import="com.mvc.entity.games.Games_luckwheel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.entity.games.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="com.mvc.util.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
<%
FormatUtil format = new FormatUtil();
 Btc_stock stock = (Btc_stock)request.getAttribute("stock");
 Btc_profit profit =(Btc_profit)request.getAttribute("profit");
 BigDecimal holding = new BigDecimal(0);
 if(request.getAttribute("holding")!=null){
	 Btc_holding hold = (Btc_holding)request.getAttribute("holding");
	 holding = hold.getBtc_stock_amount();
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
		        $("#ordermanage").addClass('selected');
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
      <div class="u_r_t_l">挂单管理</div>
      <!--<div class="u_r_t_r">您当前的资金估值为：<b style="font-size:14px; color:red;">0.00</b> 元人民币。 人民币余额：<b style="font-size:14px; color:red;">0.00 元</b></div>--> 
    </div>
    <div class="user1">
      <table width="100%" border="0" cellspacing="1" cellpadding="0" style="background:#eee; margin-top:15px;">
        <tr>
          <td height="35" colspan="8" align="left" valign="middle" bgcolor="#FFFFFF" style="font-size:14px; font-weight:bold; color:#333; text-indent:10px;">我的最新挂单</td>
        </tr>
        <tr>
          <td height="35" align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">下单日期</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">类型</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">兑换币种</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">资金类型</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">交易价</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">挂单量</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">总计</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">操作</td>
        </tr>
<%
Btc_order order = new Btc_order();
Map<Integer,Btc_stock> stockmap = (Map<Integer,Btc_stock>)request.getAttribute("stockmap");
if(request.getAttribute("orderlist")!=null){
 List<Btc_order> orderlist = (List<Btc_order>)request.getAttribute("orderlist");
 for(int i=0;i<orderlist.size();i++){
	 order = orderlist.get(i);
	 stock = stockmap.get(order.getBtc_stock_id());
%>
				<tr>
          <td height="35" align="center" valign="middle" bgcolor="#FFFFFF">><%=order.getBtc_order_time() %></td>
          <td align="center" valign="middle" bgcolor="#FFFFFF"><%=format.tansTradeType(order.getBtc_order_type())%></td>
          <td align="center" valign="middle" bgcolor="#FFFFFF"><%=stock.getBtc_stock_Eng_name() %></td>
          <td align="center" valign="middle" bgcolor="#FFFFFF"><%=order.getBtc_exstock_name() %></td>
          <td align="center" valign="middle" bgcolor="#FFFFFF"><%=format.trans(order.getBtc_order_price()) %></td>
          <td align="center" valign="middle" bgcolor="#FFFFFF"><%=format.trans(order.getBtc_order_amount()) %></td>
          <td align="center" valign="middle" bgcolor="#FFFFFF"><%=format.trans(order.getBtc_order_amount().multiply(order.getBtc_order_price()))%></td>
          <td align="center" valign="middle" bgcolor="#FFFFFF"><a href="createOrder.do?cancelorderByOid&oid=<%=order.getBtc_order_id() %>">撤单</a></td>
        </tr>
<% }}else{%>
        <tr>
          <td height="35" align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
        </tr>
<%} %>
      </table>
      
      <table width="100%" border="0" cellspacing="1" cellpadding="0" style="background:#eee; margin-top:15px;">
        <tr>
          <td height="35" colspan="6" align="left" valign="middle" bgcolor="#FFFFFF" style="font-size:14px; font-weight:bold; color:#333; text-indent:10px;">买交易记录</td>
        </tr>
        <tr>
          <td height="35" align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">成交时间</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">兑换币种</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">资金类型</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">成交价格</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">成交数量</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">兑换额</td>
        </tr>
<%
Btc_deal_list buybdl = new Btc_deal_list();
if(request.getAttribute("buyhlist")!=null){
	List<Btc_deal_list> buybdllist = (List<Btc_deal_list>)request.getAttribute("buyhlist");
	for(int i=0;i<buybdllist.size();i++){
		buybdl = buybdllist.get(i);
		stock = stockmap.get(buybdl.getBtc_stock_id());
		%>
				<tr>
          <td height="35" align="center" valign="middle" bgcolor="#FFFFFF"><%=buybdl.getBtc_deal_time() %></td>
          <td align="center" valign="middle" bgcolor="#FFFFFF"><%=stock.getBtc_stock_Eng_name()%></td>
          <td align="center" valign="middle" bgcolor="#FFFFFF"><%=buybdl.getBtc_exstock_name() %></td>
          <td align="center" valign="middle" bgcolor="#FFFFFF"><%=format.trans(buybdl.getBtc_deal_Rate()) %></td>
          <td align="center" valign="middle" bgcolor="#FFFFFF"><%=format.trans(buybdl.getBtc_deal_quantity()) %></td>
          <td align="center" valign="middle" bgcolor="#FFFFFF"><%=format.trans(buybdl.getBtc_deal_total()) %></td>
        </tr>
		<%}}else{%>
        <tr>
          <td height="35" align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
        </tr>
    <%} %>  
      </table>
      
       <table width="100%" border="0" cellspacing="1" cellpadding="0" style="background:#eee; margin-top:15px;">
        <tr>
          <td height="35" colspan="6" align="left" valign="middle" bgcolor="#FFFFFF" style="font-size:14px; font-weight:bold; color:#333; text-indent:10px;">卖交易记录</td>
        </tr>
        <tr>
          <td height="35" align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">成交时间</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">兑换币种</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">资金类型</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">成交价格</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">成交数量</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">兑换额</td>
        </tr>
 <%
Btc_deal_list sellbdl = new Btc_deal_list();
if(request.getAttribute("sellhlist")!=null){
	List<Btc_deal_list> sellbdllist = (List<Btc_deal_list>)request.getAttribute("sellhlist");
	for(int i=0;i<sellbdllist.size();i++){
		sellbdl = sellbdllist.get(i);
		stock = stockmap.get(sellbdl.getBtc_stock_id());
		%>
				<tr>
          <td height="35" align="center" valign="middle" bgcolor="#FFFFFF"><%=sellbdl.getBtc_deal_time() %></td>
          <td align="center" valign="middle" bgcolor="#FFFFFF"><%=stock.getBtc_stock_Eng_name()%></td>
          <td align="center" valign="middle" bgcolor="#FFFFFF"><%=sellbdl.getBtc_exstock_name() %></td>
          <td align="center" valign="middle" bgcolor="#FFFFFF"><%=format.trans(sellbdl.getBtc_deal_Rate()) %></td>
          <td align="center" valign="middle" bgcolor="#FFFFFF"><%=format.trans(sellbdl.getBtc_deal_quantity()) %></td>
          <td align="center" valign="middle" bgcolor="#FFFFFF"><%=format.trans(sellbdl.getBtc_deal_total()) %></td>
        </tr>
 	<%}}else{%>
        <tr>
          <td height="35" align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
        </tr>
     <%} %>  
      </table>
    </div>
  </div>
</div>
<!-- end -->
<jsp:include page="/include/foothtml.jsp"></jsp:include>
</div>
</body>
</html>
