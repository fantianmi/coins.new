<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
<!-- ****************后台管理系统******************** --> 
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<body>
	<jsp:include page="/include/headhtml.jsp"></jsp:include>
	<jsp:include page="/include/lpanelhtml.jsp"></jsp:include>
    <div class="content">
        <jsp:include page="/include/pathpanelhtml.jsp"></jsp:include>
        <div class="workplace">
            <div class="row-fluid">                        
                <div class="span4">
                    <div class="head">
                        <div class="isw-cloud"></div>
                        <h1>DDC兑换管理</h1>
                        <ul class="buttons">        
                        </ul> 
                        <div class="clear"></div>
                    </div>
                    <div class="block users scrollBox">
                        <div class="scroll" style="height: 390px;">
                        <%
                        Map<Integer, Btc_stock> stockmap = (Map<Integer, Btc_stock>)session.getAttribute("stock_map");
                        if(session.getAttribute("selfStockMap")!=null){
                        	Map<Integer, Btc_trade_category> selfstock_map = (Map<Integer, Btc_trade_category>)session.getAttribute("selfStockMap");
                        	Btc_stock stock = new Btc_stock();
                        	Btc_trade_category selfstock = new Btc_trade_category();
                        	Iterator it_selfstock_map = selfstock_map.keySet().iterator();
                        	while(it_selfstock_map.hasNext()){
                        		int key =  (Integer)it_selfstock_map.next();
                        		selfstock = (Btc_trade_category)selfstock_map.get(key);
                        		stock = stockmap.get(selfstock.getTradec_stockid());
                         		%>
                            <div class="item">
                                <div class="info">
                                    <a href="index.htm?updateselfstock&id=<%=selfstock.getTradecid() %>" class="name">
                                    <%=stock.getBtc_stock_Eng_name() %>/<%=selfstock.getTradec_exstock() %></a>
                                    <span>兑换率：&nbsp;<%=selfstock.getTradec_price() %>&nbsp;
                                    <%=selfstock.getTradec_exstock() %>&nbsp;
                                   </span>                                                                 
                                    <div class="controls">                                    
                                        <a href="tradecate.htm?delete&id=<%=selfstock.getTradecid() %>" class="icon-remove"></a>
                                    </div>                                                                    
                                </div>
                                <div class="clear"></div>
                            </div>
                            <%}
                        	}%>
                        </div>
                    </div>
                </div>   
                <!--################userlist##############-->
                <div class="span4">
                    <div class="head">
                        <div class="isw-cloud"></div>
                        <h1>LTC兑换管理</h1>
                        <ul class="buttons">        
                        </ul> 
                        <div class="clear"></div>
                    </div>
                    <div class="block users scrollBox">
                        
                        <div class="scroll" style="height: 390px;">
                        <%
                        if(session.getAttribute("selfStockMap2")!=null){
                        	Map<Integer, Btc_trade_category> selfstock_map = (Map<Integer, Btc_trade_category>)session.getAttribute("selfStockMap2");
                        	Btc_stock stock = new Btc_stock();
                        	Btc_trade_category selfstock = new Btc_trade_category();
                        	Iterator it_selfstock_map = selfstock_map.keySet().iterator();
                        	while(it_selfstock_map.hasNext()){
                        		int key =  (Integer)it_selfstock_map.next();
                        		selfstock = (Btc_trade_category)selfstock_map.get(key);
                        		stock = stockmap.get(selfstock.getTradec_stockid());
                         		%>
                        
                            
                            <div class="item">
                                <div class="info">
                                    <a href="index.htm?updateselfstock&id=<%=selfstock.getTradecid() %>" class="name">
                                    <%=stock.getBtc_stock_Eng_name() %>/<%=selfstock.getTradec_exstock() %></a>
                                    <span>兑换率：&nbsp;<%=selfstock.getTradec_price() %>&nbsp;
                                    <%=selfstock.getTradec_exstock() %>&nbsp;
                                   </span>                                                                 
                                    <div class="controls">                                    
                                        <a href="tradecate.htm?delete&id=<%=selfstock.getTradecid() %>" class="icon-remove"></a>
                                    </div>                                                                    
                                </div>
                                <div class="clear"></div>
                            </div>
                            <%}
                        	}%>
                        </div>
                        
                    </div>
                </div>   
                <!-- ##################################################################################### -->
                <%if(session.getAttribute("option").toString().equals("add")){ %>
                <div class="span4">
                    <div class="head">
                        <div class="isw-list"></div>
                        <h1>添加</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid accordion">
                    <!-- ############################# -->
                   
                        <h3>添加DDC兑换</h3>
                         <form id="validation" action="tradecate.htm?add" method="post">
                        <div>
                            <div class="row-form">
                            <div class="span3">基础币种:</div>
                            <div class="span9"><input name="tradec_exstock" value="GFB" type="text" readonly></div>
                            <div class="clear"></div>
                        </div>                                                                                 

                        <div class="row-form">
                            <div class="span3">兑换价格：</div>
                            <div class="span9">        
                                <input name="tradec_price" value="0" type="text">
                            </div>
                            <div class="clear"></div>
                        </div>    
                                                                                                     
                        <div class="row-form">
                            <div class="span3">兑换币种:</div>
                            <div class="span9">    
                            <select name="tradec_stockid">
                            <%
                            Iterator it = stockmap.keySet().iterator();
                            int i=0;
                            while(it.hasNext()){
                            	int key = Integer.parseInt(it.next().toString());
                            	Btc_stock stock = stockmap.get(key);
                            	if(!stock.getBtc_stock_Eng_name().equals("GFB")){
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
                        	<div class="span3"></div>
                            <div class="span9">  
                                <input class="btn btn-block" name="submit" type="submit" id="submit" value="确认添加" />
                            </div>
                            </form>
                            <div class="clear"></div>
                        </div> 
                        
                        <!-- ########################################### -->
                        </div>
                        
                        <h3>添加LTC兑换</h3>
                        <div>
                            <!-- ##################################### -->
                            <form id="validation" action="tradecate.htm?add" method="post">
                        <div class="row-form">
                       		 <div class="span3">基础币种</div>
                            <div class="span9"><input name="tradec_exstock" value="LTC" type="text" readonly></div>
                            <div class="clear"></div>
                        </div>                                                                                 

                        <div class="row-form">
                            <div class="span3">兑换价格：</div>
                            <div class="span9">        
                                <input name="tradec_price" value="0" type="text">
                            </div>
                            <div class="clear"></div>
                        </div>    
                                                                                                     
                        <div class="row-form">
                            <div class="span3">兑换币种:</div>
                            <div class="span9">    
                            <select name="tradec_stockid">
                            <%
                            Iterator it2 = stockmap.keySet().iterator();
                            while(it2.hasNext()){
                            	int key = Integer.parseInt(it2.next().toString());
                            	Btc_stock stock = stockmap.get(key);
                            	if(!stock.getBtc_stock_Eng_name().equals("LTC")){
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
                       		 <div class="span3"></div>
                            <div class="span9">  
                                <input class="btn btn-block" name="submit" type="submit" id="submit" value="确认添加" />
                            </div>
                            <div class="clear"></div>
                        </div>  
                        <!-- ##################################### -->
                        </form>
                        </div>
                    </div>
                    <!-- ############################# -->
                </div>
                 <%}else if(session.getAttribute("option").toString().equals("update")){
                	Btc_trade_category btc = new Btc_trade_category();
                	btc = (Btc_trade_category)session.getAttribute("btc");
                	%>
                <div class="span4">
                    <div class="head">
                    <form id="validation" action="tradecate.htm?update" method="post">
                    <input type="hidden" name="tradecid" value="<%=btc.getTradecid() %>"/>
                        <div class="isw-ok"></div>
                        <h1>修改GFB兑换币种</h1>
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
                            	if(!stock.getBtc_stock_Eng_name().equals("GFB")){
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
                        	<div class="span3"></div>
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
            <!-- ########################################## -->
            <div class="dr"><span></span></div>            
        </div>
    </div>   
</body>
</html>
