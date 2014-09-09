<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="com.mvc.util.*"%>
<%FormatUtil format = new FormatUtil(); %>
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
            <%
                    Btc_user user = new Btc_user();
                    String username = "";
                    String uname = "未认证";
                    String ucid = "未认证";
                    String email = "未认证";
                    String uphone = "未认证";
                    int uid=0;
                    if(request.getAttribute("user")!=null){
                    	user = (Btc_user)request.getAttribute("user");
                    	username = user.getUusername();
                    	if(user.getUname()!=null)
                    		uname = user.getUname();
                    	if(user.getUcertification()!=null)
                    		ucid = user.getUcertification();
                    	if(user.getUemail()!=null)
                    		email = user.getUemail();
                    	if(user.getUphone()!=null){
                    		uphone = user.getUphone();
                    	}
                    	uid = user.getUid();
                    	
                    }
                    %>
                
                <div class="span6">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1><%=session.getAttribute("username").toString()%>持有币种（非特殊情况禁止修改用户资料！）</h1>      
                        <ul class="buttons">
                       	 <a class="btn btn-inverse" href="javascript:history.go(-1);" style="height: 28px">返回上一层</a>
                        </ul>                        
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">
                    <table class="table" cellpadding="0" cellspacing="0" width="100%">
                            <thead>
                                <tr>                                    
                                    <th width="25%">币种</th>
                                    <th width="25%">持有数量</th>                               
                                    <th width="25%">操作</th>                               
                                </tr>
                            </thead>
                            <tbody>
                    <%BigDecimal cny = new BigDecimal(0);
					  cny = new BigDecimal(session.getAttribute("ab_cny").toString());
					  BigDecimal otherCount = cny;
					  Btc_stock stock = new Btc_stock(); 
					  Map<Integer,Btc_stock> stock_map = (Map<Integer,Btc_stock>)session.getAttribute("stock_mapall");
					  Map<Integer,Btc_holding> holdmap = new HashMap<Integer,Btc_holding>();
					  if(session.getAttribute("holdmap")!=null){
						  holdmap = (Map<Integer,Btc_holding>)session.getAttribute("holdmap");
					  }
					  Iterator it = stock_map.keySet().iterator();
					  while(it.hasNext()){
						  int key = Integer.parseInt(it.next().toString());
						  stock = stock_map.get(key);
						  Btc_holding hold = new Btc_holding();
						  hold.setBtc_stock_amount(new BigDecimal(0));
						  int holdid=0;
						  if(holdmap.get(stock.getBtc_stock_id())!=null){
					  		hold = holdmap.get(stock.getBtc_stock_id());
					  		holdid = hold.getBtc_holding_id();
					  		otherCount = otherCount.add(stock.getBtc_stock_price().multiply(hold.getBtc_stock_amount()));
						  }
						  %>
						  <form action="detail.do?changehold" method="post"/>
					  		<input type="hidden" name="uid" value="<%=uid %>"/>
					  		<input type="hidden" name="stockid" value="<%=stock.getBtc_stock_id()%>"/>
					  		<tr>                                    
                                <td><%=stock.getBtc_stock_name() %>(<%=stock.getBtc_stock_Eng_name()%>)</td>
                                <td>
                                <input type="text" value="<%=format.trans(hold.getBtc_stock_amount())%>" name="amount"/>
                                </td>                    
                                <td>
                               	 <input class="btn btn-warning" type="submit" value="修改(警告！)"/>
                                </td>                    
                            </tr>
                            </form>
					  <%}%>
                              <tr>                                    
                                  <td>总资产</td>
                                  <td><%=format.trans(otherCount) %></td>                    
                                  <td></td>                    
                              </tr>
                              <form action="detail.do?changecny" method="post"/>
						  		<input type="hidden" name="uid" value="<%=uid %>"/>
						  		<tr>                                    
	                                <td>人民币余额</td>
	                                <td>
	                                <input type="text" value="<%=format.trans(cny)%>" name="amount"/>
	                                </td>                    
	                                <td>
	                               	 <input class="btn btn-warning" type="submit" value="修改(警告！)"/>
	                                </td>                    
	                            </tr>
	                            </form>
                            </tbody>
                        </table>
                    </div>
                </div> 
                <!-- ######################################################### -->
                <div class="span6">
                    <div class="head">
                        <div class="isw-documents"></div>
                        <h1>用户详细信息（非特殊情况禁止修改用户资料！）</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">      
                        <form action="detail.do?changedetail" method="post">
                        <input type="hidden" name="uid" value="<%=uid %>"/>
                        <div class="row-form">
                            <div class="span3">用户名:</div>
                            <div class="span9"><input value="<%=username %>" name="username" type="text" readonly></div>
                            <div class="clear"></div>
                        </div>
                        <div class="row-form">
                            <div class="span3">真实姓名:</div>
                            <div class="span9"><input value="<%=uname %>" name="uname" type="text"></div>
                            <div class="clear"></div>
                        </div> 
                        <div class="row-form">
                            <div class="span3">身份证号:</div>
                            <div class="span9"><input value="<%=ucid %>" name="ucid" type="text"></div>
                            <div class="clear"></div>
                        </div> 
                        <div class="row-form">
                            <div class="span3">注册邮箱:</div>
                            <div class="span9"><input value="<%=email %>" name="email" type="text"></div>
                            <div class="clear"></div>
                        </div>  
                        <div class="row-form">
                            <div class="span3">绑定手机:</div>
                            <div class="span9"><input value="<%=uphone %>" name="uphone" type="text"></div>
                            <div class="clear"></div>
                        </div> 
                        <div class="row-form">
                            <div class="span3">&nbsp;</div>
                            <div class="span9"><input type="submit" class="btn btn-warning" value="确认修改用户信息(警告！)"></div>
                            <div class="clear"></div>
                        </div> 
                        </form>
                        

                    </div>
                </div>                               
                
            </div>
            <div class="dr"><span></span></div> 
            <script type="text/javascript">
            function drechargelog(){
                document.getElementById("rechargelog").action = "usermanager.do?drechargelog";
                document.getElementById("rechargelog").submit();
            }
			</script>
             <!-- row span -->
            <div class="row-fluid">
                <div class="span12">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>充值记录</h1>    
                        <ul class="buttons">
                            <li>
                                <a href="#" class="isw-settings"></a>
                                <ul class="dd-list">
                                    <li><a onclick="drechargelog();" href="#"><span class="isw-delete"></span>删除</a></li>
                                </ul>
                            </li>
                        </ul>     
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid" style="height:200px; overflow:auto">
                    <form id="rechargelog" action="" method="post">
                    <input type="hidden" name="uid" value="<%=uid%>"/>
                        <table class="table" cellpadding="0" cellspacing="0" width="100%">
                            <thead>
                                <tr>               
                                	<th><input type="checkbox" name="checkall"/></th>                     
                                    <th width="10%">id</th>
                                    <th width="10%">金额</th>
                                    <th width="30%">时间</th>
                                    <th width="40%">状态</th>
                                    <th width="10%">方式</th>                                    
                                </tr>
                            </thead>
                            <tbody>
                            <%
                            BigDecimal rtotal = new BigDecimal(0);
                            if(request.getAttribute("rcnylistm")!=null){
                            	List<UserRcnyModel> rcnylistm = (List<UserRcnyModel>)request.getAttribute("rcnylistm");
                            	UserRcnyModel urcm = new UserRcnyModel();
                            	
                            	for(int i=0;i<rcnylistm.size();i++){
                            		urcm = rcnylistm.get(i);
                            		rtotal = rtotal.add(urcm.getAmount());
                            		%>
                            		<tr>                
                            			<td><input type="checkbox" name="checkbox" value="<%=urcm.getId()%>"/></td>                    
	                                    <td><%=urcm.getId() %></td>
	                                    <td><%=format.trans(urcm.getAmount()) %></td>
	                                    <td><%=urcm.getRtime() %></td>
	                                    <td><%=urcm.getUstatus() %></td>
	                                    <td><%=urcm.getRway() %></td>
	                                </tr>
                           <%} } %>
                            </tbody>
                        </table>
                        </form>      
                    </div>
                    <div class="block-fluid">
                        <table class="table" cellpadding="0" cellspacing="0" width="100%" >
                            <thead>
                                <tr>                                    
                                    <th colspan="4">总计：<%=format.trans(rtotal) %> CNY</th>                                 
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
            <div class="dr"><span></span></div>
             <script type="text/javascript">
	            function dwithdrawlog(){
	                document.getElementById("withdrawlog").action = "usermanager.do?dwithdrawlog";
	                document.getElementById("withdrawlog").submit();
	            }
				</script>
            <!-- row span -->
            <div class="row-fluid">
                <div class="span12">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>提现记录</h1>
                        <ul class="buttons">
                            <li>
                                <a href="#" class="isw-settings"></a>
                                <ul class="dd-list">
                                    <li><a onclick="dwithdrawlog();" href="#"><span class="isw-delete"></span>删除</a></li>
                                </ul>
                            </li>
                        </ul>       
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid" style="height:200px; overflow:auto">
                     <form id="withdrawlog" action="" method="post">
                     	<input type="hidden" name="uid" value="<%=uid%>"/>
                        <table class="table" cellpadding="0" cellspacing="0" width="100%">
                            <thead>
                                <tr>  
                                	<th><input type="checkbox" name="checkall"/></th>                                      
                                    <th width="5%">金额</th>
                                    <th width="13.5%">时间</th>
                                    <th width="30%">状态</th>
                                    <th width="7.5%">收款人</th>                                    
                                    <th width="15%">地区</th>                                    
                                    <th width="14%">银行</th>                                    
                                    <th width="15%">银行卡号</th>                                    
                                </tr>
                            </thead>
                            <tbody>
                            <%
                            BigDecimal wtotal = new BigDecimal(0);
                            if(request.getAttribute("wcnylistm")!=null){
                            	List<UserWcnyModel> wcnylistm = (List<UserWcnyModel>)request.getAttribute("wcnylistm");
                            	UserWcnyModel uwcm = new UserWcnyModel();
                            	for(int i=0;i<wcnylistm.size();i++){
                            		uwcm = wcnylistm.get(i);
                            		wtotal = wtotal.add(uwcm.getWmaount());%>
                            		<tr>                     
                            			<td><input type="checkbox" name="checkbox" value="<%=uwcm.getId()%>"/></td>                 
	                                    <td><%=format.trans(uwcm.getWmaount()) %></td>
	                                    <td><%=uwcm.getRtime() %></td>
	                                    <td><%=uwcm.getRstatus() %></td>
	                                    <td><%=uwcm.getRname() %></td>
	                                    <td><%=uwcm.getKaihubank() %></td>
	                                    <td><%=uwcm.getBank() %></td>
	                                    <td><%=uwcm.getCard() %></td>
	                                </tr>
                            <%}}%>
                            </tbody>
                        </table>
                        </form>
                    </div>
                    <div class="block-fluid">
                        <table class="table" cellpadding="0" cellspacing="0" width="100%" >
                            <thead>
                                <tr>                                    
                                    <th colspan="7">总计：<%=format.trans(wtotal) %>CNY</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>                                
                
            </div>
            <!-- row span -->
             <script type="text/javascript">
	            function drechargeslog(){
	                document.getElementById("rechargeslog").action = "usermanager.do?drechargeslog";
	                document.getElementById("rechargeslog").submit();
	            }
				</script>
            <div class="row-fluid">
                <div class="span12">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>充币记录</h1>
                        <ul class="buttons">
                            <li>
                                <a href="#" class="isw-settings"></a>
                                <ul class="dd-list">
                                    <li><a onclick="drechargeslog();" href="#"><span class="isw-delete"></span>删除</a></li>
                                </ul>
                            </li>
                        </ul>        
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid" style="height:200px; overflow:auto">
                    	<form id="rechargeslog" action="" method="post">
                     	<input type="hidden" name="uid" value="<%=uid%>"/>
                        <table class="table" cellpadding="0" cellspacing="0" width="100%">
                            <thead>
                                <tr>                                    
                               		<th><input type="checkbox" name="checkall"/></th>
                                    <th width="10%">币种</th>
                                    <th width="10%">数量</th>
                                    <th width="40%">地址</th>
                                    <th width="20%">时间</th>                                    
                                    <th width="20%">状态</th>                                    
                                </tr>
                            </thead>
                            <tbody>
                            <%if(request.getAttribute("rstocklistm")!=null){
                            	List<UserStockModel> rstocklistm = (List<UserStockModel>)request.getAttribute("rstocklistm");
                            	UserStockModel usm = new UserStockModel();
                            	for(int i=0;i<rstocklistm.size();i++){
                            		usm = rstocklistm.get(i);%>
                            		<tr>                        
                            			<td><input type="checkbox" name="checkbox" value="<%=usm.getId()%>"/></td>                             
	                                    <td><%=usm.getStockName() %></td>
	                                    <td><%=format.trans(usm.getAmount()) %></td>
	                                    <td><%=usm.getAdr() %></td>
	                                    <td><%=usm.getTime() %></td>
	                                    <td><%=usm.getStatus() %></td>
	                                </tr>
                            	<%}} %>
                            </tbody>
                        </table>
                        </form>
                    </div>
                </div>   
                <!-- colspan -->                             
            </div>
            <!-- row span -->
             <script type="text/javascript">
              function dwithdrawslog(){
	                document.getElementById("withdrawslog").action = "usermanager.do?dwithdrawslog";
	                document.getElementById("withdrawslog").submit();
	            }
				</script>
            <div class="row-fluid">
                <!-- colspan -->                             
                <div class="span12">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>提币记录</h1>      
                        <ul class="buttons">
                            <li>
                                <a href="#" class="isw-settings"></a>
                                <ul class="dd-list">
                                    <li><a onclick="dwithdrawslog();" href="#"><span class="isw-delete"></span>删除</a></li>
                                </ul>
                            </li>
                        </ul>   
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid" style="height:200px; overflow:auto">
                   	 <form id="withdrawslog" action="" method="post">
                     	<input type="hidden" name="uid" value="<%=uid%>"/>
                        <table class="table" cellpadding="0" cellspacing="0" width="100%">
                            <thead>
                                <tr>            
                                	<th><input type="checkbox" name="checkall"/></th>                        
                                    <th width="10%">币种</th>
                                    <th width="10%">数量</th>
                                    <th width="40%">地址</th>
                                    <th width="20%">时间</th>                                    
                                    <th width="20%">时间</th>                                    
                                </tr>
                            </thead>
                            <tbody>
                                <%if(request.getAttribute("wstocklistm")!=null){
                            	List<UserStockModel> rstocklistm = (List<UserStockModel>)request.getAttribute("wstocklistm");
                            	UserStockModel usm = new UserStockModel();
                            	for(int i=0;i<rstocklistm.size();i++){
                            		usm = rstocklistm.get(i);%>
                            		<tr>                                   
                            			<td><input type="checkbox" name="checkbox" value="<%=usm.getId()%>"/></td>   
	                                    <td><%=usm.getStockName() %></td>
	                                    <td><%=format.trans(usm.getAmount()) %></td>
	                                    <td><%=usm.getAdr() %></td>
	                                    <td><%=usm.getTime() %></td>
	                                    <td><%=usm.getStatus() %></td>
	                                </tr>
                            	<%}} %>                               
                            </tbody>
                        </table>
                        </form>
                    </div>
                </div>                                
            </div>
            <!-- row span -->
            <script type="text/javascript">
              function dbdeallist(){
	                document.getElementById("bdeallist").action = "usermanager.do?ddeallist";
	                document.getElementById("bdeallist").submit();
	            }
              function dsdeallist(){
	                document.getElementById("sdeallist").action = "usermanager.do?ddeallist";
	                document.getElementById("sdeallist").submit();
	            }
              
              
				</script>
            <div class="row-fluid">
                <div class="span6">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>买交易记录</h1> 
                        <ul class="buttons">
                            <li>
                                <a href="#" class="isw-settings"></a>
                                <ul class="dd-list">
                                    <li><a onclick="dbdeallist();" href="#"><span class="isw-delete"></span>删除</a></li>
                                </ul>
                            </li>
                        </ul>       
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid" style="height:200px; overflow:auto">
                    <form id="bdeallist" action="" method="post">
                     	<input type="hidden" name="uid" value="<%=uid%>"/>
                        <table class="table" cellpadding="0" cellspacing="0" width="100%">
                            <thead>
                                <tr>            
                                	<th><input type="checkbox" name="checkall"/></th>                        
                                    <th width="20%">币种</th>
                                    <th width="20%">兑换</th>
                                    <th width="20%">价格</th>
                                    <th width="20">数量</th>
                                    <th width="20%">兑换额</th>                                    
                                </tr>
                            </thead>
                            <tbody>
                            <%if(request.getAttribute("bdeallistm")!=null){
                            	List<UserDealModel> bdeallistm = (List<UserDealModel>)request.getAttribute("bdeallistm");
                            	UserDealModel udm = new UserDealModel();
                            	for(int i=0;i<bdeallistm.size();i++){
                            		udm = bdeallistm.get(i);%>
                            		<tr>                                    
                            			<td><input type="checkbox" name="checkbox" value="<%=udm.getId()%>"/></td>  
	                                    <td><%=udm.getStockName() %></td>
	                                    <td><%=udm.getExstock() %></td>
	                                    <td><%=format.trans(udm.getPrice()) %></td>
	                                    <td><%=format.trans(udm.getAmount()) %></td>
	                                    <td><%=format.trans(udm.getDuihuane()) %></td>
	                                </tr>
                            		<%}} %>
                            </tbody>
                        </table>
                        </form>
                    </div>
                </div>        
                <!-- colspan -->                        
                <div class="span6">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>卖交易记录</h1>    
                        <ul class="buttons">
                            <li>
                                <a href="#" class="isw-settings"></a>
                                <ul class="dd-list">
                                    <li><a onclick="dsdeallist();" href="#"><span class="isw-delete"></span>删除</a></li>
                                </ul>
                            </li>
                        </ul>    
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid" style="height:200px; overflow:auto">
                    	<form id="sdeallist" action="" method="post">
                     	<input type="hidden" name="uid" value="<%=uid%>"/>
                        <table class="table" cellpadding="0" cellspacing="0" width="100%">
                            <thead>
                                <tr>  
                               		 <th><input type="checkbox" name="checkall"/></th>                                     
                                    <th width="20%">币种</th>
                                    <th width="20%">兑换</th>
                                    <th width="20%">价格</th>
                                    <th width="20">数量</th>
                                    <th width="20%">兑换额</th>                                
                                </tr>
                            </thead>
                            <tbody>
                                <%if(request.getAttribute("sdeallistm")!=null){
                            	List<UserDealModel> bdeallistm = (List<UserDealModel>)request.getAttribute("sdeallistm");
                            	UserDealModel udm = new UserDealModel();
                            	for(int i=0;i<bdeallistm.size();i++){
                            		udm = bdeallistm.get(i);%>
                            		<tr>   
                            			<td><input type="checkbox" name="checkbox" value="<%=udm.getId()%>"/></td>                                   
	                                    <td><%=udm.getStockName() %></td>
	                                    <td><%=udm.getExstock() %></td>
	                                    <td><%=format.trans(udm.getPrice()) %></td>
	                                    <td><%=format.trans(udm.getAmount()) %></td>
	                                    <td><%=format.trans(udm.getDuihuane()) %></td>
	                                </tr>
                            		<%}} %>                               
                            </tbody>
                        </table>
                        </form>
                    </div>
                </div>                                
                
            </div>
            <!-- row span -->
            </div>       
        </div>
        
    </div>   
    <!-- ###################################################################### -->
    
</body>
</html>
