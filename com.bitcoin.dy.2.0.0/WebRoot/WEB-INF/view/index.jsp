<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mvc.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
<%ResourceBundle stockres = ResourceBundle.getBundle("stock"); %>  
<%FormatUtil format = new FormatUtil(); %>
<%List<Btc_content> newslist = (List<Btc_content>)session.getAttribute("newslist");%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
	<title><%=res.getString("host.title")%></title>
	<jsp:include page="/include/htmlsrc.jsp" ></jsp:include>
	<link href="coins_new/css/index.css" rel="stylesheet" type="text/css" />
	<!-- slider bar src -->
	<script type="text/javascript" src="script/ajax/dataload2.js"></script>
	<!-- autoload data -->
	<script type="text/javascript"> 
	$(document).ready(function() {
		loadIndex();
    });
	
	var XMLHttpReq;
    function createXMLHttpRequest() {
		  if(window.XMLHttpRequest) { //Mozilla 浏览器
		   XMLHttpReq = new XMLHttpRequest();
		  }else if (window.ActiveXObject) { // IE浏览器
		   try {
		    XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
		   } catch (e) {
			    try {
			     XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
			    } catch (e) {}
	  	 }
	  }
	 }
		
		
	 function loadIndex() {
		  createXMLHttpRequest();
		        var url = 'autoload.do?indexrefresh&n='+ Math.random();
	  XMLHttpReq.open("GET", url, true);
	  XMLHttpReq.onreadystatechange = processResponse;//指定响应函数
	  XMLHttpReq.send(null);  // 发送请求
	 }
	 // 处理返回信息函数
	    function processResponse() {
	     if (XMLHttpReq.readyState == 4) { // 判断对象状态
	         if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息
	      indexDataShow();
	    setTimeout("loadIndex()", 5000);
	            } 
	        }
	    }
			  
	</script>
	<!-- autoload data -->
	<script type="text/javascript">
	  $(document).ready(function() {
	      $("#shouye").addClass('active');
	  });
	</script>
	<!-- banner -->
	<script type="text/javascript">
$(function() {
	var sWidth = $("#focus").width(); //获取焦点图的宽度（显示面积）
	var len = $("#focus ul li").length; //获取焦点图个数
	var index = 0;
	var picTimer;
	
	//以下代码添加数字按钮和按钮后的半透明条，还有上一页、下一页两个按钮
	var btn = "<div class='btnBg'></div><div class='btn'>";
	for(var i=0; i < len; i++) {
		btn += "<span></span>";
	}
	btn += "</div><div class='preNext pre'></div><div class='preNext next'></div>";
	$("#focus").append(btn);
	$("#focus .btnBg").css("opacity",0.5);

	//为小按钮添加鼠标滑入事件，以显示相应的内容
	$("#focus .btn span").css("opacity",0.4).mouseenter(function() {
		index = $("#focus .btn span").index(this);
		showPics(index);
	}).eq(0).trigger("mouseenter");

	//上一页、下一页按钮透明度处理
	$("#focus .preNext").css("opacity",0.2).hover(function() {
		$(this).stop(true,false).animate({"opacity":"0.5"},300);
	},function() {
		$(this).stop(true,false).animate({"opacity":"0.2"},300);
	});

	//上一页按钮
	$("#focus .pre").click(function() {
		index -= 1;
		if(index == -1) {index = len - 1;}
		showPics(index);
	});

	//下一页按钮
	$("#focus .next").click(function() {
		index += 1;
		if(index == len) {index = 0;}
		showPics(index);
	});

	//本例为左右滚动，即所有li元素都是在同一排向左浮动，所以这里需要计算出外围ul元素的宽度
	$("#focus ul").css("width",sWidth * (len));
	
	//鼠标滑上焦点图时停止自动播放，滑出时开始自动播放
	$("#focus").hover(function() {
		clearInterval(picTimer);
	},function() {
		picTimer = setInterval(function() {
			showPics(index);
			index++;
			if(index == len) {index = 0;}
		},4000); //此4000代表自动播放的间隔，单位：毫秒
	}).trigger("mouseleave");
	
	//显示图片函数，根据接收的index值显示相应的内容
	function showPics(index) { //普通切换
		var nowLeft = -index*sWidth; //根据index值计算ul元素的left值
		$("#focus ul").stop(true,false).animate({"left":nowLeft},300); //通过animate()调整ul元素滚动到计算出的position
		//$("#focus .btn span").removeClass("on").eq(index).addClass("on"); //为当前的按钮切换到选中的效果
		$("#focus .btn span").stop(true,false).animate({"opacity":"0.4"},300).eq(index).stop(true,false).animate({"opacity":"1"},300); //为当前的按钮切换到选中的效果
	}
});

</script>
</head>

<body>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<!-- content -->
<div id="focus">
  <ul>
    <li><a href="#" target="_blank"><img src="coins_new/img/banner.jpg" /></a></li>
    <li><a href="#" target="_blank"><img src="coins_new/img/banner1.jpg" /></a></li>
    <li><a href="#" target="_blank"><img src="coins_new/img/banner2.jpg" /></a></li>
    <li><a href="#" target="_blank"><img src="coins_new/img/banner3.jpg" /></a></li>
  </ul>
</div>
<div class="box">
  <dl>
    <dt>安全保障</dt>
    <dd>GOOGLE双重认证，银行系统级SSL安全连接，短信验证，离线BTC钱包，分布式存储，冷存储。专业团队运作，第三方银行资金监管，确保资金安全。</dd>
  </dl>
  <dl style="float:right;">
    <dt>高效便捷</dt>
    <dd>充值即时到账：网银全天24小时即充即到；提现超快速：网银2小时内；虚拟货币提现无须人工审核，何时提现何时有。</dd>
  </dl>
  <dl>
    <dt>永久免费</dt>
    <dd>平台承诺永久性免收充值手续费。</dd>
  </dl>
  <dl style="float:right;">
    <dt>极速买卖</dt>
    <dd>独创极速买卖机制，您只需点两下鼠标即可完成买卖。</dd>
  </dl>
  <dl>
    <dt>推广共赢</dt>
    <dd>推荐好友注册可终身享有平台利润分成，自动周结快速到账，比例根据会员等级20%-30%不等，永久有效。</dd>
  </dl>
  <dl style="float:right;">
    <dt>多币种交易</dt>
    <dd>支持比特币、莱特币、各种山寨货币、各种虚拟货币的在线交易，没有做不到，只有想不到。</dd>
  </dl>
</div>
<jsp:include page="/include/foothtml.jsp"></jsp:include>
</body>
</html>
