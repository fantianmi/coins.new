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
         <%if(request.getAttribute("editflag")==null){ %>
         	<!-- #####################start######################### -->
         	<div class="row-fluid">
                <form action="content.do?add" method="post">
                <div class="span3">
                    <div class="head">
                        <div class="isw-documents"></div>
                        <h1>首页内容管理</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">                        
                        
                        <div class="row-form">
                            <div class="span3">标题</div>
                            <div class="span9"><input placeholder="请输入标题" type="text" name="btc_content_title"></div>
                            <div class="clear"></div>
                        </div> 

                        <div class="row-form">
                            <div class="span3">类型</div>
                            <div class="span9">
                            <select name="btc_content_type">
                                        <option value="公告">公告</option>
                                        <option value="首页关于我们">首页关于我们</option>
                                        <option value="币种介绍">币种介绍</option>
                                        <option value="充值介绍">充值介绍</option>
                                        <option value="客服帮助电话">客服帮助电话</option>
                                        <option value="单页帮助中心">单页帮助中心</option>
                                        <option value="单页关于我们">单页关于我们</option>
                                        <option value="备案信息等">备案信息等</option>
                                        <option value="网站标题">网站标题</option>
                                        <option value="k线图帮助">k线图帮助</option>
                                        <option value="底栏帮助中心">底栏帮助中心</option>
                                        <option value="底栏关于我们">底栏关于我们</option>
                                </select>
                                </div>
                            <div class="clear"></div>
                        </div>                         

                        <div class="row-form">
                            <div class="span3">币种</div>
                            <div class="span9">
                            <select name=btc_content_stock_id>
                                 <option value="0">如果上面类型选择"币种介绍"则这项必填</option>
                                 <%if(session.getAttribute("stockmap2")!=null){
									Map<Integer,Btc_stock> stockmap = (Map<Integer,Btc_stock>)session.getAttribute("stockmap2");
									Iterator it = stockmap.keySet().iterator();
									while(it.hasNext()){
										int key = (Integer)it.next();
										Btc_stock stock = (Btc_stock)stockmap.get(key);%>
		                                 <option value="<%=stock.getBtc_stock_id() %>"><%=stock.getBtc_stock_name() %>
		                                 (<%=stock.getBtc_stock_Eng_name()%>)</option>
										
									<% }
                                 }
                                	 %>
                                </select></div>
                            <div class="clear"></div>
                        </div>
                        <div class="row-form">
                            <div class="span3"></div>
                            <div class="span9"><input type="submit" class="btn btn-large" value="保存"></div>
                            <div class="clear"></div>
                        </div>
                    </div>
                </div>
                
            
                
                <div class="span9">
                    <div class="head">
                        <div class="isw-favorite"></div>
                        <h1>内容输入</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid" id="wysiwyg_container" style="height: 500px;">
                        
                        <textarea id="wysiwyg" name="btc_content_msg" style="height: 500px;"></textarea>
                        
                    </div>
                </div>
                
            </div>
            
            <div class="dr"><span></span></div>
            <!-- #####################end######################### -->
            <%}else{ %>
            <!-- #####################start######################### -->
            <%
            Btc_content bc = (Btc_content)session.getAttribute("bc");
            %>
         	<div class="row-fluid">
                <form action="content.do?update&contentid=<%=bc.getBtc_content_id() %>" method="post">
                <div class="span3">
                    <div class="head">
                        <div class="isw-documents"></div>
                        <h1>首页内容管理</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">                        
                        
                        <div class="row-form">
                            <div class="span3">标题</div>
                            <div class="span9"><input value="<%=bc.getBtc_content_title() %>" type="text" name="btc_content_title"></div>
                            <div class="clear"></div>
                        </div> 

                        <div class="row-form">
                            <div class="span3">类型</div>
                            <div class="span9">
                            <select name="btc_content_type">
                                        <option value="<%=bc.getBtc_content_type() %>">不作修改不动</option>
                                        <option value="公告">公告</option>
                                        <option value="首页关于我们">首页关于我们</option>
                                        <option value="币种介绍">币种介绍</option>
                                        <option value="充值介绍">充值介绍</option>
                                        <option value="客服帮助电话">客服帮助电话</option>
                                        <option value="单页帮助中心">单页帮助中心</option>
                                        <option value="单页关于我们">单页关于我们</option>
                                        <option value="备案信息等">备案信息等</option>
                                        <option value="网站标题">网站标题</option>
                                        <option value="k线图帮助">k线图帮助</option>
                                        <option value="底栏帮助中心">底栏帮助中心</option>
                                        <option value="底栏关于我们">底栏关于我们</option>
                                </select>
                                </div>
                            <div class="clear"></div>
                        </div>                         

                        <div class="row-form">
                            <div class="span3">币种</div>
                            <div class="span9">
                            <select name=btc_content_stock_id>
                                 <option value="<%=bc.getBtc_content_stock_id() %>">不作修改不动</option>
                                 <%if(session.getAttribute("stockmap2")!=null){
									Map<Integer,Btc_stock> stockmap = (Map<Integer,Btc_stock>)session.getAttribute("stockmap2");
									Iterator it = stockmap.keySet().iterator();
									while(it.hasNext()){
										int key = (Integer)it.next();
										Btc_stock stock = (Btc_stock)stockmap.get(key);%>
		                                 <option value="<%=stock.getBtc_stock_id() %>"><%=stock.getBtc_stock_name() %>
		                                 (<%=stock.getBtc_stock_Eng_name()%>)</option>
										
									<% }
                                 }
                                	 %>
                                </select></div>
                            <div class="clear"></div>
                        </div>
                        <div class="row-form">
                            <div class="span3">发表时间：</div>
                            <div class="span9"><input value="<%=bc.getBtc_content_time() %>" readonly="readonly" type="text"></div>
                            <div class="clear"></div>
                        </div>
                        <div class="row-form">
                            <div class="span3"></div>
                            <div class="span9"><input type="submit" class="btn btn-large" value="保存"></div>
                            <div class="clear"></div>
                        </div>
                        <div class="row-form">
                            <div class="span3"></div>
                            <div class="span9"><button onclick="location.href='content.do?delete&contentid=<%=bc.getBtc_content_id() %>'" class="btn btn-large">删除</button></div>
                            <div class="clear"></div>
                        </div>
                    </div>
                </div>
                
            
                
                <div class="span9">
                    <div class="head">
                        <div class="isw-favorite"></div>
                        <h1>内容输入</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid" id="wysiwyg_container" style="height: 500px;">
                        
                        <textarea id="wysiwyg" name="btc_content_msg" style="height: 500px;"><%=bc.getBtc_content_msg() %></textarea>
                        
                    </div>
                </div>
                
            </div>
            
            <div class="dr"><span></span></div>
            <!-- #####################end######################### -->
        	<%} %>
        </div>
        </form>
    </div>   
    
</body>
</html>
