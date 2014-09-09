<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>

<!-- ****************后台管理系统******************** -->
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<body>
<script type="text/javascript">
		var msg = null;
		function sendmsg() {
			if (window.XMLHttpRequest) {
				msg = new XMLHttpRequest();
			} else if (window.ActiveXObject) {
				msg = new ActiveXObject("Microsoft.XMLHTTP");
			}
			if (msg != null) {
				var username = document.getElementById("btc_manager_username").value;
				var url = 'msg.do?sendforpost&username='+username+'&n=' + Math.random();
				msg.onreadystatechange = showmsg;
				msg.open("GET", url, true);
				msg.send(null);
			}
		}
</script>
    <div class="loginBox">        
        <div class="loginHead">
            <img src="img/logo.png" alt="比特币交易网站-后台管理" title="比特币交易网站-后台管理"/>
        </div>
        <form class="form-horizontal" action="vertify.do?adminLogin" method="post">
            <div class="control-group">
                <label for="inputEmail">用户名:</label>                
                <input type="text" id="btc_manager_username" name="btc_manager_username"/>
            </div>
            <div class="control-group">
                <label for="inputPassword">密码：</label>                
                <input type="password" id="btc_manager_password" name="btc_manager_password"/>                
            </div>
            <div class="control-group">
                <label for="inputPassword">验证码：</label>                
                <input type="text" id="msgcode" name="msgcode" style="width:150px"/>    
                <input type="button" style="width:120px" class="btn btn-success" id="btn" value="免费获取验证码"/>   
                  <script type="text/javascript">
					var wait=60;
					var count = 1;
					function time(o) {
						if (wait == 0) {
						o.removeAttribute("disabled");
						o.value="免费获取验证码";
						wait = 60;
						} else {
						o.setAttribute("disabled", true);
						o.value=wait+"秒后可以重新发送";
						wait--;
						setTimeout(function() {
						time(o)
						},
						1000)
						}
					}
					
					document.getElementById("btn").onclick=function(){
						if(count<=3){
							sendmsg();
							count++;
							time(this);
						}else{
							this.setAttribute("disabled", true);
							this.value="对不起，您发送太频繁";
						}
					}
					</script>        
            </div>
            <div class="form-actions">
                <input type="submit" class="btn btn-block" value="登录"/>
            </div>
        </form>        
    </div>   
    
</body>
</html>
