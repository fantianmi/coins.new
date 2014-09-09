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
	 <!-- form validate -->
	<!-- validate -->
	<script type="text/javascript">
	    $(document).ready(function() {
	        $("#register2").addClass('selected');
	    });
	 </script>
	<script type=text/javascript>
	$(function(){
		$('#btc_nav li').hover(function(){
			$(this).children('ul').stop(true,true).show('slow');
		},function(){
			$(this).children('ul').stop(true,true).hide('slow');
		});
		
		$('#btc_nav li').hover(function(){
			$(this).children('div').stop(true,true).show('slow');
		},function(){
			$(this).children('div').stop(true,true).hide('slow');
		});
	});
	</script>
	<script>
	function doRegister2(){
		var username=document.getElementById("uusername").value;
		var uemail=document.getElementById("uemail").value;
		if(!checkEmail(uemail)||!checkPassword()||!checkRePassword()||!checkUserName(username)){
			alert("请准确填写注册信息");
			return false;
		}
		submitForm2('form1');
	}
	
	</script>
</head>
<body>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<div class="wrapper row3">
  <div id="container" style="padding: 0px 0px;">
  <jsp:include page="/include/lpanel.jsp"></jsp:include>
      <section class="clear">
      <div style="margin-left: 40px; padding-top: 5px;border-bottom: 5px solid #0171C7;" id="usercenter">
		<h2 style="margin-top:50px; margin-bottom:0px;color:#0171C7;font-weight: bold;">账户安全性提升</h2>    
        <!-- form row -->
        <script src="yanzheng/jquery-1.4.4.min.js" type="text/javascript"></script>
		<script src="yanzheng/formValidatorRegex.js" type="text/javascript"></script>
		<script src="yanzheng/formValidator-4.1.1.min.js" type="text/javascript"></script>
		<script src="yanzheng/formValidator-4.1.1.js" type="text/javascript"></script>
		<script type="text/javascript">
		$(document).ready(function(){
		    $.formValidator.initConfig({formID:"form1",mode:'AlertTip',onError:function(msg){alert(msg)}});
		    $("#kaptcha").formValidator().inputValidator({min:4,onError:"验证码不能为空"});
		    $("#uname").formValidator().inputValidator({min:4,onError:"用户名至少4位"});
		    $("#utpassword").formValidator().inputValidator({min:1,onError:"密码不能为空,请确认"});
		    $("#password2").formValidator().inputValidator({min:1,onError:"重复密码不能为空,请确认"}).compareValidator({desID:"utpassword",operateor:"=",onError:"2次密码不一致,请确认"});
		    $("#ucertification").formValidator().functionValidator({fun:isCardID});
		    $("#uphone").formValidator({empty:true}).inputValidator({min:11,max:11,onError:"手机号码必须是11位的,请确认"}).regexValidator({regExp:"mobile",dataType:"enum",onError:"你输入的手机号码格式不正确"});;
		    $("#ucertification").attr("disabled",false).unFormValidator(false);
		});
		</script>
        <form id="form1" action="register.do?promote">
        <input type="hidden" value="<%=res.getString("host.country")%>身份证" name="ucertificationcategory"/>
        	<div class="alert-msg rnd8 warning">温馨提示，您的身份信息一经提交您自己将无法修改，请仔细核对填写<a class="close" href="javascript:void(0)">X</a></div>
        	<div class="form-input clear">
          	<label class="one_half first" for="uname">真实姓名 <span class="required">*</span><br>
	  		<input type="text" size="22" name="uname" id="uname" 
	  		onkeyup="value=value.replace(/[^/u4E00-/u9FA5]/g,'')" 
onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^/u4E00-/u9FA5]/g,''))" 
	  		placeholder="请填写您的真实姓名，我们会人工进行审核" />
            </label>
            </div>
            <div class="form-input clear">
          	<label class="one_half first" for="password1">交易密码<span class="required">*</span><br>
  			 <input type="password" size="22" id="utpassword" name="utpassword" placeholder="请输入您的交易密码" />
            </label>
            </div>
            <div class="form-input clear">
          	<label class="one_half first" for="password2">重复密码<span class="required">*</span><br>
  			 <input type="password" size="22" id="password2" name="password2" placeholder="请输入您的交易密码" />
            </label>
            </div>
            <div class="form-input clear">
          	<label class="one_half first" for="sfzh">身份证号<span class="required">*</span><br>
	  		<input type="text" size="22" id="ucertification" name="ucertification" placeholder="请输入您真实身份证信息，我们会人工进行审核" />
            </label>
            </div>
            <div class="form-input clear">
              <label class="one_half first"><br>
              <input type="button" name="button" id="button" class="button small blue" value="提交" onclick=""/>
            </div>
		</form>
        <!-- form row -->
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
