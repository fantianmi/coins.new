<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<body>

<script type="text/javascript">
    var smenu2 = "fenhonginput";
    function select_menu2(){
       if(document.getElementById(smenu2)!=null){
       		$("#" + smenu2).addClass("active");
       }else{
    	   return false;
       }
       if(document.getElementById(smenu2).parentNode.parentNode!=null){
    	   $("#" + smenu2).parent().parent().addClass('active');
       }else{
    	   return false;
       }
   }
    
    $(document).ready(function(){
    	select_menu2();
    });
    </script>
<!-- ****************后台管理系统******************** -->
<script type="text/javascript">
            function diliver(){
                document.getElementById('myForm').action = "fenhong.do?deliverFenhong";
                document.getElementById("myForm").submit();
            }
            
            function reject(){
                document.getElementById('myForm').action = "fenhong.do?rejectFenhong";
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
        <!-- params -->
        <%
        int countRow=0;
        int fhstartNo=0;
        if(request.getAttribute("countRow")!=null){countRow=Integer.parseInt(request.getAttribute("countRow").toString());}
        if(session.getAttribute("fhstartNo")!=null){fhstartNo=Integer.parseInt(session.getAttribute("fhstartNo").toString());}
        %>
        <!-- params -->
        <div class="workplace">
            <div class="row-fluid">
                <form id="myForm" action="" method="post">
                <div class="span12">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>持有分红币参与分红的用户（<%=countRow%>）</h1>
                        <ul class="buttons">
                            <li>
                                <a href="#" class="isw-settings"></a>
                                <ul class="dd-list">
                                    <li><a onclick="diliver()" href="#"><span class="isw-edit"></span>发放分红</a></li>
                                    <li><a onclick="reject()" href="#"><span class="isw-delete"></span>拒绝分红</a></li>
                                </ul>
                            </li>
                        </ul>                               
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid table-sorting">
                        <table cellpadding="0" cellspacing="0" width="100%" class="table" >
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
                                    <span style="float:left">获得平台手续费收入</span>
                                    <span style="float:right;margin-right:10px;">分红期次</span>
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
                            <%if(request.getAttribute("orderlist")!=null){
                            	Btc_fh_order bfo = new Btc_fh_order();
                            	Btc_user user = new Btc_user();
                            	List<Btc_fh_order> bfolist = (List<Btc_fh_order>)request.getAttribute("orderlist");
                            	Map<Integer,Btc_user> usermap = (Map<Integer,Btc_user>)session.getAttribute("usermap");
                            	for(int i=0;i<bfolist.size();i++){
                            		bfo = bfolist.get(i);
                            		if(usermap.get(bfo.getUid())==null) continue;
                            		user = usermap.get(bfo.getUid());
                            		%>
                            		<tr>
	                                    <td><input type="checkbox" name="checkbox" value="<%=bfo.getFh_order_id() %>"/></td>
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
	                                    <span style="float:left">￥<%=bfo.getAmount()%></span>
	                                    <span style="float:right;margin-right:10px;">
	                                    	第<%=bfo.getSeason() %>期
	                                    </span>
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
                    <!-- row span -->
                     <!-- fenye -->
                    <div class="row-form" >
				    <div class="span9">
                                <div class="btn-group">
                                <%
                                int count = countRow;
                                int pageSize = 500;
                                int myRows = 0;
                    			if(count/pageSize==0){
            						myRows = count/pageSize;
            					}else{
             						myRows = count/pageSize+1;
             					}
               					int	start = fhstartNo;
               					int end = pageSize * (myRows-1);
                    			int pageNow = (start+pageSize)/pageSize;
                                %>
                                </div>
                                <span><input class="btn" type="button" onclick="fenye(0,<%=pageSize%>);" value="首页"/></span>
                                <span><input id="prePage" class="btn" type="button" onclick="fenye(<%=start-500 %>,<%=pageSize%>);" value="上一页"/></span>
                                <span class="lead">&nbsp;&nbsp;<%=pageNow %>&nbsp;&nbsp;</span>
                                <span><input id="nextPage" class="btn" type="button" onclick="fenye(<%=start+500 %>,<%=pageSize%>);" value="下一页"/></span>
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
                                	window.location.href='index.do?deliverfenhong2&start='+start+'&count='+count+'';
                                }
                                function goto(){
                                	var obj = document.getElementById('pageNo'); //selectid
									var index = obj.selectedIndex;
									var start = obj.options[index].value; // 选中值
                                	var count = <%=pageSize%>;
                                	window.location.href='index.do?deliverfenhong2&start='+start+'&count='+count+'';
                                }
                                
                                $(document).ready(function() {
                                	var start = <%=start%>;
                                	var count = <%=count%>
									if(start-500<0){
										document.getElementById('prePage').setAttribute("disabled",true);
									}
									if(count-start<500){
										document.getElementById('nextPage').setAttribute('disabled',true);
									}
								});
                                </script>                               
                            </div>
                    <!-- row span -->
                </div>                                
                
            </div>            
            
            <div class="dr"><span></span></div> 
    
</body>
</html>
