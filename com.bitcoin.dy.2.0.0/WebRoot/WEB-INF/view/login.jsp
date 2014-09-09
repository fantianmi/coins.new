<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
<%List<Btc_content> newslist = (List<Btc_content>)session.getAttribute("newslist");%>   

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
<title>现在登录<%=res.getString("host.title")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="imagetoolbar" content="no" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<!-- ######################################################## -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="resource_new/layout/styles/main.css" rel="stylesheet" type="text/css" media="all">
<link href="resource_new/layout/styles/mediaqueries.css" rel="stylesheet" type="text/css" media="all">
<link href="resource_new/style/jquery.jslides.css" rel="stylesheet" type="text/css">

<!--[if lt IE 9]>
<link href="resource_new/layout/styles/ie/ie8.css" rel="stylesheet" type="text/css" media="all">
<script src="resource_new/layout/scripts/ie/css3-mediaqueries.min.js"></script>
<script src="resource_new/layout/scripts/ie/html5shiv.min.js"></script>
<![endif]-->
<!-- ######################################################## -->
<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
<link href='styles/style.css' type='text/css' rel='stylesheet' />
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
<!-- ######################################################## -->
<script type="text/javascript">      
 $(function(){           
     $('#kaptchaImage').click(function () {//生成验证码  
      $(this).hide().attr('src', 'general.do?captcha-image?' + Math.floor(Math.random()*100) ).fadeIn(); })      
           });   
 
</script> 

</head>

<body>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<!-- content -->
<div class="wrapper row3">
  <div id="container">
    <!-- ################################################################################################ -->
    <div id="contact" class="clear">
      <div class="one_half first">
        <h1>欢迎回来</h1>
        <p>请输入您平台注册的用户名及密码，如果您忘记密码可以点击这里<a href="index.do?findpass&type=upass">找回密码</a></p>
        <div id="respond">
        <form method="post" action="vertify.do" class="rnd5">
            <div class="form-input clear">
              <label class="one_half first" for="uusername">用户名 <span class="required">*</span><br>
                <input type="text" name="uusername" placeholder="您的网站登录用户名" id="uusername" value="" size="15">
              </label>
            </div>
            <div class="form-input clear">
              <label class="one_half first" for="upassword">密码 <span class="required">*</span><br>
                <input type="password" name="upassword" id="upassword" value="" size="22">
              </label>
              
            </div>
            <div class="form-input clear">
              <label class="one_half first" for="kaptcha">验证码 <span class="required">*</span><br>
                <input type="text" name="kaptcha" placeholder="请输入验证码" id="kaptcha" value="" size="22" style="width:100px;">
                <div style="width:100px; float:left; padding-left:20px;">
                <img src="general.do?captcha-image" width:"200px"  id="kaptchaImage"/>
                </div>
              </label>
            </div>
            <div class="form-input clear">
              <label class="one_half first" for="email"><br>
              <input type="submit" value="确认登录"></label>
             </div>
          </form>
        </div>
      </div>
      <div class="one_half">
        <section class="contact_details clear">
          <h2>如果您没有账号怎么办？</h2>
          <p>欢迎注册造币网交易中心，现在注册成为造币网会员，可以领取平台自有币赠送，作为平台用户终身分红凭证，注册后还可以进行平台造币兑换以及参与平台推广之后推出的铸币以及在线交易</p>
          <p></p>
          <section class="calltoaction opt2 clear">
          <div class="one_quarter first"><a href="index.do?Register" class="button large gradient blue">注册</a></div>
          <div class="three_quarter">
            <h1>现在就成为我们的会员吧！</h1>
            <p>给您最优秀的用户体验，最安全的交易保障!</p>
          </div>
        </section>
        <<jsp:include page="/include/address.jsp" /></jsp:include>
        </section>
      </div>
    </div>
    <!-- ################################################################################################ -->
    <div class="clear"></div>
  </div>
</div>
<!-- ####################################################################################################### -->
<jsp:include page="/include/foothtml.jsp"></jsp:include>
</div>
</body>
</html>

