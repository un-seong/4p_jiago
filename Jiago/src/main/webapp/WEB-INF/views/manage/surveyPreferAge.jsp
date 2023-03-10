<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../manage/manageHeader.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<link rel="stylesheet" href="${cpath }/resources/css/manage/surveyPreferAll.css" type="text/css">


<div class="img_back">
   <a href="javascript:history.back(-1)"><img src="${cpath }/resources/img/뒤로가기.png">뒤로가기</a>
</div>

<div id="surveyPreferQuestion_root">
	<div>
		<h1>연령대별 선호질문</h1>
		<p class="filter_preferQuestion">
			<select class="choice">
			</select>
		</p>
	
		<table class="topSurveyPreferQuestion surveyList">
			<thead>
				<tr>
					<th>연령대</th>
					<th>설문 제목</th>
					<th>참여 횟수</th>
				</tr>
			</thead>
		</table>
			
		<div class="topSurveyPreferQuestionTable">
		<table class="topSurveyPreferQuestion surveyList2">
			<tbody>
	
				<c:forEach var="dto" items="${list }">
					<tr>
						<td>${dto.age_range }</td>
						<td>${dto.survey_title }</td>
						<td>${dto.count }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
	</div>


	<div class="surveyPreferAge">
		<div id="surveyPreferAge"></div>
	</div>
</div>




<script>

	const cpath = '/jiago'
	const survey_idx = '${survey_idx}'
	const url = cpath + '/manage/getSurveyPreferAge'

	fetch(url)
	.then(resp => resp.json())
	.then(json => {   
	     console.log(json)
	    
	      // 기본 select 만듦       
	      const choice = document.querySelector('.choice')
	      console.log(choice)
	      
	      const option = document.createElement('option')
	      console.log(option)
	      option.innerText = '연령대 선택'
	         
	      choice.appendChild(option)
	     
	     
	     
		const ageRange = []
	     for(let key in json) {
	    	 ageRange.push(json[key].age_range)
	     }
	     console.log(ageRange)
	     
	     const age = ageRange.filter((v, i) => ageRange.indexOf(v) === i);
	     
	     console.log(age)
	     
	     
	    // option에 value 값 지정
        for(let i = 0; i < age.length; i++) {
           const options = document.createElement('option')
           options.innerText = age[i]
           options.setAttribute('value', 'myChart'+[i])
           
           choice.appendChild(options)
        }
           
	     
	     
	     
	     const jsonToArray = []
	     
	     for(let key in json) {
			for(let k in age) { 
				if(age[k] == json[key].age_range) {
					jsonToArray.push(
							{ 
								age_range: json[key].age_range,
								survey_title: json[key].survey_title,
								count: json[key].count
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
	     
	     
	     const arr = groupBy(jsonToArray, 'age_range')
	     
	     console.log(arr)
	     
	   	 const array = new Array()
	     
	     for(let i in arr) {
	    	 array.push(arr[i])
	     }
	     
	     console.log(array)
	     
	      const survey = new Array();
		  
	      for(let i = 0; i < age.length; i++) {
	    	  survey.push(array[i].map(e => e.survey_title))
		    	 
		  }
	     
	     console.log(survey)
	     
	     
	     const result = new Array();
	     for(let i = 0; i < age.length; i++) {
	    	 result.push(array[i].map(e => e.count))
	     }
	     
	     console.log(result)
	     
	    const surveyPreferAge = document.querySelector('#surveyPreferAge')
	     
	    for(let i = 0; i < array.length; i++) {
	            const canvas = document.createElement('canvas')
	            canvas.id = 'myChart'+[i]
	            surveyPreferAge.appendChild(canvas)
        }     
     
        for(let i = 0; i < array.length; i++) {
                     
           let context = document.getElementById('myChart' + i)
           const labels = survey[i]
           console.log('labels : ' + labels)
           console.log('labels[i] : ' + labels[i])
      
         const data = {
            labels : survey[i],
            datasets: [
               {
            	  label: '참여 횟수',
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
                        text: age[i]
                 
                    }
                }
            }
         
         }
         
         const myChart = new Chart(context, config)   
           
        }  
        
        
       const myChartNone = [] 
        for(let i = 0; i < age.length; i++) {
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