<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="com.mvc.util.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
<%ResourceBundle stockres = ResourceBundle.getBundle("stock"); %>  
<%
FormatUtil format = new FormatUtil();%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
	<title><%=res.getString("host.title")%></title>
	<jsp:include page="/include/htmlsrc.jsp" ></jsp:include>
	<script type="text/javascript">
	  $(document).ready(function() {
	      $("#tfactory").addClass('active');
	  });
	</script>
	<script language="JavaScript" type="text/javascript" src="form/ajaxsubmit.js"></script>
    <script type="text/javascript">
     function check(){
    	 var bflag = '<%=request.getAttribute("bflag").toString()%>';
    	 if(bflag=="building"){
    		 document.getElementById("joinbuildBtn").setAttribute("disabled", true);
    		 document.getElementById("joinbuildBtn").value = '您已存款';
    	 }
     }
     function caculatelx(){
    	 var stockyue=document.getElementById("stockyue").innerHTML;
    	 var putamount=document.getElementById("putamount").value;
    	 if(stockyue-putamount<0){
    		 alert("请输入小于"+stockyue+"的金额");
    	 }
    	 document.getElementById("putamount").value=putamount.replace(/[^\d.]/g,'');
    	 document.getElementById("lixishow").innerHTML=putamount*0.005;
     }
     function doJoin(){
    	 var stockyue=document.getElementById("stockyue").innerHTML;
    	 var putamount=document.getElementById("putamount").value;
    	 if(stockyue-putamount<0){
    		 alert("请输入小于"+stockyue+"的金额");
    		 return false;
    	 }
    	 submitForm2('joinForm');
     }
    </script>
    <script type="text/javascript" src="form/factory.js"></script>
</head>
<body>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
	<!-- ######################################################## -->
	<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
	<link href='styles/style.css' type='text/css' rel='stylesheet' />
		<script type="text/javascript">
		    $(document).ready(function() {
		        $("#factory").addClass('selected');
		    });
		 </script>
	<!-- else process -->
	<%
	Btc_user user = new Btc_user();
	if(session.getAttribute("globaluser")!=null){
		user = (Btc_user)session.getAttribute("globaluser");
		}
		%>
	<script type="text/javascript">
		var msg = null;
		function sendmsg() {
			if (window.XMLHttpRequest) {
				msg = new XMLHttpRequest();
			} else if (window.ActiveXObject) {
				msg = new ActiveXObject("Microsoft.XMLHTTP");
			}
			if (msg != null) {
				var tel = '<%=user.getUphone()%>';
				var url = 'msg.do?sendforpost&n=' + Math.random();
				msg.onreadystatechange = showmsg;
				msg.open("GET", url, true);
				msg.send(null);
			}
		}
	</script>
<div class="wrapper row3">
  <div id="container" style="padding: 0px 0px;">
  <jsp:include page="/include/lpanel.jsp"></jsp:include>
      <section class="clear">
      <div style="margin-left: 40px; padding-top: 5px;border-bottom: 5px solid #0171C7;" id="usercenter">
		<h2 style="margin-top:50px; margin-bottom:0px;color:#0171C7;font-weight: bold;"><%=res.getString("host.small.title")%>银行</h2>    
		<%
         Btc_factory bf = new Btc_factory();
         if(request.getAttribute("bfconfig")!=null){
         	bf = (Btc_factory)request.getAttribute("bfconfig");
         }
         %>
         </div>
         <div style="margin-left: 40px; padding-top: 5px;" id="usercenter">
         <!-- div 1 row -->
         <div class="alert-msg warning" id="alert">
	       <p><span class="important">重要</span>利息发放说明：系统每周日进行一次利息发放，用户需每周进行一次申请存币操作，如不申请则无法获得利息。</p>
	       <%if(request.getAttribute("build")!=null){
	      	 Btc_join_build bjb = (Btc_join_build)request.getAttribute("build");%>
	      	 <p>您已经申请存款，请等待系统利息发放。</p>
	       	 <p>存款时间：<%=bjb.getDate() %> ，存款金额：<%=format.trans(bjb.getAmount()) %><%=stockres.getString("stock.factory.name") %></p>
	       <%} %>
	       </div>
	       <div class="alert-msg warning" id="alert">用户存币：用户在证券币银行申请存款时确认的证券币数量，最少拥有5000个证券币才能参与存款，拥有证券币越多，产生的利息越多，每周一为证券银行开放存币日，需要存币的用户当天任何时候进行可申请存币。</div>
         <!-- div 1 row -->
         <div class="clear"></div>
         <!-- div 2 row -->
         <form action="factory.do?joinbuild" id="joinForm" name="joinForm">
         <table style="margin:0px;text-align: left;border:none;">
         <tbody>
         <tr>
         <td style="margin:0px;text-align: left;" colspan="2">您的余额:<span id="stockyue"><%=request.getAttribute("stockyue").toString() %></span><%=stockres.getString("stock.factory.name") %></td>
         </tr>
         <tr>
         <td style="margin:0px;text-align: left;width:200px"><input type="text" name="putamount" id="putamount" onkeyup="caculatelx()" placeholder="请输入存款金额（<%=stockres.getString("stock.factory.name")%>）"/></td><td style="margin:0px;text-align: left;"><input type="button" class="button small blue" id="joinbuildBtn" onclick="doJoin();" value="存款" style="width:120px"></td>
         </tr>
         <tr>
         <td style="margin:0px;text-align: left;" colspan="2">定期:7天</td>
         </tr>
         <tr>
         <td style="margin:0px;text-align: left;" colspan="2">预计获得利息：<span id="lixishow"></span></td>
         </tr>
         <tbody>
         </table>
         </form>
          <p>&nbsp;</p>
			<p>用户存款数/100000×500=高额人民币利息：</p>
			<ul class="list tick">
			<li>5000/100000×500=25RMB        （周息）</li>
			<li>5000/100000×500=100RMB       （月息）</li>
			<li>5000/100000×500=1200RMB      （年息）</li>
			</ul>
         <!-- div 2 row -->
         <div class="clear"></div>
        <!-- table row -->
        <h1> 存款记录</h1>
        <table>
        <thead>
         <tr>
         <th>日期</th><th>存入金额</th><th>预计获得利息</th><th>状态</th>
         </tr>
         </thead>
         <tbody>
         <%if(request.getAttribute("buildlog")!=null){
        	 List<Btc_join_build> list = (List<Btc_join_build>)request.getAttribute("buildlog");
        	 Btc_join_build bjb = new Btc_join_build();
        	 for(int i=0;i<list.size();i++){
        		 bjb = list.get(i);%>
        		 	<tr>
           <td><%=bjb.getDate() %></td><td><%=format.trans(bjb.getAmount()) %><%=stockres.getString("stock.factory.name") %></td><td><%=format.trans(bjb.getAmount().multiply(new BigDecimal(0.005))) %>RMB</td>
           <td><%=format.transfactory(bjb.getStatus()) %></td>
           </tr>
        	 <%}
         } %>
         </tbody>
         </table>
        <!-- table row -->
        </div>
      </section>
      </div>
    </div>
    </td></tr>
</table>
    <div class="clear"></div>
  </div>
</div>

<jsp:include page="/include/foothtml.jsp"></jsp:include>
</div>
</body>
</html>
