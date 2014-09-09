<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.mvc.vo.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("stock"); %>  
<%@ include file="/include/head.jsp"%>
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<body>
<!-- ****************后台管理系统******************** -->
<script type="text/javascript">
            function add(){
                document.getElementById('myForm').action = "bank.do?add";
                document.getElementById("myForm").submit();
            }
            
            function reject(){
                document.getElementById('myForm').action = "bank.do?reject";
                document.getElementById("myForm").submit();
            }
</script>

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
                <div class="span5">
                <%
                GBConfigModel gcm = new GBConfigModel();
                if(request.getAttribute("gbconfig")!=null){
                	gcm = (GBConfigModel)request.getAttribute("gbconfig");
                } %>
                    <div class="head">
                        <div class="isw-documents"></div>
                        <h1><%=res.getString("stock.rengou1.name")%>参数配置</h1>
                        <div class="clear"></div>
                    </div>
                    <form id="gbconfig" action="GB.do?saveGBconfig">
                    <div class="block-fluid">    
                    	<div class="row-form">
                            <div class="span3">已兑换:</div>
                            <div class="span9"><%=gcm.getArengouamount() %></div>
                            <div class="clear"></div>
                        </div> 
                        <div class="row-form">
                            <div class="span3">已铸币:</div>
                            <div class="span9"><%=gcm.getAbuildamount() %></div>
                            <div class="clear"></div>
                        </div>                    
                        
                        <div class="row-form">
                            <div class="span3"><%=res.getString("stock.rengou1.name")%>总量:</div>
                            <div class="span9"><input value="<%=gcm.getAmount() %>" name="amount" type="text" placeholder="数字"></div>
                            <div class="clear"></div>
                        </div>
                        <div class="row-form">
                            <div class="span3">用来兑换总量（现在剩余）:</div>
                            <div class="span9"><input value="<%=gcm.getRengouamount() %>" name="rengou" type="text" placeholder="数字"></div>
                            <div class="clear"></div>
                        </div> 
                        <div class="row-form">
                            <div class="span3">用来铸币总量（现在剩余）:</div>
                            <div class="span9"><input value="<%=gcm.getBuildamount() %>" name="factory" type="text" placeholder="数字"></div>
                            <div class="clear"></div>
                        </div> 
                        <div class="row-form">
                            <div class="span3"></div>
                            <div class="span9"><input value="保存" class="btn" onclick="submitForm('gbconfig');" type="button"></div>
                            <div class="clear"></div>
                        </div> 
						</form>
                                                                       
                        
                    </div>
                </div>
            <!--##############################################-->
            <div class="span7">
                    <div class="head">
                        <div class="isw-documents"></div>
                        <h1>工厂参数配置</h1>
                        <div class="clear"></div>
                    </div>
                    <%
                    FactoryGBConfigModel gbfm = new FactoryGBConfigModel();
                    FactoryGBConfigModel hlfm = new FactoryGBConfigModel();
                    FactoryGBConfigModel jffm = new FactoryGBConfigModel();
                    if(request.getAttribute("facconfigmap")!=null){
                    	Map<String,FactoryGBConfigModel> fmap = (Map<String,FactoryGBConfigModel>)request.getAttribute("facconfigmap");
                    	gbfm = fmap.get("造币工厂");
                    	hlfm = fmap.get("红利工厂");
                    	jffm = fmap.get("积分工厂");
                    }
                    %>
                    <div class="block-fluid tabs">  
                    	<ul>
                            <li><a href="#tabs-1"><%=res.getString("stock.rengou1.name")%>工厂</a></li>
                        </ul>                        
                        
                        <div id="tabs-1">
						<!--################################################-->
						<form id="gbfacconfig" action="GB.do?savefacconfig">
						<input type="hidden" name="type" value="造币工厂"/>
                        <div class="row-form">
                            <div class="span3"><%=res.getString("stock.rengou1.name")%>工厂已铸币:</div>
                            <div class="span9"><%=gbfm.getAbuildamount() %></div>
                            <div class="clear"></div>
                        </div>                    
                        
                        <div class="row-form">
                            <div class="span3">每日铸币时间:</div>
                            <div class="span9"><input value="<%=gbfm.getBuildtime() %>" name="date" type="text" placeholder="数字"></div>
                            <div class="clear"></div>
                        </div>
                        <div class="row-form">
                            <div class="span3">铸币总量:</div>
                            <div class="span9"><input value="<%=gbfm.getBuildamount() %>" name="amount" type="text" placeholder="数字"></div>
                            <div class="clear"></div>
                        </div> 
                        <div class="row-form">
                            <div class="span3">每日铸币量:</div>
                            <div class="span9"><input value="<%=gbfm.getEachbuildamount() %>" name="eachamount" type="text" placeholder="数字"></div>
                            <div class="clear"></div>
                        </div>
                        <div class="row-form">
                            <div class="span3">用户加入铸币限制:</div>
                            <div class="span9"><input value="<%=gbfm.getUserhaslimit() %>" name="userhaslimit" type="text" placeholder="数字"></div>
                            <div class="clear"></div>
                        </div>
                        <div class="row-form">
                            <div class="span3"></div>
                            <div class="span9"><input value="保存" class="btn" type="button" onclick="submitForm('gbfacconfig')"></div>
                            <div class="clear"></div>
                        </div> 
                        </form>
                        </div>                        
                    </div>
                </div>
            <!--##############################################-->
                
            </div>
            <div class="dr"><span></span></div> 
            <!--################################################-->
            <div class="row-fluid">   
            <!--##############################################-->
            <%
            Map<String,Btc_frc_rengou> rengoumap = new LinkedHashMap<String,Btc_frc_rengou>();
            List<Btc_frc_rengou> list = new ArrayList<Btc_frc_rengou>();
            Btc_frc_rengou latestbfr = new Btc_frc_rengou();
            Btc_frc_rengou logbfr = new Btc_frc_rengou();
            if(request.getAttribute("rengoumap")!=null){
            	rengoumap = (LinkedHashMap<String,Btc_frc_rengou>)request.getAttribute("rengoumap");
            	Iterator it = rengoumap.keySet().iterator();
            	int i = 0;
            	while(it.hasNext()){
            		String key = it.next().toString();
            		if(i==0){
            			latestbfr = rengoumap.get(key);
            		}else{
            			logbfr = rengoumap.get(key);
            			list.add(logbfr);
            		}
            		i++;
            	}
            }
            %>
            <div class="span12">
                    <div class="head">
                        <span>        
                           <button class="btn btn-warning" style="height:36px" type="button" id="popup_4">添加最新一期兑换（注：添加后前面的分红设置将作废）</button>
                        </span>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid tabs">  
                    	<ul>
                            <li><a href="#tabs-1"><%=latestbfr.getSeason() %>兑换设置</a></li>
                    	<%
                    	if(list.size()!=0){
                    		int j=2;
                    		for(int i=0;i<list.size();i++){
                    			logbfr = list.get(i);
                    			%>
                            <li><a href="#tabs-<%=j%>"><%=logbfr.getSeason() %>兑换历史记录</a></li>
                    		<%
                    		j++;
                    		} 
                   		}%>
                        </ul>                        
                        
                        <div id="tabs-1">
						<!--################################################-->
						<form id="rengouconfig" action="rengou.do?update">
						<input type="hidden" name="season" value="<%=latestbfr.getSeason() %>"/>
                        <div class="row-form">
                            <div class="span3">发放数量:</div>
                            <div class="span9"><%=latestbfr.getDamount() %></div>
                            <div class="clear"></div>
                        </div>                    
                        <div class="row-form">
                            <div class="span3">剩余总量:</div>
                            <div class="span9"><input value="<%=latestbfr.getAmount()%>" name="amount" type="text" placeholder="数字"></div>
                            <div class="clear"></div>
                        </div>
                        <div class="row-form">
                            <div class="span3">兑换价格:</div>
                            <div class="span9"><input value="<%=latestbfr.getPrice() %>" name="price" type="text" placeholder="数字"></div>
                            <div class="clear"></div>
                        </div> 
                        <div class="row-form">
                            <div class="span3">每位用户可兑换数量:</div>
                            <div class="span9"><input value="<%=latestbfr.getEachamount() %>" name="eachamount" type="text" placeholder="数字"></div>
                            <div class="clear"></div>
                        </div>
                        <div class="row-form">
                            <div class="span3"></div>
                            <div class="span9"><input value="保存" class="btn" type="button" onclick="submitForm('rengouconfig')"></div>
                            <div class="clear"></div>
                        </div> 
                        </form>
                        <!--################################################-->
                        </div>                        
                        <%if(list.size()!=0){
                    		int j=2;
                    		for(int i=0;i<list.size();i++){
                    			logbfr = list.get(i);
                    			
                    			
                    			%>
                    			<div id="tabs-<%=j%>">
		                        <!--################################################-->
		                        <div class="row-form">
		                            <div class="span3">发放数量:</div>
		                            <div class="span9"><%=logbfr.getDamount() %></div>
		                            <div class="clear"></div>
		                        </div>                    
		                        <div class="row-form">
		                            <div class="span3">剩余总量:</div>
		                            <div class="span9"><input value="<%=logbfr.getAmount() %>" type="text" placeholder="数字"></div>
		                            <div class="clear"></div>
		                        </div>
		                        <div class="row-form">
		                            <div class="span3">兑换价格:</div>
		                            <div class="span9"><input value="<%=logbfr.getPrice() %>" type="text" placeholder="数字"></div>
		                            <div class="clear"></div>
		                        </div> 
		                        <div class="row-form">
		                            <div class="span3">每位用户可兑换数量:</div>
		                            <div class="span9"><input value="<%=logbfr.getEachamount() %>" type="text" placeholder="数字"></div>
		                            <div class="clear"></div>
		                        </div>
		                        <!--################################################-->
		                        </div>
                    		<%
                    		j++;
                    		} 
                   		}%>
                        <!--#############################-->
                    </div>
                </div>
            <!--##############################################-->
                
            </div>
            <!--################################################-->
        </div>
        
    </div>   
    <!-- ###################################################################### -->
    <div class="dialog" id="b_popup_4" style="display: none;" title="添加兑换">   
        <div class="block">
   		 <form id="addrengou" action="rengou.do?add">        
   		 	<span>分红期次:</span>
            <p><input type="text" name="season" placeholder="如：第一期（请勿重复添加！）" /></p>                   
            <span>兑换总量:</span>
            <p><input type="text" name="amount"/></p>
            <span>兑换价格:</span>
            <p><input type="text" name="price"/></p>
            <span>每位用户可兑换的数量:</span>
            <p><input type="text" name="eachamount"/></p>
            <span></span>
            <p><input value="确认添加" class="btn" type="button" onclick="submitForm('addrengou')"></p>
            <div class="dr"><span></span></div>
            <p>注意：添加新的期次兑换之后，所有现在的用户在兑换时会采用新的兑换方式，之前的将作为历史记录保存.</p>
         </form>   
        </div>
    </div>  
    
</body>
</html>
