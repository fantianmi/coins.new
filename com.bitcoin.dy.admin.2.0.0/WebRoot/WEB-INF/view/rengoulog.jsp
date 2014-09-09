<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.mvc.entity.*"%>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<!-- ****************后台管理系统******************** -->
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<body>
    
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
        <%
        int countRow=0;
        int fhstartNo=0;
        if(request.getAttribute("countRow")!=null){countRow=Integer.parseInt(request.getAttribute("countRow").toString());}
        if(session.getAttribute("rglstartNo")!=null){fhstartNo=Integer.parseInt(session.getAttribute("rglstartNo").toString());}
        %>
        <div class="workplace">
            <div class="row-fluid">
                <form id="myForm" action="" method="post">
                <div class="span12">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>用户兑换记录(<%=countRow %>)</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid table-sorting">
                        <table cellpadding="0" cellspacing="0" width="100%" class="table" id="tSortable">
                            <thead>
                                <tr>
                                    <th><input type="checkbox" name="checkall"/></th>
                                    <th width="25%">
                                    <span style="float:left">兑换用户</span>
                                    <span style="float:right; margin-right:10px">兑换价格</span>
                                    </th>
                                    <th width="25%">
                                    <span style="float:left;">兑换数量</span>
                                    <span style="float:right; margin-right:10px">发放期次</span>                                   
                                    </th>
                                    <th width="25%">
                                    <span style="float:left">兑换兑换额</span>
                                     <span style="float:right; margin-right:10px">兑换状态</span>
                                    </th>
                                    <th width="25%">
                                    <span style="float:left">兑换时间</span>
                                    </th>                                    
                                </tr>
                            </thead>
                            <tbody>
                            <%if(request.getAttribute("rengoulist")!=null){
                            	Btc_frc_rengou_log bfrl = new Btc_frc_rengou_log();
                            	Btc_user user = new Btc_user();
                            	List<Btc_frc_rengou_log> rengoulist = (List<Btc_frc_rengou_log>)request.getAttribute("rengoulist");
                            	Map<Integer,Btc_user> usermap = (Map<Integer,Btc_user>)request.getAttribute("usermap");
                            	for(int i=0;i<rengoulist.size();i++){
                            		bfrl = rengoulist.get(i);
                            		user = usermap.get(bfrl.getUid());
                            		int id = bfrl.getId();
                            		%>
                            		<tr>
	                                    <td><input type="checkbox" name="checkbox" value="<%=id %>"/></td>
	                                   <td>
	                                    <span style="float:left"><a href="usermanager.do?seeDetail&uid=<%=user.getUid() %>"><%=user.getUusername() %></a></span>
	                                    <span style="float:right; margin-right:10px"><%=bfrl.getPrice() %></span>
	                                    </td>
	                                    <td>
	                                    <span style="float:left;"><%=bfrl.getAmount() %></span>
	                                    <span style="float:right; margin-right:10px"><%=bfrl.getSeason() %></span>                                   
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=bfrl.getPayamount() %></span>
	                                     <span style="float:right; margin-right:10px"><%=bfrl.getStatus() %></span>
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=bfrl.getDate() %></span>
	                                    </td> 
                            	<%}
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
                                     window.location.href='index.do?rengoulog&start='+start+'&count='+count+'';
                                }
                                function goto(){
                                     var obj = document.getElementById('pageNo'); //selectid
                                             var index = obj.selectedIndex;
                                             var start = obj.options[index].value; // 选中值
                                     var count = <%=pageSize%>;
                                     window.location.href='index.do?rengoulog&start='+start+'&count='+count+'';
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

    <!-- ###################################################################### -->
     <div class="dialog" id="b_popup_3" style="display: none;" title="Modal">
       <p>Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In suscipit faucibus urna.</p>                
    </div>
    
</body>
</html>
