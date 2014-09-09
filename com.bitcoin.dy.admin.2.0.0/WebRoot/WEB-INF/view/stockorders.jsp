<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<%@ page import="com.mvc.util.*"%>
<%FormatUtil format = new FormatUtil(); %>
<body>
<!-- ****************后台管理系统******************** -->
<script type="text/javascript">
            function makeOrder(){
                document.getElementById('myForm').action = "stockorders.do?makeOrder";
                document.getElementById("myForm").submit();
            }
           
            function cancelOrder(){
                document.getElementById('myForm').action = "stockorders.do?cancelByAdmin";
                document.getElementById("myForm").submit();
            }
            
</script>
    <!--###################top##############--> 
	<jsp:include page="/include/headhtml.jsp"></jsp:include>
	<!--###################/top##############--> 
    <!--#######################lpanel########################-->
	<jsp:include page="/include/lpanelhtml.jsp"></jsp:include>
    <!--#######################/lpanel########################-->    
    <div class="content">
        
        <!--#####################position##################-->
        <jsp:include page="/include/pathpanelhtml.jsp"></jsp:include>
        <!--#####################/position##################-->
        <!-- ####################content area############### -->
        <div class="workplace">

            <div class="row-fluid">
	            <div class="span12">
	            		<form id="myForm" action="" method="post">                    
	                    <div class="head">
	                        <div class="isw-grid"></div>
	                        <h1>山寨币订单管理</h1>
	                        <ul class="buttons">
	                            <li>
	                                <a href="#" class="isw-settings"></a>
	                                <ul class="dd-list">
	                                    <li><a onclick="makeOrder()" href="#"><span class="isw-edit"></span>确认请求</a></li>
	                                    <li><a onclick="cancelOrder()" href="#"><span class="isw-plus"></span>拒绝请求</a></li>
	                                </ul>
	                            </li>
	                        </ul>                               
	                        <div class="clear"></div>
	                    </div>
	                    <div class="block-fluid table-sorting">
	                        <table cellpadding="0" cellspacing="0" width="100%" class="table" id="tSortable">
	                            <thead>
	                            <input type="hidden" name="type" value="withdraw"/>
	                                <tr>
	                                    <th><input type="checkbox" name="checkall"/></th>
	                                    <th width="20%">
	                                    <span style="float:left">订单号</span>
	                                    <span style="float:right; margin-right:10px">提现用户</span>    
	                                    </th>
	                                    <th width="20%">
	                                    <span style="float:left">提现币种</span>
	                                    <span style="float:right; margin-right:10px">提现数量</span>                                   
	                                    </th>
	                                    <th width="40%">
	                                    <span style="float:left">手续费</span>
	                                    <span style="float:right; margin-right:10px">提现地址</span>  
	                                    
	                                    </th>
	                                    <th width="20%">
	                                    <span style="float:left">提现时间</span>
	                                    </th>                                    
	                                </tr>
	                            </thead>
	                            <tbody>
	                            <%if(session.getAttribute("stockorderlist")!=null){
	                            	Btc_inout_order order = new Btc_inout_order();
	                            	String username="暂无数据";
	                            	int uid=0;
	                            	String stockname = "暂无数据";
	                            	Map<Integer,Btc_user> usermap = (Map<Integer,Btc_user>)session.getAttribute("usermap");
	                            	Map<Integer,Btc_stock> stockmap = (Map<Integer,Btc_stock>)session.getAttribute("stockmap");
	                            	List<Btc_inout_order> orderlist = (List<Btc_inout_order>)session.getAttribute("stockorderlist");
	                            	for(int i=0;i<orderlist.size();i++){
	                            		order = orderlist.get(i);
	                            		if(stockmap.get(order.getBtc_stock_id())!=null){
	                            			stockname = stockmap.get(order.getBtc_stock_id()).getBtc_stock_name();
	                            		}
	                            		if(usermap.get(order.getUid())!=null){
	                            			uid = usermap.get(order.getUid()).getUid();
	                            			username=usermap.get(order.getUid()).getUusername();
	                            		}
	                            		%>
	                                  <tr>
	                                    <td><input type="checkbox" name="checkbox" value="<%=order.getBtc_inout_order_id() %>"/></td>
	                                    <td>
	                                    <span style="float:left"><%=order.getBtc_inout_order_id() %></span>
	                                    <span style="float:right; margin-right:10px"><a href="usermanager.do?seeDetail&uid=<%=uid %>"><%=username%></a></span>
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=stockname%></span>
	                                    <span style="float:right; margin-right:10px;color:#f00;"><%=format.trans(order.getBtc_inout_amount())%></span>       
	                                    </td>
	                                    <td>
	                                    <span style="float:left;color:#f00;"><%=format.trans(order.getBtc_inout_poundage()) %></span>
	                                    <span style="float:right; margin-right:10px;color:#f00;font-size: 14px;"><%=order.getBtc_inout_adr() %></span>      
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=order.getBtc_inout_time() %></span>
	                                    </td>                                    
	                                </tr>	
	                            <%}
	                           } %>    
	                            </tbody>
	                        </table>
	                        <div class="clear"></div>
	                        </form>
	                    </div>
	                </div>  
            </div>
            <script type="text/javascript">
		            function dwithdrawso(){
		                document.getElementById("withdrawo").action = "order.do?dwithdrawstocko";
		                document.getElementById("withdrawo").submit();
		            }
		           
		</script>
            <div class="row-fluid">
                
                <div class="span12">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>山寨币提现记录</h1>     
               				<ul class="buttons">
	                            <li>
	                                <a href="#" class="isw-settings"></a>
	                                <ul class="dd-list">
	                                 
	                                    <li><a onclick="dwithdrawso()" href="#"><span class="isw-delete"></span>删除</a></li>
	                                </ul>
	                            </li>
	                        </ul> 
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid" style="height:250px; overflow:auto">
                    	<form id="withdrawo" action="" method="post">  
                        <table cellpadding="0" cellspacing="0" width="100%" class="table" id="tSortable">
	                            <thead>
	                                <tr>
	                                    <th><input type="checkbox" name="checkall"/></th>
	                                    <th width="20%">
	                                    <span style="float:left">订单号</span>
	                                    <span style="float:right; margin-right:10px">提现用户</span>    
	                                    </th>
	                                    <th width="20%">
	                                    <span style="float:left">提现币种</span>
	                                    <span style="float:right; margin-right:10px">提现数量</span>                                   
	                                    </th>
	                                    <th width="40%">
	                                    <span style="float:left">手续费</span>
	                                    <span style="float:right; margin-right:10px">提现地址</span>  
	                                    
	                                    </th>
	                                    <th width="20%">
	                                    <span style="float:left">提现时间</span>
	                                    </th>                                      
	                                </tr>
	                            </thead>
	                            <tbody>
	                            <%if(session.getAttribute("stockorderlistlog")!=null){
	                            	Btc_inout_order order = new Btc_inout_order();
	                            	String username="暂无数据";
	                            	int uid=0;
	                            	String stockname = "暂无数据";
	                            	Map<Integer,Btc_user> usermap = (Map<Integer,Btc_user>)session.getAttribute("usermap");
	                            	Map<Integer,Btc_stock> stockmap = (Map<Integer,Btc_stock>)session.getAttribute("stockmap");
	                            	List<Btc_inout_order> orderlist = (List<Btc_inout_order>)session.getAttribute("stockorderlistlog");
	                            	for(int i=0;i<orderlist.size();i++){
	                            		order = orderlist.get(i);
	                            		if(stockmap.get(order.getBtc_stock_id())!=null){
	                            			stockname = stockmap.get(order.getBtc_stock_id()).getBtc_stock_name();
	                            		}
	                            		if(usermap.get(order.getUid())!=null){
	                            			uid = usermap.get(order.getUid()).getUid();
	                            			username=usermap.get(order.getUid()).getUusername();
	                            		}
	                            		%>
	                                  <tr>
	                                    <td><input type="checkbox" name="checkbox" value="<%=order.getBtc_inout_order_id() %>"/></td>
	                                    <td>
	                                    <span style="float:left"><%=order.getBtc_inout_order_id() %></span>
	                                    <span style="float:right; margin-right:10px"><a href="usermanager.do?seeDetail&uid=<%=uid %>"><%=username %></a></span>
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=stockname %></span>
	                                    <span style="float:right; margin-right:10px;color:#f00;"><%=format.trans(order.getBtc_inout_amount())%></span>       
	                                    </td>
	                                    <td>
	                                    <span style="float:left;color:#f00;"><%=format.trans(order.getBtc_inout_poundage()) %></span>
	                                    <span style="float:right; margin-right:10px;color:#f00;font-size: 14px;"><%=order.getBtc_inout_adr() %></span>      
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=order.getBtc_inout_time() %></span>
	                                    </td>                                    
	                                </tr>	
	                            <%}
	                           } %>  
	                            </tbody>
	                        </table>
                    </div>
                </div>                                
                
            </div> 
                 
            
        </div>
        <!-- ####################/content area############### -->
    </div>   
</body>
</html>
