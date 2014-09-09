<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
<%@ page import="com.mvc.entity.*"%>
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<body>
<!-- ****************后台管理系统******************** -->
	
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
            Btc_mail_config mailconfig = new Btc_mail_config();
            if(session.getAttribute("mailconfig")!=null){
            	mailconfig = (Btc_mail_config)session.getAttribute("mailconfig");
            	
            }
            	%>
    
           
            	
                <form action="config.do?updateMail" method="post">
                <div class="span12">
                    <div class="head">
                        <div class="isw-documents"></div>
                        <h1>平台邮箱配置</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">                                                     
                        
                        <div class="row-form">
                            <div class="span3">平台地址（关键配置）:</div>
                            <div class="span9"><input type="text" name="wangzhi" value="<%=mailconfig.getBtc_wangzhi() %>"/></div>
                            <div class="clear"></div>
                        </div>                                                               
                    </div>
                    <div class="block-fluid">                                                     
                        
                        <div class="row-form">
                            <div class="span3">邮箱smtp地址:</div>
                            <div class="span9"><input type="text"  name="mail_smtp_adr" value="<%=mailconfig.getBtc_mail_smtp_adr() %>"/></div>
                            <div class="clear"></div>
                        </div>                                                               
                    </div>
                    <div class="block-fluid">                                                     
                        
                        <div class="row-form">
                            <div class="span3">邮箱host:</div>
                            <div class="span9"><input type="text"  name="mail_hostName" value="<%=mailconfig.getBtc_mail_hostName()%>"/></div>
                            <div class="clear"></div>
                        </div>                                                               
                    </div>
                    <div class="block-fluid">                                                     
                        
                        <div class="row-form">
                            <div class="span3">pop地址:</div>
                            <div class="span9"><input type="text"  name="mail_pop_adr" value="<%=mailconfig.getBtc_mail_pop_adr() %>"/></div>
                            <div class="clear"></div>
                        </div>                                                               
                    </div>
                    <div class="block-fluid">                                                     
                        
                        <div class="row-form">
                            <div class="span3">imap地址:</div>
                            <div class="span9"><input type="text"  name="mail_imap_adr" value="<%=mailconfig.getBtc_mail_imap_adr() %>"/></div>
                            <div class="clear"></div>
                        </div>                                                               
                    </div>
                    <div class="block-fluid">                                                     
                        
                        <div class="row-form">
                            <div class="span3">邮箱地址:</div>
                            <div class="span9"><input type="text"  name="mail_adr" value="<%=mailconfig.getBtc_mail_adr() %>" /></div>
                            <div class="clear"></div>
                        </div>                                                               
                    </div>
                    <div class="block-fluid">                                                     
                        
                        <div class="row-form">
                            <div class="span3">登录用户名:</div>
                            <div class="span9"><input type="text" name="mail_username" value="<%=mailconfig.getBtc_mail_username() %>"/></div>
                            <div class="clear"></div>
                        </div>                                                               
                    </div>
                    <div class="block-fluid">                                                     
                        
                        <div class="row-form">
                            <div class="span3">登录密码:</div>
                            <div class="span9"><input type="text"  name="mail_password"  value="<%=mailconfig.getBtc_mail_password() %>"/></div>
                            <div class="clear"></div>
                        </div>                                                               
                    </div>
                    
                    <div class="block-fluid">                                                     
                        
                        <div class="row-form">
                            <input class="btn btn-inverse" type="submit" value="确认修改"/>
                        </div>                                                               
                    </div>
                </div>
                </form>
            </div>
            
            <div class="dr"><span></span></div>
        
        </div>
        
    </div>   
    
</body>
</html>
