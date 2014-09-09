<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.mvc.entity.*"%>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<!-- ****************后台管理系统******************** -->
<jsp:include page="/include/htmlsrc.jsp"></jsp:include> 
<body>
<script type="text/javascript">
            function deliverddc(){
                document.getElementById('myForm').action = "fenhong.do?deliverDDC";
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
                <form id="myForm" action="" method="post">
                <div class="span12">                    
                    <div class="head">
                        <div class="isw-grid"></div>
                        <h1>具有获得分红币条件的用户</h1>
                        <ul class="buttons">
                            <li>
                                <a href="#" class="isw-settings"></a>
                                <ul class="dd-list">
                                    <li><a onclick="deliverddc()" href="#"><span class="isw-edit"></span>发放分红币</a></li>
                                </ul>
                            </li>
                        </ul>                               
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid table-sorting">
                        <table cellpadding="0" cellspacing="0" width="100%" class="table" id="tSortable">
                            <thead>
                                <tr>
                                    <th><input type="checkbox" name="checkall"/></th>
                                    <th width="25%">
                                    <span style="float:left">ID</span>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <span>登陆</span>
                                    <span style="float:right; margin-right:10px">角色</span>
                                    </th>
                                    <th width="25%">
                                    <span style="float:left">交易额</span>
                                    <span style="float:right; margin-right:10px">获得分红币数量</span>                                   
                                    </th>
                                    <th width="25%">
                                    <span style="float:left">注册时间</span>
                                    <span style="float:right;margin-right:10px;">用户状态</span>
                                    </th>
                                    <th width="25%">
                                    <span style="float:left">身份证信息</span>
                                    <span style="float:right;margin-right:10px">真实姓名</span>
                                    </th>                                    
                                </tr>
                            </thead>
                            <tbody>
                            <%if(session.getAttribute("fhusermap")!=null){
                            	Map<Integer,Btc_fhDDC> btc_user_list = (Map<Integer,Btc_fhDDC>)session.getAttribute("fhusermap");
                            	Btc_fhDDC user = new Btc_fhDDC();
                            	Iterator it = btc_user_list.keySet().iterator();
                            	int i=0;
                            	while(it.hasNext()){
                            		int key = Integer.parseInt(it.next().toString());
                            		user = btc_user_list.get(key);
                            		if(!user.getUstatus().equals("已分红")){
                            		%>
                            		<tr>
	                                    <td><input type="checkbox" name="checkbox" value="<%=user.getUid() %>"/></td>
	                                    <td>
	                                    <span style="float:left"><%=user.getUid() %></span>
	                                    &nbsp;&nbsp;&nbsp;
	                                    <span><a href="usermanager.do?seeDetail&uid=<%=user.getUid() %>"><%=user.getUusername() %></a></span>
	                                    <%if(user.getUrole().equals("admin")){%>
	                                    <span style="float:right; margin-right:10px">管理员</span>
	                                    <%}else{%>
	                                    <span style="float:right; margin-right:10px">普通会员</span>
	                                    <%} %>
	                                    </td>
	                                    <td>
	                                    <span style="float:left">￥<%=user.getJiaoyie()%></span>
	                                    <span style="float:right"><%=user.getGetddc()%></span>     
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=user.getRegisttme() %></span>
	                                    <%if(user.getUstatus().equals("frozen")){%>
	                                    <span style="float:right;margin-right:10px;">冻结</span>
	                                    <%}else{%>
	                                    <span style="float:right;margin-right:10px;">正常</span>
	                                    <%} %>
	                                    </td>
	                                    <td>
	                                    <span style="float:left"><%=user.getUcertification() %></span>
	                                    <span style="float:right;margin-right:10px"><%=user.getUname() %></span>
	                                    </td>                                    
	                                </tr>
                            		<%
                            		}
                            		i++;
                            	}
                            }%>
                            </tbody>
                        </table>
                        <div class="clear"></div>
                        </form>
                    </div>
                </div>                                
                
            </div>            
            
            <div class="dr"><span></span></div> 

    <!-- ###################################################################### -->
     <div class="dialog" id="b_popup_3" style="display: none;" title="Modal">
       <p>Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In suscipit faucibus urna.</p>                
    </div>
    
</body>
</html>
