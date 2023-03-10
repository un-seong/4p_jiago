// ID 존재 확인
	const cpath = '/jiago'
	const inputId = document.getElementById('inputId')
	const sendId = document.forms[0]

	
	function checkUserId(event) {
		event.preventDefault()
		const url = cpath +'/user/sendId'
		const id = document.querySelector('input[name="id"]').value
		
		
		const opt1 = {
			method: 'POST',
			body: id,
			headers: { 
				'Content-Type': 'application/json; charset=utf-8'
			}
		}
		
		fetch(url,opt1)
		.then(response => response.text())
		.then(text => {
			
			if(text == 1) {
				location.href = cpath +'/user/pwCheckEmail'
			}
			else {
				alert('잘못된 형식의 아이디입니다.')
			}
		})
	}