<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../manage/manageHeader.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<div id="surveyQuestionRanking">
	<h1 class="userJoin_h1">가장 많이 사용된 질문</h1>
	<canvas id="myChart"></canvas>
</div>


<script>

	const cpath = '/jiago'
	const survey_idx = '${survey_idx}'
	const url = cpath + '/manage/getSurveyQuestionRanking'

	fetch(url)
	.then(resp => resp.json())
	.then(json => {   
	     console.log(json)
	    
		const question = []
	     for(let key in json) {
	    	 question.push(json[key].question_content)
	     }
	     console.log(question)
	     
	     const count = []
	     for(let key in json) {
	    	 count.push(json[key].count)
	     }
	     
	     console.log(count)
	     
	     let context = document.getElementById('myChart')
	     
         
		    const data = {
	        	labels : question,
	            datasets: [
	            	{
	                   label: '사용 횟수',
	                   data: count,
	                   backgroundColor: [
	                        'rgba(255, 99, 132)',
	                        'rgba(54, 162, 235)',
	                        'rgba(255, 206, 86)',
	                        'rgba(75, 192, 192)',
	                        'rgba(153, 102, 255)',
	                        'rgba(255, 159, 64)'
	                    ],
	                },
	                
	            ]     
	        }
	          
	        const config = {
	           type: 'bar',
	           data: data,
	             options: {
	                 plugins: {
	                     title: {
	                         display: true,
	                         text: '가장 많이 사용된 질문'
	                  
	        	         },
	        	         legend: {
		 	                	display: false
		 	                }
	            	}
	            }
	        }
	          
	          const myChart = new Chart(context, config)   
	                
	})
	
</script>



</body>
</html>