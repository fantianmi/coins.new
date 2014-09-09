<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
<%Map<String,Btc_content> indexmap = (Map<String,Btc_content>)session.getAttribute("indexmap"); 
List<Btc_content> newslistall = (List<Btc_content>)session.getAttribute("newslistall");%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
<title><%=res.getString("host.title")%></title>
<jsp:include page="/include/htmlsrc.jsp"/>
</head>
  <body>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<!-- content -->
<!-- content -->
<div class="wrapper row3">
  <div id="container">
  <div class="one_half first">
  <table>
  <thead>
  <tr>
  <th>卡号</th><th>密码</th><th>操作</th>
  </tr>
  </thead>
 	<tbody>
 	<tr><td>50010009920001</td><td>******</td><td><button onclick="" class="btn small blue">购买</button></td></tr>
 	<tr><td>50010009920001</td><td>******</td><td><button onclick="" class="btn small blue">购买</button></td></tr>
 	<tr><td>50010009920001</td><td>******</td><td><button onclick="" class="btn small blue">购买</button></td></tr>
 	<tr><td>50010009920001</td><td>******</td><td><button onclick="" class="btn small blue">购买</button></td></tr>
 	<tr><td>50010009920001</td><td>******</td><td><button onclick="" class="btn small blue">购买</button></td></tr>
 	<tr><td>50010009920001</td><td>******</td><td><button onclick="" class="btn small blue">购买</button></td></tr>
 	</tbody>
  </table>
  </div>
  <div class="one_half">
  
  </div>
    <div class="clear"></div>
  </div>
</div>
<!-- ############################################################## -->

<jsp:include page="/include/foothtml.jsp"></jsp:include>
</div>
</body>
</html>
