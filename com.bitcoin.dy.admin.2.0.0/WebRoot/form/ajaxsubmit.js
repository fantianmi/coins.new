function createXmlHttp() {
	var xmlHttp = null;
	
	try {
		//Firefox, Opera 8.0+, Safari
		xmlHttp = new XMLHttpRequest();
	} catch (e) {
		//IE
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	
	return xmlHttp;
}

function submitForm(formId) {
	var xmlHttp = createXmlHttp();
	if(!xmlHttp) {
		alert("您的浏览器不支持AJAX！");
		return 0;
	}
	
	var e = document.getElementById(formId);
	var url = e.action;
	var inputs = e.elements;
	var postData = "";
	for(var i=0; i<inputs.length; i++) {
		switch(inputs[i].type) {
			case "text":
				postData += inputs[i].name + "=" + inputs[i].value + "&";
			break;
			case "password":
				postData += inputs[i].name + "=" + inputs[i].value + "&";
			break;
			case "hidden":
				postData += inputs[i].name + "=" + inputs[i].value + "&";
			break;
			default:
				continue;
		}
	}
	
	postData += "t=" + Math.random();
	
	xmlHttp.open("POST", url, true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 
	//xmlHttp.onreadystatechange = processmsg2; 
			xmlHttp.onreadystatechange = function() {
			if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
//				var msgfull = xmlHttp.responseText;
//				window.alert(msgfull);
				var msg = xmlHttp.responseXML.getElementsByTagName("msg")[0].firstChild.nodeValue;
				var href = xmlHttp.responseXML.getElementsByTagName("href")[0].firstChild.nodeValue;
				window.alert(msg);
				if(href!='nohref'){
					window.location.href=href;
				}

			}
		}
	xmlHttp.send(postData);
} 

function set_bprice(price,num,sum){
	
	$("#bufence").each(function(i){
		$(this).find("#buyingRate").val(price);
		$(this).find("#buyQuantity").val(num);
		$(this).find("#exchange").val(sum);
	});
}
function set_sprice(price,num,sum){
	
	$("#sellfence").each(function(i){
		$(this).find("#sellingRate").val(price);
		$(this).find("#sellQuantity").val(num);
		$(this).find("#sexchange").val(sum);
	});
}
