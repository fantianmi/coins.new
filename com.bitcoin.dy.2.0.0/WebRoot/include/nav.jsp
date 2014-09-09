<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="com.mvc.util.*"%>
<%FormatUtil format = new FormatUtil(); %>
<div class="box1">
  <div class="b1_t">CNY兑换专区</div>
  <div class="b1_b">
  <%if(session.getAttribute("stock_map_navigation")!=null){
	Map<String, NaviStockModel> stock_map_navigation = (Map<String, NaviStockModel>) session.getAttribute("stock_map_navigation");
	Iterator it = stock_map_navigation.keySet().iterator();
	int index=0;
	while(it.hasNext()){
	String key=(String)it.next();
	NaviStockModel btc_stock = (NaviStockModel)stock_map_navigation.get(key);%>
	<a href="index.do?stock&stockId=<%=btc_stock.getId()%>" <%if(index==0){ %>style="margin-left:0px;"<%} %>><%=btc_stock.getName()%>(<%=btc_stock.getEngName()%>)<br /><span style="color:#d80000;">CNY<%=format.trans(btc_stock.getNewsprice()) %></span><span id="<%=format.num2color(btc_stock.getZdf())%>">(<%=format.num2percent(btc_stock.getZdf())  %>%)</span></a> 
	<%
	index++;
	}}
	%>
   <a href="bz_show.asp">下一个币<br />欢迎投票</a> 
   </div>
  <div class="b1_t">LTC兑换专区</div>
  <div class="b1_b"> 
  <%if(session.getAttribute("selfstocktradeltc")!=null){
	List<NaviStockModel> selfstocklist = (List<NaviStockModel>) session.getAttribute("selfstocktradeltc");
	NaviStockModel bstock = new NaviStockModel();
	for(int i=0;i<selfstocklist.size();i++){
		bstock = (NaviStockModel)selfstocklist.get(i);
		%>
		<a href="index.do?fulltrade&stockid=<%=bstock.getId()%>&exstock=<%=bstock.getExstock() %>" <%if(i==0){ %>style="margin-left:0px;"<%} %>><%=bstock.getName()%>(<%=bstock.getEngName()%>)<br /><span style="color:#d80000;">LTC<%=format.trans(bstock.getNewsprice()) %></span><span  id="<%=format.num2color(bstock.getZdf())%>">(<%=format.num2percent(bstock.getZdf())  %>%)</span></a>
		<%}}%>
  <a href="bz_show.asp">下一个币<br />欢迎投票</a> 
  </div>
  <div class="b1_t">股份币兑换专区</div>
  <div class="b1_b"> 
  <%if(session.getAttribute("selfstocktrade")!=null){
	List<NaviStockModel> selfstocklist = (List<NaviStockModel>) session.getAttribute("selfstocktrade");
	NaviStockModel bstock = new NaviStockModel();
	for(int i=0;i<selfstocklist.size();i++){
		bstock = (NaviStockModel)selfstocklist.get(i);%>
		<a href="index.do?fulltrade&stockid=<%=bstock.getId() %>&exstock=<%=bstock.getExstock() %>"  <%if(i==0){ %>style="margin-left:0px;"<%} %>><%=bstock.getName()%>(<%=bstock.getEngName()%>)<br /><span style="color:#d80000;">GFB<%=format.trans(bstock.getNewsprice()) %></span><span id="<%=format.num2color(bstock.getZdf())%>">(<%=format.num2percent(bstock.getZdf())  %>%)</span></a>
  <%}}%>
  <a href="bz_show.asp">下一个币<br />欢迎投票</a> </div>
</div>

