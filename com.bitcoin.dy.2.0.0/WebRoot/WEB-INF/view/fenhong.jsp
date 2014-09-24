<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="com.mvc.util.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
<%
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
 %>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
	<title><%=res.getString("host.title")%></title>
	<jsp:include page="/include/htmlsrc.jsp" ></jsp:include>
	<!-- coins_new -->
  <link href="coins_new/css/zy.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript">
		    $(document).ready(function() {
		        $("#fenhong").addClass('selected');
		    });
		 </script>
</head>
<body>
<!-- else process -->
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
      $(function(){           
          $('#kaptchaImage').click(function () {//生成验证码  
           $(this).hide().attr('src', 'general.do?captcha-image?' + Math.floor(Math.random()*100) ).fadeIn(); })      
                });   
      
     </script> 
	<!-- else process -->
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<jsp:include page="/include/nav.jsp" ></jsp:include>
 <div class="box2"> 
  <jsp:include page="/include/lpanel.jsp" ></jsp:include>
  <div class="user_r">
    <div class="u_r_t">
      <div class="u_r_t_l">领取分红赠送</div>
      <!--<div class="u_r_t_r">您当前的资金估值为：<b style="font-size:14px; color:red;">0.00</b> 元人民币。 人民币余额：<b style="font-size:14px; color:red;">0.00 元</b></div>--> 
    </div>
 <%
BigDecimal count = new BigDecimal(0);
if(request.getAttribute("fhlist")!=null){
Btc_fh_order bfo = new Btc_fh_order();
 List<Btc_fh_order> fhlist = (List<Btc_fh_order>)request.getAttribute("fhlist");
 for(int i=0;i<fhlist.size();i++){
	 bfo = fhlist.get(i);
	 count = count.add(bfo.getAmount());
 }
} 
%>
<!-- form row -->
<!-- validate process -->
<script src="yanzheng/jquery-1.4.4.min.js" type="text/javascript"></script>
<script src="yanzheng/formValidator-4.1.1.js" type="text/javascript" charset="UTF-8"></script>
   <script src="yanzheng/formValidatorRegex.js" type="text/javascript" charset="UTF-8"></script>
   <script language="javascript" src="yanzheng/DateTimeMask.js" type="text/javascript"></script>
   <script type="text/javascript">
$(document).ready(function(){
    $.formValidator.initConfig({formID:"form1",mode:'AlertTip',onError:function(msg){alert(msg)}});
    $("#utpassword").formValidator().inputValidator({min:3,onError:"密码不能为空,请确认"});
});
</script>
<!-- validate process -->

    <div class="user1">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:15px;">
        <tr>
          <td width="16%" height="35" align="right" valign="middle" style="font-weight:bold; color:#333;">可领取的GFB分红：</td>
          <td width="84%"><%=count %> 人民币 </td>
        </tr>
        <form action="fenhong.do?getfenhong" id="form1" method="post">
         <input type="hidden" name="amount" value=""/>
        <tr>
          <td height="35" align="right" valign="middle" style="font-weight:bold; color:#333;">交易密码：</td>
          <td><input name="" type="text" style="width:200px; height:25px; line-height:25px; color:#666; border:1px solid #ddd;" id="utpassword" name="utpassword"  />
            请输入您设置的交易密码 </td>
        </tr>
        <tr>
          <td height="35">&nbsp;</td>
          <td><input id="button"  value="确认领取"  type="submit"  style="margin-top:15px; font-family:微软雅黑; color:#333; padding:0px 10px; font-size:12px;" /></td>
        </tr>
        </form>
        <tr>
          <td height="80">&nbsp;</td>
          <td>可兑换的比特券数受市场交易价格影响，但优于市场行情。<br />
        请确认所选信息准确无误后提交分红申请，因网站数据实时更新，最终获得的分红赠送以提交后实际数据为准，一旦提交，无法撤销。</td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="1" cellpadding="0" style="margin-top:15px; background:#eee;">
        <tr>
          <td height="30" colspan="6" bgcolor="#FFFFFF" style="text-indent:10px; font-weight:600; font-size:14px;">最近分红领取记录</td>
        </tr>
        <tr>
          <td width="15%" height="30" align="center" valign="middle" bgcolor="#f9f9f9" style="font-weight:bold; color:#333;">分红期次</td>
          <td width="15%" align="center" valign="middle" bgcolor="#f9f9f9" style="font-weight:bold; color:#333;">获得分红</td>
          <td width="15%" align="center" valign="middle" bgcolor="#f9f9f9" style="font-weight:bold; color:#333;">发放状态</td>
          <td width="16%" align="center" valign="middle" bgcolor="#f9f9f9" style="font-weight:bold; color:#333;">发放日期</td>
          <td width="18%" align="center" valign="middle" bgcolor="#f9f9f9" style="font-weight:bold; color:#333;">领取日期</td>
          <td width="21%" align="center" valign="middle" bgcolor="#f9f9f9" style="font-weight:bold; color:#333;">领取状态</td>
        </tr>
        <%if(request.getAttribute("fhlistall")==null){%>
        <tr>
          <td height="30" align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
          <td align="center" valign="middle" bgcolor="#FFFFFF">暂无记录</td>
        </tr>
        <%}else{
	      	 List<Btc_fh_order> bfolistall = (List<Btc_fh_order>)request.getAttribute("fhlistall");
	      	 Btc_fh_order bfoall = new Btc_fh_order();
	      	 for(int i=0;i<bfolistall.size();i++){
	      		 bfoall = bfolistall.get(i);%>
	      		 <tr>
	            <td height="30" align="center" valign="middle" bgcolor="#FFFFFF">第<%=bfoall.getSeason() %>期分红</td>
	            <td align="center" valign="middle" bgcolor="#FFFFFF"><%=bfoall.getAmount() %></td>
	            <td align="center" valign="middle" bgcolor="#FFFFFF"><%=bfoall.getIsdeliver() %></td>
	            <td align="center" valign="middle" bgcolor="#FFFFFF"><%=bfoall.getDelivertime() %></td>
	            <%if(bfoall.getGettime()==null){%>
	            <td align="center" valign="middle" bgcolor="#FFFFFF">未领取</td>	
	            <%}else{ %>
	            <td align="center" valign="middle" bgcolor="#FFFFFF"><%=bfoall.getGettime() %></td>
	            <%} %>
	            <td align="center" valign="middle" bgcolor="#FFFFFF"><%=bfoall.getIsget() %></td>
	          </tr>
	      	 <%}} %>
      </table>
    </div>
  </div>
</div>
<jsp:include page="/include/foothtml.jsp"></jsp:include>
</div>
</body>
</html>
