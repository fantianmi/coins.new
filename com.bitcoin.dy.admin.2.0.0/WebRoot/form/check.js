var last_length = 0;
function check(obj) {
	var reg = /^\d+\.*\d*$/i;
	if (!reg.test(obj.value)) {

		obj.value = obj.value.substring(0, last_length)
	} else {
		last_length = obj.value.length;
	}
}
function check2(obj) {
	var reg = /^\d+\.*\d*$/i;
	if (!reg.test(clipboardData.getData('text'))) {
		this.value = clipboardData.setData('text', clipboardData
				.getData('text').replace(/[^(\d|\.)]/g, ''))
	}
}