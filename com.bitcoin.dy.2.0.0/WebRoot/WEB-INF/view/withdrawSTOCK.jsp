<%@page import="com.mvc.util.FormatUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>
<%Map<String,Btc_content> indexmap = (Map<String,Btc_content>)session.getAttribute("indexmap"); 
 Btc_stock stock = (Btc_stock)request.getAttribute("stock");
 Btc_profit profit =(Btc_profit)request.getAttribute("profit");
 FormatUtil format=new FormatUtil();
 BigDecimal holding = new BigDecimal(0);
 if(request.getAttribute("coinLeft")!=null){
	 holding = new BigDecimal(request.getAttribute("coinLeft").toString());
 }
 %>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
	<title><%=res.getString("host.title")%></title>
	<jsp:include page="/include/htmlsrc.jsp" ></jsp:include>
	<!-- coins_new -->
  <link href="coins_new/css/zy.css" rel="stylesheet" type="text/css" />
  <!-- 同步账户操作 -->
</head>
<body>
<body>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<jsp:include page="/include/nav.jsp" ></jsp:include>
<div class="box2"> 
	<jsp:include page="/include/lpanel.jsp" ></jsp:include>
  <div class="user_r">
    <div class="u_r_t">
      <div class="u_r_t_l"><%=stock.getBtc_stock_name() %>提现</div>
    </div>
    <div class="user1">
    	<table>
    	<form action="coinProcess.do?withdrawStock" method="post">
       <input type="hidden" name="stockId" value="<%=stock.getBtc_stock_id() %>"/>
    	<tr>
    	<td>可用余额</td><td><%=format.trans(holding) %> <%=stock.getBtc_stock_Eng_name() %></td><td></td>
    	</tr>
    	<tr>
    	<td>当日提现上限</td><td><%=request.getAttribute("todaywithdraw").toString() %>/ <%=stock.getWithdrawzdz()%><%=stock.getBtc_stock_Eng_name() %></td><td></td>
    	</tr>
    	<tr>
    	<td>交易密码</td><td><input type="password" size="22" name="utpassword" id="utpassword" placeholder="请输入您的交易密码" /></td><td></td>
    	</tr>
    	<tr>
    	<td>提现数额 (<%=stock.getBtc_stock_Eng_name() %>)</td><td><input type="text" size="22" name="btc_inout_amount" id="btc_inout_amount" placeholder="请输入整数" class="numinput input-6x"/></td><td>最少 <%=stock.getWithdrawzxz() %>
            <%=stock.getBtc_stock_Eng_name() %>，一次最多<%=stock.getWithdrawzdz() %> 
            <%=stock.getBtc_stock_Eng_name() %></td>
    	</tr>
    	<tr>
    	<td>手续费</td><td><%=stock.getWithdrawsxf().multiply(new BigDecimal(100)).setScale(2,BigDecimal.ROUND_HALF_UP)%>%</td><td></td>
    	</tr>
    	<tr>
    	<td>收款地址</td><td><input type="text" size="22" name="btc_inout_adr" id="btc_inout_adr" placeholder="请输入您的提现钱包地址" class="numinput input-6x"/></td><td></td>
    	</tr>
    	<tr>
    	<td colspan="3" style="text-align: left"><input name="submit" id="submit" value="提交提现申请" type="submit"  class="btn black"/></td>
    	</tr>
    	</form>
    	</table>
		    <p>在上面的输入框中输入资金密码和您要提现的<%=stock.getBtc_stock_Eng_name() %>钱包地址和<%=stock.getBtc_stock_Eng_name() %>
			      数额，并点击“提现”
			      按钮提交提现申请。您的申请将立即或者几小时内被处理。</p>
      <table width="100%" border="0" cellspacing="1" cellpadding="0" style="background:#eee; margin-top:15px;">
        <tr>
          <td height="35" colspan="8" align="left" valign="middle" bgcolor="#FFFFFF" style="font-size:14px; font-weight:bold; color:#333; text-indent:10px;">提现记录</td>
        </tr>
        <tr>
          <td height="35" align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">单号</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">提现地址</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">金额</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">提现时间</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">备注/回执单</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">操作</td>
        </tr>
        <%if(request.getAttribute("orderilst")!=null){
        	List<Btc_inout_order> orderlist = (List<Btc_inout_order>)request.getAttribute("orderilst");
        	Btc_inout_order order = new Btc_inout_order();
        	for(int i=0;i<orderlist.size();i++){
        		order = orderlist.get(i);
        	%>
        <tr>
            <td height="30" align="center" valign="middle" bgcolor="#FFFFFF"><%=order.getBtc_inout_order_id() %></td>
            <td height="30" align="center" valign="middle" bgcolor="#FFFFFF" ><%=order.getBtc_inout_adr() %></td>
            <td height="30" align="center" valign="middle" bgcolor="#FFFFFF"><%=format.trans(order.getBtc_inout_amount()) %></td>
            <td height="30" align="center" valign="middle" bgcolor="#FFFFFF"><%=order.getBtc_inout_time() %></td>
            <td height="30" align="center" valign="middle" bgcolor="#FFFFFF" ><%=order.getBtc_inout_msg() %></td>
            <%if(order.getBtc_inout_status().equals("未处理")){ %>
            <td><a href="#">处理中</a></td>
            <%}else{ %>
			<td><a href="#">已处理</a></td>
			<%} %>          
          </tr>
        <%}
        }else{ %>
          <tr>
            <td height="30" align="center" valign="middle" bgcolor="#FFFFFF" >无</td>
            <td height="30" align="center" valign="middle" bgcolor="#FFFFFF" >暂无记录</td>
            <td height="30" align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
            <td height="30" align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
            <td height="30" align="center" valign="middle" bgcolor="#FFFFFF" >暂无记录</td>
            <td height="30" align="center" valign="middle" bgcolor="#FFFFFF" >暂无记录</td>
          </tr>
          <%} %>
      </table>
    </div>
  </div>
</div>
<jsp:include page="/include/foothtml.jsp"></jsp:include>
</body>
</html>
