   
      const mainForm = document.getElementById('mainForm')
      const checkNumber = document.getElementById('checkNumber')
      const newPassword = document.getElementById('newPassword')
      

      document.forms[0].onsubmit = (event) => {
         event.preventDefault()

         const checkedValue = event.target.querySelector('input:checked').value
         

         const url = cpath + '/user/findType'
         
         const item =  {
            email: user0,
            type: checkedValue,
         }
         
         
         const cls = {
            method: 'POST',
            body: JSON.stringify(item),
            headers: {
               'Content-Type': 'application/json; charset=utf-8'
            }   
         }
         
         fetch(url , cls)
         .then(response => response.text())
         .then(text => {
            
            if(text == 'email') {
               alert('계정에 저장된 이메일 주소로 인증번호를 보냈습니다.')
               event.target.parentNode.classList.add('hidden')
               checkNumber.classList.remove('hidden')
               checkNumber.setAttribute('cellNum','false')
               
            // 2분 타이머 설정
            let secondsLeft = 120
            const timerDiv = document.getElementById('timer');
            let timer = setInterval(() => {
               if(checkNumber.getAttribute('cellNum') == 'true') {
                  return
               }
               secondsLeft--;
               if (secondsLeft === 0) {
                  clearInterval(timer)
                  alert('시간이 초과되었습니다. 다시 시도해주세요.');
                  event.target.parentNode.classList.remove('hidden')
                  checkNumber.classList.add('hidden')
                  return
               } else {
                  timerDiv.innerHTML = '남은 시간 : ' + secondsLeft +'초'
               }
            }, 1000)
               
            }
            else {
               alert('휴대폰 인증 미구현')
               
            }
         })

      }         // form[0]
         
      
      

      
      
      
      
      document.forms[1].onsubmit = event => {
         event.preventDefault()
         
         const inputValue = event.target.querySelector('input[type="text"]').value
         
         const url = cpath + '/user/pwFindMailNumber'
         checkNumber.setAttribute('cellNum','true')
         
         const cls = {
               method: 'POST',
               body: inputValue,
               headers: {
                  'Content-Type': 'plain/text; charset=utf-8'
               }   
         }
         
         fetch(url ,cls)
         .then(response => response.text())
         .then(text => {
            
            if(text == 1) {
               alert('인증에 성공하였습니다.')
               event.target.parentNode.classList.add('hidden')
               newPassword.classList.remove('hidden')
               
            } else {
               alert('인증번호가 틀렸습니다.')
            }
         })
      }
      
      const addPassword = document.querySelector('input[name="password"]')
      const checkPassword = document.querySelector('input[name="passwordCheck"]')
      const pwMessage1 = document.getElementById('pwMessage1')
      const pwMessage2 = document.getElementById('pwMessage2')
      const btn = document.querySelector('.btn')
      
      function pwHandler1(event) {
         const addPwValue = event.target.value
         pwMessage2.innerText = ''
         btn.disabled = true
         if(addPwValue.length == 0) {
            pwMessage1.innerText = ''
            checkPassword.disabled = true
            return
         }
         
         const pw_if = /(?=.*[0-9])(?=.*[a-z])(?=.*\W)(?=\S+$).{8,20}/
         if(pw_if.test(addPwValue)) {
            pwMessage1.innerText = '사용가능한 비밀번호입니다.'   
            pwMessage1.style.color = 'blue'
            checkPassword.disabled = false
         }
         else {
            pwMessage1.innerText = '조건에 부합되지 않은 비밀번호입니다.'
            pwMessage1.style.color = 'red'
            checkPassword.value = ''
            checkPassword.disabled = true
         }
      }
      addPassword.onkeyup = pwHandler1
      
      
      function pwHandler2(event) {
         const checkPwValue = event.target.value
         if(checkPwValue.length == 0) {
            pwMessage2.innerText = ''
            btn.disabled = true
            return
         }
         
         if(checkPwValue == addPassword.value ) {
            pwMessage2.innerText = '비밀번호가 서로 일치합니다'
            pwMessage2.style.color = 'blue'
            btn.disabled = false
         }
         else {
            pwMessage2.innerText = '비밀번호가 서로 일치하지 않습니다'
            pwMessage2.style.color = 'red'
            btn.disabled = true
         }
      }
      
      checkPassword.onkeyup = pwHandler2
