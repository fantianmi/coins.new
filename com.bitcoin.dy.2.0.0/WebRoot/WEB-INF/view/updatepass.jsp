<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="com.mvc.util.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
<%Map<String,Btc_content> indexmap = (Map<String,Btc_content>)session.getAttribute("indexmap"); 
 Btc_stock stock = (Btc_stock)request.getAttribute("stock");
 Btc_profit profit =(Btc_profit)request.getAttribute("profit");
 BigDecimal holding = new BigDecimal(0);
 if(request.getAttribute("holding")!=null){
	 Btc_holding hold = (Btc_holding)request.getAttribute("holding");
	 holding = hold.getBtc_stock_amount();
 }
 Btc_user user = new Btc_user();
if(session.getAttribute("globaluser")!=null){
user = (Btc_user)session.getAttribute("globaluser");
}
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
	<title><%=res.getString("host.title")%></title>
	<jsp:include page="/include/htmlsrc.jsp" ></jsp:include>
</head>
<body>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
	<!-- ######################################################## -->
	<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
	<link href='styles/style.css' type='text/css' rel='stylesheet' />
		<script type="text/javascript">
		    $(document).ready(function() {
		        $("#gerenziliao").addClass('selected');
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
	<!-- copy process -->
	<script type="text/javascript">
	function copyToClipboard(txt) {
	    if (window.clipboardData) {
	        window.clipboardData.clearData();
	        window.clipboardData.setData("Text", txt);
	        alert("已经成功复制到剪帖板上！");
	    } else if (navigator.userAgent.indexOf("Opera") != -1) {
	        window.location = txt;
	    } else if (window.netscape) {
	        try {
	            netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
	        } catch(e) {
	            alert("被浏览器拒绝！\n请在浏览器地址栏输入'about:config'并回车\n然后将'signed.applets.codebase_principal_support'设置为'true'");
	        }
	        var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
	        if (!clip) return;
	        var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
	        if (!trans) return;
	        trans.addDataFlavor('text/unicode');
	        var str = new Object();
	        var len = new Object();
	        var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
	        var copytext = txt;
	        str.data = copytext;
	        trans.setTransferData("text/unicode", str, copytext.length * 2);
	        var clipid = Components.interfaces.nsIClipboard;
	        if (!clip) return false;
	        clip.setData(trans, null, clipid.kGlobalClipboard);
	        alert("已经成功复制到剪帖板上！");
	    }
	}
	function copyTo(x) {
	    var txt = document.getElementById(x).innerHTML;
	    copyToClipboard(txt);
	}
	</script>
	<!-- copy process -->
	  <%
  String updatetype = "";
  if(request.getAttribute("updatetype")!=null){
  	updatetype = request.getAttribute("updatetype").toString();
  } %>
<div class="wrapper row3">
  <div id="container" style="padding: 0px 0px;">
  <jsp:include page="/include/lpanel.jsp"></jsp:include>
      <section class="clear">
      <div style="margin-left: 40px; padding-top: 5px;border-bottom: 5px solid #0171C7;" id="usercenter">
		<h2 style="margin-top:50px; margin-bottom:0px;color:#0171C7;font-weight: bold;">修改您的<%if(updatetype.equals("updatepassword")){ %>登陆<%}else{ %>交易<%}%>密码&nbsp;<%=res.getString("host.small.title")%></h2>    
	</div>
	<div style="margin-left: 40px;" id="usercenter">	
		<p>&nbsp;</p>
        <!-- content row -->
        <!-- form validate -->
	    <script src="yanzheng/jquery-1.4.4.min.js" type="text/javascript"></script>
		<script src="yanzheng/formValidator-4.1.1.js" type="text/javascript" charset="UTF-8"></script>
	    <script src="yanzheng/formValidatorRegex.js" type="text/javascript" charset="UTF-8"></script>
	    <script language="javascript" src="yanzheng/DateTimeMask.js" type="text/javascript"></script>
	    <script type="text/javascript">
	    $(document).ready(function(){
	        $.formValidator.initConfig({formID:"form1",mode:'AlertTip',onError:function(msg){alert(msg)}});
	        $("#opassword").formValidator().inputValidator({min:1,onError:"原密码不能为空,请确认"});
	        $("#password1").formValidator().inputValidator({min:1,onError:"密码不能为空,请确认"});
	        $("#password2").formValidator().inputValidator({min:1,onError:"重复密码不能为空,请确认"}).compareValidator({desID:"password1",operateor:"=",onError:"2次密码不一致,请确认"});
	    });
	    </script>
        <form action="register.do?updatepassword" method="post" name="form1" id="form1">
      	 <input type="hidden" name="updatetype" value="<%=updatetype %>"/>
            <div class="form-input clear">
          	<label class="one_half first" for="fk">原密码<span class="required">*</span>
           <%if(updatetype.equals("updateutpassword")){
          	 %>
          	 <a href="index.do?findpass&type=utpass">忘记交易密码？</a>
          	 <%
           } %>
          	
          	<br>
  			 <input type="password" size="22" id="fk" name="opassword" class="sz" placeholder="请输入您最初设置的密码" />
            </label>
            </div>
            <div class="form-input clear">
          	<label class="one_half first" for="password1">新密码<span class="required">*</span><br>
  			 <input type="password" size="22" id="password1" name="npassword" class="sz" placeholder="请输入新的密码" />
            </label>
            </div>
            <div class="form-input clear">
          	<label class="one_half first" for="password2">重复密码<span class="required">*</span><br>
  			 <input type="password" size="22" id="password2" name="password2" class="sz" placeholder="请再次输入新的密码" />
            </label>
            </div>
            <div class="form-input clear">
              <label class="one_half first"><br>
              <input type="submit" name="button" id="button" value="确认修改" class="button small blue"/>
            </div>
    		</form>
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
