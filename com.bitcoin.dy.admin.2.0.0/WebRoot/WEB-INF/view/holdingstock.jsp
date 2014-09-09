<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.mvc.vo.*"%>
<%@page import="com.mvc.entity.*"%>
<%@page import="com.mvc.util.*"%>
<%@ page import="java.util.*"%>
<%@ include file="/include/head.jsp"%>
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<%FormatUtil format = new FormatUtil();
int stockid=Integer.parseInt(request.getAttribute("stockid").toString());
%>
<body>
<script type="text/javascript" src="js/search.js"></script>
<!-- ****************后台管理系统******************** -->
	<jsp:include page="/include/headhtml.jsp"></jsp:include>
	<jsp:include page="/include/lpanelhtml.jsp"></jsp:include>
	<script type="text/javascript">
    function select_menu(){
       if(document.getElementById("yonghuzijin")!=null){
       		$("#yonghuzijin").addClass("active");
       }else{
    	   return false;
       }
       if(document.getElementById("yonghuzijin").parentNode.parentNode!=null){
    	   $("#yonghuzijin").parent().parent().addClass('active');
       }else{
    	   return false;
       }
   }
    
    $(document).ready(function(){
    	select_menu();
    });
    </script>
    
    <div class="content">
        <jsp:include page="/include/pathpanelhtml.jsp"></jsp:include>
        <div class="workplace">
            <div class="row-fluid">
            <!-- table -->
            <div class="span12">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>用户资金查看(<%=request.getAttribute("countHold") %>)&nbsp;&nbsp;(当前资金：<%=request.getAttribute("currentCoin").toString() %>)</h1>             
						<ul class="buttons">
							<li>
                                <a href="#" class="isw-settings"></a>
                                <ul class="dd-list">
                                    <li><a onclick="beAdmin()" href="#"><span class="isw-edit"></span>赋予管理员角色</a></li>
                                    <li><a onclick="frozen()" href="#"><span class="isw-delete"></span>冻结</a></li>
                                    <li><a onclick="cancelFrozen()" href="#"><span class="isw-delete"></span>取消冻结</a></li>
                                    <li><a onclick="deleteU()" href="#"><span class="isw-delete"></span>删除</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#"  style="font-size: 16px;color:#666;line-height: 35px;height:60px;background-color: #fff">&nbsp;&nbsp;选择币种：&nbsp;&nbsp;<%=request.getAttribute("currentCoin").toString() %>&nbsp;&nbsp;↓</a>
                                <ul class="dd-list">
                                    <li><a href="holding.do?cny"><span class="isw-target"></span>人民币</a></li>
                                <%if(session.getAttribute("stockmap")!=null){
                                	Map<Integer,Btc_stock> stockmap=(Map<Integer,Btc_stock>)session.getAttribute("stockmap");
                                	Iterator it=stockmap.keySet().iterator();
                                	Btc_stock stock=new Btc_stock();
                                	while(it.hasNext()){
                                		int key=Integer.parseInt(it.next().toString());
                                		stock=stockmap.get(key);%>
                                    <li><a href="holding.do?coin&stockid=<%=stock.getBtc_stock_id()%>"><span class="isw-target"></span><%=stock.getBtc_stock_name() %></a></li>
                                	<%}}	%>
                                </ul>
                            </li>
                            <li>
                            </li>
                        </ul>                               
                        <div class="clear"></div>
                    </div>
                    <%
			        int countRow=0;
			        int fhstartNo=0;
			        String currentCoin=request.getAttribute("currentCoin").toString();
			        if(request.getAttribute("countHold")!=null){countRow=Integer.parseInt(request.getAttribute("countHold").toString());}
			        if(session.getAttribute("holdcoinStartNO")!=null){fhstartNo=Integer.parseInt(session.getAttribute("holdcoinStartNO").toString());}
			        %>
                    <div class="block-fluid table-sorting">
                        <table cellpadding="0" cellspacing="0" width="100%" class="table" id="tSortable">
                            <thead>
                                <tr>
                                    <th><input type="checkbox" name="checkall"/></th><th width="25%">序号</th><th width="25%">用户名</th><th width="25%">真实姓名</th><th width="25%">持有量</th>                                    
                                </tr>
                            </thead>
                            <tbody>
                            <form id="holdingForm" action="" method="post">
                            <%if(request.getAttribute("userListVo")!=null){
                            	List<UserHold> list=(List<UserHold>)request.getAttribute("userListVo");
                            	UserHold hold=new UserHold();
                            	for(int i=0;i<list.size();i++){
                            		hold=list.get(i);%>
                            		<tr><td><input type="checkbox" name="checkbox" value="<%=hold.getId()%>"/></td><td><%=hold.getId() %></td><td><a href="usermanager.do?seeDetail&uid=<%=hold.getId()%>"><%=hold.getUsername()%></a></td><td><%=hold.getName()%></td><td><%=format.trans(hold.getAmount())%></td></tr>
                            	<%}} %>
                            	</form>
                            	<script type="text/javascript">
						            function beAdmin(){
						                document.getElementById("holdingForm").action = "usermanager.do?beAdmin";
						                document.getElementById("holdingForm").submit();
						            }
						            function frozen(){
						                document.getElementById("holdingForm").action = "usermanager.do?frozen";
						                document.getElementById("holdingForm").submit();
						            }
						            function cancelFrozen(){
						                document.getElementById("holdingForm").action = "usermanager.do?cancelFrozen";
						                document.getElementById("holdingForm").submit();
						            }
						            function deleteU(){
						                document.getElementById("holdingForm").action = "usermanager.do?deleteU";
						                document.getElementById("holdingForm").submit();
						            }
								</script>
                            </tbody>
                        </table>
                        <div class="clear"></div>
                    </div>
                </div>       
            <!-- table -->
            </div>            
            <!-- fenye -->
            <div class="row-form" >
				    <div class="span9">
                                <div class="btn-group">
                                <%
                                int count = Integer.parseInt(request.getAttribute("countHold").toString());
                                int pageSize = 100;
                                int myRows = 0;
                    			if(count/pageSize==0){
            						myRows = count/pageSize;
            					}else{
             						myRows = count/pageSize+1;
             					}
               					int	start = Integer.parseInt(session.getAttribute("holdcoinStartNO").toString());
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
                                	window.location.href='holding.do?coin&stockid=<%=stockid%>&start='+start+'&count='+count+'';
                                }
                                function goto(){
                                	var obj = document.getElementById('pageNo'); //selectid
									var index = obj.selectedIndex;
									var start = obj.options[index].value; // 选中值
                                	var count = <%=pageSize%>;
                                	window.location.href='holding.do?coin&stockid=<%=stockid%>&start='+start+'&count='+count+'';
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
				    <div class="clear"></div>
				</div>
            <!-- fenye -->
            <div class="dr"><span></span></div> 
            <div class="row-fluid">
            <div class="span3">
                    <div class="head">
                        <div class="isw-documents"></div>
                        <h1>快速查询用户</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">                        
                        <div class="row-form">
                            <div class="span12">
                                <select name="searchWay">
                                        <option value="byid">根据用户id查询</option>
                                        <option value="byuusername">根据用户名查询</option>
                                        <option value="byuname">根据真实姓名查询</option>
                                </select>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="row-form">
                            <div class="span12"><input placeholder="查询内容" name="scontent" type="text" id="searchContent"></div>
                            <div class="clear"></div>
                        </div> 
                        <div class="row-form">
                            <div class="span4"></div>
                            <div class="span8"><input value="查询" class="btn" type="button" onclick="dosearch();"></div>
                            <div class="clear"></div>
                        </div> 
                    </div>
                </div>
                <!-- span -->
                <div class="span9">                    
			                    <div class="head">
			                        <div class="isw-grid"></div>
			                        <h1>查询结果</h1>
			                        <div class="clear"></div>
			                    </div>
			                    <div class="block-fluid table-sorting">
			                        <table class="table" id="tSortable_2" cellpadding="0" cellspacing="0" width="100%">
			                            <thead>
			                                <tr>
			                                    <th></th>
			                                    <th width="25%">
			                                    <span style="float:left">ID</span>
			                                    <span style="float:right; margin-right:10px">登陆</span>
			                                    </th>
			                                    <th width="20%">
			                                    <span style="float:left">角色</span>
			                                    &nbsp;&nbsp;
			                                    <span style="float:right; margin-right:10px">[手机号]</span>                                   
			                                    </th>
			                                    <th width="25%">
			                                    <span style="float:left">注册时间</span>
			                                    <span style="float:right;margin-right:10px;">用户状态</span>
			                                    </th>
			                                    <th width="30%">
			                                    <span style="float:left">身份证信息</span>
			                                    <span style="float:right;margin-right:10px">真实姓名</span>
			                                    </th>                                    
			                                </tr>
			                            </thead>
			                            <form id="smyForm" action="" method="post">
			                            <tbody id="searchresult">
			                            
			                            </tbody>
			                            </form>
			                        </table>
			                        <div class="clear"></div>
			                        
			                    </div>                               
			                
			            </div>
                <!-- span -->
            </div>
        </div>
        
    </div>   
    <!-- ###################################################################### -->
    
</body>
</html>
