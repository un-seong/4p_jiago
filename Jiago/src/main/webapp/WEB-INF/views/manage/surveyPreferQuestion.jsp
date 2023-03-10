<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../manage/manageHeader.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<link rel="stylesheet" href="${cpath }/resources/css/manage/surveyPreferAll.css" type="text/css">

<div id="surveyPreferQuestion_root">
	<div>
		<h1>회사별 선호 질문</h1>
		<p class="filter_preferQuestion">
			<select class="choice">
			</select>
		</p>
		<table class="topSurveyPreferQuestion surveyList">
			<thead>
				<tr>
					<th>회사명</th>
					<th>질문</th>
					<th>사용 횟수</th>
				</tr>
			</thead>
		</table>
		<div class="topSurveyPreferQuestionTable">
		<table class="topSurveyPreferQuestionTable low">
			<tbody>
				<c:forEach var="dto" items="${list }">
					<tr>
						<td>${dto.company_name }</td>
						<td>${dto.question_content }</td>
						<td>${dto.preference_count }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
	</div>

	<div class="surveyPreferQuestion">
		<div id="surveyPreferQuestion"></div>
	</div>
</div>
<script>

   const cpath = '/jiago'
   const survey_idx = '${survey_idx}'
   const url = cpath + '/manage/getSurveyPreferQuestion'

   fetch(url)
   .then(resp => resp.json())
   .then(json => {   
        console.log(json)
        
       // 기본 select 만듦       
       const choice = document.querySelector('.choice')
      console.log(choice)
      
      const option = document.createElement('option')
      console.log(option)
      option.innerText = '회사 선택'
         
      choice.appendChild(option)
        
 
         
      const company_name = []
        for(let key in json) {
           company_name.push(json[key].company_name)
        }
        console.log(company_name)
        
        const companys = company_name.filter((v, i) => company_name.indexOf(v) === i);
        
        console.log(companys)
        
        
          // option에 value 값 지정
        for(let i = 0; i < companys.length; i++) {
           const options = document.createElement('option')
           options.innerText = companys[i]
           options.setAttribute('value', 'myChart'+[i])
           
           choice.appendChild(options)
        }
             
        
        
        const jsonToArray = []
        for(let key in json) {
         for(let k in companys) { 
            if(companys[k] == json[key].company_name) {
               
               jsonToArray.push(
                     { 
                        company_name: json[key].company_name,
                        question_content: json[key].question_content,
                        preference_count: json[key].preference_count
                     }
               )               
            }
         }
           
        }
        console.log(jsonToArray)
        
        const groupBy = function (data, key) {
           return data.reduce(function (carry, el) {
             var group = el[key];
      
             if (carry[group] === undefined) {
               carry[group] = []
             }
      
             carry[group].push(el)
             return carry
           }, {})
         }
        
        
        const arr = groupBy(jsonToArray, 'company_name')
        
        console.log(arr)
        
          const array = new Array()
        
        for(let i in arr) {
           array.push(arr[i])
        }
        
        console.log(array)
        
         const question = new Array();
        
         for(let i = 0; i < companys.length; i++) {
            question.push(array[i].map(e => e.question_content))
              
        }
        
        console.log(question)
        
        
        const result = new Array();
        for(let i = 0; i < companys.length; i++) {
           result.push(array[i].map(e => e.preference_count))
        }
        
        console.log(result)
        
       const surveyPreferQuestion = document.querySelector('#surveyPreferQuestion')
        
       for(let i = 0; i < array.length; i++) {
               const canvas = document.createElement('canvas')
               canvas.id = 'myChart'+[i]
               surveyPreferQuestion.appendChild(canvas)
        }     
     
        for(let i = 0; i < array.length; i++) {
                     
           let context = document.getElementById('myChart' + i)
           const labels = question[i]
           console.log('labels : ' + labels)
           console.log('labels[i] : ' + labels[i])
      
         const data = {
            labels : question[i],
            datasets: [
               {
                 label: '결과',
                  data: result[i]
               },
            ]
            
         }
         
         const config = {
            type: 'pie',
            data: data,
            options: {
                plugins: {
                    title: {
                        display: true,
                        text: companys[i]
                 
                    }
                }
            }
         
         }
         
         const myChart = new Chart(context, config)   
           
        }  
                    
        
        
        const myChartNone = [] 
       for(let i = 0; i < companys.length; i++) {
          const mychart = document.querySelector('#myChart'+[i])
          myChartNone.push(mychart)
       }
       
        myChartNone.map(e => e.style.display = 'none')
       console.log(myChartNone)
          
       
       
       function myChartBlockhandler(event) {
  
           myChartNone.map(e => e.style.display = 'none')
             

             const myChartBlock = myChartNone.filter(data => (data.getAttribute('id') == event.target.value) == true)
             console.log(myChartBlock)

             myChartBlock.map(e => e.style.display = 'block')

         }

       choice.onchange = myChartBlockhandler 
       
        
   })
   
</script>



</body>
</html>