<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
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
	        $("#bitebitixian").addClass('selected');
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
	<!-- ######################################################## -->
    <script language="JavaScript" type="text/javascript" src="script/jquery.js"></script>
	<script language="JavaScript" type="text/javascript" src="script/jquery.corner.js"></script>
	<script language="JavaScript" type="text/javascript" src="script/jVal.js"></script>
	<script type="text/javascript" src="script/geo.js"></script>
	<script type="text/javascript" src="script/data.js"></script>
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
	<script language="JavaScript" type="text/javascript" src="msg/msgprocess.js"></script>
  

<div class="wrapper row3">
<div id="container" style="padding: 0px 0px;">
<!-- ####################### -->
  <jsp:include page="/include/lpanel.jsp"></jsp:include>
 <!-- ################################################################################################ -->
      <section class="clear">
      <div style="margin-left: 40px; padding-top: 5px;border-bottom: 5px solid #0171C7;">
		<h2 style="margin-top:50px; margin-bottom:0px;color:#0171C7;font-weight: bold;"><%=stock.getBtc_stock_name() %>提现</h2>    
		<p></p>
		</div>
	 <div style="margin-left: 40px; padding-top: 30px;">      
      <!-- ################################################ -->
      <div id="respond">
        <form action="stockorders.do?withdrawStock" method="post">
        <input type="hidden" name="stockId" value="<%=stock.getBtc_stock_id() %>"/>
            <p>
		    <label for="email">可用余额&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
             	
	          </p>
	          <p>
			    <label for="email">&nbsp;&nbsp;&nbsp;&nbsp;</label>
	            
	          </p>
            <div class="form-input clear">
          	<label class="one_half first" for="utpassword"><span class="required">*</span><br>
  			 
            </label>
            </div>
            <div class="form-input clear">
          	<label class="one_half first" for="btc_inout_amount"><span class="required">*</span><br>
	  		
	  		
            </label>
            </div>
            <div class="form-input clear">
          	<label class="one_half first" for="btc_inout_adr"><span class="required">*</span><br>
	  		
            </label>
            </div>
            <p>
		    <label for="email"></label>
		    
          </p>
    		<div class="form-input clear">
              <label class="one_half first" for="msgcode"><span class="required">*</span><br>
              <span class="one_half first">
                	
                </span>
                <span class="one_half">
                
                </span>
              </label>
            </div>
             
            <div class="form-input clear">
              <label class="one_half first"><br>
                   
            </div>
            
            <div class="alert-msg rnd8 info">
            
           </div>
  
		</form>
      
      <h1>最近提现记录</h1>
      <table summary="Summary Here" cellpadding="0" cellspacing="0">
        <thead>
          <tr>
            <th width="10%">单号</th>
            <th width="20%">提现地址（转账号码）</th>
            <th width="10%">金额</th>
            <th width="15%">提现时间</th>
			<th width="30%">备注/回执单</th>
			<th width="10%">操作</th>
          </tr>
        </thead>
        <tbody>
        <%if(request.getAttribute("orderilst")!=null){
        	List<Btc_inout_order> orderlist = (List<Btc_inout_order>)request.getAttribute("orderilst");
        	Btc_inout_order order = new Btc_inout_order();
        	for(int i=0;i<orderlist.size();i++){
        		order = orderlist.get(i);
        	%>
       	  <tr>
            <td><%=order.getBtc_inout_order_id() %></td>
            <td><%=order.getBtc_inout_adr() %></td>
            <td><%=order.getBtc_inout_amount() %></td>
            <td><%=order.getBtc_inout_time() %></td>
            <td><%=order.getBtc_inout_msg() %></td>
            <%if(order.getBtc_inout_status().equals("未处理")){ %>
            <td><a href="#">处理中</a></td>
            <%}else{ %>
			<td><a href="#">已处理</a></td>
			<%} %>          
          </tr>
        <%}
        }else{ %>
          <tr>
            <td>无</td>
            <td>暂无记录</td>
            <td>暂无记录</td>
            <td>暂无记录</td>
            <td>暂无记录</td>
            <td>暂无记录</td>
          </tr>
          <%} %>
        </tbody>
      </table>
      </section>
      </div>
    </div>
     </td></tr>
</table>
    <!-- ################################################################################################ -->
    <div class="clear"></div>
  </div>
  </div>

<jsp:include page="/include/foothtml.jsp"></jsp:include>
</div>
</body>
</html>
