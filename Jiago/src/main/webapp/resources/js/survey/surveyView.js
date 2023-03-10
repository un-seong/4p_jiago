function surveyDeleteHandler(event) {   
      const cpath = '/jiago'
      const surveyIdx = survey_idx
      const surveyName = survey_name
      const message = "'" + surveyName + "' 을/를 정말로 삭제하시겠습니까?'"
      const flag = confirm(message)
      if(flag) {
         const url = cpath + '/survey/surveyDelete/' + surveyIdx
         fetch(url)
         .then(resp => resp.text())
           .then(text => {
              alert(text)
              location.href = cpath + '/survey/surveyManage'
             })   
      }
   }
   
const surveyDeleteButton = document.getElementById('surveyDelete')



function surveyExampleViewHandler() {
	const surveyListExample_length = document.querySelectorAll('.surveyList.example').length
	console.log(surveyListExample_length)
    const surveyListView_list = document.querySelector('.surveyView.item2')
    console.log(surveyListView_list)
    if(surveyListExample_length < 1) {
    	console.log('여기 도나요?')
    	surveyListView_list.classList.add('hidden')
    }
    else {
    	surveyListView_list.classList.remove('hidden')
    }
}






