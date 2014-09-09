<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="com.mvc.util.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
<%ResourceBundle stockres = ResourceBundle.getBundle("stock"); %>  
<%
FormatUtil format = new FormatUtil();
Map<String,Btc_content> indexmap = (Map<String,Btc_content>)session.getAttribute("indexmap"); %>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
	<title><%=res.getString("host.title")%></title>
	<jsp:include page="/include/htmlsrc.jsp" ></jsp:include>
</head>
<body>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<script type="text/javascript">
  $(document).ready(function() {
      $("#subscribe").addClass('active');
  });
</script>
	<!-- ######################################################## -->
	<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
	<link href='styles/style.css' type='text/css' rel='stylesheet' />
		<script type="text/javascript">
		    $(document).ready(function() {
		        $("#rengou").addClass('selected');
		    });
		 </script>
	<!-- else process -->
	<%
	Btc_user user = new Btc_user();
	if(session.getAttribute("globaluser")!=null){
		user = (Btc_user)session.getAttribute("globaluser");
		}
		%>
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
	<!-- else process -->
<%
 BigDecimal eachget = new BigDecimal(0);
 BigDecimal leftamount = new BigDecimal(0);
 BigDecimal userbuyamountlog = new BigDecimal(0);
 BigDecimal usercanbuy = new BigDecimal(0);
 BigDecimal price = new BigDecimal(0);
 if(request.getAttribute("rgvm")!=null){
	 RengouViewModel rgvm = (RengouViewModel)request.getAttribute("rgvm");
	 eachget = rgvm.getEachget();
	 leftamount = rgvm.getLeftamount();
	 userbuyamountlog = rgvm.getUserbuyamountlog();
	 usercanbuy = rgvm.getUsercanbuy();
	 price = rgvm.getPrice();
 } %>
 <script type="text/javascript">
 	function checkInput(x){
 		var leftamount = <%=eachget %>-<%=userbuyamountlog %>;
 		var userinput = document.getElementById(x).value;
 		if(userinput>leftamount){
 			window.alert('请输入小于'+leftamount+'数字');
 			document.getElementById(x).value=leftamount;
 		}
 	}
 </script>
<div class="wrapper row3">
  <div id="container" style="padding: 0px 0px;">
  <jsp:include page="/include/lpanel.jsp"></jsp:include>
      <section class="clear">
      <div style="margin-left: 40px; padding-top: 5px;border-bottom: 5px solid #0171C7;" id="usercenter">
		<h2 style="margin-top:50px; margin-bottom:0px;color:#0171C7;font-weight: bold;"><%=stockres.getString("stock.rengou1.name") %>兑换</h2>    
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
			<div class="alert-msg warning"><span class="important">说明</span>麦币将作为即将推出的麦场的种子币，通过种植麦币为您的财富增值，现在总兑换量10万，每人限兑换100个，数量有限，赶快行动吧！</div>
       	<form action="rengou.do?rengou" method="post" id="form1">
         	<input type="hidden" name="amount" value="<%=eachget%>"/>
                 <p>
                   <span>兑换价格：</span>
                      	￥<%=format.trans(price)%>
                 </p>
                 <p>
                   <span>可以兑换数量：</span>
                      <%=format.trans(userbuyamountlog) %>/<%=format.trans(eachget)%>&nbsp;&nbsp;(本期发放还剩余：<%=format.trans(leftamount) %>)
                 </p>
                 <p>
                   <span>兑换数量：</span>
                     <%=format.trans(eachget)%><%=stockres.getString("stock.rengou1.name") %>&nbsp;&nbsp;&nbsp;&nbsp;合计：<%=format.trans(price.multiply(eachget)) %>RMB
                 </p>
                 <br>
			 <div class="form-input clear">
          	  <label class="one_half first" for="utpassword">交易密码<span class="required">*</span><br>
  			    <input type="password" size="22" name="utpassword" id="utpassword" placeholder="请输入您的交易密码" />
              </label>
             </div>
                <div class="form-input clear">
           </div>
           <div class="form-input clear">
             <label class="one_half first"><br>
             <input id="submit" name="submit"  type="submit" value="确认兑换"  class="button small blue"/>
           </div>
         </form>
        <!-- form row -->
        <p>&nbsp;</p>
        <div id="gallery">
        <section>
        <figure>
        <ul><li><img src="img/farm/maibi.jpg" /></li></ul>
        </figure>
        </section>
        </div>
        <p>&nbsp;</p>
        <!-- table row -->
              <h1>您的兑换记录</h1>
              <table summary="Summary Here" cellpadding="0" cellspacing="0">
                <thead>
                  <tr>
                      <th>兑换时间</th>
                      <th>兑换数量</th>
                      <th>买入价格</th>
                      <th>总兑换额</th>
                      <th>状态</th>
                      <th>兑换期次</th>
                    </tr>
                </thead>
                <tbody>
				<%
				String date2 = "暂无记录";
				String amount2 = "暂无记录";
				String price2 = "暂无记录";
				String total2 = "暂无记录";
				String status2 = "暂无记录";
				String season2 = "暂无记录";
				
				if(request.getAttribute("rengoulog")!=null){
					List<Btc_frc_rengou_log> rengoulist = (List<Btc_frc_rengou_log>)request.getAttribute("rengoulog");
					Btc_frc_rengou_log bfrl = new Btc_frc_rengou_log();
					for(int i=0;i<rengoulist.size();i++){
						bfrl = rengoulist.get(i);
						date2 = bfrl.getDate().toString();
						amount2 = format.trans(bfrl.getAmount());
						price2 = format.trans(bfrl.getPrice());
						total2 = format.trans(bfrl.getPayamount());
						status2 = bfrl.getStutus();
						season2 = bfrl.getSeason();
						%>
						<tr>
	                      <td><%=date2 %></td>
	                      <td><%=amount2 %></td>
	                      <td><%=price2 %></td>
	                      <td><%=total2 %></td>
	                      <td><%=status2 %></td>
	                      <td><%=season2%></td>
	                    </tr>
					<%}
				
				} %>
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
