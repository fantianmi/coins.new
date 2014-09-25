<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.math.BigDecimal"%>
<%
	String url = request.getRequestURI();
	if (request.getQueryString() != null)
		url += "?" + request.getQueryString();
%>
<%ResourceBundle res = ResourceBundle.getBundle("stock"); %>  
 <div class="menu">                
        
        <div class="breadLine">            
            <div class="arrow"></div>
            <div class="adminControl active">
                您好, 管理员<%=session.getAttribute("usernameadmin").toString() %>
            </div>
        </div>
        
        <div class="admin">
            <div class="image">
                <img src="img/users/default.jpg" class="img-polaroid"/>                
            </div>
            <ul class="control">                
                <li><span class="icon-share-alt"></span> <a href="vertify.do?logout">退出登录</a></li>
            </ul>
            <div class="info">
                <span>比特币交易网站后台管理系统</span>
            </div>
        </div>
        <!--###################dashbordpanel##########################-->
        <ul class="navigation">            
            <li id="setting">
                <a href="index.do?setting">
                    <span class="isw-grid"></span><span class="text">设置</span>
                </a>
            </li>
            <li class="openable">
                <a href="#">
                    <span class="isw-list"></span><span class="text">用户及订单管理</span>
                </a>
                <ul>
                    <li id="userlist">
                        <a href="index.do?userlist">
                            <span class="icon-th-large"></span><span class="text">用户列表总览</span>
                        </a>                  
                    </li>
                    <li id="yonghuzijin">
                        <a href="holding.do?cny">
                            <span class="icon-th-large"></span><span class="text">用户资金管理</span>
                        </a>                  
                    </li>
                    <li id="rechargestockorder">
                        <a href="index.do?rechargestockorder">
                            <span class="icon-th-large"></span><span class="text">虚拟币充值订单管理</span>
                        </a>                  
                    </li>                                           
                    <li id="withdrawstockorder">
                        <a href="index.do?withdrawstockorder">
                            <span class="icon-th-large"></span><span class="text">虚拟币提现订单管理</span>
                        </a>                  
                    </li>                                           
                </ul> 
            </li>  
            <!--#######################################################################-->
            <li class="openable">
                <a href="#">
                    <span class="isw-list"></span><span class="text">分红管理</span>
                </a>
                <ul>
                    <li id="fenhonginput">
                        <a href="index.do?fenhonginput">
                            <span class="icon-th-large"></span><span class="text">手续费分红</span>
                        </a>                  
                    </li>                                           
                </ul> 
            </li>
            <!--#######################################################################-->   
            <li class="openable">
                <a href="#">
                    <span class="isw-list"></span><span class="text">币种管理</span>
                </a>
                <ul>
                    <li id="stocklist">
                        <a href="index.do?stocklist">
                            <span class="icon-th-large"></span><span class="text">币种管理</span>
                        </a>                  
                    </li> 
                </ul>                
            </li>   
            <li id="mailconfig">
                <a href="index.do?mailconfig">
                    <span class="isw-grid"></span><span class="text">邮件管理</span>
                </a>
            </li>  
            <li id="allorders">
                <a href="index.do?allorders">
                    <span class="isw-grid"></span><span class="text">委托管理</span>
                </a>
            </li>  
            
            <li id="caiwuguanli">
                <a href="index.do">
                    <span class="isw-grid"></span><span class="text">平台收支明细</span>
                </a>
            </li> 
        </ul>
        <!--###################/dashbordpanel##########################-->
        <div class="dr"><span></span></div>
        
        <div class="widget-fluid">
            
            <div class="wBlock">
                <div class="dSpace" style="width:90%">
                <%BigDecimal cny_amount2 = new BigDecimal(session.getAttribute("cny_amount").toString());
                      cny_amount2 = cny_amount2.setScale(2,BigDecimal.ROUND_HALF_UP);
                            %>
                    <h3>平台状态</h3>
                    <span class="number"><%=cny_amount2%></span>                    
                    <span><b>平台总金额：</b><%=cny_amount2%></span>
                    <span><b>手续费收入：</b><%=session.getAttribute("profit").toString() %> </span>
                    <span><b>注册用户：</b><%=session.getAttribute("user_amount").toString() %></span>
                </div>
                
            </div>
            <div class="dr"><span></span></div>
            <div class="widget-fluid">
	            <div id="menuDatepicker"></div>
	        </div>
            
        </div>
        
    </div>

    
    <script type="text/javascript">
    var menuname = '<%=request.getQueryString()%>';
    var smenu = new Array();
    smenu = menuname.split("&");
    function select_menu(){
       if(document.getElementById(smenu[0])!=null){
       		$("#" + smenu[0]).addClass("active");
       }else{
    	   return false;
       }
       if(document.getElementById(smenu[0]).parentNode.parentNode!=null){
    	   $("#" + smenu[0]).parent().parent().addClass('active');
       }else{
    	   return false;
       }
   }
    
    $(document).ready(function(){
    	select_menu();
    });
    </script>