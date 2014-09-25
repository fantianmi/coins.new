<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="com.mvc.util.*"%>

<%
FormatUtil format = new FormatUtil();
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/";
%>
<div class="user_l">
  <div class="u_l_t">用户中心</div>
  <div class="u_l_b">
  <a href="index.do?usercenter" id="usercenter">我的资金管理</a> 
  <a href="index.do?ordermanage" id="ordermanage">我的挂单及交易记录 </a>
  <a href="index.do?register2" id="register2">进行实名认证</a>
  <a href="index.do?userdetail" id="gerenziliao">我的详细资料</a> 
  <a href="index.do?updatepass" id="loginPassReset">修改登录密码</a>
  <a href="index.do?updateutpass" id="tradePassReset">修改交易密码</a> 
  <a href="index.do?tuijie" id="tuijie">推广得股份币</a> 
  <a href="index.do?fenhong" id="fenhong">股份币分红领取</a> 
  <a href="coinProcess.do?generalAdr&stockid=1001">莱特币充值</a> 
  <a href="index.do?withdrawStock&stockid=1001">莱特币提现</a> 
  </div>
  <div class="u_l_t">持有币种</div>
  <%
	  BigDecimal cny = new BigDecimal(session.getAttribute("ab_cny").toString());
	  BigDecimal otherCount = cny;
	  Map<String,Btc_stock> stock_map = (Map<String,Btc_stock>)session.getAttribute("stock_map");
	  if(session.getAttribute("btc_holding_list")!=null){
	  	List<Btc_holding> Btc_holding_list = (List<Btc_holding>)session.getAttribute("btc_holding_list");
	  	for(int i=0;i<Btc_holding_list.size();i++){
	  		Btc_holding btc_holding = Btc_holding_list.get(i);
	  		Btc_stock btc_stock = new Btc_stock();
	  		BigDecimal stock_price = new BigDecimal(0);
	  		String stockName = "";
	  		String stockEngName = "";
  			btc_stock = stock_map.get(btc_holding.getBtc_stock_id());
  			stock_price = btc_stock.getBtc_stock_price();
  			stockName = btc_stock.getBtc_stock_name();
  			stockEngName = btc_stock.getBtc_stock_Eng_name();
	  		stock_price.setScale(2,BigDecimal.ROUND_HALF_UP);
	  		BigDecimal stock_amount = btc_holding.getBtc_stock_amount();
	  		stock_amount.setScale(4,BigDecimal.ROUND_HALF_UP);
	  		otherCount = otherCount.add(stock_price.multiply(stock_amount));
	  		%>
	  		<div class="u_l_b1"><a href="index.htm?stock&stockId=<%=btc_stock.getBtc_stock_id() %>" ><%=stockName %>(<%=stockEngName %></a></div>
	  	<%
	  	}
	  } 
	  otherCount = otherCount.setScale(2,BigDecimal.ROUND_HALF_UP);
	  request.setAttribute("otherCount",format.trans(otherCount));
	  %>
</div>
