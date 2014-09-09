<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
<%List<Btc_content> newslistall = (List<Btc_content>)session.getAttribute("newslistall");%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
<title><%=res.getString("host.title")%></title>
<jsp:include page="/include/htmlsrc.jsp" ></jsp:include>
</head>
  <body>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<!-- content -->
<div class="wrapper row3">
  <div id="container">
    <div class="three_quarter first">
    <section id="infomations"><section id="latest_news" class="col-xs-8">
    <%Btc_content content = (Btc_content)request.getAttribute("newsbyid"); %>
    <h1 class="titleh1">
	<img src="resource_new/img/title-icon-tel.png" alt="平台常见问题解答">平台常见问题解答
    </h1>
    <!-- faq area -->
          <div class="accordion-wrapper"><a href="javascript:void(0)" class="accordion-title orange"><span>平台如何进行充值？</span></a>
        <div class="accordion-content">
          <p>用户登录网站后，先要进行实名认证，通过后，再点击人民币充值或者点卡充值，点卡充值是由用户直接联系网站客服QQ进行转帐后，由平台为用户发放对应数值的点卡。</p>
        </div>
      </div>
      <div class="accordion-wrapper"><a href="javascript:void(0)" class="accordion-title orange"><span>实名认证之后用户信息是否能够保密？</span></a>
        <div class="accordion-content">
          <p>用户实名认证信息全部保存在服务器内，非本人通过多种认证方式不能获得，安全有保障。</p>
        </div>
      </div>
      <div class="accordion-wrapper"><a href="javascript:void(0)" class="accordion-title orange"><span><%=res.getString("host.small.title")%>回购的日期是什么时候？</span></a>
        <div class="accordion-content">
          <p><%=res.getString("host.small.title")%>开盘上市交易后一个月内，如果未能在二天内连续以一元的价格站稳，在月底即可启动回购，在兑换<%=res.getString("host.small.title")%>的网页上有回购的按键可点击，另如果用户已经出售了初次兑换的<%=res.getString("host.small.title")%>，再点击回购，<%=res.getString("host.small.title")%>有权利拒绝该用户的回购要求，用户所有的交易都在服务器内有详细的历史纪录，<%=res.getString("host.small.title")%>对此拥有绝对的解释权。</p>
        </div>
      </div>
      <div class="accordion-wrapper"><a href="javascript:void(0)" class="accordion-title orange"><span><%=res.getString("host.small.title")%>商城和游戏什么时候面世？</span></a>
        <div class="accordion-content">
          <p><%=res.getString("host.small.title")%>商城和<%=res.getString("host.small.title")%>游戏分批逐步面世，<%=res.getString("host.small.title")%>商城将在三个月内上市，<%=res.getString("host.small.title")%>游戏上市时间见公告。
9。<%=res.getString("host.small.title")%>商城买东西：<%=res.getString("host.small.title")%>商城是以模拟JD商城方式运营，详情到时可详阅<%=res.getString("host.small.title")%>商城。</p>
        </div>
      </div>
      <div class="accordion-wrapper"><a href="javascript:void(0)" class="accordion-title orange"><span>合作网站加入需要哪些条件？</span></a>
        <div class="accordion-content">
          <p>欢迎任何拥有与<%=res.getString("host.small.title")%>有相同理念的，有对虚拟币有美好未来的组织和个人与我们合作。</p>
        </div>
      </div>
      <div class="accordion-wrapper"><a href="javascript:void(0)" class="accordion-title orange"><span><%=res.getString("host.small.title")%>交易规则是什么?</span></a>
        <div class="accordion-content">
          <p>以类似股票的交易规则或方法进行买卖操作，没有涨跌停限制，没有交易时间限制（24小时交易均可交易）。</p>
        </div>
      </div>
      <div class="accordion-wrapper"><a href="javascript:void(0)" class="accordion-title orange"><span>人民币充值，提现需要多长时间？</span></a>
        <div class="accordion-content">
          <p>人民币充值是即时到帐的，人民币提现一般正常工作时间2个小时内到账，非工作时间24小时内到账。但由于我们也是用第三方支付平台，他们也需要审核的，所以有时在数据量大时可能会比较慢，请 大家耐心等待，如果24小时后还没到帐，再联系我们。</p>
        </div>
      </div>
      <div class="accordion-wrapper"><a href="javascript:void(0)" class="accordion-title orange"><span>实名认证注意事项</span></a>
        <div class="accordion-content">
          <p>1 实名验证，请务必提供真实有效的身份验证信息（验证后不能修改）</p>
<p>2 绑定真实银行卡信息（此绑定为日后提现用，仅可提现到该绑定的帐号上，名称和卡号都要对应，否则不能提现），验证后不可修改</p>
        </div>
      </div>
    <!-- faq area -->
	</section></section>
    </div>
    <jsp:include page="/include/contentleft.jsp"></jsp:include>
    <div class="clear"></div>
  </div>
</div>
<!-- ############################################################## -->

<jsp:include page="/include/foothtml.jsp"></jsp:include>
</div>
</body>
</html>
