<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../manage/manageHeader.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<div id="surveyUserDonateRank">
	<h1 class="userJoin_h1">유저별 기부 순위</h1>
	<canvas id="myChart"></canvas>
</div>


<script>

	const cpath = '/jiago'
	const survey_idx = '${survey_idx}'
	const url = cpath + '/manage/getSurveyUserDonateRank'

	fetch(url)
	.then(resp => resp.json())
	.then(json => {   
	     console.log(json)
	    
		const userName = []
	     for(let key in json) {
	    	 userName.push(json[key].user_name)
	     }
	     console.log(userName)
	     
	     const total_donate = []
	     for(let key in json) {
	   		total_donate.push(json[key].total_donate)
	     }
	     
	     console.log(total_donate)
	     
	     let context = document.getElementById('myChart')
	     
         
		    const data = {
	        	labels : userName,
	            datasets: [
	            	{
	                   label: '기부금액',
	                   data: total_donate,
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
	                         text: '유저별 기부 순위'
	                  
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