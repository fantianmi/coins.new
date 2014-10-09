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
	        $("#ddz").addClass('selected');
	    });
	 </script>
	<script type="text/javascript">
	    $(document).ready(function() {
	        $("#tluckwheel").addClass('active');
	    });
	 </script>
	 <!-- data load -->
	 <script type="text/javascript">
function ingame(){
	var hamount = document.getElementById('hamount').value;
	if(hamount==''){
		alert('请输入转入金额')
		return false;
	}
    document.getElementById('myForm').action = "game.do?ingrade";
    document.getElementById("myForm").submit();
}

function outgame(){
	if(document.getElementById('gamount').value==''){
		alert('请输入转出金额')
		return false;
	}
    document.getElementById('myForm').action = "game.do?outgrade";
    document.getElementById("myForm").submit();
}

</script>
<script type="text/javascript"> 
var XMLHttpReq;
function createXMLHttpRequest() {
	if(window.XMLHttpRequest) { 
		XMLHttpReq = new XMLHttpRequest();
	}else if(window.ActiveXObject) { 
	try {
		XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {}
		}
	}
}	
function sendRequest() {
		createXMLHttpRequest();
		var url = 'game.do?checkyue&n='+ Math.random();
		XMLHttpReq.open("GET", url, true);
		XMLHttpReq.onreadystatechange = processResponse;
		XMLHttpReq.send(null);  
}
function processResponse() {
if (XMLHttpReq.readyState == 4) {
	if (XMLHttpReq.status == 200) {
		showmsg();
		setTimeout("sendRequest()", 5000);
		}
	}
}
function showmsg() {
	var msg = xmlHttp.responseXML.getElementsByTagName("msg")[0].firstChild.nodeValue;
	var href = xmlHttp.responseXML.getElementsByTagName("href")[0].firstChild.nodeValue;
	if(msg!='nomsg'){
		window.alert(msg);
		if(href!='nohref'){
			window.location.href=href;
		}
	}
}


window.onload=function(){
	sendRequest(); 
}
		  
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
		<h2 style="margin-top:50px; margin-bottom:0px;color:#0171C7;font-weight: bold;">开心斗地主</h2>    
        <div class="alert-msg info">玩游戏前请首先往游戏帐户中充入游戏积分，1游戏积分=1<%=dres.getString("game.stock.name") %>，保证帐户中至少有100游戏积分<span style="color:#F00">（2倍房间最低进入积分100，10倍房间最低进入积分500，20倍最低进入积分1000）</span>（支持随时转出），转入后登陆游戏大厅（账号密码跟平台账号密码一致），点击开始游戏即可进入等待，如果这时候有至少2人也加入了游戏即可开始</div>
		</div>
		<div style="margin-left: 40px; padding-top: 5px;">
        <!-- alert row -->
        <!-- table row -->
        <form id="myForm" method="post">
    <%
    int gameyue=0;
    BigDecimal accountyue = new BigDecimal(0);
    if(request.getAttribute("gamemodel")!=null){
    	GameModel gm = (GameModel)request.getAttribute("gamemodel");
    	gameyue = gm.getGameYue();
    	accountyue = gm.getAccountyue();
    } %>
    <div id="ddzdetail">
    <table>
    <tbody>
    <tr>
    <th>游戏积分</th><td><span class="normal-color"><%=gameyue %></span></td>
    <th>账户<%=dres.getString("game.stock.name") %>余额</th><td><span class="normal-color"><%=accountyue %></span></td>
    </tr>
    <tr>
    <th>转入积分</th><td><span class="one_half first"><input type="text" name="hamount" id="hamount" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></span>
    <span class="one_half"><input type="button" onclick="ingame()" value="转入" class="btn small blue"></span></td>
    <th>转出积分</th><td><span class="one_half first"><input type="text" name="gamount" id="gamount" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></span>
    <span class="one_half"><input type="button" onclick="outgame()" value="转出" class="btn small blue"/></span></td>
    </tbody>
    </table>
    </form>      
    <p>
      <%String roomName = request.getAttribute("ddz").toString(); %>
    <h2 style="margin-bottom:0px;color:#0171C7;font-weight: bold;">房间列表：(当前房间：<%=format.transDDZroom(roomName) %>)</h2>
    <ul class="list tagcloud" ><li><a href="game.do?room=1">两倍房间</a></li><li><a href="game.do?room=5">十倍房间</a></li><li><a href="game.do?room=10">二十倍房间</a></li></ul></p>
      <%if(request.getAttribute("yuebuzu")==null){%>
      <div>
      <iframe src="http://s-136124.gotocdn.com:8888/<%=roomName %>" name="cjsj" width="100%" marginwidth="0" height="700" marginheight="0" align="top" scrolling="Auto" frameborder="0"></iframe>
      </div>
      </div>
      <%}else{%>
      <div class="alert-msg warning">您的游戏积分不足，请至少转入<%=format.transDDZ2Grede(roomName) %><%=dres.getString("game.stock.name") %>作为游戏基础积分</div>
      <%} %>
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
