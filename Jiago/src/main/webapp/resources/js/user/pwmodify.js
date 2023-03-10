const cpath = '/jiago'
const pwCheck = document.getElementById('pwCheck')						// 변경시 비밀번호 검사
		const changePw = document.getElementById('changePw')					// div를 숨기기 위한 전체 div
		const modifyPw = document.getElementById('modifyPw')					// 새로운 비밀번호 입력
		const changeCheckPw = document.getElementById('changeCheckPw') 			// 비밀번호 확인
		const checkPwText1 = document.querySelector('.checkPwText1')			// 비밀번호 조건 메세지
		const checkPwText2 = document.querySelector('.checkPwText2')			// 비밀번호 확인 메세지
		const modifyStart = document.getElementById('modifyStart')
		
		
		
		document.forms[0].onsubmit = function(event) {
			event.preventDefault()
			
			const inputPw = document.querySelector('input[name="input_pw"]').value
			
			const item1 = {
				idx: user_idx,
				inputPw: inputPw
			}
			
			const url = cpath +'/popUp/pwCheck'
			const tmp = {
					method: 'POST',
					body: JSON.stringify(item1),
					headers: {
						'Content-Type': 'application/json; charset=utf-8'
					}	
				}
			
			fetch(url,tmp)
			.then(response => response.text())
			.then(text => {
				if(text == 1) {
					pwCheck.classList.add('hidden')
					changePw.classList.remove('hidden')
				}
				else alert('비밀번호가 틀렸습니다.')
			})
		}
	
	
	
	
	function modifyPwHandler(event) {
		changeCheckPw.value = ''
		checkPwText2.innerText = ''
		const joinPwValue = event.target.value
		if(joinPwValue.length == 0) {
			checkPwText1.innerText = ''
			changeCheckPw.setAttribute('disabled',true)
			return
		}
		const pw_if = /(?=.*[0-9])(?=.*[a-z])(?=.*\W)(?=\S+$).{8,20}/
		if(pw_if.test(joinPwValue)) {
			checkPwText1.innerText = '사용가능한 비밀번호입니다'
			checkPwText1.style.color = 'blue'
			changeCheckPw.removeAttribute('disabled')		// 사용가능한 비밀번호가 아니면 비밀번호 확인 비활성화
		}
		else {
			checkPwText1.innerText = '조건에 부합되지 않은 비밀번호입니다.'
			checkPwText1.style.color = 'red'
			changeCheckPw.setAttribute('disabled',true)
		}
	}
	
	
	function checkPwHandler(event) {
		const checkPwValue = event.target.value
		if(checkPwValue == modifyPw.value) {
			modifyPw.setAttribute('name','user_pw')
			checkPwText2.innerText = '비밀번호가 서로 일치합니다'
			checkPwText2.style.color = 'blue'
			
		}
		else {
			modifyPw.removeAttribute('name')
			checkPwText2.innerText = '비밀번호가 서로 일치하지 않습니다'
			checkPwText2.style.color = 'red'
		}
	}
	
	
	
	function pwUpdate(event) {
		event.preventDefault()
		url = cpath +'/popUp/pwUpdate'
		
		
		
		const item2 = {
			idx: user_idx,
			modifyPw: modifyPw.value,
			checkPw: changeCheckPw.value
		}
		const res = {
			method: 'POST',
			body: JSON.stringify(item2),
			headers: {
				'Content-Type': 'application/json; charset=utf-8'
			}	
		}
		fetch(url, res)
		.then(response => response.text())
		.then(text => {
			
			if(text == 1) {
				
				alert('비밀번호가 성공적으로 수정되었습니다.')	
				window.close();
				const parent = window.opener;
				parent.location.reload();
			}
			else {
				alert('오류가 발생했습니다.')
			}
		
		})
	}