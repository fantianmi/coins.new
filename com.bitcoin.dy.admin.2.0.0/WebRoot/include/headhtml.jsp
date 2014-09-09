<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.mvc.entity.*" %>
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
<div class="header">
    <a class="logo" href="index.dol"><img src="img/logo.png" alt="Aquarius -  responsive admin panel" title="Aquarius -  responsive admin panel"/></a>
    <ul class="header_menu">
        <li class="list_icon"><a href="#">&nbsp;</a></li>
    </ul>    
</div>

