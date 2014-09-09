<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<body>
<!-- ****************后台管理系统******************** -->
<script type="text/javascript">
            function beAdmin(){
                document.getElementById('myForm').action = "usermanager.do?beAdmin";
                document.getElementById("myForm").submit();
            }
            
            function frozen(){
                document.getElementById('myForm').action = "usermanager.do?frozen";
                document.getElementById("myForm").submit();
            }
            
            function cancelFrozen(){
                document.getElementById('myForm').action = "usermanager.do?cancelFrozen";
                document.getElementById("myForm").submit();
            }
           
            function deleteU(){
                document.getElementById('myForm').action = "usermanager.do?deleteU";
                document.getElementById("myForm").submit();
            }
            
            function cancelAdmin(){
                document.getElementById('managerList').action = "usermanager.do?cancelAdmin";
                document.getElementById("managerList").submit();
            }
            
            function deleteAdmin(){
                document.getElementById('managerList').action = "usermanager.do?deleteAdmin";
                document.getElementById("managerList").submit();
            }
            
            function sbeAdmin(){
                document.getElementById('smyForm').action = "usermanager.do?beAdmin";
                document.getElementById("smyForm").submit();
            }
            
            function sfrozen(){
                document.getElementById('smyForm').action = "usermanager.do?frozen";
                document.getElementById("smyForm").submit();
            }
            
            function scancelFrozen(){
                document.getElementById('smyForm').action = "usermanager.do?cancelFrozen";
                document.getElementById("smyForm").submit();
            }
           
            function sdeleteU(){
                document.getElementById('smyForm').action = "usermanager.do?deleteU";
                document.getElementById("smyForm").submit();
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
        
        <div class="workplace">
            <div class="row-fluid">
                <form id="myForm" action="" method="post">
                <div class="span12">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>注册用户管理（<%=session.getAttribute("countAllUser").toString() %>）</h1>
                        <ul class="buttons">
                            <li>
                                <a href="#" class="isw-settings"></a>
                                <ul class="dd-list">
                                    <li><a onclick="beAdmin();" href="#"><span class="isw-edit"></span>赋予管理员角色</a></li>
                                    <li><a onclick="frozen();" href="#"><span class="isw-delete"></span>冻结</a></li>
                                    <li><a onclick="cancelFrozen();" href="#"><span class="isw-delete"></span>取消冻结</a></li>
                                    <li><a onclick="deleteU();" href="#"><span class="isw-delete"></span>删除</a></li>
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
                                    <span style="float:left">ID</span>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <span>登陆</span>
                                    <span style="float:right; margin-right:10px">角色</span>
                                    </th>
                                    <th width="25%">
                                    <span style="float:left">[活动资金]</span>
                                    &nbsp;&nbsp;
                                    <span style="float:right; margin-right:10px">[手机号]</span>                                   
                                    </th>
                                    <th width="25%">
                                    <span style="float:left">注册时间</span>
                                    <span style="float:right;margin-right:10px;">用户状态</span>
                                    </th>
                                    <th width="25%">
                                    <span style="float:left">身份证信息</span>
                                    <span style="float:right;margin-right:10px">真实姓名</span>
                                    </th>                                    
                                </tr>
                            </thead>
                            <tbody>
                            <%if(session.getAttribute("allUserList")!=null){
                            	Map<Integer,Btc_account_book> accountMap = (Map<Integer,Btc_account_book>)session.getAttribute("allUserByMap");
                            	List<Btc_user> Btc_user_list = (List<Btc_user>)session.getAttribute("allUserList");
                            	Btc_user user = new Btc_user();
                            	for(int i=0;i<Btc_user_list.size();i++){
                            		user = Btc_user_list.get(i);
                            		%>
                            		<tr>
	                                    <td><input type="checkbox" name="checkbox" value="<%=user.getUid() %>"/></td>
	                                    <td>
	                                    <span style="float:left"><%=user.getUid() %></span>
	                                    &nbsp;&nbsp;&nbsp;
	                                    <span><a href="usermanager.do?seeDetail&uid=<%=user.getUid() %>"><%=user.getUusername() %></a></span>
	                                    <%if(user.getUrole().equals("admin")){%>
	                                    <span style="float:right; margin-right:10px">管理员</span>
	                                    <%}else{%>
	                                    <span style="float:right; margin-right:10px">普通会员</span>
	                                    <%} %>
	                                    </td>
	                                    <td>
	                                    <%if(accountMap.get(user.getUid())!=null){
	                                    	%>
	                                    <span style="float:left">[￥<%=accountMap.get(user.getUid()).getAb_cny()%>]</span>
	                                    <% }else{%>
	                                    <span style="float:left">[￥0.00]</span>
	                                    <%} %>
	                                    &nbsp;&nbsp;
	                                    <span style="float:right"><%=user.getUphone()%></span>     
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=user.getUsdtime() %></span>
	                                    <%if(user.getUstatus().equals("frozen")){%>
	                                    <span style="float:right;margin-right:10px;">冻结</span>
	                                    <%}else{%>
	                                    <span style="float:right;margin-right:10px;">正常</span>
	                                    <%} %>
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=user.getUcertification() %></span>
	                                    <span style="float:right;margin-right:10px"><%=user.getUname() %></span>
	                                    </td>                                    
	                                </tr>
                            		<%
                            	}
                            }%>
                            </tbody>
                        </table>
                        <div class="clear"></div>
                        </form>
                    </div>
                    <!-- fenye -->
                    <div class="row-form" >
				    <div class="span9">
                                <div class="btn-group">
                                <%
                                int count = Integer.parseInt(session.getAttribute("countAllUser").toString());
                                int pageSize = 100;
                                int myRows = 0;
                    			if(count/pageSize==0){
            						myRows = count/pageSize;
            					}else{
             						myRows = count/pageSize+1;
             					}
               					int	start = Integer.parseInt(session.getAttribute("startNo").toString());
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
                                	window.location.href='index.do?userlist&start='+start+'&count='+count+'';
                                }
                                function goto(){
                                	var obj = document.getElementById('pageNo'); //selectid
									var index = obj.selectedIndex;
									var start = obj.options[index].value; // 选中值
                                	var count = <%=pageSize%>;
                                	window.location.href='index.do?userlist&start='+start+'&count='+count+'';
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
                </div>                                
                
            </div>            
            
            <div class="dr"><span></span></div> 
            
            <div class="row-fluid">
                <div class="span4">
                    <div class="head">
                        <div class="isw-documents"></div>
                        <h1>快速查询用户</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">                        
                    	<form action="usermanager.do?search" method="post">
                        <div class="row-form">
                            <div class="span9">
                                <select name="searchway">
                                        <option value="byid">根据用户id查询</option>
                                        <option value="byuusername">根据用户名查询</option>
                                        <option value="byuname">根据真实姓名查询</option>
                                </select>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="row-form">
                            <div class="span9"><input placeholder="查询内容" name="scontent" type="text"></div>
                            <div class="clear"></div>
                        </div> 
                        <div class="row-form">
                            <div class="span3"></div>
                            <div class="span9"><input value="查询" class="btn" type="submit"></div>
                            <div class="clear"></div>
                        </div> 
						</form>
                        
                    </div>
                </div>
                <div class="span8">                    
                    <div class="head">
                    <form action="" id="managerList" method="post">
                        <div class="isw-grid"></div>
                        <h1>管理员列表</h1>
                        <ul class="buttons">
                        </ul>                               
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid table-sorting">
                        <table cellpadding="0" cellspacing="0" width="100%" class="table" id="tSortable">
                            <thead>
                                <tr>
                                    <th width="25%">
                                    <span style="float:left">ID</span>
                                    <span style="float:right; margin-right:10px">登陆</span>
                                    </th>
                                    <th width="25%">
                                    <span>姓名</span>                               
                                    </th>
                                    <th width="25%">
                                    <span>身份证信息</span>                                    
                                    </th>
                                    <th width="25%">
                                    <span style="float:left">管理员角色</span>
                                    </th>                                    
                                    <th>
                                    <span style="float:left"></span>
                                    </th>                                    
                                </tr>
                            </thead>
                            <tbody>
                            <%if(session.getAttribute("managerList")!=null){
                            	Btc_user admin = new Btc_user();
                            	List<Btc_user> adminList = (List<Btc_user>)session.getAttribute("managerList");
                            	for(int i=0;i<adminList.size();i++){
                            		admin = adminList.get(i);
                            		%>
	                            	<tr>
	                                    <td>
	                                    <span style="float:left"><%=admin.getUid() %></span>
	                                    <span style="float:right; margin-right:10px"><%=admin.getUusername() %></span>
	                                    </td>
	                                    <td>
	                                    <span><%=admin.getUname() %></span> 
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=admin.getUcertification() %></span>
	
	                                    </td>
	                                    <td>
	                                    <span style="float:left">管理员</span>
	                                    </td>                                    
	                                    <td>
	                                    <span style="float:left"><a class="isb-cancel" href="usermanager.do?cancelAdmin&uid=<%=admin.getUid()%>"></a></span>
	                                    </td>                                    
	                                </tr>
                            		
                            	<%}
                            } %>
                            </tbody>
                        </table>
                        <div class="clear"></div>
                    </div>
                    </form>
                </div>       
            <div class="dr"><span></span></div>  
            <div class="row-fluid">
                <form id="smyForm" action="" method="post">
                <div class="span12">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>查询结果</h1>
                        <ul class="buttons">
                            <li>
                                <a href="#" class="isw-settings"></a>
                                <ul class="dd-list">
                                    <li><a onclick="sbeAdmin()" href="#"><span class="isw-edit"></span>赋予管理员角色</a></li>
                                    <li><a onclick="sfrozen()" href="#"><span class="isw-delete"></span>冻结</a></li>
                                    <li><a onclick="scancelFrozen()" href="#"><span class="isw-delete"></span>取消冻结</a></li>
                                    <li><a onclick="sdeleteU()" href="#"><span class="isw-delete"></span>删除</a></li>
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
                                    <span style="float:left">ID</span>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <span>登陆</span>
                                    <span style="float:right; margin-right:10px">角色</span>
                                    </th>
                                    <th width="25%">
                                    <span style="float:left">[活动资金]</span>
                                    &nbsp;&nbsp;
                                    <span style="float:right; margin-right:10px">[手机号]</span>                                   
                                    </th>
                                    <th width="25%">
                                    <span style="float:left">注册时间</span>
                                    <span style="float:right;margin-right:10px;">用户状态</span>
                                    </th>
                                    <th width="25%">
                                    <span style="float:left">身份证信息</span>
                                    <span style="float:right;margin-right:10px">真实姓名</span>
                                    </th>                                    
                                </tr>
                            </thead>
                            <tbody>
                            <%if(session.getAttribute("resultlist")!=null){
                            	Map<Integer,Btc_account_book> accountMap = (Map<Integer,Btc_account_book>)session.getAttribute("allUserByMap");
                            	List<Btc_user> Btc_user_list = (List<Btc_user>)session.getAttribute("resultlist");
                            	Btc_user user = new Btc_user();
                            	for(int i=0;i<Btc_user_list.size();i++){
                            		user = Btc_user_list.get(i);
                            		%>
                            		<tr>
	                                    <td><input type="checkbox" name="checkbox" value="<%=user.getUid() %>"/></td>
	                                    <td>
	                                    <span style="float:left"><%=user.getUid() %></span>
	                                    &nbsp;&nbsp;&nbsp;
	                                    <span><a href="usermanager.do?seeDetail&uid=<%=user.getUid() %>"><%=user.getUusername() %></a></span>
	                                    <%if(user.getUrole().equals("admin")){%>
	                                    <span style="float:right; margin-right:10px">管理员</span>
	                                    <%}else{%>
	                                    <span style="float:right; margin-right:10px">普通会员</span>
	                                    <%} %>
	                                    </td>
	                                    <td>
	                                    <%if(accountMap.get(user.getUid())!=null){
	                                    	%>
	                                    <span style="float:left">[￥<%=accountMap.get(user.getUid()).getAb_cny()%>]</span>
	                                    <% }else{%>
	                                    <span style="float:left">[￥0.00]</span>
	                                    <%} %>
	                                    &nbsp;&nbsp;
	                                    <span style="float:right"><%=user.getUphone()%></span>     
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=user.getUsdtime() %></span>
	                                    <%if(user.getUstatus().equals("frozen")){%>
	                                    <span style="float:right;margin-right:10px;">冻结</span>
	                                    <%}else{%>
	                                    <span style="float:right;margin-right:10px;">正常</span>
	                                    <%} %>
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=user.getUcertification() %></span>
	                                    <span style="float:right;margin-right:10px"><%=user.getUname() %></span>
	                                    </td>                                    
	                                </tr>
                            		<%
                            	}
                            }%>
                            </tbody>
                        </table>
                        <div class="clear"></div>
                        </form>
                    </div>                               
                
            </div>       
        </div>
        
    </div>   
    <!-- ###################################################################### -->
    
</body>
</html>
