<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
<%@ page import="com.mvc.entity.*"%>
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<!-- ****************后台管理系统******************** -->
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
         <div class="workplace">
            
            <div class="row-fluid">
                
                <div class="span12">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>首页内容管理</h1>      
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid" style="height:700px; overflow:auto">
                        <table class="table" cellpadding="0" cellspacing="0" width="100%">
                            <thead>
                                <tr>                                    
                                    <th width="10%">ID</th>
                                    <th width="30%">标题</th>
                                    <th width="10%">作者</th>
                                    <th width="10%">类型</th>
                                    <th width="15%">币种名</th>                                    
                                    <th width="15%">发表时间</th>                                    
                                    <th width="10%">操作</th>                                    
                                </tr>
                            </thead>
                            <tbody>
                            <%if(session.getAttribute("contentlist")!=null){
								List<Btc_content> clist = (List<Btc_content>)session.getAttribute("contentlist");
								Btc_content content = new Btc_content();
								String stockName = "该内容不包含该选项";
								String value = "";
								Map<Integer,Btc_stock> stockmap = (Map<Integer,Btc_stock>)session.getAttribute("stockmap2");
								for(int i=0;i<clist.size();i++){
									content = clist.get(i);
									if(stockmap.get(content.getBtc_content_stock_id())!=null)
									 stockName = stockmap.get(content.getBtc_content_stock_id()).getBtc_stock_name();
									%>
									<tr>                                    
	                                    <td><%=content.getBtc_content_id() %></td>
	                                    <td><%=content.getBtc_content_title()%></td>
	                                    <td><%=content.getAuthor()%></td>
	                                    <td><%=content.getBtc_content_type() %></td>
	                                    <td><%=stockName %></td>   
	                                    <td><%=content.getBtc_content_time() %></td>                                    
	                                    <td><a class="isb-edit" href="content.do?edite&contentid=<%=content.getBtc_content_id() %>" title="查看/修改"></a>
	                                    <a class="isb-cancel" href="content.do?delete&contentid=<%=content.getBtc_content_id() %>" title="删除该文章"></a></td>                                    
	                                </tr>
									
								<%
								}
                            }
                            	%>
                            </tbody>
                        </table>
                    </div>
                </div>                                
                
            </div>
            
            <div class="dr"><span></span></div>
        
        </div>
        
    </div>   
    
</body>
</html>
