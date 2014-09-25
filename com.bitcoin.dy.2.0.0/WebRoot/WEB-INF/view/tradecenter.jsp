<%@page import="com.mvc.config.CoinConfig"%>
<%@page import="com.mvc.util.FormatUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>
<%
FormatUtil format = new FormatUtil();
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%Map<String,Btc_content> indexmap = (Map<String,Btc_content>)session.getAttribute("indexmap"); 
List<Btc_content> newslist = (List<Btc_content>)session.getAttribute("newslist");%>       	   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
<title><%=res.getString("host.title")%></title>
<jsp:include page="/include/htmlsrc.jsp" ></jsp:include>
<script type="text/javascript">
  $(document).ready(function() {
      $("#tradecenter").addClass('active');
  });
</script>
<!-- ######################################################## -->
<script type="text/javascript" src="script/ajax/dataload.js"></script>
<%int globalstockid = Integer.parseInt(request.getAttribute("btc_stock_id").toString());
 Btc_stock globalstock = (Btc_stock)request.getAttribute("globalbtc_stock");%>
 
<script type="text/javascript"> 
var XMLHttpReq;
var exstock='<%=request.getAttribute("exstock").toString()%>';
function createXMLHttpRequest() {
if(window.XMLHttpRequest) { XMLHttpReq = new XMLHttpRequest();}
else if (window.ActiveXObject) {
	   try {XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
	   } catch (e) {
	   try {
	     XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
	    } catch (e) {}
	   }
	  }
	 }
	
	//发送请求函数
	
	 function sendRequest() {
	  createXMLHttpRequest();
	        var url = 'autoload.do?refreshstock&stockId=<%=globalstockid%>&exstock='+exstock+'&n='+ Math.random();
  XMLHttpReq.open("GET", url, true);
  XMLHttpReq.onreadystatechange = processResponse;//指定响应函数
  XMLHttpReq.send(null);  // 发送请求
 }
 // 处理返回信息函数
    function processResponse() {
     if (XMLHttpReq.readyState == 4) { // 判断对象状态
         if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息
    DisplayHot();
    setTimeout("sendRequest()", 5000);
            } 
        }
    }
		  
</script>
<!-- ####################################################### -->
<script type="text/javascript" src="formcheck/datatype.js"></script>
<!-- ######################################################## -->
<script type="text/javascript" src="scripts/jquery-1.4.1.min.js"></script>
<script type="text/javascript" src="scripts/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="scripts/jquery.timers.1.2.js"></script>
<script type="text/javascript" src="scripts/jquery.galleryview.2.1.1.min.js"></script>
<script type="text/javascript" src="scripts/jquery.galleryview.setup.js"></script>
<script type="text/javascript">
function saveReport() {  
    // jquery 表单提交  
    $("#showDataForm").ajaxSubmit(function(message) {  
          // 对于表单提交成功后处理，message为提交页面saveReport.do的返回内容  
       });  
      
    return false; // 必须返回false，否则表单会自己再做一次提交操作，并且页面跳转  
}  
</script>
<!-- coins_new -->
<link href="coins_new/css/zy.css" rel="stylesheet" type="text/css" />
</head>
  <body>
  <%
String showStockName = request.getAttribute("btc_stock_name").toString(); 
Btc_profit profit = (Btc_profit)request.getAttribute("profit");
BigDecimal tradesxf = globalstock.getTradesxf();
BigDecimal sxf = new BigDecimal(0);
if(request.getAttribute("extradesxf")==null){ sxf=profit.getBtc_profit_trade_poundage();}
else{sxf=new BigDecimal(request.getAttribute("extradesxf").toString());}%>
<script type="text/javascript">
    var stksxf = <%=tradesxf%>;
    var exstksxf = <%=sxf%>;
    function caculateEx_BQ_Pound(x){
    	var buyleft=document.getElementById("buyduihuane").innerHTML;
    	fomatFloatcheck(x,2,0);
    	check(document.getElementById(x));
        document.getElementById("exchange").value = ((document.getElementById("buyQuantity").value) * (document.getElementById(x).value)).toFixed(2);
        document.getElementById("poundage").innerHTML = (document.getElementById("buyQuantity").value * stksxf).toFixed(2);
        document.getElementById("canbuyamount").innerHTML=(buyleft/document.getElementById(x).value).toFixed(2);
    }
    
    function caculateEx(x){
    	var buyleft=document.getElementById("buyduihuane").innerHTML;
    	fomatFloatcheck(x,2,0);
    	check(document.getElementById(x));
        document.getElementById("exchange").value = ((document.getElementById("buyingRate").value) * (document.getElementById(x).value)).toFixed(2);
        document.getElementById("poundage").innerHTML = (document.getElementById("buyQuantity").value * stksxf).toFixed(2);
        document.getElementById("canbuyamount").innerHTML=(buyleft/document.getElementById("buyingRate").value).toFixed(2);
    }
    function caculateBQ(x){
    	var buyleft=document.getElementById("buyduihuane").innerHTML;
    	fomatFloatcheck(x,2,0);
    	check(document.getElementById(x));
        document.getElementById("buyQuantity").value = (document.getElementById("exchange").value / document.getElementById("buyingRate").value).toFixed(2);
        document.getElementById("poundage").innerHTML = (document.getElementById("buyQuantity").value * stksxf).toFixed(2);
        document.getElementById("canbuyamount").innerHTML=(buyleft/document.getElementById("buyingRate").value).toFixed(2);
    }
    
    function scaculateEx_BQ_Pound(x){
    	var sellleft=document.getElementById("sellyue").innerHTML;
    	fomatFloatcheck(x,2,0);
    	check(document.getElementById(x));
    	document.getElementById("sexchange").value = ((document.getElementById("sellQuantity").value) * (document.getElementById(x).value)).toFixed(2);
        document.getElementById("spoundage").innerHTML = (document.getElementById("sexchange").value * exstksxf).toFixed(2);
        document.getElementById("cansellamount").innerHTML=(sellleft/1).toFixed(2);
    }
    
    function scaculateEx(x){
    	var sellleft=document.getElementById("sellyue").innerHTML;
        fomatFloatcheck(x,2,0);
    	check(document.getElementById(x));
        document.getElementById("sexchange").value = ((document.getElementById("sellingRate").value) * (document.getElementById(x).value)).toFixed(2);
        document.getElementById("spoundage").innerHTML = (document.getElementById("sexchange").value * exstksxf).toFixed(2);
        document.getElementById("cansellamount").innerHTML=(sellleft/1).toFixed(2);
    }
    function scaculateBQ(x){
    	var sellleft=document.getElementById("sellyue").innerHTML;
    	fomatFloatcheck(x,2,0);
    	check(document.getElementById(x));
        document.getElementById("sellQuantity").value = (document.getElementById("sexchange").value / document.getElementById("sellingRate").value).toFixed(2);
        document.getElementById("spoundage").innerHTML = (document.getElementById("sexchange").value * exstksxf).toFixed(2);
        document.getElementById("cansellamount").innerHTML=(sellleft/1).toFixed(2);
    }

</script>
<!-- ################################################################################### -->
		<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
		<script src="script/Hightcharts/highstock.js" charset="utf-8"></script>
		<script src="script/Hightcharts/exporting.js"></script>
		<script src="script/Hightcharts/stockcommon.js"></script>
		<script language=javascript>
		var stockid=<%=globalstock.getBtc_stock_id() %>;
		var exstock='<%=request.getAttribute("exstock").toString()%>';
		function ConfirmDelbid(price)
		{
		   if(confirm("确认撤销该买单？"))
		   {
		        location.href='createOrder.do?cancelorder&price='+price+'&stockid='+stockid+'&exstock='+exstock+'&type=bid';
		   }
		}
		function ConfirmDelsell(price)
		{
		   if(confirm("确认撤销该卖单？"))
		   {
		        location.href='createOrder.do?cancelorder&price='+price+'&stockid='+stockid+'&exstock='+exstock+'&type=sell';
		   }
		}
		
		function Confirmbuy()
		{
		   if(confirm("确兑换买？"))
		   {
		        var latestpricet = document.getElementById("latestprice").innerHTML;
		   		var buyingRate = document.getElementById('buyingRate').value;
		   		var absSub=latestpricet-buyingRate;
		   		absSub=Math.abs(absSub);
		   		if(absSub>10){
		   			alert("平台涨幅控制在10元之内，请重新下单");
		   			return false;
		   		}
		        var buyQuantity = document.getElementById('buyQuantity').value;
				var buyduihuane=document.getElementById('buyduihuane').innerHTML;
		        var exchange = document.getElementById('exchange').value;
		        if(buyingRate<=0||buyQuantity<=0||exchange<=0){
		        	alert('请将表单填写完整');
		        	return false;
		        }
		        
		   		
		        if(buyduihuane-exchange<0){
			       	   alert('您的余额不足，请重新输入');
			       	   return false;
			       } 
		   
		        <%if(request.getAttribute("exstock").equals(CoinConfig.getMainCoinName())){%>
		       document.getElementById('bufence').action = "form.do?trade";
		   		<%}else{%>
		       document.getElementById('bufence').action = "form.do?stocktrade";
		   		<%}%>
		   	   submitForm('bufence', 'tip');
		   }
		}
		function Confirmsell()
		{
		   if(confirm("确认卖出？"))
		   {
			   	var latestpricet = document.getElementById("latestprice").innerHTML;
		   		var sellingRate = document.getElementById('sellingRate').value;
		   		var absSub=latestpricet-sellingRate;
		   		absSub=Math.abs(absSub);
		   		if(absSub>10){
		   			alert("平台涨幅控制在10元之内，请重新下单");
		   			return false;
		   		}
		        var sellQuantity = document.getElementById('sellQuantity').value;
		        var sexchange = document.getElementById('sexchange').value;
		        if(sellingRate<=0||sellQuantity<=0||sexchange<=0){
		        	alert('买卖单价格数量或兑换额不能为0');
		        	return false;
		        }
		        
		   		var stockyue=document.getElementById('sellyue').innerHTML;
		        var inputsell = document.getElementById('sellQuantity').value;
		        if(inputsell-stockyue>0){
			       	   alert('您的余额不足，请重新输入');
			       	   return false;
			       } 
			       
			   <%if(request.getAttribute("exstock").equals(CoinConfig.getMainCoinName())){%>
		        document.getElementById('sellfence').action = "form.do?trade";
		   		<%}else{%>
		        document.getElementById('sellfence').action = "form.do?stocktrade";
		   		<%}%>
		   		submitForm('sellfence', 'tip');
			}
		}
		</script>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<script>
//将form转为AJAX提交
function ajaxSubmit(frm, fn) {
    var dataPara = getFormJson(frm);
    $.ajax({
        url: frm.action,
        type: frm.method,
        data: dataPara,
        success: fn
    });
}

//将form中的值转换为键值对。
function getFormJson(frm) {
    var o = {};
    var a = $(frm).serializeArray();
    $.each(a, function () {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });

    return o;
}
$(document).ready(function(){
    $('#Form1').bind('submit', function(){
        ajaxSubmit(this, function(data){
            alert(data);
        });
        return false;
    });
});
</script>
<script src="script/Hightcharts/stockcommon.js"></script>
<script type="text/javascript">
	var ajaxObj6 = null;
	var ajaxObj7 = null;
	var ajaxObj8 = null;
	$(document).ready(function() {
		getTimeLine();
	});

	function getDayLine() {
		$("#highstock_tab a").removeAttr("id");
		$("#highstock_tab a:eq(2)").attr("id","cur");
		if (window.XMLHttpRequest) {
			ajaxObj7 = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			ajaxObj7 = new ActiveXObject("Microsoft.XMLHTTP");
		}

		if (ajaxObj7 != null) {
			var url = 'ajax.do?hicharts&stockId=<%=globalstock.getBtc_stock_id()%>&exstock=<%=CoinConfig.getMainCoinName()%>&type=day&n='+ Math.random();
			ajaxObj7.onreadystatechange = displayDayLine;
			ajaxObj7.open("GET", url, true);
			ajaxObj7.send(null);
		}
	}

	function getTimeLine() {
		$("#highstock_tab a").removeAttr("id");
		$("#highstock_tab a:eq(1)").attr("id","cur");
		if (window.XMLHttpRequest) {
			ajaxObj6 = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			ajaxObj6 = new ActiveXObject("Microsoft.XMLHTTP");
		}

		if (ajaxObj6 != null) {
			var url = 'ajax.do?hicharts&stockId=<%=globalstock.getBtc_stock_id()%>&exstock=<%=CoinConfig.getMainCoinName()%>&type=hours&n='+Math.random();
			ajaxObj6.onreadystatechange = displayTimeLine;
			ajaxObj6.open("GET", url, true);
			ajaxObj6.send(null);
		}
	}

	function get5minLine() {
		$("#highstock_tab a").removeAttr("id");
		$("#highstock_tab a:eq(0)").attr("id","cur");
		if (window.XMLHttpRequest) {
			ajaxObj8 = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			ajaxObj8 = new ActiveXObject("Microsoft.XMLHTTP");
		}

		if (ajaxObj8 != null) {
			var url = 'ajax.do?hicharts&stockId=<%=globalstock.getBtc_stock_id()%>&exstock=<%=CoinConfig.getMainCoinName()%>&type=min&n='+Math.random();
			ajaxObj8.onreadystatechange = display5minLine;
			ajaxObj8.open("GET", url, true);
			ajaxObj8.send(null);
		}
	}
</script>
<jsp:include page="/include/nav.jsp"></jsp:include>
<!-- content -->
<div class="box2">
  <div class="b2_l">
    <div class="b2_l_t">
      <div class="b2_l_t_l"><img src="<%=globalstock.getLogoadr() %>" width="30" height="30" style="float:left;" /> <b style="margin-left:10px;"><%=globalstock.getBtc_stock_name() %><%=globalstock.getBtc_stock_Eng_name()%>对<%=request.getAttribute("exstock").toString()%>交易市场</b></div>
      <div class="b2_l_t_r" id="highstock_tab"><a href="JavaScript:get5minLine();">分钟</a><a href="JavaScript:getTimeLine();">小时</a><a href="JavaScript:getDayLine();">日</a></div>
    </div>
    <div class="b2_l_b" id="k-line" style="height: 306px; width:833px;border:1px solid #cccccc"></div>
  </div>
  <div class="b2_r">
    <ul>
      <li>当前<%=globalstock.getBtc_stock_name() %>成交价格<br />
        <b style="font-size:18px; color:#ff7e00;"  id="latestprice"><!-- ajax data --></b><%=request.getAttribute("exstock").toString()%></li>
      <li>24小时成交总额<br />
        <b style="font-size:18px; color:#004993;" id="amount_today"><!-- ajax data --></b><%=request.getAttribute("exstock").toString()%></li>
      <li>今日最高价：<b style="font-size:18px; color:#d80000;" id="top_todayRate"><!-- ajax data --></b> <%=request.getAttribute("exstock").toString()%></li>
      <li>今日最低价：<b style="font-size:18px; color:#d80000;" id="low_todayRate"><!-- ajax data --></b> <%=request.getAttribute("exstock").toString()%></li>
      <li>涨跌幅：<b style="font-size:18px; color:#0ab955;" id="zhangdiefu"><!-- ajax data -->%</b></li>
      <li>平台持有量：<br />
        <b style="font-size:18px; color:#004993;" id="amount"><!-- ajax data --></b> <%=globalstock.getBtc_stock_Eng_name()%> </li>
    </ul>
  </div>
</div>
<div class="box3">
  <div class="b3_l">
    <div class="b3_l1">
      <div class="b3_l1_l" style="float:left;">
        <div class="b3_l1_l_t">您挂载的卖单</div>
        <div class="b3_l1_l_m"><span>卖出单价</span><span>卖出数量</span><span>卖出总价</span><span>操作</span></div>
        <div class="b3_l1_l_b">
          <ul id="usersellorder">
          <!-- ajax data -->
          </ul>
        </div>
      </div>
      <div class="b3_l1_l" style="float:right;">
        <div class="b3_l1_l_t">您挂载的买单</div>
        <div class="b3_l1_l_m"><span>卖出单价</span><span>卖出数量</span><span>卖出总价</span><span>操作</span></div>
        <div class="b3_l1_l_b">
          <ul id="userbuyorder">
          <!-- ajax data -->
          </ul>
        </div>
      </div>
    </div>
    <div class="b3_l1">
      <div class="b3_l1_l" style="float:left;">
        <div class="b3_l1_l_t">卖出<%=globalstock.getBtc_stock_name()%><%=globalstock.getBtc_stock_Eng_name() %></div>
         <!-- tradefence -->
            <%
            BigDecimal bestOffer = null;
						if(request.getAttribute("buyingOders")!=null){
								ArrayList<Btc_order> toGetBestBid = (ArrayList<Btc_order>)request.getAttribute("buyingOders");
								bestOffer = toGetBestBid.get(0).getBtc_order_price();
						}else{
								Btc_stock btc_stock=(Btc_stock)request.getAttribute("btc_stock");
								bestOffer = btc_stock.getBtc_stock_price();
								bestOffer.setScale(2,BigDecimal.ROUND_HALF_UP);
						}%>
        <div class="b4_l1_l_b">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100%" height="40">您当前的<%=globalstock.getBtc_stock_name()%><%=globalstock.getBtc_stock_Eng_name() %>余额为： <b style="color:#d80000; font-size:16px;"  id="sellyue"><!-- ajax data --></b> 个 <b>[<a href="coinProcess.do?generalAdr&stockid=<%=globalstock.getBtc_stock_id() %>" style="color:#014a93;">充值</a>]</b></td>
            </tr>
            <form id="sellfence" action="" >
            <input type="hidden" name="exstock" value="<%=request.getAttribute("exstock").toString() %>"/>
		  			<input type="hidden" name="stock_id" value="<%=request.getAttribute("btc_stock_id").toString() %>">
		  			<input type="hidden" name="order_type" value="sell">
		  			
            <tr>
              <td height="40">最佳卖价：<span  id="sellfenceshowbestsell"><!-- ajax data --></span></td>
            </tr>
            <tr>
              <td height="40">可卖出量：<span id="cansellamount"><!-- ajax data --></span></td>
            </tr>
            <tr>
              <td height="40">卖出单价：
              	<input name="order_price" id="sellingRate" onpaste="check2(this)" value="<%=format.trans(bestOffer) %>" onkeyup="scaculateEx_BQ_Pound(this.id);" size="10" type="text" style="width:150px; text-indent:5px; height:18px; border:1px solid #abadb3; line-height:18px; background:#fff; font-size:14px; color:#333;" ></td>
            </tr>
            <tr>
              <td height="40">卖出数量：
              	<input name="order_amount" id="sellQuantity" onpaste="check2(this)" value="0" onkeyup="scaculateEx(this.id);" size="10" type="text" style="width:150px; text-indent:5px; height:18px; border:1px solid #abadb3; line-height:18px; background:#fff; font-size:14px; color:#333;"></td>
            </tr>
            <tr>
              <td height="40">总兑换额：
                <input name="exchange" id="sexchange" onpaste="check2(this)" value="0" onkeyup="scaculateBQ(this.id);" type="text"  style="width:150px; text-indent:5px; height:18px; border:1px solid #abadb3; line-height:18px; background:#fff; font-size:14px; color:#333;"></td>
            </tr>
            </form>
            <tr>
              <td height="40"><span style="display:block; height:30px; line-height:30px; float:left;">手续费：<span id="spoundage">0<!-- ajax data --></span> (<%=request.getAttribute("exstock").toString()%>) 免手续费</span> <button href="#" id="tradeBtn" onclick="Confirmsell()" href="#">立即出售</button></td>
            </tr>
          </table>
        </div>
      </div>
      <div class="b3_l1_l" style="float:right;">
        <div class="b3_l1_l_t">买入<%=globalstock.getBtc_stock_name()%><%=globalstock.getBtc_stock_Eng_name() %></div>
        <%
				BigDecimal bestBid = new BigDecimal(0);
				if(request.getAttribute("sellOders")!=null){
					ArrayList<Btc_order> toGetBestOffer = (ArrayList<Btc_order>)request.getAttribute("sellOders");
					bestBid = toGetBestOffer.get(0).getBtc_order_price();
				}else{
					Btc_stock btc_stock=(Btc_stock)request.getAttribute("btc_stock");
					bestBid = btc_stock.getBtc_stock_price();
				} %>
        <div class="b4_l1_l_b">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100%" height="40">您当前的<%=request.getAttribute("exstock").toString()%>余额为： <b style="color:#d80000; font-size:16px;" id="buyduihuane"><!-- ajax data --></b> 个 <b>[<a href="coinProcess.do?generalAdr&stockid=<%=CoinConfig.getMainCoin()%>" style="color:#014a93;">充值</a>]</b></td>
            </tr>
            <tr>
              <td height="40">最佳买价：<span id="buyfenceshowbestbid"><!-- ajax data --></span></td>
            </tr>
            <tr>
              <td height="40">可兑换额：<span id="canbuyamount"><!-- ajax data --></span></td>
            </tr>
            <form id="bufence" style="height:28px">
            <input type="hidden" name="exstock" value="<%=request.getAttribute("exstock").toString() %>"/>
			      <input type="hidden" name="stock_id" value="<%=request.getAttribute("btc_stock_id").toString() %>">
			      <input type="hidden" name="order_type" value="bid">
            <tr>
              <td height="40">买入单价：
              <input name="order_price" id="buyingRate" onpaste="check2(this)" value="<%=format.trans(bestBid) %>" onkeyup="caculateEx_BQ_Pound(this.id);" size="10" type="text" style="width:150px; text-indent:5px; height:18px; border:1px solid #abadb3; line-height:18px; background:#fff; font-size:14px; color:#333;"></td>
            </tr>
            <tr>
              <td height="40">买入数量：
              <input name="order_amount" id="buyQuantity" onpaste="check2(this)" value="0" onkeyup="caculateEx(this.id);" size="10" type="text"  style="width:150px; text-indent:5px; height:18px; border:1px solid #abadb3; line-height:18px; background:#fff; font-size:14px; color:#333;"></td>
            </tr>
            <tr>
              <td height="40">总兑换额：
                <input name="exchange" id="exchange" onpaste="check2(this)" value="0" onkeyup="caculateBQ(this.id);" size="10" type="text"  style="width:150px; text-indent:5px; height:18px; border:1px solid #abadb3; line-height:18px; background:#fff; font-size:14px; color:#333;"></td>
            </tr>
            </form>
            <tr>
              <td height="40"><span style="display:block; height:30px; line-height:30px; float:left;" >手续费：<span id="poundage"><!-- ajax data --></span> (<%=request.getAttribute("exstock").toString()%>) 免手续费</span> <button href="#" id="tradeBtn"  onclick="Confirmbuy();">立即买入</button></td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    <div class="b3_l1">
      <div class="b3_l1_l" style="float:left;">
        <div class="b3_l1_l_t">当前卖单</div>
        <div class="b5_l1_l_m"><span>卖出单价</span><span>卖出数量</span><span>卖出总价</span></div>
        <div class="b5_l1_l_b">
          <ul id="globalsellorder">
            <!-- ajax data -->
          </ul>
        </div>
      </div>
      <div class="b3_l1_l" style="float:right;">
        <div class="b3_l1_l_t">当前买单</div>
        <div class="b5_l1_l_m"><span>买入单价</span><span>买入数量</span><span>买入总额<%=request.getAttribute("exstock").toString()%></span></div>
        <div class="b5_l1_l_b">
          <ul  id="globalbidorder">
          <!-- ajax data -->
           </ul>
        </div>
      </div>
    </div>
    <div class="b6_t">最近市场成交数据</div>
    <div class="b6_m"><span>成交时间</span><span>成交类型</span><span>成交单价</span><span>成交数量</span><span>成交总额<%=request.getAttribute("exstock").toString()%></span></div>
    <div class="b6_b">
      <ul id="dealorderlist">
			<!-- ajax data -->
      </ul>
    </div>
  </div>
  <div class="b3_r">
    <div class="b3_r1_t">关于莱特币LTC介绍</div>
    <div class="b3_r1_b">总量 8400万 </div>
    <div class="b3_r2"><img src="coins_new/img/yl.jpg" width="170" /></div>
    <div class="b3_r1_t">官方QQ群</div>
    <div class="b3_r3_b">
      <ul>
        <li><a href="#">49529494 </a></li>
        <li><a href="#">279912152</a></li>
      </ul>
    </div>
    <div class="b3_r4"><b>风险提示</b><br>
      本站仅提供一个供网友交易的平台，比特币等山寨币交易有极高的风险，当前任何虚拟币极容易受到庄家的控制。入市须谨慎，一定注意控制好风险！</div>
  </div>
</div>
<jsp:include page="/include/foothtml.jsp"></jsp:include>
</body>
</html>
