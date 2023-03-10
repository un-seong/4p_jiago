// 메세지 전송
	const findUserId = document.getElementById('findUserId')
	const sendmessage = document.forms[0]
	const checkmessage = document.forms[1]
	const numcheck = document.getElementById('check')
	const cpath = '/jiago'
	
	
	function sendmail(event) {
		event.preventDefault()
		const url = cpath + '/user/sendNumber'
		const userEmail = document.getElementById('userEmail')
		
		
		const opt1 = {
			method: 'POST',
			body: userEmail.value,
			headers: {
				'Content-Type': 'plain/text; charset=utf-8'
			}
		}
		fetch(url , opt1)
		.then(response => response.text())
		.then(text => {
			
			if(text != 0) {
				numcheck.classList.remove('hidden')
				findUserId.classList.add('hidden')
				alert('인증번호가 발송되었습니다. 메일을 확인해주세요')
				
				// 2분 타이머 설정
				let secondsLeft = 120;
				const timerDiv = document.getElementById('timer');
				let timer = setInterval(() => {
					secondsLeft--
					if (secondsLeft === 0) {
						clearInterval(timer)
						alert('시간이 초과되었습니다. 다시 시도해주세요.')
						numcheck.classList.add('hidden')
						findUserId.classList.remove('hidden')
						return
					} else {
						timerDiv.innerHTML = '남은 시간 : ' + secondsLeft +'초'
					}
				}, 1000)
				
				
			}
			else {
				alert('존재하지 않는 메일 주소 입니다.')
				return
			}
		})

	}
	
	
	
	// 메세지 인증
	
	function checknumber(event) {
		event.preventDefault()
		const ob = {
				email: document.getElementById('userEmail').value,
				checkNumber: document.getElementById('checkNumber').value
			}
		
		
		const url = cpath + '/user/sendCheckNumber'
		
			const opt2 = {
				method: 'POST',
				body: JSON.stringify(ob),
				headers: {
					'Content-Type': 'application/json; charset=utf-8'
				}
			}
		
			fetch(url, opt2)
			.then(response => response.json())
			.then(text => {
				const result = document.getElementById('result')
				if(text[0] != '없음') {
					alert('인증이 완료되었습니다')
					const result = document.getElementById('result')
					const imgLogo = document.querySelector('.imglogo')
					imgLogo.classList.remove('hidden')
					numcheck.classList.add('hidden')
					let count = 1;
					text.forEach(id => {
						const tmp = document.createElement('div')
						tmp.classList.add('idList')
						tmp.innerText = count + '. ' + id
						result.appendChild(tmp)
						count++;
					})
					const passwordFindLink = document.querySelector('#result > .otherlink')
					passwordFindLink.classList.remove('hidden')
				}
				else {
					alert('인증번호가 일치하지 않습니다. 다시 확인해주세요')
					return
				}
			})
		}