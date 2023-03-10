	// 모달 열기 버튼
	const modalBtn = document.getElementById("open-modal");

	// 모달 요소
	const modal = document.getElementById("customer-grade-modal");

	// 모달 열기 버튼 클릭 시 모달을 보이도록 설정
	modalBtn.onclick = function() {
		modal.style.display = "block";
		document.body.style.overflow = 'hidden';
	}

	// 모달 외부 클릭 시 모달을 숨김 처리
	window.onclick = function(event) {
		if (event.target == modal) {
			modal.style.display = "none";
			document.body.style.overflow = 'unset';
		}
	}