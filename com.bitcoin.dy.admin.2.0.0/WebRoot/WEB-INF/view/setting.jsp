<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
<%ResourceBundle res = ResourceBundle.getBundle("stock"); %>  
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
        
        <div class="workplace">
        <%
        Btc_profit btc_profit = new Btc_profit();
        if(session.getAttribute("btc_profit")!=null){
        	btc_profit = (Btc_profit)session.getAttribute("btc_profit");
        }
        	%>
        	<div class="row-fluid">
                <form action="config.do?updateConfig" method="post">
                <div class="span4">
                    <div class="head">
                        <div class="isw-documents"></div>
                        <h1>人民币充值提现管理面板</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">                        
                        
                        <div class="row-form">
                            <div class="span9"><input type="text" name="btc_profit_rechargeCNY_limit" value="<%=btc_profit.getBtc_profit_rechargeCNY_limit()%>"/>人民币充值最小值</div>
                            <div class="clear"></div>
                        </div> 

                        <div class="row-form">
                            <div class="span9"><input type="text" name="btc_profit_rechargeCNY_poundage" value="<%=btc_profit.getBtc_profit_rechargeCNY_poundage() %>"/>人民币充值手续费（百分比）</div>
                            <div class="clear"></div>
                        </div>     
                        
                        <div class="row-form">
                            <div class="span9"><input type="text" name="btc_profit_withdrawCNY_limit_min" value="<%=btc_profit.getBtc_profit_withdrawCNY_limit_min() %>"/>人民币提现最小额</div>
                            <div class="clear"></div>
                        </div>  
                        
                        <div class="row-form">
                            <div class="span9"><input type="text" name="btc_profit_withdrawCNY_limit_max" value="<%=btc_profit.getBtc_profit_withdrawCNY_limit_max() %>"/>人民币提现最大额</div>
                            <div class="clear"></div>
                        </div>  
                        
                        <div class="row-form">
                            <div class="span9"><input type="text" name="btc_profit_withdrawCNY_poundage" value="<%=btc_profit.getBtc_profit_withdrawCNY_poundage() %>"/>人民币提现手续费（百分比）</div>
                            <div class="clear"></div>
                        </div> 
                        
                         <div class="row-form">
                         	<input type="submit" class="btn btn-block" value="保存" />
                            <div class="clear"></div>
                        </div>                     

                                                                  
                        
                    </div>
                    </form>
                </div>
                
                <div class="span4">
                	<form action="config.do?updateConfig" method="post">
                    <div class="head">
                        <div class="isw-documents"></div>
                        <h1>其它币种充值提现管理面板</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">                        
                        
                        <div class="row-form">
                            <div class="span9"><input type="text" name="btc_profit_rechargeStock_limit" value="<%=btc_profit.getBtc_profit_rechargeStock_limit()  %>"/>其它币种充值最小值</div>
                            <div class="clear"></div>
                        </div> 

                        <div class="row-form">
                            <div class="span9"><input type="text" name="btc_profit_rechargeStock_poundage" value="<%=btc_profit.getBtc_profit_rechargeStock_poundage() %>"/>其它币种充值手续费（百分比）</div>
                            <div class="clear"></div>
                        </div>     
                        
                        <div class="row-form">
                            <div class="span9"><input type="text" name="btc_profit_withdrawCNY_limit_min" value="<%=btc_profit.getBtc_profit_withdrawStock_limit_min()%>"/>其它币种提现最小额</div>
                            <div class="clear"></div>
                        </div>  
                        
                        <div class="row-form">
                            <div class="span9"><input type="text" name="btc_profit_withdrawCNY_limit_max" value="<%=btc_profit.getBtc_profit_withdrawStock_limit_max()%>"/>其它币种提现最大额</div>
                            <div class="clear"></div>
                        </div>  
                        
                        <div class="row-form">
                            <div class="span9"><input type="text" name="btc_profit_withdrawCNY_poundage" value="<%=btc_profit.getBtc_profit_withdrawStock_poundage() %>"/>其它币种提现手续费（百分比）</div>
                            <div class="clear"></div>
                        </div> 
                        
                         <div class="row-form">
                           <input type="submit" class="btn btn-block" value="保存" />
                            <div class="clear"></div>
                        </div>                     

                                                                  
                        
                    </div>
                    </form>
                </div>
                
                <!-- ################################################### -->
                <div class="span4">
                    <div class="head">
                        <div class="isw-list"></div>
                        <h1>奖励</h1>
                        <div class="clear"></div>
                    </div>
                    <div role="tablist" class="block-fluid accordion ui-accordion ui-widget ui-helper-reset ui-accordion-icons">
                        
                        <h3 tabindex="0" aria-selected="true" aria-expanded="true" role="tab" class="ui-accordion-header ui-helper-reset ui-state-active ui-corner-top"><span class="ui-icon ui-icon-triangle-1-s"></span>奖励1</h3>
                        <div role="tabpanel" style="height: 132px; display: block; overflow: auto; padding-top: 0px; padding-bottom: 0px;" class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion-content-active">
 						<form action="config.do?updateConfig" method="post">
                            <div class="block-fluid">                        
                        <div class="row-form">
                            <div class="span9"><input type="text" name="regist_get" value="<%=btc_profit.getRegist_get() %>"/>用户注册得<%=res.getString("stock.registeraward.name")%></div>
                            <div class="clear"></div>
                        </div> 
                        <div class="row-form">
                            <div class="span9"><input type="text" name="inviteRegist_get" value="<%=btc_profit.getInviteRegist_get() %>"/>被推广人注册推广人获得<%=res.getString("stock.tuijieaward.name")%>（个数）</div>
                            <div class="clear"></div>
                        </div> 
                        <div class="row-form">
                            <div class="span9"><input type="text" name="btc_profit_profit_trade_get" value="<%=btc_profit.getBtc_profit_profit_trade_get() %>"/>买方用户交易送<%=res.getString("stock.tradeaward.name")%>（百分比）</div>
                            <div class="clear"></div>
                        </div> 
                         <div class="row-form">
                           <input type="submit" class="btn btn-block" value="保存" />
                            <div class="clear"></div>
                        </div>                     
                    </div>
                            </form>
                        </div>
                        
                        <h3 tabindex="-1" aria-selected="false" aria-expanded="false" role="tab" class="ui-accordion-header ui-helper-reset ui-state-default ui-corner-all"><span class="ui-icon ui-icon-triangle-1-e"></span>奖励2</h3>
                        <div role="tabpanel" style="height: 132px; overflow: auto; display: none; padding-top: 0px; padding-bottom: 0px;" class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom">
                        <!-- ####################################### -->
                        <form action="config.do?updateConfig" method="post">
                            <div class="block-fluid">                        
                        <div class="row-form">
                            <div class="span9"><input type="text" name="rechargecny_get" value="<%=btc_profit.getRechargecny_get() %>"/>用户充值人民币送人民币（百分比）</div>
                            <div class="clear"></div>
                        </div> 
                         <div class="row-form">
                           <input type="submit" class="btn btn-block" value="保存" />
                            <div class="clear"></div>
                        </div>                     
                    </div>
                            </form>
                        <!-- ####################################### -->
                        </div>
                        
                        <h3 tabindex="-1" aria-selected="false" aria-expanded="false" role="tab" class="ui-accordion-header ui-helper-reset ui-state-default ui-corner-all"><span class="ui-icon ui-icon-triangle-1-e"></span>奖励3</h3>
                        <div role="tabpanel" style="height: 132px; overflow: auto; display: none; padding-top: 0px; padding-bottom: 0px;" class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom">
                                                    <form action="config.do?updateConfig" method="post">
                            <div class="block-fluid">                        
                        <div class="row-form">
                            <div class="span9"><input type="text" name="rechargecny_getpgc" value="<%=btc_profit.getRechargecny_getpgc() %>"/>用户充值人民币送<%=res.getString("stock.rechargeaward.name")%>个数</div>
                            <div class="clear"></div>
                        </div> 
                        <div class="row-form">
                            <div class="span9"><input type="text" name="tjduihuan" value="<%=btc_profit.getTjduihuan()%>"/>用户兑换送<%=res.getString("stock.tjduihuan.name")%>个</div>
                            <div class="clear"></div>
                        </div> 
                         <div class="row-form">
                           <input type="submit" class="btn btn-block" value="保存" />
                            <div class="clear"></div>
                        </div>                     
                    </div>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- ################################################### -->
                
                
                
                
            </div>
            
            <div class="dr"><span></span></div>
            
            <div class="row-fluid">
                <div class="span4">
                    <div class="head">
                    	<form action="config.do?updateConfig" method="post">
                        <div class="isw-documents"></div>
                        <h1>交易</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">                        
                        <form action="config.do?updateConfig" method="post">
                        <div class="row-form">
                            <div class="span9"><input type="text" name="btc_profit_trade_poundage" value="<%=btc_profit.getBtc_profit_trade_poundage() %>"/>每笔交易手续费</div>
                            <div class="clear"></div>
                        </div> 
                         <div class="row-form">
                           <input type="submit" class="btn btn-block" value="保存" />
                            <div class="clear"></div>
                        </div>                     
						</form>
                                                                  
                        
                    </div>
                </div>
                
                <div class="span4">
                    <div class="head">
                    	<form action="birth.do?update" method="post">
                        <div class="isw-documents"></div>
                        <h1>平台运营起始时间</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">                        
                        <form action="config.do?updateConfig" method="post">
                        <div class="row-form">
                            <div class="span3">Date:</div>
                            <div class="span9"><input type="text" name="birth" value="<%=session.getAttribute("birth").toString() %>" placeholder="请输入正确的日期格式"/><span>例如: 2014-03-30</span></div>
                            <div class="clear"></div>
                        </div>
                         <div class="row-form">
                           <input type="submit" class="btn btn-block" value="保存" />
                            <div class="clear"></div>
                        </div>                     
						</form>
                                                                  
                        
                    </div>
                </div>
                 <div class="span4">
                <form action="config.do?updateConfig" method="post">
                    <div class="head">
                        <div class="isw-list"></div>
                        <h1>打开关闭交易</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">                        
                        
                        <div class="row-form">
                            <div class="span5">交易状态:</div>
                            <div class="span7">
                                <select name="isjiaoyi">
                                		<option value="<%=btc_profit.getIsjiaoyi() %>"><%=btc_profit.getIsjiaoyi() %></option>
                                <%
                                String status=btc_profit.getIsjiaoyi();
                                if(status.equals("打开交易")){ %>
                                        <option value="关闭交易">关闭交易</option>
                                <%}else{%>
                                		<option value="打开交易">打开交易</option>
                                <%} %>
                                </select>
                            </div>
                            <div class="clear"></div>
                        </div> 
                        <div class="row-form">
                           <input type="submit" class="btn btn-block" value="保存" />
                            <div class="clear"></div>
                        </div>                                           
                    </div>
                    </form>
                </div>
                
            </div>
            <div class="dr"><span></span></div>    
            
        </div>
        
    </div>   
    
</body>
</html>
