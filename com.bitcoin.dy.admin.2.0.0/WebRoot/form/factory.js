function joinbuild() {
	if (window.XMLHttpRequest) {
		joinmsg = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		joinmsg = new ActiveXObject("Microsoft.XMLHTTP");
	}
	if (joinmsg != null) {
		var url = 'factory.do?joinbuild&n=' + Math.random();
		joinmsg.onreadystatechange = function() {
			if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
				var joinmsg = xmlHttp.responseXML.getElementsByTagName("msg")[0].firstChild.nodeValue;
				var href = xmlHttp.responseXML.getElementsByTagName("href")[0].firstChild.nodeValue;
				window.alert(joinmsg);
				if(href!='nohref'){
					window.location.href=href;
				}

			}
		}
		joinmsg.open("GET", url, true);
		joinmsg.send(null);
	}
}
