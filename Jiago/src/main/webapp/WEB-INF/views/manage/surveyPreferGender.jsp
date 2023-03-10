<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../manage/manageHeader.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<link rel="stylesheet" href="${cpath }/resources/css/manage/surveyPreferAll.css" type="text/css">


<div class="img_back">
   <a href="javascript:history.back(-1)"><img src="${cpath }/resources/img/뒤로가기.png">뒤로가기</a>
</div>

<div class="surveyPreferGender">
<h1 class="surveyPreferGenderHeader">성별별 선호조사 결과</h1>


<div id="SurveyPreferGender">
   <canvas id="myChart0"></canvas>
   <canvas id="myChart1"></canvas>
</div>
</div>

<script>

   const cpath = '/jiago'
   const survey_idx = '${survey_idx}'
   const url = cpath + '/manage/getSurveyPreferGender'

   fetch(url)
   .then(resp => resp.json())
   .then(json => {   
        console.log(json)
        
       const user_man = []
        const user_woman = []
        for(let key in json) {
           console.log(json[key].user_gender == '남성')
           
           if(json[key].user_gender == '남성') {
              user_man.push(json[key])
           }else {
              user_woman.push(json[key])
           }
           
        }
        
        const mans_survey_title = []
        for(let key in user_man) {
           mans_survey_title.push(user_man[key].survey_title)
        }
        
        const mans_count = []
        for(let key in user_man) {
           mans_count.push(user_man[key].count)
        }
        
        const womans_survey_title = []
        for(let key in user_woman) {
           womans_survey_title.push(user_woman[key].survey_title)
        }
        
        const womans_count = []
        for(let key in user_woman) {
           womans_count.push(user_woman[key].count)
        }
             
   
        let context = document.getElementById('myChart0')
        
          const data = {
              labels : mans_survey_title,
               datasets: [
                  {
                      label: '결과',
                      data: mans_count
                   }
               ]     
           }
             
           const config = {
              type: 'pie',
              data: data,
                options: {
                    plugins: {
                        title: {
                            display: true,
                            text: '남성'
                     
                       }
                  }
               }
           }
             
             const myChart = new Chart(context, config)
   
        

         let context1 = document.getElementById('myChart1')
        
        
          const data1 = {
              labels : womans_survey_title,
               datasets: [
                  {
                      label: '결과',
                      data: womans_count
                   }
               ]     
           }
             
           const config1 = {
              type: 'pie',
              data: data1,
                options: {
                    plugins: {
                        title: {
                            display: true,
                            text: '여성'
                     
                       }
                  }
               }
           }
             
             const myChart1 = new Chart(context1, config1)
        
   })
   
</script>
        
</body>
</html>