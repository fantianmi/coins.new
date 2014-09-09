<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="com.mvc.util.*"%>
<%
FormatUtil format = new FormatUtil();
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

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
                        <h1>现有币种</h1>
                        <ul class="buttons">        
                        </ul> 
                        <div class="clear"></div>
                    </div>
                    <div class="block users scrollBox">
                        
                        <div class="scroll" style="height: 550px">
                        
                        <%if(session.getAttribute("stockmlist")!=null){
                        	List<StockModel> stocklist = (List<StockModel>)session.getAttribute("stockmlist");
                        	StockModel stockm = new StockModel();
                        	for(int i=0;i<stocklist.size();i++){
                        		stockm = stocklist.get(i);
                         		%>
	                         	 <div class="item" >
			                           <div class="info">
			                               <a href="#" class="name"><%=stockm.getEngName()%></a>
			                               <p style="margin-bottom: 0px">平台持有量：<%=format.trans(stockm.getAomount())%>个</p>                                    
			                               <p>中文名：<%=stockm.getName()%></p>                                    
			                               <div class="controls">                                    
			                                   <a href="managestock.do?delete&id=<%=stockm.getId()%>" class="icon-remove"></a>
			                               </div>                                                                    
			                           </div>
			                           <div class="clear"></div>
			                       </div>
                          <%	} }%>
                            
                        </div>
                        
                    </div>
                </div>                
                <div class="span4">
                    <div class="head">
                        <div class="isw-cloud"></div>
                        <h1>兑换方式</h1>
                        <ul class="buttons">        
                        </ul> 
                        <div class="clear"></div>
                    </div>
                    <div class="block users scrollBox">
                        
                        <div class="scroll" style="height: 550px;">
                        <%if(session.getAttribute("btc_stock_map")!=null){
                        	Map<Integer,Btc_stock> 	all_btc_stock_map = (Map<Integer,Btc_stock>)session.getAttribute("all_btc_stock_map");
                        	Iterator it_btc_stock_map2 = all_btc_stock_map.keySet().iterator();
                        	while(it_btc_stock_map2.hasNext()){
                        		int key =  (Integer)it_btc_stock_map2.next();
                        		Btc_stock btc_stock = (Btc_stock)all_btc_stock_map.get(key);
                         		%>
	                         	 <div class="item">
			                           <div class="info">
			                               <a href="index.do?updateStock&id=<%=btc_stock.getBtc_stock_id() %>" class="name"><%=btc_stock.getBtc_stock_Eng_name() %>/<%=btc_stock.getBtc_stock_exchange_name() %></a>
			                               <p>兑换率：<%=format.trans(btc_stock.getBtc_stock_price())%></p>                                    
			                               <div class="controls">                                    
			                                   <a href="managestock.do?delete&id=<%=btc_stock.getBtc_stock_id() %>" class="icon-remove"></a>
			                               </div>                                                                    
			                           </div>
			                           <div class="clear"></div>
			                       </div>
                          <%	}
                        }%>                   
                     
                            
                        </div>
                        
                    </div>
                </div>   
                <%if(request.getAttribute("updateStock")==null){
                	%>
                	<div class="span4">
                    <div class="head">
                        <div class="isw-ok"></div>
                        <h1>添加币种</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">                        
                        <form name="addstock" id="validation" action="managestock.do?addstock" method="post"
                        enctype="multipart/form-data">
                        <input type="hidden" name="baseurl" value="<%=basePath %>"/>
                        <div class="row-form">
                            <div class="span2" style="width:100px">图标:(jpg格式)</div>
                            <div class="span2" style="margin-left:0px"><input type="file" name="file" size="50"></div>                                                        
                                                    
                            <div class="clear"></div>
                        </div>
                        <div class="row-form">
                            <div class="span3">币名:</div>
                            <div class="span9"><input name="stock_name" value="中文名" type="text"><span>市场上的币种：如比特币..</span></div>
                            <div class="clear"></div>
                        </div>                         

                        <div class="row-form">
                            <div class="span3">币英文缩写:</div>
                            <div class="span9"><input name="stock_Eng_name" value="请输入大写字母" type="text"><span>英文名：如BTC..</span></div>
                            <div class="clear"></div>
                        </div>    
                             
                        <div class="row-form">
                            <div class="span3">开启交易:</div>
                            <div class="span9">
                            <select name="istrade">
                                        <option value="1">开启</option>
                                		<option value="0">关闭</option>
                             </select>
                             </div>
                            <div class="clear"></div>
                        </div>         
                        <div class="row-form">
                            <div class="span3">与兑换币的兑换率:</div>
                            <div class="span9">        
                                <input name="stock_price" value="例：5000" type="text">
                                <span>比如5000人民币买1比特币</span>
                            </div>
                            <div class="clear"></div>
                        </div>   
                                                                                                      
                        <div class="row-form">
                            <div class="span12">        
                                	<table border="1" width="100%">
                                	<tr><td>交易手续费</td><td>充值最小值</td></tr>
                                	<tr><td>提现最小值</td><td>提现最大值</td></tr>
                                	<tr><td>提现手续费</td><td></td></tr>
                                	</table>
                            	</div>
                            	<div class="span12">        
                               	上方为图例
                            	</div>
                            	<div class="span5">        
                                <input name="tradesxf" value="交易手续费" type="text">
                            	</div>
                            	<div class="span5">        
                                <input name="rechargezxz" value="充值最小值" type="text">
                            	</div>
                            	<div class="span5">        
                                <input name="withdrawzxz" value="提现最小值" type="text">
                            	</div>
                            	<div class="span5">        
                                <input name="withdrawzdz" value="提现最大值" type="text">
                            	</div>
                            	<div class="span5">        
                                <input name="withdrawsxf" value="提现手续费" type="text">
                            	</div>
                            <div class="clear"></div>
                        </div>      
                        <div class="row-form">
                            <div class="span3">兑换币:</div>
                            <div class="span9">       
                            	<input value="CNY" readonly="readonly" type="text" name="stock_exchange_name"> 
                            </div>
                            <div class="clear"></div>
                        </div>      
                            
                        <div class="row-form">
                            <div class="span3">该币种充值地址:</div>
                            <div class="span9">        
                                <input name="stock_recharge_adr" value="暂无地址" type="text">
                                <span>请输入用户充值到平台的地址</span>
                            </div>
                            <div class="clear"></div>
                        </div>  
                        <div class="row-form">
                            <div class="span3">rpcpocketadr:</div>
                            <div class="span9">        
                                <input name="stock_pocket_adr" value="钱包的rpcconnection" type="text">
                                <span>没有可以不填（跟对应币种的name.conf配置文件保持一致）</span>
                            </div>
                            <div class="clear"></div>
                        </div>  
                        <div class="row-form">
                            <div class="span3">rpcport:</div>
                            <div class="span9">        
                                <input name="stock_port" value="钱包的rpcport" type="text">
                                <span>没有可以不填（跟对应币种的name.conf配置文件保持一致）</span>
                            </div>
                            <div class="clear"></div>
                        </div>  
                        <div class="row-form">
                            <div class="span3">rpcusername:</div>
                            <div class="span9">        
                                <input name="rpcusername" value="钱包的rpcusername" type="text">
                                <span>没有可以不填（跟对应币种的name.conf配置文件保持一致）</span>
                            </div>
                            <div class="clear"></div>
                        </div> 
                        <div class="row-form">
                            <div class="span3">rpcpassword:</div>
                            <div class="span9">        
                                <input name="rpcpassword" value="钱包的rpcpassword" type="text">
                                <span>没有可以不填（跟对应币种的name.conf配置文件保持一致）</span>
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
                <% }else{%>
                <div class="span4">
                    <div class="head">
                        <div class="isw-ok"></div>
                        <%Btc_stock btc_stock = (Btc_stock)session.getAttribute("btc_stock");
                          %>
                        <h1>修改<%=btc_stock.getBtc_stock_name() %>的配置</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">                        
                        <form id="validation" action="managestock.do?updateStock" method="post"
                        enctype="multipart/form-data">
                        <input name="btc_stock_id" type="hidden" value="<%=btc_stock.getBtc_stock_id()%>"/>
                        <input type="hidden" name="logoadr" value="<%=btc_stock.getLogoadr() %>"/>  
                        <input type="hidden" name="baseurl" value="<%=basePath %>"/>
                        <div class="row-form">
                            <div class="span2" style="width:100px"><img src="<%=btc_stock.getLogoadr()%>" width="31px" height="31px" class="img-polaroid"/></div>
                            <div class="span2" style="margin-left:0px"><input type="file" name="file" size="50"></div>                                                        
                                                    
                            <div class="clear"></div>
                        </div>  
                        <div class="row-form">
                            <div class="span3">币名:</div>
                            <div class="span9"><input name="stock_name" value="<%=btc_stock.getBtc_stock_name() %>" type="text"><span>市场上的币种：如比特币..</span></div>
                            <div class="clear"></div>
                        </div>                         

                        <div class="row-form">
                            <div class="span3">币英文缩写:</div>
                            <div class="span9"><input name="stock_Eng_name" value="<%=btc_stock.getBtc_stock_Eng_name() %>" type="text"><span>英文名：如BTC..</span></div>
                            <div class="clear"></div>
                        </div>             
                        <div class="row-form">
                            <div class="span3">开启交易:</div>
                            <div class="span9">
                            <select name="istrade">
                                        <option value="<%=btc_stock.getIstrade() %>"><%=format.transTradeStatus(btc_stock.getIstrade()) %></option>
                                        <option value="1">开启</option>
                                		<option value="0">关闭</option>
                             </select>
                             </div>
                            <div class="clear"></div>
                        </div>                                                                    

                        <div class="row-form">
                            <div class="span3">与兑换币的兑换率:</div>
                            <div class="span9">        
                                <input name="stock_price" value="<%=format.trans(btc_stock.getBtc_stock_price()) %>" type="text">
                                <span>比如5000人民币买1比特币</span>
                            </div>
                            <div class="clear"></div>
                        </div>      
                        <div class="row-form">
                           		 <div class="span12">        
                                	<table border="1" width="100%">
                                	<tr><td>交易手续费</td><td>充值最小值</td></tr>
                                	<tr><td>提现最小值</td><td>提现最大值</td></tr>
                                	<tr><td>提现手续费</td><td></td></tr>
                                	</table>
                            	</div>
                            	<div class="span12">        
                               	上方为图例
                            	</div>
                            	<div class="span5">        
                                <input name="tradesxf" value="<%=format.trans(btc_stock.getTradesxf()) %>" type="text">
                            	</div>
                            	<div class="span5">        
                                <input name="rechargezxz" value="<%=format.trans(btc_stock.getRechargezxz()) %>" type="text">
                            	</div>
                            	<div class="span5">        
                                <input name="withdrawzxz" value="<%=format.trans(btc_stock.getWithdrawzxz()) %>" type="text">
                            	</div>
                            	<div class="span5">        
                                <input name="withdrawzdz" value="<%=format.trans(btc_stock.getWithdrawzdz()) %>" type="text">
                            	</div>
                            	<div class="span5">        
                                <input name="withdrawsxf" value="<%=format.trans(btc_stock.getWithdrawsxf()) %>" type="text">
                            	</div>
                            <div class="clear"></div>
                        </div>                                                                            
                            
                        <div class="row-form">
                            <div class="span3">兑换币:</div>
                            <div class="span9">     
                            <input value="CNY" readonly="readonly" type="text" name="stock_exchange_name">    
                            </div>
                            <div class="clear"></div>
                        </div>      
                            
                        <div class="row-form">
                            <div class="span3">该币种充值地址:</div>
                            <div class="span9">        
                                <input name="stock_recharge_adr" value="<%=btc_stock.getBtc_stock_recharge_adr() %>" type="text">
                                <span>请输入用户充值到平台的地址</span>
                            </div>
                            <div class="clear"></div>
                        </div>  
                        <div class="row-form">
                            <div class="span3">rpcpocketadr:</div>
                            <div class="span9">        
                                <input name="stock_pocket_adr" value="<%=btc_stock.getBtc_stock_pocket_adr() %>" type="text">
                                <span>没有可以不填（跟对应币种的name.conf配置文件保持一致）</span>
                            </div>
                            <div class="clear"></div>
                        </div>  
                        <div class="row-form">
                            <div class="span3">rpcport:</div>
                            <div class="span9">        
                                <input name="stock_port" value="<%=btc_stock.getBtc_stock_port() %>" type="text">
                                <span>没有可以不填（跟对应币种的name.conf配置文件保持一致）</span>
                            </div>
                            <div class="clear"></div>
                        </div>  
                        <div class="row-form">
                            <div class="span3">rpcusername:</div>
                            <div class="span9">        
                                <input name="rpcusername" value="<%=btc_stock.getRpcusername()%>" type="text">
                                <span>没有可以不填（跟对应币种的name.conf配置文件保持一致）</span>
                            </div>
                            <div class="clear"></div>
                        </div>  
                        <div class="row-form">
                            <div class="span3">rpcpassword:</div>
                            <div class="span9">        
                                <input name="rpcpassword" value="<%=btc_stock.getRpcpassword() %>" type="text">
                                <span>没有可以不填（跟对应币种的name.conf配置文件保持一致）</span>
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

            
        </div>
        
    </div>   
    
</body>
</html>
