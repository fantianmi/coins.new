<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
<%@ page import="com.mvc.util.*"%>
<%FormatUtil format = new FormatUtil(); %>
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<%ResourceBundle res = ResourceBundle.getBundle("shop"); %>  
<body>
<script type="text/javascript">
function addSubmit(){
	if(checkIsNull("cardnum")==true){alert("请输入充值码"); return false;}
	if(checkIsNull("season")==true){alert("请输入期次"); return false;}
    document.getElementById("addCard").submit();
}
function carddelete(){
    document.getElementById("sellingForm").action = "phonecard.do?delete";
    document.getElementById("sellingForm").submit();
}
</script>
	<jsp:include page="/include/headhtml.jsp"></jsp:include>
	<jsp:include page="/include/lpanelhtml.jsp"></jsp:include>
    <div class="content">
        <jsp:include page="/include/pathpanelhtml.jsp"></jsp:include>
        <div class="workplace">
            <div class="row-fluid">
               <div class="span12">
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>录入手机充值卡</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">                        
                        <form id="addCard" method="post" action="phonecard.do?add">
                        <div class="row-form">
                            <div class="span1">充值码</div>
                            <div class="span2"><input type="text" name="cardnum" id="cardnum"/></div>
                            <div class="span2">价格（<%=res.getString("shop.stock.name") %>/条）</div>
                            <div class="span2"><input type="text" name="cardprice" id="cardprice" value="<%=res.getString("card.default.price")%>"/></div>
                            <div class="span1">期次</div>
                            <div class="span2"><input type="text" name="season" id="season" value="<%=request.getAttribute("season").toString()%>"/></div>
                            <div class="span2"><input value="录入" type="button" onclick="addSubmit();" class="btn btn-block"></div>
                            <div class="clear"></div>
                        </div>    
                        </form>                                        
                    </div>
                </div>
            </div>            
            
            <div class="dr"><span></span></div>
            <!-- rowspan -->
            <div class="row-fluid">
                <div class="span6">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>出售中的充值码</h1>     
                        <ul class="buttons">
                            <li>
                                <a href="#" class="isw-settings"></a>
                                <ul class="dd-list">
                                    <li><a href="javascript:carddelete();"><span class="isw-plus"></span>删除</a></li>
                                </ul>
                            </li>
                        </ul>                          
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid table-sorting">
                    	<form id="sellingForm" method="post">
                        <table cellpadding="0" cellspacing="0" width="100%" class="table">
                            <thead>
                                <tr>
                                    <th><input type="checkbox" name="checkall"/></th>
                                    <th width="10%">id</th>
                                    <th width="30%">充值码</th>
                                    <th width="10%">价格</th>
                                    <th width="30%"> 生成日期</th>                                    
                                    <th width="20%">期次</th>                                    
                                </tr>
                            </thead>
                            <tbody>
                            
                            <%if(request.getAttribute("sellinglist")!=null){
                            	Btc_phonecard card = new Btc_phonecard();
                            	List<Btc_phonecard> list = (List<Btc_phonecard>)request.getAttribute("sellinglist");
                            	for(int i=0;i<list.size();i++){
                            		card = list.get(i);%>
                            	<tr>
                                    <td><input type="checkbox" name="checkbox" value="<%=card.getId() %>"/></td>
                                    <td><%=card.getId()%></td>
                                    <td><%=card.getCard()%></td>
                                    <td><%=card.getPrice() %></td>
                                    <td><%=card.getSdtime()%></td>                                    
                                    <td><%=card.getSeason()%></td>                                    
                                </tr>	
                            	<%}} %>
                            </tbody>
                        </table>
                        </form>
                        <div class="clear"></div>
                    </div>
                </div>
                <!-- rowspan -->
                <div class="span4">
                <form action="shop.do?update"  method="post">
                    <div class="head">
                        <div class="isw-list"></div>
                        <h1>打开关闭</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">                        
                        <%int isopen=0;
                        if(request.getAttribute("isopen")!=null){
                        	isopen=Integer.parseInt(request.getAttribute("isopen").toString());
                        }
                        %>
                        <div class="row-form">
                            <div class="span5">状态:</div>
                            <div class="span7">
                                <select name="isopen">
                                		<option value="<%=isopen%>"><%=format. transShop(isopen)%></option>
                                		<option value="1">打开商场</option>
                                        <option value="0">关闭商场</option>
                                </select>
                            </div>
                            <div class="clear"></div>
                        </div> 
                        <div class="row-form">
                           <input class="btn btn-block" value="保存" type="submit">
                            <div class="clear"></div>
                        </div>                                           
                    </div>
                    </form>
                </div>
                <!-- rowspan -->
            </div>
            <div class="dr"><span></span></div> 
            <%
		        int countRow=0;
		        int pcardstartNo=0;
		        if(request.getAttribute("countRow")!=null){countRow=Integer.parseInt(request.getAttribute("countRow").toString());}
		        if(session.getAttribute("pcardstartNo")!=null){pcardstartNo=Integer.parseInt(session.getAttribute("pcardstartNo").toString());}
		        %>
            <!--rowspan-->
            <div class="row-fluid">
                <div class="span6">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>已售出的充值码(<%=countRow %>)</h1>    
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid table-sorting">
                        <table cellpadding="0" cellspacing="0" width="100%" class="table">
                            <thead>
                                <tr>
                                    <th width="15%">使用者</th>
                                    <th width="15%">充值码</th>
                                    <th width="15%">价格</th>
                                    <th width="35%">出售日期</th>                                   
                                    <th width="20%">期次</th>                                   
                                </tr>
                            </thead>
                            <tbody>
                            <%if(request.getAttribute("selledlist")!=null){
                            	Btc_phonecard card = new Btc_phonecard();
                            	List<Btc_phonecard> list = (List<Btc_phonecard>)request.getAttribute("selledlist");
                            	Map<Integer,Btc_user> usermap = (Map<Integer,Btc_user>)request.getAttribute("usermap");
                            	Btc_user user = new Btc_user();
                            	for(int i=0;i<list.size();i++){
                            		card = list.get(i);
                            		user.setUid(0);
                            		user.setUusername("该用户不存在");
                            		if(usermap.get(card.getUid())!=null){
                            			user = usermap.get(card.getUid());
                            		}
                            		%>
                            	<tr>
                                    <td><a href="usermanager.do?seeDetail&uid=<%=user.getUid() %>"><%=user.getUusername()%></td>
                                    <td><%=card.getCard()%></td>
                                    <td><%=card.getPrice()%></td>
                                    <td><%=card.getUsetime()%></td>                                    
                                    <td><%=card.getSeason()%></td>                                    
                                </tr>
                            	<%}} %>
                            </tbody>
                        </table>
                        <div class="clear"></div>
                    </div>
                </div>                                
            </div>
            <!--row span-->
            <div class="row-form" >
              <div class="span9">
                      <div class="btn-group">
                      <%
                      int count = countRow;
                      int pageSize = 100;
                      int myRows = 0;
                         if(count/pageSize==0)myRows = count/pageSize;
                         else myRows = count/pageSize+1;
                         int start = pcardstartNo;
                         int end = pageSize * (myRows-1);
                         int pageNow = (start+pageSize)/pageSize;
                      %>
                      </div>
                      <span><input class="btn" type="button" onclick="fenye(0,<%=pageSize%>);" value="首页"/></span>
                      <span><input id="prePage" class="btn" type="button" onclick="fenye(<%=start-100 %>,<%=pageSize%>);" value="上一页"/></span>
                      <span class="lead">&nbsp;&nbsp;<%=pageNow %>&nbsp;&nbsp;</span>
                      <span><input id="nextPage" class="btn" type="button" onclick="fenye(<%=start+100 %>,<%=pageSize%>);" value="下一页"/></span>
                      <span><input class="btn" type="button" onclick="fenye(<%=end%>,<%=pageSize%>);" value="末页"/></span>
                      <span style="width:30px">
                      <select id="pageNo" style="width:80px">
                           <option value="<%=pageNow%>">第<%=pageNow%>页</option>
                      <%for(int i=1;i<=myRows;i++){%>
                           <option value="<%=(i-1)*pageSize%>">第<%=i%>页</option>
                      <%} %>
                      </select>
                      <input class="btn" type="button" onclick="goto();" value="GO"/>
                      </span>
                      <script>
                      function fenye(start,count){
                           window.location.href='phonecard.do?start='+start+'&count='+count+'';
                      }
                      function goto(){
                           var obj = document.getElementById('pageNo'); //selectid
                                   var index = obj.selectedIndex;
                                   var start = obj.options[index].value; // 选中值
                           var count = <%=pageSize%>;
                           window.location.href='phonecard.do?start='+start+'&count='+count+'';
                      }
                      
                      $(document).ready(function() {
                           var start = <%=start%>;
                           var count = <%=count%>
                                   if(start-100<0){
                                        document.getElementById('prePage').setAttribute("disabled",true);
                                   }
                                   if(count-start<100){
                                        document.getElementById('nextPage').setAttribute('disabled',true);
                                   }
                              });
                      </script>
                  </div>
            <!--row span-->
        </div>
        
    </div>   
    
</body>
</html>
