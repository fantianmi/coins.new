<? header("content-Type: text/html; charset=utf-8");?>
<?php
		$input_charset = $_POST['input_charset'];
		$interface_version = $_POST['interface_version'];
		$merchant_code = $_POST['merchant_code'];
		$notify_url = $_POST['notify_url'];
		$order_amount = $_POST['order_amount'];
		$order_no = $_POST['order_no'];
		$order_time = $_POST['order_time'];
		$sign_type = $_POST['sign_type'];
		$product_code = $_POST['product_code'];
		$product_desc = $_POST['product_desc'];
		$product_name = $_POST['product_name'];
		$product_num = $_POST['product_num'];
		$return_url = $_POST['return_url'];
		$service_type = $_POST['service_type'];
		$show_url = $_POST['show_url'];
		$extend_param = $_POST['extend_param'];
		$extra_return_param = $_POST['extra_return_param'];
		$bank_code = $_POST['bank_code'];
		$client_ip = $_POST['client_ip'];
		$sign = $_POST['sign'];	
?>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body onLoad="document.dinpayForm.submit();">
<form name="dinpayForm" method="post" action="https://pay.dinpay.com//gateway?input_charset=UTF-8">
	<input type="hidden" name="sign" value="<? echo $sign?>" />
	<input type="hidden" name="merchant_code" value="<? echo $merchant_code?>" />
	<input type="hidden" name="bank_code" value="<? echo $bank_code?>"/>
	<input type="hidden" name="order_no" value="<? echo $order_no?>"/>
	<input type="hidden" name="order_amount" value="<? echo $order_amount?>"/>
	<input type="hidden" name="service_type" value="<? echo $service_type?>"/>
	<input type="hidden" name="input_charset" value="<? echo $input_charset?>"/>
	<input type="hidden" name="notify_url" value="<? echo $notify_url?>">
	<input type="hidden" name="interface_version" value="<? echo $interface_version?>"/>
	<input type="hidden" name="sign_type" value="<? echo $sign_type?>"/>
	<input type="hidden" name="order_time" value="<? echo $order_time?>"/>
	<input type="hidden" name="product_name" value="<? echo $product_name?>"/>
	<input Type="hidden" Name="client_ip" value="<? echo $client_ip?>"/>
	<input Type="hidden" Name="extend_param" value="<? echo $extend_param?>"/>
	<input Type="hidden" Name="extra_return_param" value="<? echo $extra_return_param?>"/>
	<input Type="hidden" Name="product_code" value="<? echo $product_code?>"/>
	<input Type="hidden" Name="product_desc" value="<? echo $product_desc?>"/>
	<input Type="hidden" Name="product_num" value="<? echo $product_num?>"/>
	<input Type="hidden" Name="return_url" value="<? echo $return_url?>"/>
	<input Type="hidden" Name="show_url" value="<? echo $show_url?>"/>
	</form>
</body>
</html>