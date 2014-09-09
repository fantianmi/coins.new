<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
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
				<!--################userlist##############-->
                <div class="span6">
                    <div class="head">
                        <div class="isw-cloud"></div>
                        <h1>正在投票中的币种</h1>
                        <ul class="buttons">        
                        </ul> 
                        <div class="clear"></div>
                    </div>
                    <div class="block users scrollBox">
                        
                        <div class="scroll" style="height: 550px">
                        
                        <%if(session.getAttribute("votelist")!=null){
                        	List<Btc_votestock> list = (List<Btc_votestock>)session.getAttribute("votelist");
                        	Btc_votestock bvs = new Btc_votestock();
                        	for(int i=0;i<list.size();i++){
                        		bvs = list.get(i);
                        	
                         		%>
	                         	 <div class="item">
			                           <div class="info">
			                               <a href="index.do?updatevotestock&vid=<%=bvs.getVid() %>" class="name"><%=bvs.getVstockname()%>(<%=bvs.getVstockEngname() %>)/<%=bvs.getVstockfullName() %></a>
			                               <p>获得票数：<%=bvs.getVamount() %></p>                                    
			                               <div class="controls">                                    
			                                   <a href="votestock.do?delete&vid=<%=bvs.getVid() %>" class="icon-remove"></a>
			                               </div>                                                                    
			                           </div>
			                           <div class="clear"></div>
			                       </div>
                          <%	}
                        }%>
                            
                        </div>
                        
                    </div>
                </div>                
                <!--################userlist##############-->
                <%if(request.getAttribute("updateStock")==null){
                	%>
                	<div class="span6">
                    <div class="head">
                        <div class="isw-ok"></div>
                        <h1>添加币种</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">                        
                        <form name="addstock" id="validation" action="votestock.do?add" method="post">
                            
                        <div class="row-form">
                            <div class="span3">币名:</div>
                            <div class="span9"><input name="vstockname" value="中文名" type="text"><span>市场上的币种：如联储币..</span></div>
                            <div class="clear"></div>
                        </div>                         

                        <div class="row-form">
                            <div class="span3">币英文缩写:</div>
                            <div class="span9"><input name="vstockEngname" value="请输入大写字母" type="text"><span>英文名：如 FRSC..</span></div>
                            <div class="clear"></div>
                        </div>                                                                                 

                        <div class="row-form">
                            <div class="span3">币英文全称:</div>
                            <div class="span9">        
                                <input name="vstockfullName" value="比如 FederalReserveSystem" type="text">
                                <span>比如 FederalReserveSystem</span>
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
                <% }else{
                	Btc_votestock bvs = (Btc_votestock)session.getAttribute("bvs");
                %>
                <div class="span6">
                    <div class="head">
                        <div class="isw-ok"></div>
                        <h1>修改</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">                        
                        <form name="addstock" id="validation" action="votestock.do?update" method="post">
                        <input type="hidden" name="vid" value="<%=bvs.getVid() %>"/>    
                        <div class="row-form">
                            <div class="span3">币名:</div>
                            <div class="span9"><input name="vstockname" value="<%=bvs.getVstockname() %>" type="text"><span>市场上的币种：如比特币..</span></div>
                            <div class="clear"></div>
                        </div>                         
                        <div class="row-form">
                            <div class="span3">币英文缩写:</div>
                            <div class="span9"><input name="vstockEngname" value="<%=bvs.getVstockEngname() %> " type="text"><span>英文名：如BTC..</span></div>
                            <div class="clear"></div>
                        </div>                                                                                 
                       <div class="row-form">
                            <div class="span3">币英文全称:</div>
                            <div class="span9">        
                                <input name="vstockfullName" value="比如 FederalReserveSystem" type="text">
                                <span>比如 FederalReserveSystem</span>
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
