<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../manage/manageHeader.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>



	<div id="surveyCountByDonate">
		<h1 class="countByCom_h1">회사 별 설문 개수</h1>
		<canvas id="surveyCountByDonateChart"></canvas>
	</div>
</div>

<script>

	const cpath = '/jiago'
	const survey_idx = '${survey_idx}'
	const url = cpath + '/manage/getSurveyCountByDonate'

	fetch(url)
	.then(resp => resp.json())
	.then(json => {   
	     console.log(json)
	    
		const companyName = []
	     for(let key in json) {
	    	 companyName.push(json[key].company_name)
	     }
	     console.log(companyName)
	     
	     const count = []
	     for(let key in json) {
	   		count.push(json[key].count)
	     }
	     
	     console.log(count)
	     
	     let context = document.getElementById('surveyCountByDonateChart')
	     
         
		    const data = {
	        	labels : companyName,
	            datasets: [
	            	{
	            	   label: '설문 조사 수',
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
	                         text: '회사 별 설문 조사 수'
	                  
	        	         },
	        	         legend: {
	 	                	display: false
	 	                }
	            	},
	            
	            }
	        }
	          
	          const myChart = new Chart(context, config)   
	                
	})
	
</script>


</body>
</html>