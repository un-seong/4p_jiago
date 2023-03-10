	const openButton = document.querySelector('button[type="button"]');

	const modal = document.querySelector(".modal");

	const closeButton = modal.querySelector('button[name="close"]');
	

	const modalBackground = modal.querySelector(".modal_background");

	function displayModal() {
		document.body.style.overflow = 'hidden';
		modal.classList.toggle("hidden");
	}

	function closeHandler() {
		modal.classList.toggle("hidden");
		document.body.style.overflow = 'unset';
	}
	
	
	const form = document.querySelector('form')

	function formHandler() {
		const point = document.getElementById("point").value;
		alert(point + '포인트 기부 감사합니다')
	}