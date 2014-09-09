<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="com.mvc.util.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
<%ResourceBundle dres = ResourceBundle.getBundle("ddz"); %>  
<%
FormatUtil format = new FormatUtil();
%>
<%
String basePath = request.getScheme()+"://"+request.getServerName();
%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
	<title><%=res.getString("host.title")%></title>
	<jsp:include page="/include/htmlsrc.jsp" ></jsp:include>
	<script type="text/javascript">
	    $(document).ready(function() {
	        $("#maichang").addClass('selected');
	    });
	    $(document).ready(function() {
	        $("#tluckwheel").addClass('active');
	    });
	 </script>
	 <!-- data load -->
</head>
<body>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<div class="wrapper row3">
  <div id="container" style="padding: 0px 0px;">
  <jsp:include page="/include/lpanel_g.jsp"></jsp:include>
      <section class="clear">
      <div style="margin-left: 40px; padding-top: 5px;border-bottom: 5px solid #0171C7;" id="usercenter">
		<h2 style="margin-top:50px; margin-bottom:0px;color:#0171C7;font-weight: bold;">麦田</h2>    
		</div>
		<div style="margin-left: 40px; padding-top: 5px;">
        <!-- table row -->
      <div id="respond">
      <div class="alert-msg warning" style="color:#f00">开通麦田需消耗200个新投币,每天播种一次，收获一次，麦子成熟期为8小时，成熟后有提示，超过12小时不收割，麦子将变草.</div>
      <div class="alert-msg warning">麦币全网总量800万颗，第一年产量预计200万颗，预计10年全部产出，系统将按周期自动减产，一个月后开启麦币消耗应用。麦币种子平台总投放量10万颗，每用户限制申领兑换100颗，平台所有开通麦田的用户默认为1级，每块地需要10个麦币种子，收获后需要消耗10个新投币进行翻地，麦币可以升级土地。 </div>
      	<h6 style="color:#4C7BB3;font-size: 16px;font-weight: 800">游戏区</h6>
      	<%if(request.getAttribute("open")!=null){ %>
      	<iframe src="AppleCoin.jsp" name="cjsj" width="100%" marginwidth="0" height="950" marginheight="0" align="top" scrolling="Auto" frameborder="0"></iframe>
      	<%}else{ %>
      	<div class="alert-msg warning">对不起，您暂未开通麦场，开通需要消耗200枚新投币&nbsp;&nbsp;<a href="farm.do?openfarm" class="button medium blue">立即开通</a></div>
      	<%} %>
      </div>
        <!-- table row -->
        </div>
      </section>
      </div>
    </div>
    </td></tr>
</table>
</div>
    <div class="clear"></div>
  </div>
</div>

<jsp:include page="/include/foothtml.jsp"></jsp:include>
</div>
</body>
</html>
