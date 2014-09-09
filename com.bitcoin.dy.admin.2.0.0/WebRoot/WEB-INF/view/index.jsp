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

                <div class="span4">                    

                    <div class="wBlock red">                        
                        <div class="dSpace" style="width:95%">
                            <h3>平台现充入人民币共计</h3>
                            <%BigDecimal cny_amount = new BigDecimal(session.getAttribute("cny_amount").toString());
                            cny_amount = cny_amount.setScale(2,BigDecimal.ROUND_HALF_UP);
                            %>
                            <span class="number"><%=cny_amount %>元</span>                    
                        </div>                       
                    </div>                     
                    
                </div>                
               
                <div class="span4">                    

                    <div class="wBlock blue">
                        <div class="dSpace" style="width:95%">
                            <h3>各个环节手续费总收入共计</h3>
                            
                            <span class="number"><%=session.getAttribute("profit").toString() %>元</span>
                        </div>	
                    </div>                      
                    
                </div>  
                
                 <div class="span4">                    

                    <div class="wBlock green">                        
                        <div class="dSpace" style="width:95%">
                            <h3>注册用户总计</h3>                            
                            <span class="number"><%=session.getAttribute("user_amount").toString() %></span>                    
                        </div>                    
                    </div>                    
                    <div class="clear"></div>                    
                    
                </div>
              
            </div>            
            
            <div class="dr"><span></span></div> 
            
            <div class="row-fluid">
                
                <div class="span4">
                    <div class="head">
                        <div class="isw-edit"></div>
                        <h1>人民币手续费收入账单明细</h1>
                        <ul class="buttons">                                                       
                           
                        </ul>                        
                        <div class="clear"></div>
                    </div>
                    <div class="block news scrollBox">
                        
                        <div class="scroll" style="height: 270px;">
                            <%if(session.getAttribute("incomeCNY_list")!=null){
							   List<Btc_incomeCNY> incomeCNY_list = (List<Btc_incomeCNY>)session.getAttribute("incomeCNY_list");
							   Btc_incomeCNY incomeCNY = new Btc_incomeCNY();
							   for(int i=0;i<incomeCNY_list.size();i++){
							  	 incomeCNY = incomeCNY_list.get(i);
							  	 %>
							  	 <div class="item">
	                                <a href="#">收：￥<%=incomeCNY.getBtc_incomeCNY_amount() %></a>
	                                <p>[原因]&nbsp;<%=incomeCNY.getBtc_incomeCNY_reason() %></p>
	                                <span class="date"><%=incomeCNY.getBtc_incomeCNY_time() %></span>     
	                            </div>
							  	 <%
							   }
                            }
                            	%>
                        </div>
                        
                    </div>
                </div>                               

                 <div class="span4">
                    <div class="head">
                        <div class="isw-edit"></div>
                        <h1>人民币支出账单明细</h1>
                        <ul class="buttons">                                                       
                           
                        </ul>                        
                        <div class="clear"></div>
                    </div>
                    <div class="block news scrollBox">
                        
                        <div class="scroll" style="height: 270px;">
                            
                           <%if(session.getAttribute("outcomeCNY_list")!=null){
							   List<Btc_outcomeCNY> outcomeCNY_list = (List<Btc_outcomeCNY>)session.getAttribute("outcomeCNY_list");
							   Btc_outcomeCNY outcomeCNY = new Btc_outcomeCNY();
							   for(int i=0;i<outcomeCNY_list.size();i++){
							  	 outcomeCNY = outcomeCNY_list.get(i);
							  	 %>
							  	 <div class="item">
	                                <a href="#">支：￥<%=outcomeCNY.getBtc_outcomeCNY_amount() %></a>
	                                <p>[原因]&nbsp;<%=outcomeCNY.getBtc_outcomeCNY_reason() %></p>
	                                <span class="date"><%=outcomeCNY.getBtc_outcomeCNY_time() %></span>     
	                            </div>
							  	 <%
							   }
                            }
                            	%>
                           
                        </div>
                        
                    </div>
                </div> 
                
             <div class="span4">
                <div class="head">
                    <div class="isw-edit"></div>
                    <h1>其他币种收入账单明细</h1>
                    <ul class="buttons">                                                       
                       
                    </ul>                        
                    <div class="clear"></div>
                </div>
                <div class="block news scrollBox">
                    
                    <div class="scroll" style="height: 270px;">
	                    <%if(session.getAttribute("incomeStock_list")!=null){
						   List<Btc_incomeStock> incomeStock_list = (List<Btc_incomeStock>)session.getAttribute("incomeStock_list");
						   Btc_incomeStock intcomeStock = new Btc_incomeStock();
						   for(int i=0;i<incomeStock_list.size();i++){
						  	 intcomeStock = incomeStock_list.get(i);
						  	 %>
						  	 <div class="item">
	                           <a href="#">币种：<%=intcomeStock.getBtc_incomeStock_name() %> 收入：<%=intcomeStock.getBtc_incomeStock_amount() %></a>
	                           <p>[原因]&nbsp;<%=intcomeStock.getBtc_incomeStock_reason() %></p>
	                           <span class="date"><%=intcomeStock.getBtc_incomeStock_time() %></span>     
	                       </div>
						  	 <%
						   }
                         }
                         	%>
                        
                        
                       
                    </div>
                    
                </div>
            </div> 

            <div class="dr"><span></span></div>
            
            <div class="row-fluid">
                
                <div class="span4">
                <div class="head">
                    <div class="isw-edit"></div>
                    <h1>其他币种支出账单明细</h1>
                    <ul class="buttons">                                                       
                       
                    </ul>                        
                    <div class="clear"></div>
                </div>
                <div class="block news scrollBox">
                    
                    <div class="scroll" style="height: 270px;">
                     <%if(session.getAttribute("outcomeSock_list")!=null){
						   List<Btc_outcomeStock> outcomeSock_list = (List<Btc_outcomeStock>)session.getAttribute("outcomeSock_list");
						   Btc_outcomeStock outcomeStock = new Btc_outcomeStock();
						   for(int i=0;i<outcomeSock_list.size();i++){
						  	 outcomeStock = outcomeSock_list.get(i);
						  	 %>
						  	<div class="item">
	                            <a href="#">币种：<%=outcomeStock.getBtc_outcomeStock_name() %> 支出：<%=outcomeStock.getBtc_outcomeStock_amount() %></a>
	                            <p>[原因]&nbsp;<%=outcomeStock.getBtc_outcomeStock_reason() %></p>
	                            <span class="date"><%=outcomeStock.getBtc_outcomeStock_time() %></span>     
	                        </div>
						  	 <%
						   }
                         }
                         	%>
                    </div>
                    
                </div>                
                
               
                
            </div> 
            
            <div class="span4">
                <div class="head">
                    <div class="isw-edit"></div>
                    <h1>平台充入币种及数量</h1>
                    <ul class="buttons">                                                       
                       
                    </ul>                        
                    <div class="clear"></div>
                </div>
                <div class="block news scrollBox">
                    
                    <div class="scroll" style="height: 270px;">
                     <%if(session.getAttribute("inAll_list")!=null){
						   List<Btc_inAll> inAll_list = (List<Btc_inAll>)session.getAttribute("inAll_list");
						   Btc_inAll inAll = new Btc_inAll();
						   for(int i=0;i<inAll_list.size();i++){
						  	 inAll = inAll_list.get(i);
						  	 %>
						  	<div class="item">
	                            <a href="#">币种：<%=inAll.getBtc_inAll_name() %>总量：<%=inAll.getBtc_inAll_amount() %></a>
	                               
	                        </div>
						  	 <%
						   }
                         }
                         	%>
                        
                        
                         
                        
                       
                    </div>
                    
                </div>                
                
               
                
            </div>             
                        
            <div class="dr"><span></span></div>
        
        </div>
        
    </div> 	
        
    </div>   
    
</body>
</html>
