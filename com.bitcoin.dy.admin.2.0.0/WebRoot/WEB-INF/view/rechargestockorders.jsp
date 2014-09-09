<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
<!-- ****************后台管理系统******************** -->
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<body>
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
		<script type="text/javascript">
            function drechargeso(){
                document.getElementById("rechargeso").action = "order.do?drechargestocko";
                document.getElementById("rechargeso").submit();
            }
		</script>
            <div class="row-fluid">
	            <div class="span12">
	                    <div class="head">
	                        <div class="isw-grid"></div>
	                        <h1>山寨币订单管理</h1>
							<ul class="buttons">
	                            <li>
	                                <a href="#" class="isw-settings"></a>
	                                <ul class="dd-list">
	                                    <li><a onclick="drechargeso()" href="#"><span class="isw-delete"></span>删除</a></li>
	                                </ul>
	                            </li>
	                        </ul> 	                        
	                        <div class="clear"></div>
	                    </div>
	                    <div class="block-fluid table-sorting">
	                    <form id="rechargeso" action="" method="post"> 
	                        <table cellpadding="0" cellspacing="0" width="100%" class="table" id="tSortable">
	                            <thead>
	                            <input type="hidden" name="type" value="withdraw"/>
	                                <tr>
	                                    <th><input type="checkbox" name="checkall"/></th>
	                                    <th width="20%">
	                                    <span style="float:left">订单号</span>
	                                    <span style="float:right; margin-right:10px">充值用户</span>    
	                                    </th>
	                                    <th width="20%">
	                                    <span style="float:left">充值币种</span>
	                                    <span style="float:right; margin-right:10px">充值数量</span>                                   
	                                    </th>
	                                    <th width="40%">
	                                    <span>充值地址</span>  
	                                    </th>
	                                    <th width="20%">
	                                    <span style="float:left">充值时间</span>
	                                    </th>                                    
	                                </tr>
	                            </thead>
	                            <tbody>
	                            <%if(request.getAttribute("olist")!=null){
	                            	Btc_rechargeStock_order order = new Btc_rechargeStock_order();
	                            	Btc_user user = new Btc_user();
	                            	int uid=0;
	                            	String username="无记录";
	                            	String stockname="无记录";
	                            	Map<Integer,Btc_user> usermap = (Map<Integer,Btc_user>)request.getAttribute("usermap");
	                            	Map<Integer,Btc_stock> stockmap = (Map<Integer,Btc_stock>)request.getAttribute("stockmap");
	                            	List<Btc_rechargeStock_order> orderlist = (List<Btc_rechargeStock_order>)request.getAttribute("olist");
	                            	for(int i=0;i<orderlist.size();i++){
	                            		order = orderlist.get(i);
	                            		if(stockmap.get(order.getStockid())!=null){
	                            			stockname =  stockmap.get(order.getStockid()).getBtc_stock_name();
	                            		}
	                            		if(usermap.get(order.getUid())!=null){
	                            			user = usermap.get(order.getUid());
	                            			username = user.getUusername();
	                            			uid = user.getUid();
	                            		}
	                            		%>
	                                  <tr>
	                                    <td><input type="checkbox" name="checkbox" value="<%=order.getId() %>"/></td>
	                                    <td>
	                                    <span style="float:left"><%=order.getId() %></span>
	                                    <span style="float:right; margin-right:10px"><a href="usermanager.do?seeDetail&uid=<%=uid %>"><%=username%></a></span>
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=stockname%></span>
	                                    <span style="float:right; margin-right:10px;color:#f00;"><%=order.getAmount()%></span>       
	                                    </td>
	                                    <td>
	                                    <span style="color:#f00;font-size: 14px;"><%=order.getAdr() %></span>      
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=order.getDate()%></span>
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
                 
            
        </div>
        <!-- ####################/content area############### -->
    </div>   
</body>
</html>
