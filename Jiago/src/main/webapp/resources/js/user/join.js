
	const cpath = '/jiago'
		
// 약간 동의 체크시 히든 회원가입 폼 히든 삭제

	const contract = document.forms[0]	// 약간동의 폼
	const joinForm = document.forms[1]	// 회원가입 폼
	
	const agbtn = document.querySelector('.agbtn')

	function btnHandler() {
		contract.parentNode.classList.add('hidden')
		joinForm.parentNode.classList.remove('hidden')
	}
	
	
	
	// 회원 가입 시 아이디 중복 검사
	const joinId = document.getElementById('joinId')			// 아이디 input폼
	const checkIdText = document.querySelector('.checkIdText')	// 조건 일치 여부 및 중복 여부 확인 문장



	function joinIdCheck() {
		
		const url = cpath +'/user/joinId/' + joinId.value
		
		
		fetch(url)
		.then(response => response.text())
		.then(text => {			
			
			const id_if = /^(?=.*[0-9]+)[a-zA-Z][a-zA-Z0-9]{5,12}$/g
			if(text == 0 && id_if.test(joinId.value)) {
				checkIdText.innerText = '회원가입이 가능한 아이디 입니다.'
				checkIdText.style.color = 'blue'
				joinId.name = 'user_id'
				
			}
			else {
				checkIdText.innerText = '조건이 맞지 않거나 중복된 계정이 존재합니다.'
				checkIdText.style.color = 'red'
				joinId.name = ''
			}
		})
	}
	
	
	
	// 비밀번호 입력 및 확인
	const joinPw = document.getElementById('joinPw')				// 새로운 비밀번호 입력
	const checkPw = document.getElementById('checkPw') 				// 비밀번호 확인
	const checkPwText1 = document.querySelector('.checkPwText1')	// 비밀번호 조건 메세지
	const checkPwText2 = document.querySelector('.checkPwText2')	// 비밀번호 확인 메세지


	function joinPwHandler(event) {
		checkPw.value = ''
		checkPwText2.innerText = ''
		const joinPwValue = event.target.value
		if(joinPwValue.length == 0) {
			checkPwText1.innerText = ''
			checkPw.setAttribute('disabled',true)
			return
		}
		const pw_if = /(?=.*[0-9])(?=.*[a-z])(?=.*\W)(?=\S+$).{8,20}/
		if(pw_if.test(joinPwValue)) {
			checkPwText1.innerText = '사용가능한 비밀번호입니다'
			checkPwText1.style.color = 'blue'
			checkPw.removeAttribute('disabled')		// 사용가능한 비밀번호가 아니면 비밀번호 확인 비활성화
		}
		else {
			checkPwText1.innerText = '조건에 부합되지 않은 비밀번호입니다.'
			checkPwText1.style.color = 'red'
			
			checkPw.setAttribute('disabled',true)
		}
	}
	
	
	
	
	function checkPwHandler(event) {
		const checkPwValue = event.target.value
		if(checkPwValue.length == 0) {
			checkPwText2.innerText = ''
		}
		if(checkPwValue == joinPw.value) {
			joinPw.name = 'user_pw'
			checkPwText2.innerText = '비밀번호가 서로 일치합니다'
			checkPwText2.style.color = 'blue'
			
		}
		else {
			joinPw.name = ''
			checkPwText2.innerText = '비밀번호가 서로 일치하지 않습니다'
			checkPwText2.style.color = 'red'
		}
	}
	
	
	
	
	const joinName = document.getElementById('joinName')
	
	
	
	function nameCheckHandler(event) {
		const name_if = /[0-9]|[a-z]|[A-Z]|[가-힣]{4,12}$/g
		const inputName = event.target.value
		const nameCheckMessage = document.querySelector('.nameCheckMessage')
		
		if(inputName.length == 0) {
			nameCheckMessage.innerText = ''
			return
		}
		if(name_if.test(inputName) && inputName.length >= 4 && inputName.length <= 12) {
			const url = cpath +"/user/joinName/" + inputName + "/"
			fetch(url)
			.then(response => response.text())
			.then(text => {
				
				if(text != 1) {
					
					joinName.name = 'user_name'
					nameCheckMessage.innerText = '사용 가능한 별명 입니다.'
					nameCheckMessage.style.color = 'blue'
					return
				}
			})
		}
		else {
			joinName.name = ''
			nameCheckMessage.innerText = '이미 존재하는 이름이거나 조건 양식에 맞지 않습니다.'
			nameCheckMessage.style.color = 'red'
		}	
	}
	
	
	
	// 주소 입력
	function findUserAddress() {
	  new daum.Postcode({
	     oncomplete: function(data) {
             // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

             // 각 주소의 노출 규칙에 따라 주소를 조합한다.
             // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
             var addr = ''; // 주소 변수
             var extraAddr = ''; // 참고항목 변수

             //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
             if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                 addr = data.roadAddress;
             } else { // 사용자가 지번 주소를 선택했을 경우(J)
                 addr = data.jibunAddress;
             }

             // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
             if(data.userSelectedType === 'R'){
                 // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                 // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                 if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                     extraAddr += data.bname;
                 }
                 // 건물명이 있고, 공동주택일 경우 추가한다.
                 if(data.buildingName !== '' && data.apartment === 'Y'){
                     extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                 }
                 // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                 if(extraAddr !== ''){
                     extraAddr = ' (' + extraAddr + ')';
                 }
                 // 조합된 참고항목을 해당 필드에 넣는다.
                 document.getElementById("extraAddress").value = extraAddr;
             
             } else {
                 document.getElementById("extraAddress").value = '';
             }

             // 우편번호와 주소 정보를 해당 필드에 넣는다.
             document.getElementById('postcode').value = data.zonecode;
             document.getElementById("address").value = addr;
             // 커서를 상세주소 필드로 이동한다.
             document.getElementById("detailAddress").focus();
	     }
  	  }).open();	
	}
	
	const detailAddress = document.getElementById('detailAddress')
	const userAddress = document.getElementById('userAddress')
	
	function addressHandler(event) {
		userAddress.name = 'user_address'
		userAddress.value = 
			document.getElementById('postcode').value +
			document.getElementById("address").value + ' ' +
			event.target.value
		
	}

	
	
	
	const userPhone = document.getElementById('userPhone')

	// 휴대폰 번호 입력 부분
	function changePhone1(){
	    const phone1 = document.getElementById("phone1").value // 010
	    if(phone1.length === 3){
	        document.getElementById("phone2").focus();
	    }
	}
	function changePhone2(){
	    const phone2 = document.getElementById("phone2").value // ****
	    if(phone2.length === 4){
	        document.getElementById("phone3").focus();
	    }
	}
	function changePhone3(){
		const phone1 = document.getElementById("phone1").value
		const phone2 = document.getElementById("phone2").value
		const phone3 = document.getElementById("phone3").value // ****
	    if(phone3.length == 4) {
	    	const allPhone = phone1 + '-' + phone2 + '-' + phone3
	    	const url = cpath +'/user/checkPhoneNum/' + allPhone + '/'
	    	fetch(url)
	    	.then(response => response.text())
	    	.then(text => {
	    		if(text != 1) {
	    	    	userPhone.name = 'user_phone'
	    		    userPhone.value = allPhone
	    		}
	    	})
	    }
	    
	}

	
	
// 이메일 입력
	
	let frontEmail = ''
	let secondEmail = ''
	
	const inputEmailFront = document.getElementById('email1')
	const inputSelectEmail = document.getElementById('email2')
	
	const directly = document.getElementById('directEmail')
	
	
	function frontEmailId() {
		frontEmail = inputEmailFront.value
	}
	
	inputEmailFront.onchange = frontEmailId
	
	// 셀렉트 선택
	function emailHandler(event) {
		const selectValue = inputSelectEmail.value
		
		
 		if(selectValue == '직접 입력') {	// 직접 입력이 들어오면 숨긴 폼 보여주기
			directly.classList.remove('hidden')
			directly.disabled = false
		}
 		else {
 			directly.classList.add('hidden')
 			directly.disabled = true
 			secondEmail = selectValue
 		}
	}
	
	
	// 직접입력 창에서 입력을 완료하면 변경
	directly.onchange = function(event) {			
		secondEmail = event.target.value
	}
	
	// 이메일 인증 창 열고 전송 후 받기
	const checkEmailSend = document.getElementById('checkEmailSend')
	function checkEmailSendHandler() {
		if(secondEmail.length == 0 || frontEmail.length == 0) {
			alert('옳바른 형태의 이메일 주소가 아닙니다')
			return
		}
        const emailCheckMailUrl = cpath +'/popUp/emailCheckMail/' + frontEmail + '@' + secondEmail + '/';
        const emailCheckMailOption = 'top=200, left=250, width=500, height=500 , status=no, menubar=no, toolbar=no, resizable=no';
        window.open(emailCheckMailUrl, 'popUp', emailCheckMailOption);
	}
	
	

	 
	 function joinFormHandler(event) {
		  const checkNameAll = Array.from(document.querySelectorAll('input[name]'));
		  const result = checkNameAll.filter(value => value.name == '');

		  if (result != null && result != '') {
		    result[0].scrollIntoView();
		    if (result[0].id == 'userEmail') alert('이메일 인증이 필요합니다!!');
		    //event.preventDefault();
		    return false;
		  } else {
		    //joinForm.unbind();
		    return true;
		  }
		}