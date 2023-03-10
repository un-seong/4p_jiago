const form = document.querySelector('form')    	
	function formHandler() {
		const point = document.getElementById("point").value;
		 	alert(point +'포인트 기부 감사합니다')
	    }


window.onkeydown = function() {
	var kcode = event.keyCode;
	if(kcode == 116) event.returnValue = false;
}
