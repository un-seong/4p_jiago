<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="${cpath }/resources/css/survey/surveyView.css" type="text/css">
<script>
	const survey_idx = '${dto.survey_idx}'
    const survey_name = '${dto.survey_title}'
	
</script>
</head>
<body>

<div class="img_back">
   <a href="javascript:history.back(-1)"><img src="${cpath }/resources/img/뒤로가기.png">뒤로가기</a>
</div>


   <div id="survey_view_root">
      <div id="survey_view_main">
         <div class="surveyView item">
         <h1>설문 상세</h1>
            <table class="surveyView">
               <tr>
                  <th>설문 번호</th>
                  <td>${dto.survey_idx}</td>
               </tr>

               <tr>
                  <th>회사 번호</th>
                  <td>${dto.company_idx}</td>
               </tr>

               <tr>
                  <th>설문 제목</th>
                  <td>${dto.survey_title}</td>
               </tr>

               <tr>
                  <th>설문 기간</th>
                  <td>${dto.survey_date}</td>
               </tr>

               <tr>
                  <th>주요 대상</th>
                  <td><p>연령대 : ${dto.survey_targetAge }</p>
                     <p>성별 : ${dto.survey_targetGender}</p>
                     <p>직업 : ${dto.survey_targetJob }</p></td>
               </tr>

               <tr>
                  <th>예상 응답 시간</th>
                  <td>${dto.survey_time}분</td>
               </tr>

               <tr>
                  <th>설문 정보</th>
                  <td>${dto.survey_info }</td>
               </tr>

               <tr>
                  <th>적립금</th>
                  <td>${dto.survey_point}POINT</td>
               </tr>

               <tr>
                  <th>삭제 여부</th>
                  <td>${dto.survey_delete}</td>
               </tr>

            </table>
         <div class="view_button">   
            <div><a href="${cpath }/survey/surveyManage/"><button>목록</button></a></div>
            <div class="view_mdButton">
               <a href="${cpath }/survey/surveyModify/${dto.survey_idx}"><button>수정</button></a>
               <button id="surveyDelete">삭제</button>
            </div>
         </div>
         </div>
      </div>   
      <div class="surveyView item2">
         <h1>보기 목록</h1>
		<div class="surveyView item2_list">
         <c:forEach var="dto" items="${list }" varStatus="status">
            <div class="surveyList item" question_idx="${dto.question_idx}"
               index="${status.count }">
               <div class="surveyList surveyTitle question">${status.count}.
                  ${dto.question_content}</div>
               <c:forEach var="dtoEX" items="${exList }" varStatus="status">
                  <c:if test="${dto.question_idx == dtoEX.question_idx }">
                     <div class="surveyList example"
                        question_idx="${dtoEX.question_idx}">
                        <div class="surveyList surveyExample">${dtoEX.example_content }</div>
                     </div>
                  </c:if>
               </c:forEach>
            </div>
         </c:forEach>
         </div>
      </div>
   </div>
      
   <script src="${cpath }/resources/js/survey/surveyView.js"></script>
   
   <script>
   
	surveyDeleteButton.onclick = surveyDeleteHandler
	
	window.onload = surveyExampleViewHandler

	</script>
	

</body>
</html>