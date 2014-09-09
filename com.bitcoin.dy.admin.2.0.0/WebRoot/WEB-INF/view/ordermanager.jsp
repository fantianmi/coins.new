<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mvc.util.*"%>
<%FormatUtil format = new FormatUtil(); %>
<%@ include file="/include/head.jsp"%>
<!-- ****************后台管理系统******************** -->
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<body>
    
	<jsp:include page="/include/headhtml.jsp"></jsp:include>
	<jsp:include page="/include/lpanelhtml.jsp"></jsp:include>
        
    <div class="content">
        
        
        <jsp:include page="/include/pathpanelhtml.jsp"></jsp:include>
        
        <div class="workplace">
        <script type="text/javascript">
	            function deleteorder(){
	                document.getElementById("ordersf").action = "order.do?deleteorder";
	                document.getElementById("ordersf").submit();
	            }
		</script>
            <div class="row-fluid">
                <%
			        int wtcountRow=0;
			        int wtstartNo=0;
			        if(request.getAttribute("wtcountRow")!=null){wtcountRow=Integer.parseInt(request.getAttribute("wtcountRow").toString());}
			        if(session.getAttribute("wtstartNo")!=null){wtstartNo=Integer.parseInt(session.getAttribute("wtstartNo").toString());}
			        %>
                <div class="span12">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>委托管理(<%=wtcountRow %>)</h1>
                        <ul class="buttons">
                            <li>
                                <a href="#" class="isw-settings"></a>
                                <ul class="dd-list">
                                    <li><a onclick="deleteorder()" href="#"><span class="isw-delete"></span>删除</a></li>
                                </ul>
                            </li>
                        </ul>  
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid table-sorting">
                    <form id="ordersf" action="" method="post">  
                        <table cellpadding="0" cellspacing="0" width="100%" class="table" id="tSortable">
                            <thead>
                                <tr>
                                    <th><input type="checkbox" name="checkall"/></th>
                                    <th width="25%">
                                    <span style="float:left">单号</span>
                                    <span style="float:right; margin-right:10px">用户名</span>
                                    </th>
                                    <th width="25%">
                                    <span style="float:left">委托类型</span>
                                    <span style="float:right; margin-right:10px">委托币种</span>                                   
                                    </th>
                                    <th width="25%">
                                    <span style="float:left">委托价格</span>
                                    <span style="float:right;margin-right:10px;">委托数量</span>
                                    </th>
                                    <th width="25%">
                                    <span style="float:left">下单时间</span>
                                    </th>                                    
                                </tr>
                            </thead>
                            <tbody>
                            <%if(session.getAttribute("orderlist")!=null){
                            	Map<Integer,Btc_user> usermap = (Map<Integer,Btc_user>)session.getAttribute("usermap2");
                            	Map<Integer,Btc_stock> stockmap = (Map<Integer,Btc_stock>)session.getAttribute("stockmap2");
                            	List<Btc_order> orderlist = (List<Btc_order>)session.getAttribute("orderlist");
                            	Btc_user user = new Btc_user();
                            	Btc_stock stock = new Btc_stock();
                            	Btc_order order = new Btc_order();
                            	for(int i=0;i<orderlist.size();i++){
                            		order = orderlist.get(i);
                            		user = usermap.get(order.getUid());
                            		stock = stockmap.get(order.getBtc_stock_id());
                            		%>
                            		<tr>
	                                    <td><input type="checkbox" name="checkbox" value="<%=order.getBtc_order_id()%>"/></td>
	                                    <td>
	                                    <span style="float:left"><%=order.getBtc_order_id() %></span>
	                                    <%if(user!=null){ %>
	                                    <span style="float:right; margin-right:10px"><%=user.getUusername() %></span>
	                                    <%}else{ %>
	                                    <span style="float:right; margin-right:10px">该用户已被删除</span>
	                                    <%} %>
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=order.getBtc_order_type() %></span>
	                                    <span style="float:right"><%=stock.getBtc_stock_name() %></span>     
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=format.trans(order.getBtc_order_price())%></span>
	                                    <span style="float:right;margin-right:10px;"><%=format.trans(order.getBtc_order_amount()) %></span>
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=order.getBtc_order_time()%></span>
	                                    </td>                                    
	                                </tr>
                            		<%
                            	}
                            }%>
                            </tbody>
                        </table>
                        </form>
                        <div class="clear"></div>
                        
                    </div>
                    <!-- rowspan -->
                    <div class="row-form" >
                        <div class="span9">
                                <div class="btn-group">
                                <%
                                int wtcount = wtcountRow;
                                int wtpageSize = 20;
                                int wtmyRows = 0;
                                   if(wtcount/wtpageSize==0){
                                          wtmyRows = wtcount/wtpageSize;
                                     }else{
                                           wtmyRows = wtcount/wtpageSize+1;
                                      }
                                        int     wtstart = wtstartNo;
                                        int wtend = wtpageSize * (wtmyRows-1);
                                   int wtpageNow = (wtstart+wtpageSize)/wtpageSize;
                                %>
                                </div>
                                <span><input class="btn" type="button" onclick="wtfenye(0,<%=wtpageSize%>);" value="首页"/></span>
                                <span><input id="prePage" class="btn" type="button" onclick="wtfenye(<%=wtstart-20 %>,<%=wtpageSize%>);" value="上一页"/></span>
                                <span class="lead">&nbsp;&nbsp;<%=wtpageNow %>&nbsp;&nbsp;</span>
                                <span><input id="nextPage" class="btn" type="button" onclick="wtfenye(<%=wtstart+20 %>,<%=wtpageSize%>);" value="下一页"/></span>
                                <span><input class="btn" type="button" onclick="wtfenye(<%=wtend%>,<%=wtpageSize%>);" value="末页"/></span>
                                <span style="width:30px">
                                <select id="pageNo" style="width:80px">
                                     <option value="<%=wtpageNow%>">第<%=wtpageNow%>页</option>
                                <%for(int i=1;i<=wtmyRows;i++){%>
                                     <option value="<%=(i-1)*wtpageSize%>">第<%=i%>页</option>
                                <%} %>
                                </select>
                                <input class="btn" type="button" onclick="wtgoto();" value="GO"/>
                                </span>
                                <script>
                                function wtfenye(wtstart,wtcount){
                                     window.location.href='index.do?allorders&wtstart='+wtstart+'&wtcount='+wtcount+'';
                                }
                                function wtgoto(){
                                     var obj = document.getElementById('pageNo'); //selectid
                                             var index = obj.selectedIndex;
                                             var wtstart = obj.options[index].value; // 选中值
                                     var wtcount = <%=wtpageSize%>;
                                     window.location.href='index.do?allorders&wtstart='+wtstart+'&wtcount='+wtcount+'';
                                }
                                $(document).ready(function() {
                                     var wtstart = <%=wtstart%>;
                                     var wtcount = <%=wtcount%>
                                             if(wtstart-20<0){
                                                  document.getElementById('prePage').setAttribute("disabled",true);
                                             }
                                             if(wtcount-wtstart<20){
                                                  document.getElementById('nextPage').setAttribute('disabled',true);
                                             }
                                        });
                                </script>
                            </div>
                    <!-- rowspan -->
                </div>                                
                
            </div>            
            
            <div class="dr"><span></span></div> 
            <script type="text/javascript">
			            function ddeallist(){
			                document.getElementById('deallistf').action = "order.do?ddeallist";
			                document.getElementById("deallistf").submit();
			            }
			</script>
            <div class="row-fluid">
                <%
		        int countRow=0;
		        int fhstartNo=0;
		        if(request.getAttribute("countRow")!=null){countRow=Integer.parseInt(request.getAttribute("countRow").toString());}
		        if(session.getAttribute("jystartNo")!=null){fhstartNo=Integer.parseInt(session.getAttribute("jystartNo").toString());}
		        %>
		                
                <div class="span12">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>成交记录(<%=countRow %>)</h1>
                       <ul class="buttons">
	                            <li>
	                                <a href="#" class="isw-settings"></a>
	                                <ul class="dd-list">
	                                    <li><a onclick="ddeallist()" href="#"><span class="isw-delete"></span>删除</a></li>
	                                </ul>
	                            </li>
	                        </ul>         
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid" >
                    <form id="deallistf" action="" method="post">  
                        <table class="table" cellpadding="0" cellspacing="0" width="100%">
                            <thead>
                                <tr>             
                                	<th><input type="checkbox" name="checkall"/></th>                       
                                    <th width="20%">
                                    <span style="float:left">成交单号</span>
                                    <span style="float:right; margin-right:10px">成交价格</span>
                                    </th>
                                    <th width="20%">
                                    <span style="float:left">成交数量</span>
                                    <span style="float:right; margin-right:10px">成交总价</span>
                                    </th>
                                    <th width="20%">
                                    <span style="float:left">买家id</span>
                                    <span style="float:right; margin-right:10px">卖家id</span>
                                    </th>
                                    <th width="20%">
                                    <span style="float:left">成交类型</span>
                                    <span style="float:right; margin-right:10px">成交币种</span>
                                    </th>
                                    <th width="20%">
                                    <span style="float:left">成交时间</span>
                                    </th>                                    
                                </tr>
                            </thead>
                            <tbody>
                            <%if(session.getAttribute("deallist")!=null){
                            	List<Btc_deal_list> deallist = (List<Btc_deal_list>)session.getAttribute("deallist");
                            	Map<Integer,Btc_stock> stockmap = (Map<Integer,Btc_stock>)session.getAttribute("stockmap2");
                            	Btc_deal_list bdl = new Btc_deal_list();
                            	Btc_stock stock = new Btc_stock();
                            	for(int i=0;i<deallist.size();i++){
                            		bdl=deallist.get(i);
                            		stock = stockmap.get(bdl.getBtc_stock_id());
                            		%>
                            		<tr>               
                            		 	<td><input type="checkbox" name="checkbox" value="<%=bdl.getBtc_deal_id()%>"/></td>                     
	                                    <td>
	                                    <span style="float:left"><%=bdl.getBtc_deal_id() %></span>
	                                    <span style="float:right; margin-right:10px"><%=format.trans(bdl.getBtc_deal_Rate()) %></span>
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=format.trans(bdl.getBtc_deal_quantity()) %></span>
	                                    <span style="float:right; margin-right:10px"><%=format.trans(bdl.getBtc_deal_quantity()) %></span>
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><a href="usermanager.do?seeDetail&uid=<%=bdl.getBuid() %>"><%=bdl.getBuid()%></a></span>
	                                    <span style="float:right; margin-right:10px"><a href="usermanager.do?seeDetail&uid=<%=bdl.getSuid()%>"><%=bdl.getSuid()%></a></span>
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=bdl.getBtc_deal_type() %></span>
	                                    <span style="float:right; margin-right:10px"><%=stock.getBtc_stock_name() %></span>
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=bdl.getBtc_deal_time() %></span>
	                                    </td>
	                                </tr>
                            	
                            	<%}
                            } %>
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
                          int pageSize = 13;
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
                          <span><input id="prePage" class="btn" type="button" onclick="fenye(<%=start-13 %>,<%=pageSize%>);" value="上一页"/></span>
                          <span class="lead">&nbsp;&nbsp;<%=pageNow %>&nbsp;&nbsp;</span>
                          <span><input id="nextPage" class="btn" type="button" onclick="fenye(<%=start+13 %>,<%=pageSize%>);" value="下一页"/></span>
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
                               window.location.href='index.do?allorders&start='+start+'&count='+count+'';
                          }
                          function goto(){
                               var obj = document.getElementById('pageNo'); //selectid
                                       var index = obj.selectedIndex;
                                       var start = obj.options[index].value; // 选中值
                               var count = <%=pageSize%>;
                               window.location.href='index.do?allorders&start='+start+'&count='+count+'';
                          }
                          $(document).ready(function() {
                               var start = <%=start%>;
                               var count = <%=count%>
                                       if(start-13<0){
                                            document.getElementById('prePage').setAttribute("disabled",true);
                                       }
                                       if(count-start<13){
                                            document.getElementById('nextPage').setAttribute('disabled',true);
                                       }
                                  });
                          </script>
                      </div>
            <!-- rowspan -->
        </div>
        
    </div>   
    <!-- ###################################################################### -->
    
</body>
</html>
