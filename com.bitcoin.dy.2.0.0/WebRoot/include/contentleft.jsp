<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="com.mvc.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>
<script type="text/javascript">
  $(document).ready(function() {
      $("#zuixindongtai").addClass('active');
  });
</script>  
<div id="sidebar_1" class="sidebar one_quarter">
    <aside>
      <!-- /nav -->
      <section id="new_look">
	<h1>
		<img src="resource_new/img/title-icon-group.png" alt="关注我们">
		关注我们			</h1>
	<ul class="list-unstyled">
		<li>

			<img src="resource_new/img/wechatfollow-zh.png">
			<br>
			<img src="resource_new/img/weixin.png">
		</li>
		<li>
			<img src="resource_new/img/weibo-logo-32x32.png">Weibo
			<p class="follow-btn">
				<a class="weibo-follow-zh link" href="#" target="_blank"><%=res.getString("host.small.title")%><i title="微博机构认证"></i></a>
			</p>
		</li>
		<li>
			<img src="resource_new/img/google-logo-32x32.png"><%=res.getString("host.small.title")%>团队邮件列表<p>
				<a class="link" href="#" target="_blank"><%=res.getString("host.mail")%></a>
			</p>
		</li>
		
		<li><img src="resource_new/img/QQ-logo-32x32.png"><%=res.getString("host.small.title")%>团队客服
		<p class="red"><%=res.getString("host.qiyejiaotan")%></p>
		<li><img src="resource_new/img/QQ-logo-32x32.png"><%=res.getString("host.small.title")%>团队 QQ群
		<p class="red"><%=res.getString("host.qq.group1")%></p>
		<p class="red"><%=res.getString("host.qq.group2")%></p>
		<p class="red"><%=res.getString("host.qq.group3")%></p>
		<p class="red"><%=res.getString("host.qq.group4")%></p>
		<p class="red"><%=res.getString("host.qq.group5")%></p>
		</ul>
	</section>
      <!-- /section -->
    </aside>
  </div>