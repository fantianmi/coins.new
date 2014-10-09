<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="com.mvc.util.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
	<title><%=res.getString("host.title")%></title>
	<jsp:include page="/include/htmlsrc.jsp" ></jsp:include>
		<!-- coins_new -->
  <link href="coins_new/css/zy.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript">
		    $(document).ready(function() {
		        $("#register2").addClass('selected');
		    });
		 </script>
	 <!-- form validate -->
</head>
<body>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<jsp:include page="/include/nav.jsp" ></jsp:include>
 <div class="box2"> 
  <jsp:include page="/include/lpanel.jsp" ></jsp:include>
    <div class="user_r">
    <div class="u_r_t">
      <div class="u_r_t_l">实名认证</div>
      <!--<div class="u_r_t_r">您当前的资金估值为：<b style="font-size:14px; color:red;">0.00</b> 元人民币。 人民币余额：<b style="font-size:14px; color:red;">0.00 元</b></div>--> 
    </div>
    <div class="user1">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:15px;">
        <input type="hidden" value="<%=res.getString("host.country")%>身份证" name="ucertificationcategory"/>
        <tr>
          <td width="37%" height="35" align="right" style="color:#333; font-weight:bold;">真实姓名：</td>
          <td width="63%" style="padding-left:10px;"><input  name="realName" id="realName" 
	  		onkeyup="value=value.replace(/[^/u4E00-/u9FA5]/g,'')" 
onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^/u4E00-/u9FA5]/g,''))" 
	  		placeholder="请填写您的真实姓名，我们会人工进行审核"  type="text" style="width:200px; height:25px; line-height:25px; color:#666; border:1px solid #ddd;" /></td>
        </tr>
        <tr>
          <td width="37%" height="35" align="right" style="color:#333; font-weight:bold;">再次输入真实姓名：</td>
          <td width="63%" style="padding-left:10px;"><input  name="realName2" id="realName2" 
	  		onkeyup="value=value.replace(/[^/u4E00-/u9FA5]/g,'')" 
onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^/u4E00-/u9FA5]/g,''))" 
	  		placeholder="请再次输入您的真实姓名"  type="text" style="width:200px; height:25px; line-height:25px; color:#666; border:1px solid #ddd;" /></td>
        </tr>
        <tr>
          <td height="35" align="right" style="color:#333; font-weight:bold;">交易密码：</td>
          <td style="padding-left:10px;"><input id="upassword" name="upassword" placeholder="请输入您的交易密码"  type="password" style="width:200px; height:25px; line-height:25px; color:#666; border:1px solid #ddd;" /></td>
        </tr>
        <tr>
          <td height="35" align="right" style="color:#333; font-weight:bold;">重复密码：</td>
          <td style="padding-left:10px;"><input id="passWordAgain" name="passWordAgain" placeholder="请再次输入您的交易密码" type="password" style="width:200px; height:25px; line-height:25px; color:#666; border:1px solid #ddd;" /></td>
        </tr>
        <tr>
          <td height="35" align="right" style="color:#333; font-weight:bold;">身份证号：</td>
          <td style="padding-left:10px;"><input id="identityNo" name="identityNo" placeholder="请输入您真实身份证信息，我们会人工进行审核"  type="text" style="width:200px; height:25px; line-height:25px; color:#666; border:1px solid #ddd;" /></td>
        </tr>
        <tr>
          <td height="35" align="right" style="color:#333; font-weight:bold;">角 色：</td>
          <td style="padding-left:10px;">平台会员</td>
        </tr>
        <tr>
          <td colspan="2"  style="text-align: center"><input type="button"  value="提交" onclick="validateIdentity();"/></td>
        </tr>
      </table><span style="display:block; margin-top:15px; color:red; text-align:center;">注：用户资料是在实名认证时候填写，不能修改如果资料填错需要修改请联系平台客服人员！</span>
    </div>
  </div>
</div>
<jsp:include page="/include/foothtml.jsp"></jsp:include>
</body>
</html>
