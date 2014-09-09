<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  

 <div class="one_half first">
   <address>
 	 <%=res.getString("host.small.title") %>官方QQ群： <br>
 	 <ul class="list tagcloud">
 	 <li class="one_half first"><%=res.getString("host.qq.group1") %></li>
 	  <li class="one_half"><%=res.getString("host.qq.group2") %></li>
 	  <li class="one_half first"><%=res.getString("host.qq.group3") %></li>
 	  <li class="one_half"><%=res.getString("host.qq.group4") %></li>
 	  <li class="one_half first"><%=res.getString("host.qq.group5") %></li>
 	 </ul>
   </address>
 </div>
 <div class="one_half">
      <ul class="list none">
        <li>电话: <%=res.getString("host.tel")%></li>
        <li>传真: <%=res.getString("host.tel")%></li>
        <li>邮箱: <a href="#"><%=res.getString("host.mail")%></a></li>
      </ul>
    </div>