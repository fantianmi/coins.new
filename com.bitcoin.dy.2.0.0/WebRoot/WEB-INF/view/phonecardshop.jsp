<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
<%ResourceBundle shopres = ResourceBundle.getBundle("shop"); %>  
<%Map<String,Btc_content> indexmap = (Map<String,Btc_content>)session.getAttribute("indexmap"); 
List<Btc_content> newslistall = (List<Btc_content>)session.getAttribute("newslistall");%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
<title><%=res.getString("host.title")%></title>
<jsp:include page="/include/htmlsrc.jsp"/>
<script type="text/javascript">
   $(document).ready(function() {
       $("#tshop").addClass('active');
   });
</script>
</head>
  <body>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<!-- content -->
<div class="wrapper row3" >
<div class="full-screen-slider" >
 	 <ul id="slides">
    <li style="background:url('slider/04.png') no-repeat center top"></li>
    </ul>
</div>
<div id="container" style="background-color: #fff;margin-bottom: 0px;padding-bottom: 0px">
<!-- shop area -->
<iframe src="shopdetail.jsp" name="cjsj" width="100%" marginwidth="0" height="750" marginheight="0" align="top" scrolling="Auto" frameborder="0"></iframe>
<!-- shop area -->
  </div>
  <div id="container" style="padding-top: 0px;margin-top:0px">
  <h1 style="font-size:14px;color:#0171C7;font-weight:800">我的充值卡</h1>
  <table id="centertext">
  <thead>
  <tr><th>订单号</th><th>充值码</th><th>购买时间</th><th>兑换币</th><th>价格</th></tr>
  </thead>
  <tbody>
  <%if(request.getAttribute("list")!=null){
		List<Btc_phonecard> list = (List<Btc_phonecard>)request.getAttribute("list");
		Btc_phonecard card = new Btc_phonecard();
		Map<Integer,Btc_stock> stockmap=(Map<Integer,Btc_stock>)request.getAttribute("stockmap");
		Btc_stock stock=new Btc_stock();
		for(int i=0;i<list.size();i++){
			card=list.get(i);
			stock.setBtc_stock_name("无记录");
			if(stockmap.get(card.getStockid())!=null){
				stock=stockmap.get(card.getStockid());
			}
			%>
			 <tr><td><%=card.getId() %></td><td><%=card.getCard() %></td><td><%=card.getUsetime() %></td><td><%=stock.getBtc_stock_name()%></td><td><%=card.getPrice() %></td></tr>
	  <%}}%>
 
  </tbody>
  </table>
    <div class="clear"></div>
  </div>
</div>
<!-- ############################################################## -->

<jsp:include page="/include/foothtml.jsp"></jsp:include>
</div>
</body>
</html>
