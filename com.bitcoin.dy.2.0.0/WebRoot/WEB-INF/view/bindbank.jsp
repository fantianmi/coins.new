<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="com.mvc.util.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
<%
FormatUtil format = new FormatUtil();
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/";
Btc_user user = new Btc_user();
if(session.getAttribute("globaluser")!=null){
user = (Btc_user)session.getAttribute("globaluser");
}
%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
	<title><%=res.getString("host.title")%></title>
	<jsp:include page="/include/htmlsrc.jsp" ></jsp:include>
	<!-- coins_new -->
  <link href="coins_new/css/zy.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="script/geo.js"></script>
	<script type="text/javascript" src="script/data.js"></script>
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
     <script type="text/javascript">
		    $(document).ready(function() {
		        $("#bankmanage").addClass('selected');
		    });
	</script>
</head>
<body>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<jsp:include page="/include/nav.jsp" ></jsp:include>
 <div class="box2"> 
  <jsp:include page="/include/lpanel.jsp" ></jsp:include>
  <div class="user_r">
    <div class="u_r_t">
      <div class="u_r_t_l">添加银行信息</div>
      <!--<div class="u_r_t_r">您当前的资金估值为：<b style="font-size:14px; color:red;">0.00</b> 元人民币。 人民币余额：<b style="font-size:14px; color:red;">0.00 元</b></div>--> 
    </div>
<script type="text/javascript" src="script/geo.js"></script>
<script type="text/javascript" src="script/data.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
    	setup();
    	preselect('北京市');
    	promptinfo();
    });
</script>
<script src="js/jquery-1.4.4.min.js" type="text/javascript"></script>
<script src="js/formValidator-4.1.1.js" type="text/javascript" charset="UTF-8"></script>
<script src="js/formValidatorRegex.js" type="text/javascript" charset="UTF-8"></script>
<script language="javascript" src="js/DateTimeMask.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
	$.formValidator.initConfig({formID:"bindbankform",mode:'AlertTip',onError:function(msg){alert(msg)}});
	$("#utpassword").formValidator().inputValidator({min:5,onError:"密码不能为空,请确认"});
	$("#depositbank").formValidator().inputValidator({min:5,onError:"开户行不能为空,请确认"});
	$("#card").formValidator().inputValidator({min:5,onError:"卡号不能为空,请确认"});
});
</script>

    <div class="user1">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:15px;">
      <form action="bank.do?add" method="post" id="bindbankform">
        <tr>
          <td height="35" align="right" valign="middle" style="font-weight:bold; color:#333;">交易密码：</td>
          <td><input name="utpassword" id="utpassword"  type="text" style="width:200px; height:25px; line-height:25px; color:#666; border:1px solid #ddd;" />
            请输入您设置的交易密码 </td>
        </tr>
         <tr>
          <td height="35" align="right" valign="middle" style="font-weight:bold; color:#333;">提现银行：</td>
          <td><select name="bankname" id="bankname">
                <option value="未填写">请选择银行</option>
                <option value="中国银行">中国银行</option>
                <option value="邮政储蓄">邮政储蓄</option>
                <option value="工商银行">工商银行</option>
                <option value="农业银行">农业银行</option>
                <option value="交通银行">交通银行</option>
                <option value="广东发展银行">广东发展银行</option>
                <option value="深圳发展银行">深圳发展银行</option>
                <option value="建设银行">建设银行</option>
                <option value="上海浦东发展银行">上海浦东发展银行</option>
                <option value="上海浦发银行">上海浦发银行</option>
                <option value="浙江泰隆商业银行">浙江泰隆商业银行</option>
                <option value="招商银行">招商银行</option>
                <option value="中国民生银行">中国民生银行</option>
                <option value="兴业银行">兴业银行</option>
                <option value="重庆银行">重庆银行</option>
                <option value="中国光大">中国光大</option>
            </select></td>
        </tr>
         <tr>
          <td height="35" align="right" valign="middle" style="font-weight:bold; color:#333;">开户地区：</td>
          <td><select class="select" name="province" id="s1">
		          <option></option>
		        </select>
          <select class="select" name="city" id="s2">
		          <option></option>
		        </select></td>
        </tr>
         <tr>
          <td height="35" align="right" valign="middle" style="font-weight:bold; color:#333;">开户城市：</td>
          <td><select class="select" name="town" id="s3">
		          <option></option>
		        </select></td>
        </tr>
         <tr>
          <td height="35" align="right" valign="middle" style="font-weight:bold; color:#333;">开户行：</td>
          <td><input name="depositbank" id="depositbank" type="text" style="width:200px; height:25px; line-height:25px; color:#666; border:1px solid #ddd;" />
           请勿重复填写银行名称与省市，只需填写具体支行名称。</td>
        </tr>
        <tr>
          <td height="35" align="right" valign="middle" style="font-weight:bold; color:#333;">收款人姓名：</td>
          <td><inputname="name" id="name" value="<%=user.getUname() %>"  type="text"  style="width:100px; height:25px; line-height:25px; color:#666; border:1px solid #ddd;" />
            不能修改，平台注册时候已经填写 

</td>
        </tr>
        <tr>
          <td height="35" align="right" valign="middle" style="font-weight:bold; color:#333;">提现账号（卡号）：</td>
          <td><input name="card" id="card"   type="text" style="width:200px; height:25px; line-height:25px; color:#666; border:1px solid #ddd;" />
            只能是数字，请勿加空格 </td>
        </tr>
        <tr>
          <td height="35">&nbsp;</td>
          <td><input id="submitbutton" type="submit"  value="确认添加" style="margin-top:15px; font-family:微软雅黑; color:#333; padding:0px 10px; font-size:12px;" /></td>
        </tr>
        </form>
      </table>
      <div class="reset1" style="margin-top:10px;">如果您充值后24小时未到账或未填付款说明，请发付款信息到:<b> d-wang@yeah.net</b> 。我们会有专人为您处理。<br />

<span style="color:red;">注意：添加之后就不能修改，请准确填写，您填写的信息会经过我们人工审核，并在24小时之内与您本人再次确认，审核通过之后 方可在提现时候使用</span></div>
<div class="reset1" style="margin-top:10px;"><img src="img/banks.png" width="804" /></div>
    </div>
  </div>
</div>
<jsp:include page="/include/foothtml.jsp"></jsp:include>
</div>
</body>
</html>
