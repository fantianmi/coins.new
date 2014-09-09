<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<body>
<!-- ****************后台管理系统******************** -->
<script type="text/javascript">
            function agreevote(){
                document.getElementById('myForm').action = "votestock.do?agreevote";
                document.getElementById("myForm").submit();
            }
           
            function rejectvote(){
                document.getElementById('myForm').action = "votestock.do?rejectvote";
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
	                        <h1>币种加入平台投票</h1>
	                        <ul class="buttons">
	                            <li>
	                                <a href="#" class="isw-settings"></a>
	                                <ul class="dd-list">
	                                    <li><a onclick="agreevote()" href="#"><span class="isw-edit"></span>同意</a></li>
	                                    <li><a onclick="rejectvote()" href="#"><span class="isw-plus"></span>拒绝</a></li>
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
	                                    <span style="float:left">中文名</span>
	                                    <span style="float:right"  margin-right:10px">全名</span>
	                                    </th>
	                                    <th width="20%">
	                                    <span style="float:left">英文简称</span>
	                                    <span style="float:right; margin-right:10px">状态</span>                                   
	                                    </th>
	                                    <th width="30%">
	                                    <span style="float:left">申请人用户名</span>
	                                    <span style="float:right; margin-right:10px">申请人真实姓名</span>  
	                                    
	                                    </th>
	                                    <th width="25%">
	                                    <span style="float:left">申请人注册时间</span>
	                                    </th>                                    
	                                </tr>
	                            </thead>
	                            <tbody>
	                            <%
	                            if(request.getAttribute("usermap")!=null&&request.getAttribute("votelist")!=null){
	                            	Btc_user user = new Btc_user();
	                            	Btc_votestock vote = new Btc_votestock();
	                            	List<Btc_votestock> votelist = (List<Btc_votestock>)request.getAttribute("votelist");
	                            	Map<String,Btc_user> usermap = (Map<String,Btc_user>)request.getAttribute("usermap");
	                            	for(int i=0;i<votelist.size();i++){
	                            		vote = votelist.get(i);
	                            		user = usermap.get(vote.getUsername());
	                            		%>
	                            		  <tr>
	                                    <td><input type="checkbox" name="checkbox" value="<%=vote.getVid() %>"/></td>
	                                    <td>
	                                    <span style="float:left"><%=vote.getVstockname() %></span>
	                                    <span style="float:right; margin-right:10px"><%=vote.getVstockfullName() %></span>
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=vote.getVstockEngname() %></span>
	                                    <span style="float:right; margin-right:10px"><%=vote.getVstatus() %></span>
	                                    </td>
	                                    <td>
	                                    <span style="float:right">
	                                    <%=user.getUname() %>
	                                    </span>
	                                    <span style="float:left">
	                                    <a href="usermanager.do?seeDetail&uid=<%=user.getUid() %>">
	                                    <%=user.getUusername() %>
	                                    </a>
	                                    </span>
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=user.getUsdtime() %></span>
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
                 
            
        </div>
        <!-- ####################/content area############### -->
    </div>   
</body>
</html>
