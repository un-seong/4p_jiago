<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>


<script>
	const survey_idx = '${survey_idx}'
   	const user_idx = '${login.user_idx}'
   	const cpath = '${cpath}'
</script>

<link rel="stylesheet" href="${cpath }/resources/css/survey/surveyStart.css" type="text/css">

<div class="main" value="0">
   <div class="surveyList_all">
         <div class="surveyList_wrap">
           <div class="surveyList_start"><img src="${cpath }/resources/img/survey_startpage.png"></div>
      
               <c:forEach var="dto" items="${list }" varStatus="status">
                  <div class="surveyList item" question_idx="${dto.question_idx}" index="${status.count }">
                     <div class="surveyList surveyTitle question">${status.count}. ${dto.question_content}</div>
                  </div>
               </c:forEach>
      
            <diV class="example_wrap hidden" value="0">
               <c:forEach var="dtoEX" items="${exList }" varStatus="status">
                  <div class="surveyList example" question_idx="${dtoEX.question_idx}">
                     <label><div class="surveyList surveyExample">
                        <input type="radio" name="${dtoEX.question_idx }" value="${dtoEX.example_content }" required>
                           ${dtoEX.example_content }
                     </div></label>
                  </div>
               </c:forEach>
            </div>
         </div>
         
      
      
      <div class="button_wrap">
         <button class="button before">이전</button>
         <button class="button after">다음</button>
          
         <a href="${cpath }/survey/surveyComplete/${survey_idx}"><button class="button submit">제출</button></a>
      </div>
   </div>
</div>

    <script src="${cpath }/resources/js/survey/surveyStart.js"></script>

   <script>
	
   
      window.onload = surveyStart
      
      buttonBefore.onclick = buttonBeforeHandler
      buttonAfter.onclick = buttonAfterHandler
      buttonSubmit.onclick = submitHandler
    </script>

</body>
</html>