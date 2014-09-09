function dosearch(){
	var sel=document.getElementsByName("searchWay")[0];
	var searchway= sel.options[sel.options.selectedIndex].value;
	var scontent=document.getElementById("searchContent").value;
	if(scontent==null){alert("请输入查询内容");return false;}
	ajaxsearch(searchway,scontent);
}
var XMLHttpReq;
function createXMLHttpRequest() {
    if (window.XMLHttpRequest) { //Mozilla 浏览器
        XMLHttpReq = new XMLHttpRequest();
    } else if (window.ActiveXObject) { // IE浏览器
        try {
            XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
        } catch(e) {
            try {
                XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
            } catch(e) {}
        }
    }
}

function ajaxsearch(searchway,scontent) {
    createXMLHttpRequest();
    var url = 'search.do?searchway='+searchway+'&scontent='+scontent+'&n=' + Math.random();
    XMLHttpReq.open("GET", url, true);
    XMLHttpReq.onreadystatechange = processResponse; //指定响应函数
    XMLHttpReq.send(null); // 发送请求
}

// 处理返回信息函数
function processResponse() {
    if (XMLHttpReq.readyState == 4) { // 判断对象状态
        if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息
        	var resultString = XMLHttpReq.responseXML.getElementsByTagName("resultString")[0].firstChild.nodeValue;
        	document.getElementById("searchresult").innerHTML = resultString;
        }
    }
}
		  
