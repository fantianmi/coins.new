<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="com.mvc.util.*"%>
<%FormatUtil format = new FormatUtil(); %>
<div class="box1">
  <div class="b1_t">LTC兑换专区</div>
  <div class="b1_b">
  <%if(session.getAttribute("stock_map_navigation")!=null){
	Map<String, NaviStockModel> stock_map_navigation = (Map<String, NaviStockModel>) session.getAttribute("stock_map_navigation");
	Iterator it = stock_map_navigation.keySet().iterator();
	int index=0;
	while(it.hasNext()){
	String key=(String)it.next();
	NaviStockModel btc_stock = (NaviStockModel)stock_map_navigation.get(key);%>
	<a href="index.do?stock&stockId=<%=btc_stock.getId()%>" <%if(index==0){ %>style="margin-left:0px;"<%} %>><%=btc_stock.getName()%>(<%=btc_stock.getEngName()%>)<br /><span style="color:#d80000;">LTC <%=format.trans(btc_stock.getNewsprice()) %></span><span id="<%=format.num2color(btc_stock.getZdf())%>">(<%=format.num2percent(btc_stock.getZdf())  %>%)</span></a> 
	<%
	index++;
	}}
	%>
   
   </div>
</div>

