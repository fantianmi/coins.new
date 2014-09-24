<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mvc.util.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%ResourceBundle stockres = ResourceBundle.getBundle("stock"); %>
<%FormatUtil format = new FormatUtil(); %>
  
<%if(request.getAttribute("msg")==null){
}else{
String msg = request.getAttribute("msg").toString();
String href = null;
%>
<script type="text/javascript">
 alert("<%=msg%>");
 <%if(request.getAttribute("href")!=null&&request.getAttribute("href").equals("back")==false){ href = request.getAttribute("href").toString();%>
	 location.href="<%=request.getContextPath() %>/<%=href%>";
 <%}else if(request.getAttribute("href").equals("back")==true){%>
	 location.href="javascript:history.go(-1);";
 <%}%>
</script>
<%} %>

<!-- coins_new  -->
<script type="text/javascript">
var isOver = 0;
function showSub(cur){
 for(i=1; i<=9; i++) {
  //加if判断防止由于疏忽遗漏ID或错定义ID导致脚本出错，下同
  if(document.getElementById("sub_"+[i]) != null){
   document.getElementById("sub_"+[i]).style.display='none';
  }
 }
 if(document.getElementById("sub_"+cur)!=null) {
  document.getElementById("sub_"+cur).style.display='block';
 }
 isOver = 1;
}
function isOut(){
 for(i=1; i<=9; i++) {
  if(document.getElementById("sub_"+[i]) != null && isOver == 0){
   document.getElementById("sub_"+[i]).style.display='none';
  }
 }
}
function hideSub(){
 isOver = 0;
 window.setTimeout("isOut()",1000); 
}
</script>
<!-- coins_new nav -->
<div id="head">
  <div class="head">
    <div class="menu"><a href="#" onmouseover="showSub(1)" onmouseout="hideSub()"><img src="coins_new/img/meun.jpg" width="22" height="14" /></a></div>
    <div class="logo"><a href="index.do"><img src="coins_new/img/logo.jpg" width="97" height="27" /></a></div>
    <div id="menu_colum_nav"><ul>
    <a href="index.do?usercenter"><li>用户中心</li></a>
    <%if(session.getAttribute("globaluser")==null){ %>
    <a href="index.do?Login"><li>登录</li></a><a href="reg.jsp"><li>注册</li></a>
    <%}else{ 
    Btc_user user=(Btc_user)session.getAttribute("globaluser");
    String name=user.getUusername();
    if(name.length()>14)name=name.substring(0,14)+"..";
    %>
    <a href="index.do?userdetail"><li><%=name %></li></a><a href="index.do?logout"><li>安全退出</li></a>
    <%} %>
    </ul></div>
  </div>
  <div class="menu_x">
    <div id="sub_1" onmouseover="showSub(1)" onmouseout="hideSub()" style="display:none;">
    <!-- coin list -->
    <%if(session.getAttribute("stock_map_navigation")!=null){
	Map<String, NaviStockModel> stock_map_navigation = (Map<String, NaviStockModel>) session.getAttribute("stock_map_navigation");
	Iterator it = stock_map_navigation.keySet().iterator();
	int i=1;
	while(it.hasNext()){
	String key=(String)it.next();
	NaviStockModel bstock = (NaviStockModel)stock_map_navigation.get(key);%>
<dl <%if(i%5==1){ %>style="margin-left:0px;"<%} %>>
     <a href="index.do?stock&stockId=<%=bstock.getId()%>">
     <dt><img src="<%=bstock.getImgsrc() %>" width="40" height="40" /></dt>
     <dd><%=bstock.getName() %>(<%=bstock.getEngName() %>)<br />
       <span style="color:#d80000;">CNY<%=format.trans(bstock.getNewsprice()) %></span><span id="<%=format.num2color(bstock.getZdf())%>">(<%=format.num2percent(bstock.getZdf())%>%)</span></dd>
     </a>
   </dl>
	<%	i++;}}%>
    </div>
  </div>
</div>

<%
	String url = request.getRequestURI();
	if (request.getQueryString() != null)
		url += "?" + request.getQueryString();
%>
<script>
window.onload=function(){
	<%if(url.indexOf("stock")!=-1){%>
	sendRequest(); 
	<%}%>
	<%if(url.indexOf("factory")!=-1){%>
	check(); 
	<%}%>
	count_top=stockids.length;
	getTopData(stockids[0]);
}
</script>
