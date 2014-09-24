<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
<%List<Btc_content> newslist = (List<Btc_content>)session.getAttribute("newslist");%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!-- saved from url=(0070)https://vip.btcchina.com/index/login?redirect=%2Ftrade#/buysell/cnybtc
-->
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-gb" xml:lang="en-gb">
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="content-style-type" content="text/css">
        <meta http-equiv="content-language" content="en-gb">
        <meta http-equiv="imagetoolbar" content="no">
        <meta name="resource-type" content="document">
        <meta name="distribution" content="global">
        <meta name="keywords" content="">
        <meta name="description" content="">
        <title>Login</title>
        <meta content="IE=edge" http-equiv="X-UA-Compatible">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <meta content="320" name="MobileOptimized">
        <link type="text/css" rel="stylesheet" href="login/css/font-awesome.min.css">
        <link type="text/css" rel="stylesheet" href="login/css/bootstrap.min.css">
        <link type="text/css" rel="stylesheet" href="login/css/uniform.default.css">
        <link href="login/select2_metro.css" type="text/css" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="login/css/style-metronic.css">
        <link type="text/css" rel="stylesheet" href="login/css/style.css">
        <link type="text/css" rel="stylesheet" href="login/css/style-responsive.css">
        <link type="text/css" rel="stylesheet" href="login/css/plugins.css">
        <link type="text/css" rel="stylesheet" href="login/css/login.css">
        <link type="text/css" rel="stylesheet" href="login/css/custom.css">
        <link href="login/css/print.css" rel="stylesheet" type="text/css"
        media="print" title="printonly">
        <link type="text/css" rel="stylesheet" href="login/css/style2.css">
        <script type="text/javascript" src="script/coin/coincommon.js"></script>
        <script type="text/javascript" charset="UTF-8" src="login/js/logb02.js"></script>
        <script type="text/javascript" src="chrome-extension://bfbmjmiodbnnpllbbbfblcplfjjepjdn/js/injected.js"></script>
        <style>
            #haloword-pron { background: url(chrome-extension://bhkcehpnnlgncpnefpanachijmhikocj/img/icon.svg)
            -94px -34px; }#haloword-pron:hover { background: url(chrome-extension://bhkcehpnnlgncpnefpanachijmhikocj/img/icon.svg)
            -111px -34px; }#haloword-open { background: url(chrome-extension://bhkcehpnnlgncpnefpanachijmhikocj/img/icon.svg)
            -94px -17px; }#haloword-open:hover { background: url(chrome-extension://bhkcehpnnlgncpnefpanachijmhikocj/img/icon.svg)
            -111px -17px; }#haloword-close { background: url(chrome-extension://bhkcehpnnlgncpnefpanachijmhikocj/img/icon.svg)
            -94px 0; }#haloword-close:hover { background: url(chrome-extension://bhkcehpnnlgncpnefpanachijmhikocj/img/icon.svg)
            -111px 0; }#haloword-add { background: url(chrome-extension://bhkcehpnnlgncpnefpanachijmhikocj/img/icon.svg)
            -94px -51px; }#haloword-add:hover { background: url(chrome-extension://bhkcehpnnlgncpnefpanachijmhikocj/img/icon.svg)
            -111px -51px; }#haloword-remove { background: url(chrome-extension://bhkcehpnnlgncpnefpanachijmhikocj/img/icon.svg)
            -94px -68px; }#haloword-remove:hover { background: url(chrome-extension://bhkcehpnnlgncpnefpanachijmhikocj/img/icon.svg)
            -111px -68px; }
        </style>
    </head>
    
    <body id="phpbb" style="background-color: rgb(255, 255, 255);" class="section-ucp ltr">
        <div id="wrap">
            <a id="top" name="top" accesskey="t">
            </a>
            <div class="logo" style="margin: 60px auto 0;
            padding: 15px;
            text-align: center; ">
                <a href="https://vip.btcchina.com/">
                    <img alt="" src="login/img/logo-180x50.png">
                </a>
            </div>
            <div class="banner">
                <h1 style="color:#555555;width:100%;
                font-family: &#39;Open Sans&#39;,arial;
                font-size: 38px;
                margin-bottom: 15px;
                font-weight: 400;
                text-align: center;">
                </h1>
                <h2 class="hidden-small" style="color:#555555;
                margin-bottom: 15px;
                text-align: center;">
                </h2>
            </div>
            <a name="start_here">
            </a>
            <div id="page-body" style="background-color: #ffffff;">
                <!-- <script type="text/javascript">-->
                <!-- onload_functions.push('document.getElementById("username").focus();');-->
                <!-- </script>-->
                <div class="content" style="background-color: #fafafa;
                border-radius: 2px;
                box-shadow: 0 2px 2px rgba(0, 0, 0, 0.3);
                margin: 0 auto;
                padding: 20px 30px 15px;
                width: 460px;">
                    <form action="vertify.do" class="login-form" method="post" id="loginForm" autocomplete="off">
										<h2>登录</h2>
										<fieldset class="fields1">
											<div class="form-group">
												<label for="username">用户名</label>
												<div style=" border-left: 2px solid #1E90FF !important;" class="input-icon">
													<i class="icon-user"></i>
													<input type="text" tabindex="1" placeholder="用户名" name="uusername" id="uusername" size="25" value="" class="form-control placeholder-no-fix">
												</div>
											</div>
											<div class="form-group">
												<label for="password">密码</label>
												<div style=" border-left: 2px solid #1E90FF !important;" class="input-icon">
													<i class="icon-lock"></i>
													<input type="password" tabindex="2" placeholder="密码" id="upassword" name="upassword" size="25" class="form-control placeholder-no-fix">
												</div>
											</div>
																<div class="form-actions" style="-moz-border-bottom-colors: none; -moz-border-left-colors: none;-moz-border-right-colors: none;-moz-border-top-colors: none;background-color: #fafafa;border-color: -moz-use-text-color -moz-use-text-color #EEEEEE;border-image: none;border-style: none none solid;
						    border-width: 0 0 1px;
						    clear: both;
						    margin-left: -30px;
						    margin-right: -30px;
						    padding: 0 30px 25px;">
												<input type="button" name="login"  onclick="loginSubmit()" tabindex="6"  value="登录" style="" class="btn blue btn-block"><i class="m-icon-swapright m-icon-white"></i>
						
												<div class="forget-password">
													<h4></h4>
													<a href="index.do?findpass&type=upass">忘记了密码</a><br><a href="reg.jsp" class="">注册</a>
												</div>
											</div>
										</fieldset>
				<div class="panel" style="background-color:#fafafa;">
					<div class="inner"><span class="corners-top"><span></span></span>
						<div class="content">
							<p></p>
						</div>
						<span class="corners-bottom"><span></span></span></div>
				</div>
			</form>

		</div>

	</div>

	<div class="copyright"> Copyright © 2014 上海萨图西网络有限公司。保留所有权利。</div>
            <div>
                <a id="bottom" name="bottom" accesskey="z">
                </a>
            </div>
        </div>
        <script async="" src="login/analytics.js">
        </script>
        <script type="text/javascript" src="login/js/jquery-1.10.2.min.js">
        </script>
        <script type="text/javascript" src="login/js/jquery-migrate-1.2.1.min.js">
        </script>
        <script type="text/javascript" src="login/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="login/js/twitter-bootstrap-hover-dropdown.min.js"></script>
        <script type="text/javascript" src="login/js/jquery.slimscroll.min.js">
        </script>
        <script type="text/javascript" src="login/js/jquery.blockui.min.js">
        </script>
        <script type="text/javascript" src="login/js/jquery.cookie.min.js">
        </script>
        <script type="text/javascript" src="login/js/jquery.uniform.min.js">
        </script>
        <script src="login/js/select2.min.js" type="text/javascript">
        </script>
        <script type="text/javascript" src="login/js/app.js">
        </script>
    </body>
</html>
