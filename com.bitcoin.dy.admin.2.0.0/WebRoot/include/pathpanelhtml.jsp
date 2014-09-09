<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.mvc.entity.*"%>
<%
	String url = request.getRequestURI();
	if (request.getQueryString() != null)
		url += "?" + request.getQueryString();
%>
<div class="breadLine">

	<ul class="breadcrumb">
		<li>
			<a href="#">比特币后台管理系统</a>
			<span class="divider">></span>
		</li>
		<%
			if (url.indexOf("order") != -1||url.indexOf("withdrawCNYorders") != -1) {
		%>
		<li class="active">
			订单管理
		</li>
		<%
			} else if (url.indexOf("userlist") != -1) {
		%>
		<li class="active">
			用户管理
		</li>
		<%
			}else if (url.indexOf("stocklist") != -1) {
		%>
		<li class="active">
			真实币种管理
		</li>
		<%
			}else if (url.indexOf("selfstock") != -1) {
		%>
		<li class="active">
			平台自有币种管理
		</li>
		<%
			} else if ((url.indexOf("index") != -1) && (url.indexOf("?") == -1)) {
		%>
		<li class="active">
			控制面板
		</li>
		<%
			}else if (url.indexOf("selfstock") != -1) {
		%>
		<li class="active">
			平台自有币种管理
		</li>
		<%
			} else if (url.indexOf("setting") != -1) {
		%>
		<li class="active">
			平台交易参数设置
		</li>
		<%
			}
		%>
	</ul>

	<ul class="buttons">
		<li>
			<a href="#" class="link_bcPopupList"><span class="icon-user"></span><span
				class="text">管理员列表</span>
			</a>

			<div id="bcPopupList" class="popup">
				<div class="head">
					<div class="arrow"></div>
					<span class="isw-users"></span>
					<span class="name">所有管理员</span>
					<div class="clear"></div>
				</div>
				<div class="body-fluid users">
					<%if(session.getAttribute("managerList")!=null){
						List<Btc_user> userList_path = (List<Btc_user>)session.getAttribute("managerList");
						for(int i=0;i<userList_path.size();i++){
							Btc_user user_path = userList_path.get(i);%>
							<div class="item">
								<div class="image">
									<a href="#"><img src="img/users/default.jpg" width="32" />
									</a>
								</div>
								<div class="info">
									<a href="#" class="name"><%=user_path.getUusername() %></a>
									<span><%=user_path.getUname() %></span>
								</div>
								<div class="clear"></div>
							</div>
							
						<%}
					}
						%>

				</div>
			</div>
		</li>
	</ul>

</div>

