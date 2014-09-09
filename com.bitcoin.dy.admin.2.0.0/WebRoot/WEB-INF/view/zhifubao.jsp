<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<body>
<!-- ****************后台管理系统******************** -->
<script type="text/javascript">
            function add(){
                document.getElementById('myForm').action = "zhi.do?add";
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
        <div class="workplace">
            <div class="row-fluid">
                <form id="myForm" action="" method="post">     
                <div class="span12">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <%
			        int countRow=0;
			        int fhstartNo=0;
			        if(request.getAttribute("countRow")!=null){countRow=Integer.parseInt(request.getAttribute("countRow").toString());}
			        if(session.getAttribute("zhistartNo")!=null){fhstartNo=Integer.parseInt(session.getAttribute("zhistartNo").toString());}
			        %>
                        <h1>支付宝绑定激活申请(<%=countRow %>)</h1>
                        <ul class="buttons">
                            <li>
                                <a href="#" class="isw-settings"></a>
                                <ul class="dd-list">
                                    <li><a onclick="add()" href="#"><span class="isw-plus"></span>确认激活</a></li>
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
                                    姓名
                                   </th>
                                    <th width="25%">
                                    手机号
                                    </th>
                                    <th width="25%">
                                  	 支付宝账号
                                    </th>
                                    <th width="25%">
                                  	  注册账号
                                    </th>                                    
                                </tr>
                            </thead>
                            <tbody>
                            <%if(request.getAttribute("zhilist")!=null){
                            	List<Btc_zhifubao> zhilist = (List<Btc_zhifubao>)request.getAttribute("zhilist");
                            	Map<Integer,Btc_user> usermap = (Map<Integer,Btc_user>)request.getAttribute("usermap");
                            	Btc_user user = new Btc_user();
                            	Btc_zhifubao zhi = new Btc_zhifubao();
                            	for(int i=0;i<zhilist.size();i++){
                            		zhi = zhilist.get(i);
                            		user = usermap.get(zhi.getUid());
                            		%>
                            		<tr>
	                                    <td><input type="checkbox" name="checkbox" value="<%=zhi.getId()%>"/></td>
	                                    <td><%=user.getUname() %> </td>
	                                    <td><%=user.getUphone() %></td>
	                                    <td><%=zhi.getCard()%></td>
	                                    <td><%=user.getUusername() %></td>                                    
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
                                     window.location.href='index.do?zhifubao&start='+start+'&count='+count+'';
                                }
                                function goto(){
                                     var obj = document.getElementById('pageNo'); //selectid
                                             var index = obj.selectedIndex;
                                             var start = obj.options[index].value; // 选中值
                                     var count = <%=pageSize%>;
                                     window.location.href='index.do?zhifubao&start='+start+'&count='+count+'';
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
                    <!-- row span -->
                </div>                                
            </div>            
            <div class="dr"><span></span></div> 
        </div>
        
    </div>   
    <!-- ###################################################################### -->
    
</body>
</html>
