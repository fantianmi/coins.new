<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<%@ page import="com.mvc.util.*"%>
<%FormatUtil format = new FormatUtil(); %>
<body>
<!-- ****************后台管理系统******************** -->
<script type="text/javascript">
            function withdrawCNY(){
                document.getElementById('myForm').action = "rechargetouser.do?makeWithdrawCNY";
                document.getElementById("myForm").submit();
            }
           
            function rejectWithdrawCNY(){
                document.getElementById('myForm').action = "rechargetouser.do?rejectWithdrawCNY";
                document.getElementById("myForm").submit();
            }
            
            function deletetWithdrawCNY(){
                document.getElementById('myForm').action = "rechargetouser.do?deleteWithdrawCNY";
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
	                        <h1>人民币提现订单管理</h1>
	                        <ul class="buttons">
	                            <li>
	                                <a href="#" class="isw-settings"></a>
	                                <ul class="dd-list">
	                                    <li><a onclick="withdrawCNY()" href="#"><span class="isw-edit"></span>确认提现</a></li>
	                                    <li><a onclick="rejectWithdrawCNY()" href="#"><span class="isw-plus"></span>拒绝提现</a></li>
	                                    <li><a onclick="deletetWithdrawCNY()" href="#"><span class="isw-delete"></span>删除</a></li>
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
	                                    <th width="25%">
	                                    <span style="float:left">订单号</span>
	                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                                    <span>订单用户</span>
	                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                                    <span>提现金额</span>
	                                    &nbsp;&nbsp;&nbsp;
	                                    <span style="float:right"  margin-right:10px">手续费</span>
	                                    </th>
	                                    <th width="30%">
	                                    <span style="float:left">[提现方式]</span>
	                                    &nbsp;&nbsp;
	                                    <span>[用户平台姓名]</span>
	                                    <span style="float:right; margin-right:10px">提现地址</span>                                   
	                                    </th>
	                                    <th width="20%">
	                                    <span style="float:left">收款人</span>
	                                    <span style="float:right; margin-right:10px">开户银行/支付宝</span>  
	                                    
	                                    </th>
	                                    <th width="25%">
	                                    <span style="float:left">银行卡号</span>
	                                    <span style="float:right;margin-right:10px">申请提现时间</span>
	                                    </th>                                    
	                                </tr>
	                            </thead>
	                            <tbody>
	                            <%
	                            if(session.getAttribute("usermap")!=null&&session.getAttribute("withdrawCNYorders")!=null){
	                            	Map<Integer,Btc_user> usermap = (Map<Integer,Btc_user>)session.getAttribute("usermap");
	                            	List<Btc_withdrawCNY_order> withdrawCNYorders = (List<Btc_withdrawCNY_order>)session.getAttribute("withdrawCNYorders");
	                            	String username = "";
	                            	String uname = "";
	                            	for(int i=0;i<withdrawCNYorders.size();i++){
	                            		Btc_withdrawCNY_order bwo = withdrawCNYorders.get(i);
	                            		username = usermap.get(bwo.getUid()).getUusername();
	                            		uname = usermap.get(bwo.getUid()).getUname();
	                            		%>
	                            		  <tr>
	                                    <td><input type="checkbox" name="checkbox" value="<%=bwo.getBtc_bwo_id() %>"/></td>
	                                    <td>
	                                    <span style="float:left"><%=bwo.getBtc_bwo_id() %></span>
	                                    &nbsp;&nbsp;&nbsp;
	                                    <span><a href="usermanager.do?seeDetail&uid=<%=bwo.getUid()%>"><%=username %></a></span>
	                                    &nbsp;&nbsp;&nbsp;
	                                    <span><%=format.trans(bwo.getBtc_bwo_amount()) %></span>
	                                    &nbsp;&nbsp;&nbsp;
	                                    <span style="float:right; margin-right:10px"><%=format.trans(bwo.getBtc_bwo_poundage()) %></span>
	                                    </td>
	                                    <td>
	                                    <span style="float:left">[<%=bwo.getBtc_bwo_withdraw_way() %>]</span>
	                                    &nbsp;
	                                    <span>[<%=uname %>]</span>
	                                    &nbsp;
	                                    <span>[<%=bwo.getBtc_bwo_province() %>]</span>
	                                    
	                                    <span>[<%=bwo.getBtc_bwo_city() %>]</span> 
	                                    <span>[<%=bwo.getBtc_bwo_town() %>]</span>       
	                                    </td>
	                                    <td>
	                                    <span style="float:right"><%=bwo.getBtc_bwo_bank() %></span>
	                                    <span style="float:left"><%=bwo.getBtc_bwo_rname() %></span>
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=bwo.getBtc_bwo_card() %></span>
	                                    <span style="float:right;margin-right:10px"><%=bwo.getBtc_bwo_time() %></span>
	                                    </td>                                    
	                                </tr>	
	                            		<%
	                            	}
	                            }
	                            %>
	                            </tbody>
	                        </table>
	                        <div class="clear"></div>
	                        </form>
	                    </div>
	                </div>  
            </div>
            <!-- ############################################## -->
            <script type="text/javascript">
	            function dwithdrawo(){
	                document.getElementById("withdrawo").action = "rechargetouser.do?dwithdrawcnyo";
	                document.getElementById("withdrawo").submit();
	            }
			</script>
            <div class="row-fluid">
                <%
		        int countRow=0;
		        int fhstartNo=0;
		        if(request.getAttribute("countRow")!=null){countRow=Integer.parseInt(request.getAttribute("countRow").toString());}
		        if(session.getAttribute("txstartNo")!=null){fhstartNo=Integer.parseInt(session.getAttribute("txstartNo").toString());}
		        %>
                <div class="span12">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>人民币提现记录(<%=countRow %>)</h1>
                        <ul class="buttons">
	                            <li>
	                                <a href="#" class="isw-settings"></a>
	                                <ul class="dd-list">
	                                    <li><a onclick="dwithdrawo()" href="#"><span class="isw-delete"></span>删除</a></li>
	                                </ul>
	                            </li>
	                        </ul>         
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid" style="height:200px; overflow:auto">
                    <form id="withdrawo" action="" method="post"> 
                        <table cellpadding="0" cellspacing="0" width="100%" class="table">
	                            <thead>
	                                <tr>
	                                	<th><input type="checkbox" name="checkall"/></th>
	                                    <th width="22.5%">
	                                    <span style="float:left">订单号</span>
	                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                                    <span>订单用户</span>
	                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                                    <span>提现金额</span>
	                                    &nbsp;&nbsp;&nbsp;
	                                    <span style="float:right"  margin-right:10px">手续费</span>
	                                    </th>
	                                    <th width="30%">
	                                    <span style="float:left">[提现方式]</span>
	                                    &nbsp;&nbsp;
	                                    <span>[用户平台姓名]</span>
	                                    <span style="float:right; margin-right:10px">提现地址</span>                                   
	                                    </th>
	                                    <th width="20%">
	                                    <span style="float:left">收款人</span>
	                                    <span style="float:right; margin-right:10px">开户银行地址</span>  
	                                    
	                                    </th>
	                                    <th width="27.5%">
	                                    <span style="float:left">银行卡号</span>
	                                    <span style="float:right;margin-right:10px">申请提现时间</span>
	                                    </th>                                    
	                                </tr>
	                            </thead>
	                            <tbody>
	                            <%
	                            if(request.getAttribute("listOrderlog")!=null){
	                            	Map<Integer,Btc_user> usermap = (Map<Integer,Btc_user>)session.getAttribute("usermap");
	                            	List<Btc_withdrawCNY_order> withdrawCNYorders = (List<Btc_withdrawCNY_order>)request.getAttribute("listOrderlog");
	                            	String username = "无记录";
	                            	String uname = "无记录";
	                            	for(int i=0;i<withdrawCNYorders.size();i++){
	                            		Btc_withdrawCNY_order bwo = withdrawCNYorders.get(i);
	                            		if(usermap.get(bwo.getUid())!=null){
		                            		username = usermap.get(bwo.getUid()).getUusername();
		                            		uname = usermap.get(bwo.getUid()).getUname();
	                            		}
	                            		%>
	                            		  <tr>
	                            		<td><input type="checkbox" name="checkbox" value="<%=bwo.getBtc_bwo_id() %>"/></td>
	                                    <td>
	                                    <span style="float:left"><%=bwo.getBtc_bwo_id() %></span>
	                                    &nbsp;&nbsp;&nbsp;
	                                    <span><a href="usermanager.do?seeDetail&uid=<%=bwo.getUid()%>"><%=username %></a></span>
	                                    &nbsp;&nbsp;&nbsp;
	                                    <span><%=format.trans(bwo.getBtc_bwo_amount()) %></span>
	                                    &nbsp;&nbsp;&nbsp;
	                                    <span style="float:right; margin-right:10px"><%=format.trans(bwo.getBtc_bwo_poundage()) %></span>
	                                    </td>
	                                    <td>
	                                    <span style="float:left">[<%=bwo.getBtc_bwo_withdraw_way() %>]</span>
	                                    &nbsp;
	                                    <span>[<%=uname %>]</span>
	                                    &nbsp;
	                                    <span>[<%=bwo.getBtc_bwo_province() %>]</span>
	                                    
	                                    <span>[<%=bwo.getBtc_bwo_city() %>]</span> 
	                                    <span>[<%=bwo.getBtc_bwo_town() %>]</span>       
	                                    </td>
	                                    <td>
	                                    <span style="float:right"><%=bwo.getBtc_bwo_bank() %></span>
	                                    <span style="float:left"><%=bwo.getBtc_bwo_rname() %></span>
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=bwo.getBtc_bwo_card() %></span>
	                                    <span style="float:right;margin-right:10px"><%=bwo.getBtc_bwo_time() %></span>
	                                    </td>                                    
	                                </tr>	
	                            		<%
	                            	}
	                            }
	                            %>
	                            </tbody>
	                        </table>
	                        </form>
                    </div>
                </div>                                
                
            </div>
            <!-- rowspan -->
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
                                     window.location.href='index.do?withrawCNYorders&start='+start+'&count='+count+'';
                                }
                                function goto(){
                                     var obj = document.getElementById('pageNo'); //selectid
                                             var index = obj.selectedIndex;
                                             var start = obj.options[index].value; // 选中值
                                     var count = <%=pageSize%>;
                                     window.location.href='index.do?withrawCNYorders&start='+start+'&count='+count+'';
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
    </div>   
</body>
</html>
