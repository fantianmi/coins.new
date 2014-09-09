<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<body>
<script type="text/javascript">
            function fenfa(){
            	var fname = document.getElementById('displayusername').value;
                document.getElementById('myForm').action = "paycard.do?fenfa&fname="+fname+"";
                document.getElementById("myForm").submit();
            }
            
            function deletep(){
                document.getElementById('myForm').action = "paycard.do?delete";
                document.getElementById("myForm").submit();
            }
            
           
</script>
<!-- ****************后台管理系统******************** -->

    
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
               <!--#######################################-->
               <div class="span6">
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>生成点卡</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">                        
                        <form action="paycard.do?general" method="post">
                        <div class="row-form">
                            <div class="span2">生成面值:</div>
                            <div class="span2">
                                <select name="mianzhi">
                                        <option value="100">100元</option>
                                        <option value="200">200元</option>
                                        <option value="500">500元</option>
                                        <option value="1000">1000元</option>
                                        <option value="2000">2000元</option>
                                        <option value="5000">5000元</option>
                                        <option value="10000">10000元</option>
                                        <option value="20000">20000元</option>
                                        <option value="50000">50000元</option>
                                        <option value="100000">100000元</option>
                                </select>
                            </div>
                            <div class="span2">生成数量:</div>
                            <div class="span2"><input type="text" name="num" placeholder="请输入整数"
                            onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"></div>
                            <div class="span2"><input value="生成" type="submit" class="btn btn-block"></div>
                            <div class="clear"></div>
                        </div>    
                        </form>                                        
                    </div>
                </div>
               <!--#######################################-->
            </div>            
            
            <div class="dr"><span></span></div> 
            <!--#######################################-->
            <div class="row-fluid">
                <form action="" id="myForm" method="post">
                <!-- ###################################################################### -->
			    <div class="dialog" id="b_popup_4" style="display: none;" title="管理员分配点卡">                                
			        <div class="block">
			            <span>发放用户名:</span>
			            <p><input type="text" name="fname" id="displayusername"/></p>
			            <span></span>
			            <p><input type="button" onclick="fenfa();" class="btn" value="确认发放"/></p>
			            <div class="dr"><span></span></div>
			            <p>发放选中点卡到用户账户中，用户可以到点卡充值中心进行充值</p>
			        </div>
			    </div>
			    <!-- ###################################################################### -->
                <div class="span6">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>未使用点卡</h1>     
                        <ul class="buttons">
                            <li>
                                <a href="#" class="isw-settings"></a>
                                <ul class="dd-list">
                                    <li><a href="#" id="popup_4"><span class="isw-plus"></span>发放给用户</a></li>
                                    <li><a href="javascript:deletep();"><span class="isw-plus"></span>删除</a></li>
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
                                    <th width="10%">编号</th>
                                    <th width="20%">面值</th>
                                    <th width="35%">卡号</th>
                                    <th width="35%"> 生成日期</th>                                    
                                </tr>
                            </thead>
                            <tbody>
                            
                            <%if(request.getAttribute("unuselist")!=null){
                            	Btc_paycard card = new Btc_paycard();
                            	List<Btc_paycard> unuselist = (List<Btc_paycard>)request.getAttribute("unuselist");
                            	for(int i=0;i<unuselist.size();i++){
                            		card = unuselist.get(i);%>
                            	<tr>
                                    <td><input type="checkbox" name="checkbox" value="<%=card.getPaycard_id() %>"/></td>
                                    <td><%=card.getPaycard_id() %></td>
                                    <td><%=card.getPaycard_mianzhi() %>元</td>
                                    <td><%=card.getPaycard_num() %></td>
                                    <td><%=card.getPaycard_gtime() %></td>                                    
                                </tr>	
                            	<%}
                            } %>
                                                             
                            </tbody>
                        </table>
                        <div class="clear"></div>
                    </div>
                </div>
                </form>
            </div>
            <!--#######################################-->
            <div class="dr"><span></span></div> 
            <!--#######################################-->
            <div class="row-fluid">
                <form name="form2" action="paycard.do?delete" method="post">
                <div class="span10">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>已使用点卡</h1>    
                        <ul class="buttons">
                            <li>
                                <a href="#" class="isw-settings"></a>
                                <ul class="dd-list">
                                    <li><a href="javascript:form1.submit();"><span class="isw-plus"></span>删除</a></li>
                                </ul>
                            </li>
                        </ul>                            
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid table-sorting">
                        <table cellpadding="0" cellspacing="0" width="100%" class="table" id="tSortable_2">
                            <thead>
                                <tr>
                                    <th><input type="checkbox" name="checkall"/></th>
                                    <th width="15%">
                                    <span style="float:left">使用者id</span>
                                    </th>
                                    <th width="15%">
                                    <span style="float:left">面值</span>
                                    </th><th width="25%">
                                    <span style="float:left">卡号</span>
                                    </th><th width="45%">
                                    <span style="float:left">使用日期</span>
                                    <span style="float:right; margin-right:10px">生成日期</span>
                                    </th>                                   
                                </tr>
                            </thead>
                            <tbody>
                            <%if(request.getAttribute("uselist")!=null){
                            	Btc_paycard card = new Btc_paycard();
                            	List<Btc_paycard> uselist = (List<Btc_paycard>)request.getAttribute("uselist");
                            	for(int i=0;i<uselist.size();i++){
                            		card = uselist.get(i);%>
                            	<tr>
                                    <td><input type="checkbox" name="checkbox" value="<%=card.getPaycard_id() %>"/></td>
                                    <td>
                                    <span style="float:left"><%=card.getPaycard_user() %></span>
                                    </td>
                                    <td>
                                    <span style="float:left"><%=card.getPaycard_mianzhi() %></span>
                                    </td>
                                    <td>
                                    <span style="float:left"><%=card.getPaycard_num() %></span>
                                    </td>
                                    <td>
                                    <span style="float:left"><%=card.getPaycard_usetime() %></span>
                                    <span style="float:right; margin-right:10px"><%=card.getPaycard_gtime() %></span>
                                    </td>                                    
                                </tr>
                            	<%}
                            } %>
                                
                                                             
                            </tbody>
                        </table>
                        <div class="clear"></div>
                    </div>
                </div>                                
                </form>
            </div>
            <!--##########################################-->
            
            
        </div>
        
    </div>   
    
</body>
</html>
