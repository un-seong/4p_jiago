 const checkbox_top = document.querySelector('#th_checkAll')

        function allCheckHandler(event) {
            const allCheckbox = document.querySelectorAll('input[name="checkRow"]')

            const delete_but = document.querySelector('.delete_button')

            if(event.target.checked == true) {
                allCheckbox.forEach(e => e.checked = true)
                delete_but.classList.remove('hidden')
            }
            else {
                allCheckbox.forEach(e => e.checked = false)
                delete_but.classList.add('hidden')
            }
        }
 
 
 const allCheckbox = Array.from(document.querySelectorAll('input[name="checkRow"]'))

 function allDeleteHandler(event) {
  const allCheckbox1 = Array.from(document.querySelectorAll('input[name="checkRow"]:checked'))

  const delete_but = document.querySelector('.delete_button')

  if(allCheckbox1.length != 0) {
     delete_but.classList.remove('hidden')
  }
  else {
     delete_but.classList.add('hidden')
  }
  
  }
  allCheckbox.forEach(e => e.onchange = allDeleteHandler)  
  
  
  
  
   const delForm = document.querySelector('.delForm')
        console.log(delForm)

        function delMember(event) {
            const allCheckbox = Array.from(document.querySelectorAll('input[name="checkRow"]:checked'))

            const checkbox2Value = Array.from(allCheckbox.map(e => e.value)) 

            const ob = {
               answer_content: checkbox2Value
            }

            const cpath = '/jiago'
            const url = cpath + '/memberAjax'
            
            const opt = {
                method: 'POST',
                body: JSON.stringify(ob),
                headers: {
                        'Content-Type': 'application/json; charset=utf-8'
                }

            }
            fetch(url, opt)
            .then(resp => resp.text())
            .then(text => {
            	alert(text)
            	location.reload()
            })
            
            
            
        }