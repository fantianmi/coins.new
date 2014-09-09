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
Map<String,Btc_content> indexmap = (Map<String,Btc_content>)session.getAttribute("indexmap"); %>
<%
Btc_user user = new Btc_user();
String uname = "";
if(session.getAttribute("globaluser")!=null){
	user = (Btc_user)session.getAttribute("globaluser");
	uname=user.getUname();	
}
%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
	<title><%=res.getString("host.title")%></title>
	<jsp:include page="/include/htmlsrc.jsp" ></jsp:include>
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
	        $("#rechargeCNY").addClass('selected');
	    });
	 </script>
</head>
<body>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<!-- else process -->
<div class="wrapper row3">
  <div id="container" style="padding: 0px 0px;">
  <jsp:include page="/include/lpanel.jsp"></jsp:include>
      <section class="clear">
      <div style="margin-left: 40px; padding-top: 5px;border-bottom: 5px solid #0171C7;" id="usercenter">
		<h2 style="margin-top:50px; margin-bottom:0px;color:#0171C7;font-weight: bold;">网银充值</h2>    
		</div>
		<div style="margin-left: 40px; padding-top: 5px;" id="usercenter">
        <!-- table row -->
        <!-- validate process -->
			<script src="yanzheng/jquery-1.4.4.min.js" type="text/javascript"></script>
			<script src="yanzheng/formValidator-4.1.1.js" type="text/javascript" charset="UTF-8"></script>
		    <script src="yanzheng/formValidatorRegex.js" type="text/javascript" charset="UTF-8"></script>
		    <script language="javascript" src="yanzheng/DateTimeMask.js" type="text/javascript"></script>
		    <script type="text/javascript">
		    $(document).ready(function(){
		        $.formValidator.initConfig({formID:"form1",mode:'AlertTip',onError:function(msg){alert(msg)}});
		        $("#order_amount").formValidator().inputValidator({min:0,onError:"请将表单输入完整"});
		    });
		    </script>
			<!-- validate process -->
	        <form action="pay.do?CNY" method="post" id="form1" target="_blank">
	        <input type="hidden" name="bro_recharge_way" value="网银充值">
            <input type="hidden" name="bro_sname" value="<%=uname %>"/>
            <div class="form-input clear">
          	<label class="one_half first" for="order_amount">充值金额<span class="required">*</span><br>
          	<input type="text" size="22" name="order_amount" id="order_amount" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');this.value=this.value.replace('.','');" placeholder="请输入整数，最小充值金额<%=request.getAttribute("rechargelimit").toString() %>元" />
            </label>
            </div>
            <div class="form-input clear">
          	<label class="one_half first" for="bro_recharge_way">充值方式<span class="required">*</span><br>
          	<select onchange="javascript:location.href=this.value;">
			<option value="#" selected="selected" >网银充值</option>
			<option value="index.do?recharge2local">线下充值</option>
			</select>
            </label>
            </div>
            <p>&nbsp;</p>
		 	<input class="button small blue" type="submit" value="立刻充值"/>
		</form>
		
		<!-- table row -->
		<p>“网银充值”充值 即时到帐</p>
      <p>如果您充值后24小时未到账或未填付款说明，请与客服<%=res.getString("host.kefu") %>联系。</p>
      <h1>最近充值记录</h1>
      <table summary="Summary Here" cellpadding="0" cellspacing="0">
        <thead>
          <tr>
            <th width="10%">单号</th>
            <th width="10%">充值方式</th>
            <th width="10%">充值金额</th>
            <th width="10%">手续费</th>
			<th width="20%">充值时间</th>
			<th width="40%">备注/回执单</th>
          </tr>
        </thead>
        <tbody>
        <%if(request.getAttribute("listOrder")!=null){
        	Btc_rechargeCNY_order bro = new Btc_rechargeCNY_order();
        	List<Btc_rechargeCNY_order> listOrder = (List<Btc_rechargeCNY_order>)request.getAttribute("listOrder");
        	for(int i=0;i<listOrder.size();i++){
        		bro = listOrder.get(i);
        		%>
        		<tr >
		            <td><%=bro.getBillNo()%></td>
		            <td><%=bro.getBro_recharge_way() %></td>
		            <td><%=format.trans(bro.getBro_recharge_acount()) %></td>
		            <td><%=format.trans(bro.getBro_factorage())%></td>
					<td><%=bro.getBro_recharge_time() %></td>
		            <td><%=bro.getBro_remark() %></td>
		          </tr>
       <%} }else{%>
        	<tr ><td colspan=6>暂无记录</td></tr>
        <%} %>	
        </tbody>
      </table>
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
