<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%Map<String,Btc_content> indexmap = (Map<String,Btc_content>)session.getAttribute("indexmap"); %>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
<%
int uid=0;
String uname = "无";
String email = "无";
String ucid = "无";
int recomand=0;
String role = "平台会员";
String emailstatus = "发送激活邮件";
String date = "";
String rget = "";
if(request.getAttribute("userdetail")!=null){
	Btc_user user = (Btc_user)request.getAttribute("userdetail");
	uid = user.getUid();
	if(user.getUname()!=null)
		uname = user.getUname();
	if(user.getUemail()!=null)
		email = user.getUemail();
	if(user.getRecommend()!=0)
		recomand = user.getRecommend();
	if(user.getUcertification()!=null){
		ucid = user.getUcertification();
		String end = ucid.substring(ucid.length()-4,ucid.length());
		ucid = "**************"+end;
	}
	if(user.getUstatus().equals("active")){
		emailstatus = "已激活";
	}
	if(user.getUrole().equals("admin")){
		role = "管理员";
	}
	if(user.getRget()!=null){
		rget = user.getRget();
	}
	date = user.getUsdtime();
}
%>
<head profile="http://gmpg.org/xfn/11">
	<title><%=res.getString("host.title")%></title>
	<jsp:include page="/include/htmlsrc.jsp" ></jsp:include>
		<!-- coins_new -->
  <link href="coins_new/css/zy.css" rel="stylesheet" type="text/css" />
</head>
  <body>
  <script type="text/javascript">
    $(document).ready(function() {
        $("#gerenziliao").addClass('selected');
    });
 </script>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<jsp:include page="/include/nav.jsp" ></jsp:include>
 <div class="box2"> 
  <jsp:include page="/include/lpanel.jsp" ></jsp:include>
  <div class="user_r">
    <div class="u_r_t">
      <div class="u_r_t_l">完整资料</div>
    </div>
    <div class="user1">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:15px;font-size:12px">
        <tr>
          <td height="35" align="right" style="color:#333; font-weight:bold;">真实姓名：</td>
          <td style="padding-left:10px;"><%=uname %></td>
        </tr>
        <tr>
          <td height="35" align="right" style="color:#333; font-weight:bold;">注册邮箱：</td>
          <td style="padding-left:10px;"><%=email %> <%if(!emailstatus.equals("已激活")){%><a href="javascript:sendmail();" style="color:red;"><%=emailstatus%></a><%}%></td>
        </tr>
        <tr>
          <td height="35" align="right" style="color:#333; font-weight:bold;">身份证号码：</td>
          <td style="padding-left:10px;"><%=ucid %></td>
        </tr>
        <tr>
          <td height="35" align="right" style="color:#333; font-weight:bold;">推荐人ID：</td>
          <td style="padding-left:10px;"><%=recomand %></td>
        </tr>
        <tr>
          <td height="35" align="right" style="color:#333; font-weight:bold;">角 色：</td>
          <td style="padding-left:10px;"><%=role %></td>
        </tr>
      </table><span style="display:block; margin-top:15px; color:red; text-align:center;">注：用户资料是在实名认证时候填写，不能修改如果资料填错需要修改请联系平台客服人员！</span>
    </div>
  </div>
</div>
<script type="text/javascript">
	var xmlHttp = null;
	function getd() {
		if (window.XMLHttpRequest) {
			xmlHttp = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		if (xmlHttp != null) {
			var url = 'getD.do?&n=' + Math.random();
			xmlHttp.onreadystatechange = function() {
				if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
	//				var msgfull = xmlHttp.responseText;
	//				window.alert(msgfull);
					var msg = xmlHttp.responseXML.getElementsByTagName("msg")[0].firstChild.nodeValue;
					var href = xmlHttp.responseXML.getElementsByTagName("href")[0].firstChild.nodeValue;
					window.alert(msg);
					if(href!='nohref'){
						window.location.href=href;
					}else{
						window.location.reload();
					}
	
				}
			}
			xmlHttp.open("GET", url, true);
			xmlHttp.send(null);
		}
	}
</script>
<script type="text/javascript">
	function sendmail(){
		var url = 'mail.do?sendforactive&n='+Math.random();
		buttondo(url);
	}
</script>
<jsp:include page="/include/foothtml.jsp"></jsp:include>
</div>
</body>
</html>
