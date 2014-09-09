<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mvc.util.*"%>
<%FormatUtil format = new FormatUtil(); %>
<%@ include file="/include/head.jsp"%>
<!-- ****************后台管理系统******************** -->
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<body>
<script type="text/javascript">
            function insertStu(){
                document.getElementById('myForm').action = "rechargetouser.do?CNY";
                document.getElementById("myForm").submit();
            }
            
            function rejectInsert(){
                document.getElementById('myForm').action = "rechargetouser.do?rejectCNY";
                document.getElementById("myForm").submit();
            }
           
            function deleteStu(){
                document.getElementById('myForm').action = "rechargetouser.do?deleteOrders";
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
				<!--#############talbe3##############-->    
				<form id="myForm" action="" method="post">          
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>未处理的充值订单</h1>   
						<ul class="buttons">
                            <li>
                                <a href="#" class="isw-settings"></a>
                                <ul class="dd-list">
                                    <li><a onclick="insertStu()" href="#"><span class="isw-plus"></span>确认充值</a></li>
                                    <li><a onclick="rejectInsert()" href="#"><span class="isw-plus"></span>取消充值</a></li>
                                    <li><a onclick="deleteStu()"><span class="isw-delete"></span>删除</a></li>
                                </ul>
                            </li>
                        </ul>                              
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid table-sorting">
                        <table cellpadding="0" cellspacing="0" width="100%" class="table" id="tSortable">
                            <thead>
                                <tr>
                                    <th><input type="checkbox" name="checkall"/></th>
                                    <th width="15%">订单号</th>
                                    <th width="30%">汇款人&nbsp;-&nbsp;充值方式</th>
                                    <th width="30%">充值金额-手续费</th>
                                    <th width="25%">充值时间</th>                                    
                                </tr>
                            </thead>
                            <tbody>
                            <%if(request.getAttribute("listOrder")!=null){
								List<Btc_rechargeCNY_order> list = (List<Btc_rechargeCNY_order>)request.getAttribute("listOrder");
								Btc_rechargeCNY_order bro = new Btc_rechargeCNY_order();
								for(int i=0;i<list.size();i++){
									bro = list.get(i);
                            	%>
					        <tr>
					          <td><input type="checkbox" name="checkbox" value="<%=bro.getBro_id() %>"/></td>
					          <td><%=bro.getBillNo()%></td>
					          <td><%=bro.getBro_sname() %>&nbsp;-&nbsp;<%=bro.getBro_recharge_way() %>&nbsp;&nbsp;<%=format.transBank(bro.getBro_rname()) %></td>
					          <td><%=format.trans(bro.getBro_recharge_acount()) %>元&nbsp;-&nbsp;<%=format.trans(bro.getBro_factorage()) %>元</td>
							  <td><%=bro.getBro_recharge_time() %></td>
					        </tr>
					        <%}} %>
                            </tbody>
                        </table>
                        <div class="clear"></div>
                    </div>
                    </form>
			     <!--#############talbe3/##############-->
                </div>                                
                
            </div>            
            
            <div class="dr"><span></span></div>   
            
            <script type="text/javascript">
		            function drecharge(){
		                document.getElementById("rechargeo").action = "rechargetouser.do?deleteOrders";
		                document.getElementById("rechargeo").submit();
		            }
		           
		</script>
            <div class="row-fluid">
                
                <div class="span12">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <%
				        int countRow=0;
				        int fhstartNo=0;
				        if(request.getAttribute("countRow")!=null){countRow=Integer.parseInt(request.getAttribute("countRow").toString());}
				        if(session.getAttribute("czstartNo")!=null){fhstartNo=Integer.parseInt(session.getAttribute("czstartNo").toString());}
				        %>
                        <h1>人民币充值记录(<%=countRow %>)</h1>      
                        <ul class="buttons">
                            <li>
                                <a href="#" class="isw-settings"></a>
                                <ul class="dd-list">
                                    <li><a onclick="drecharge();"><span class="isw-delete"></span>删除</a></li>
                                </ul>
                            </li>
                        </ul>  
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid" style="height:250px; overflow:auto">
                    	<form id="rechargeo" action="" method="post">          
                        <table cellpadding="0" cellspacing="0" width="100%" class="table" id="tSortable">
	                            <thead>
	                                <tr>
	                                    <th><input type="checkbox" name="checkall"/></th>
	                                    <th width="15%">订单号</th>
	                                    <th width="30%">汇款人&nbsp;-&nbsp;充值方式</th>
	                                    <th width="30%">充值金额-手续费</th>
	                                    <th width="25%">充值时间</th>                                    
	                                </tr>
	                            </thead>
	                            <tbody>
					        <%if(request.getAttribute("listOrderlog")!=null){
								List<Btc_rechargeCNY_order> list2 = (List<Btc_rechargeCNY_order>)request.getAttribute("listOrderlog");
								Btc_rechargeCNY_order bro = new Btc_rechargeCNY_order();
								for(int i=0;i<list2.size();i++){
									bro = list2.get(i);
                            	%>
					        <tr>
					          <td><input type="checkbox" name="checkbox" value="<%=bro.getBro_id()%>"/></td>
					          <td><%=bro.getBillNo()%></td>
					          <td><%=bro.getBro_sname() %>&nbsp;-&nbsp;<%=bro.getBro_recharge_way() %>&nbsp;&nbsp;</td>
					          <td><%=format.trans(bro.getBro_recharge_acount()) %>元&nbsp;-&nbsp;<%=format.trans(bro.getBro_factorage()) %>元</td>
							  <td><%=bro.getBro_recharge_time() %></td>
					        </tr>
					        <%}} %>
	                            </tbody>
	                        </table>
	                        </form>
                    </div>
                </div>                                
                
            </div>   
            <!-- rowspan -->
            <!-- fenye -->
                    <div class="row-form" >
                        <div class="span9">
                                <div class="btn-group">
                                <%
                                int count = countRow;
                                int pageSize = 100;
                                int myRows = 0;
                                   if(count/pageSize==0){
                                          myRows = count/pageSize;
                                     }else{
                                           myRows = count/pageSize+1;
                                      }
                                        int     start = fhstartNo;
                                        int end = pageSize * (myRows-1);
                                   int pageNow = (start+pageSize)/pageSize;
                                %>
                                </div>
                                <span><input class="btn" type="button" onclick="fenye(0,<%=pageSize%>);" value="首页"/></span>
                                <span><input id="prePage" class="btn" type="button" onclick="fenye(<%=start-100 %>,<%=pageSize%>);" value="上一页"/></span>
                                <span class="lead">&nbsp;&nbsp;<%=pageNow %>&nbsp;&nbsp;</span>
                                <span><input id="nextPage" class="btn" type="button" onclick="fenye(<%=start+100 %>,<%=pageSize%>);" value="下一页"/></span>
                                <span><input class="btn" type="button" onclick="fenye(<%=end%>,<%=pageSize%>);" value="末页"/></span>
                                <span style="width:30px">
                                <select id="pageNo" style="width:80px">
                                     <option value="<%=pageNow%>">第<%=pageNow%>页</option>
                                <%for(int i=1;i<=myRows;i++){%>
                                     <option value="<%=(i-1)*pageSize%>">第<%=i%>页</option>
                                <%} %>
                                </select>
                                <input class="btn" type="button" onclick="goto();" value="GO"/>
                                </span>
                                <script>
                                function fenye(start,count){
                                     window.location.href='index.do?orders&start='+start+'&count='+count+'';
                                }
                                function goto(){
                                     var obj = document.getElementById('pageNo'); //selectid
                                             var index = obj.selectedIndex;
                                             var start = obj.options[index].value; // 选中值
                                     var count = <%=pageSize%>;
                                     window.location.href='index.do?orders&start='+start+'&count='+count+'';
                                }
                               
                                $(document).ready(function() {
                                     var start = <%=start%>;
                                     var count = <%=count%>
                                             if(start-100<0){
                                                  document.getElementById('prePage').setAttribute("disabled",true);
                                             }
                                             if(count-start<100){
                                                  document.getElementById('nextPage').setAttribute('disabled',true);
                                             }
                                        });
                                </script>                              
                            </div>

            
            <!-- rowspan -->
            
        </div>
        
        <!-- ####################/content area############### -->
    </div>   
</body>
</html>
