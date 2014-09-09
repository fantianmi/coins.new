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
                        <div class="isw-archive"></div>
                        <h1>分红币矿池</h1>                                              
                        <div class="clear"></div>
                    </div>
                    <div role="tablist" class="block-fluid accordion ui-accordion ui-widget ui-helper-reset ui-accordion-icons">
                        
                        <h3 tabindex="0" aria-selected="true" aria-expanded="true" role="tab" class="ui-accordion-header ui-helper-reset ui-state-default ui-state-active ui-corner-top"><span class="ui-icon ui-icon-triangle-1-s"></span>红利币（GBP)</h3>
                        <div role="tabpanel" style="height: 189px;" class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion-content-active">
                            <table class="sOrders" cellpadding="0" cellspacing="0" width="100%">
                               
                                <tbody>
                                    <tr>
                                        <td><span class="date">总量</span></td>
                                        
                                        <td><span class="price">12000000</span></td>
                                    </tr>
                                    <tr>
                                        <td><span class="date">已发放数量</span></td>
                                      	<%
                                      	BigDecimal amountnow = new BigDecimal(0);
                                      	amountnow = new BigDecimal(session.getAttribute("amountnow").toString());
                                      	Btc_stock ddc = (Btc_stock)session.getAttribute("ddc");
                                      	%>
                                        <td><span class="price"><%= amountnow%></span></td>
                                    </tr>
                                    <tr>
                                        <td><span class="date">红利币价格</span></td>
                                        <td><span class="price"><%=ddc.getBtc_stock_price() %></span></td>
                                    </tr>  
                                     <tr>
                                        <td><span class="date">现在是开始第几天</span></td>
                                        <td><span class="price"><%=session.getAttribute("day").toString() %>天</span></td>
                                    </tr>                                    
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="3" align="right"><button class="btn btn-small">查看分红</button></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>                                       
                        
                    </div>
                </div>
                
            </div> 
                       
                        
            <div class="dr"><span></span></div>
        
        </div>
        
    </div> 	
        
    </div>   
    
</body>
</html>
