<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../manage/manageHeader.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>





<div id="surveyUserDonateRank">
	<h1 class="userJoin_h1">월별 기부 통계자료</h1>
	<canvas id="myChart"></canvas>
</div>


<script>

	const cpath = '/jiago'
	const survey_idx = '${survey_idx}'
	const url = cpath + '/manage/getDonateMonth'

	fetch(url)
	.then(resp => resp.json())
	.then(json => {   
	     console.log(json)
	    
		const member = []
	     for(let key in json) {
	    	 member.push(json[key].member)
	     }
	     console.log(member)
	     
	     const total = []
	     for(let key in json) {
	   		total.push(json[key].total)
	     }
	     
	     console.log(total)
	     
	     const month = []
	     for(let key in json) {
	   		month.push(json[key].month)
	     }
	     
	     console.log(month)
	     
	     let context = document.getElementById('myChart')
	     
         
		    const data = {
			  labels: month,
			  datasets: [{
			    type: 'bar',
			    label: '총 참여자 수',
			    data: member,
			    borderColor: 'rgb(255, 99, 132)',
			    backgroundColor: 'rgba(2, 94, 115, 0.2)',
			    yAxisID: 'y'
			  }, 
			  {
			    type: 'line',
			    label: '총 기부 금액',
			    data: total,
			    fill: false,
			    borderColor: 'rgb(242, 102, 139)',
			    yAxisID: 'y1'
			  }]
			};
	          
	        const config = {
	           type: 'bar',
	           data: data,
	             options: {
	                 plugins: {
	                     title: {
	                         display: true,
	                         text: '월별 기부 현황'
	                  
	        	         }
	            	},
	            	scales: {
	                    y: {
	                        type: 'linear',
	                        display: true,
	                        position: 'left',
// 	                        suggestedMin: 0,
// 	                        suggestedMax: 20
	                    },
	                    y1: {
	                        type: 'linear',
	                        display: true,
	                        position: 'right',
// 	                        suggestedMin: 0,
// 	                        suggestedMax: 10000
	                    }
	            	}
	            }
	        }
	          
	          const myChart = new Chart(context, config)   
	                
	})
	
</script>


</body>
</html>