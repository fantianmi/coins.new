<%@page import="com.mvc.util.FormatUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%
ResourceBundle res = ResourceBundle.getBundle("host"); 
Btc_stock stock = (Btc_stock)request.getAttribute("stock");
FormatUtil format=new FormatUtil();
%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
	<title><%=res.getString("host.title")%></title>
	<jsp:include page="/include/htmlsrc.jsp" ></jsp:include>
	<!-- coins_new -->
  <link href="coins_new/css/zy.css" rel="stylesheet" type="text/css" />
  <!-- 同步账户操作 -->
  <script type="text/javascript">
			var wait=30;
			var count = 1;
			function time(o) {
				if (wait == 0) {
				o.removeAttribute("disabled");
				o.value="充值并且"+<%=stock.getRechargezxz()%>+"个确认后，请点同步";
				wait = 30;
				} else {
				o.setAttribute("disabled", true);
				o.value=wait+"秒后可以重新同步";
				wait--;
				setTimeout(function() {
				time(o)
				},
				1000)
				}
			}
			
			document.getElementById("syn").onclick=function(){
				syn();
				time(this);
			}
			
			var xmlHttp = null;
			function syn() {
				if (window.XMLHttpRequest) {
					xmlHttp = new XMLHttpRequest();
				} else if (window.ActiveXObject) {
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				}
				if (xmlHttp != null) {
					var adr = '<%=request.getAttribute("rechargeadr").toString()%>';
					var stockid =<%=stock.getBtc_stock_id() %>;
					var url = 'coinProcess.do?syn&adr='+adr+'&stockid='+stockid+'&n=' + Math.random();
					xmlHttp.onreadystatechange = function() {
						if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
							var msg = xmlHttp.responseXML.getElementsByTagName("msg")[0].firstChild.nodeValue;
							var href = xmlHttp.responseXML.getElementsByTagName("href")[0].firstChild.nodeValue;
							window.alert(msg);
							if(href!='nohref'){
								window.location.href=href;
							}
			
						}
					}
					xmlHttp.open("GET", url, true);
					xmlHttp.send(null);
				}
			}
			</script>
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
      <div class="u_r_t_l"><%=stock.getBtc_stock_name() %>充值</div>
    </div>
    <div class="user1">
    	<p>请将<%=stock.getBtc_stock_name() %>汇入&nbsp;&nbsp;<span style="font-size:14px; color:#F00;"><%=request.getAttribute("rechargeadr").toString()%></span></p>
    	<br/>
    	<p>请通过<%=stock.getBtc_stock_name() %> 客户端或在线钱包将您需要充值的<%=stock.getBtc_stock_Eng_name() %>数目发送到该地址。发送完成后，系统会自动在此交易获得<%=stock.getRechargezxz()%> 个确认后将该笔虚拟币充值到您在本站的账户，<%=stock.getRechargezxz()%>个确认需要大约 0.5 到 1 小时时间，请耐心等待。 同一个地址可多次充值，不影响到账。 </p>
      <p>注意: 如果您的一次发送数量<span style="color:#F00">少于<%=stock.getRechargezxz()%><%=stock.getBtc_stock_Eng_name() %></span>，系统将累积到1<%=stock.getBtc_stock_Eng_name() %>后入账。</p>
      <p>注意: 从矿池发送或者发送挖矿产生的虚拟币转账确认时间可能出现较长的情况，请尽量从您的钱包(Wallet)发送充值虚拟币。 </p>
      <table width="100%" border="0" cellspacing="1" cellpadding="0" style="background:#eee; margin-top:15px;">
        <tr>
          <td height="35" colspan="8" align="left" valign="middle" bgcolor="#FFFFFF" style="font-size:14px; font-weight:bold; color:#333; text-indent:10px;"><%=stock.getBtc_stock_name() %>充值记录</td>
        </tr>
        <tr>
          <td height="35" align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">订单时间</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">充值地址</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">数量</td>
          <td align="center" valign="middle" bgcolor="#f9f9f9" style="color:#333; font-weight:bold;">状态</td>
        </tr>
        <tr>
				<td colspan="4" style="text-align: right" bgcolor="#f9f9f9" style="color: #333; font-weight:bold;"><input type="button" id="syn" value="充值达到<%=format.trans(stock.getRechargezxz())%>个后点击同步" onclick="syn()" style="width:200px" class="btn black"></td>
				</tr>
				<%
				if(request.getAttribute("orderlist")!=null){
				List<Btc_rechargeStock_order> list = (List<Btc_rechargeStock_order>)request.getAttribute("orderlist");
				Btc_rechargeStock_order brso = new Btc_rechargeStock_order();
				for(int i=0;i<list.size();i++){
					brso = list.get(i);
				%>
				<tr>
				<td height="30" align="center" valign="middle" bgcolor="#FFFFFF"><%=brso.getDate() %></td><td height="30" align="center" valign="middle" bgcolor="#FFFFFF"><%=brso.getAdr() %></td>
				<td height="30" align="center" valign="middle" bgcolor="#FFFFFF"><%=brso.getAmount() %></td><td height="30" align="center" valign="middle" bgcolor="#FFFFFF"><%=brso.getStatus() %></td>
				</tr>
			<%}}%>
      </table>
    </div>
  </div>
</div>
<jsp:include page="/include/foothtml.jsp"></jsp:include>
</body>
</html>
