<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
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
                                    
            <div class="row-fluid">                        
                              
                <!--################userlist##############-->
                <div class="span6">
                    <div class="head">
                        <div class="isw-cloud"></div>
                        <h1>兑换方式总览</h1>
                        <ul class="buttons">        
                        </ul> 
                        <div class="clear"></div>
                    </div>
                    <div class="block users scrollBox">
                        
                        <div class="scroll" style="height: 550px;">
                        <%if(session.getAttribute("tradecatelist")!=null){
                        	List<Btc_trade_category> tradecatelist = (List<Btc_trade_category>)session.getAttribute("tradecatelist");
                        	Map<Integer, Btc_stock> stockmap = (Map<Integer, Btc_stock>)session.getAttribute("stock_map");
                        	Btc_stock stock = new Btc_stock();
                        	Btc_trade_category selfstock = new Btc_trade_category();
                        	for(int i=0;i<tradecatelist.size();i++){
                        		selfstock = tradecatelist.get(i);
                        		stock = stockmap.get(selfstock.getTradec_stockid());
                         		%>
                        
                            
                            <div class="item">
                                <div class="info">
                                    <a href="index.do?updateselfstock&id=<%=selfstock.getTradecid() %>" class="name">
                                    <%=stock.getBtc_stock_Eng_name() %>/<%=selfstock.getTradec_exstock() %></a>
                                    <span>兑换率：&nbsp;<%=selfstock.getTradec_price() %>&nbsp;
                                    <%=selfstock.getTradec_exstock() %>&nbsp;
                                   </span>                                                                 
                                    <div class="controls">                                    
                                        <a href="tradecate.do?delete&id=<%=selfstock.getTradecid() %>" class="icon-remove"></a>
                                    </div>                                                                    
                                </div>
                                <div class="clear"></div>
                            </div>
                            <%}
                        	}%>
                        </div>
                        
                    </div>
                </div>   
                <%if(session.getAttribute("option").toString().equals("add")){ %>
                <div class="span6">
                    <div class="head">
                    <form id="validation" action="tradecate.do?add" method="post">
                        <div class="isw-ok"></div>
                        <h1>添加新的兑换方式</h1>
                        <div class="clear"></div>
                    </div>
                    
                    <div class="block-fluid">                        
                        <div class="row-form">
                            <div class="span3">兑换币种:</div>
                            <div class="span9">
                            <select name="tradec_exstock">
                            <%
                            Map<Integer, Btc_stock> stockmap = (Map<Integer, Btc_stock>)session.getAttribute("stock_map");
                            Iterator it = stockmap.keySet().iterator();
                            int i=0;
                            while(it.hasNext()){
                            	int key = Integer.parseInt(it.next().toString());
                            	Btc_stock stock = stockmap.get(key);
                            	if(!stock.getBtc_stock_Eng_name().equals("DDC")){
                            	%>
                            	<option value="<%=stock.getBtc_stock_Eng_name() %>"><%=stock.getBtc_stock_Eng_name() %></option>
                            	<%
                            }}
                            %>
                            </select> 
                            <span>现在暂时支持BTC/LTC/GBP/GBC，其他币种添加后在前台不会显示</span></div>
                            <div class="clear"></div>
                        </div>                                                                                 

                        <div class="row-form">
                            <div class="span3">与兑换币的兑换率:</div>
                            <div class="span9">        
                                <input name="tradec_price" value="0" type="text">
                                <span>比如5000DDC买1比特币</span>
                            </div>
                            <div class="clear"></div>
                        </div>    
                                                                                                     
                        <div class="row-form">
                            <div class="span3">要兑换币种:</div>
                            <div class="span9">    
                            <select name="tradec_stockid">
                            <%
                            it = stockmap.keySet().iterator();
                            i=0;
                            while(it.hasNext()){
                            	int key = Integer.parseInt(it.next().toString());
                            	Btc_stock stock = stockmap.get(key);
                            	if(!stock.getBtc_stock_Eng_name().equals("DDC")){
                            	%>
                            	<option value="<%=stock.getBtc_stock_id()%>"><%=stock.getBtc_stock_Eng_name() %></option>
                            	<%
                            }}
                            %>
                            
                            	
                            </select>    
                            </div>
                            <div class="clear"></div>
                        </div>      
                        <div class="row-form">
                            <div class="span9">  
                                <input class="btn btn-block" name="submit" type="submit" id="submit" value="确认添加" />
                            </div>
                            <div class="clear"></div>
                        </div>                                    
                            
                        </form>
                    </div>
                                                    
                </div>
                <%}else if(session.getAttribute("option").toString().equals("update")){
                	Btc_trade_category btc = new Btc_trade_category();
                	btc = (Btc_trade_category)session.getAttribute("btc");
                	%>
               	<div class="span6">
                    <div class="head">
                    <form id="validation" action="tradecate.do?update" method="post">
                    <input type="hidden" name="tradecid" value="<%=btc.getTradecid() %>"/>
                        <div class="isw-ok"></div>
                        <h1>修改DDC兑换币种</h1>
                        <div class="clear"></div>
                    </div>
                    
                    <div class="block-fluid">                        
                        <div class="row-form">
                            <div class="span3">币英文缩写:</div>
                            <div class="span9"><input name="tradec_exstock" value="<%=btc.getTradec_exstock() %>" type="text"><span>英文名：如BTC..</span></div>
                            <div class="clear"></div>
                        </div>                                                                                 

                        <div class="row-form">
                            <div class="span3">与兑换币的兑换率:</div>
                            <div class="span9">        
                                <input name="tradec_price" value="<%=btc.getTradec_price() %>" type="text">
                                <span>比如5000DDC买1比特币</span>
                            </div>
                            <div class="clear"></div>
                        </div>    
                                                                                                     
                        <div class="row-form">
                            <div class="span3">兑换币种:</div>
                            <div class="span9">    
                            <select name="tradec_stockid">
                            <%
                            Map<Integer, Btc_stock> stockmap = (Map<Integer, Btc_stock>)session.getAttribute("stock_map");
                            Iterator it = stockmap.keySet().iterator();
                            int i=0;
                            Btc_stock defaultstock = new Btc_stock();
                            defaultstock = stockmap.get(btc.getTradec_stockid());
                            %>
                            <option value="<%=defaultstock.getBtc_stock_id()%>"><%=defaultstock.getBtc_stock_Eng_name() %></option>
                            <%
                            while(it.hasNext()){
                            	int key = Integer.parseInt(it.next().toString());
                            	Btc_stock stock = stockmap.get(key);
                            	if(!stock.getBtc_stock_Eng_name().equals("DDC")){
                            	%>
                            	<option value="<%=stock.getBtc_stock_id()%>"><%=stock.getBtc_stock_Eng_name() %></option>
                            	<%
                            }}
                            %>
                            
                            	
                            </select>    
                            </div>
                            <div class="clear"></div>
                        </div>      
                        <div class="row-form">
                            <div class="span9">  
                                <input class="btn btn-block" name="submit" type="submit" id="submit" value="确认修改" />
                            </div>
                            <div class="clear"></div>
                        </div>                                    
                            
                        </form>
                    </div>
                                                    
                </div>
                <%} %>
                
            </div>

            <div class="dr"><span></span></div>            
            
            <div class="row-fluid">
                <div class="span12">
                    
                    <div class="widgetButtons">                        
                        <div class="bb"><a href="#"><span class="ibw-plus"></span></a></div>
                    </div>
                    
                </div>
            </div>            
        </div>
        
    </div>   
    
</body>
</html>
