
	const cpath = '/jiago'
	const url = cpath + '/user/sendJoinEmail/'+ email +'/'
	const emailForm = document.getElementById('emailForm')
	
	
	// 2분 타이머 설정
	let secondsLeft = 120;
	const timerDiv = document.getElementById('timer');
	let timer = setInterval(() => {
		secondsLeft--
		if (secondsLeft === 0) {
			clearInterval(timer)
			alert('시간이 초과되었습니다. 다시 시도해주세요.')
			window.close();
		} else {
			timerDiv.innerHTML = '남은 시간 : ' + secondsLeft +'초'
		}
	}, 1000)
	
	
	
	fetch(url)
	.then(response => response.text())
	.then(text => {
		if(text.includes('중복') == true || text.includes('문제') == true) {
			if(window.confirm(text + ' 창을 닫으시겠습니까?')) window.close();
		}
		else {
			alert(text)
			emailForm.classList.remove('hidden')
		}
	})
	
	const form = document.querySelector('.form')
	
	
	function formHandler(event) {
		event.preventDefault()
		const inputNum = document.getElementById('inputNum').value
		const url = cpath + '/user/equalCheckNumber/' + inputNum + '/'
		
		fetch(url)
		.then(response => response.text())
		.then(text => {
			
			if(text == '인증완료') {
				emailForm.classList.add('hidden')
				const parentPage = opener.document.getElementById("userEmail")
				parentPage.name = 'user_email'
				parentPage.value = email
				if(window.confirm('인증에 성공하였습니다. 창을 닫으시겠습니까?')) window.close();
			}
			else alert('인증에 실패했습니다. 다시 시도해 주세요.')
		})
		
	}