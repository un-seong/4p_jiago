<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath }" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${cpath }/resources/css/survey/surveyQuestionModify.css" type="text/css">

</head>
<body>

<div class="img_back">
   <a href="javascript:history.back(-1)"><img src="${cpath }/resources/img/뒤로가기.png">뒤로가기</a>
</div>   
   
<div id="survey_wrap">
   <h2>설문 질문 수정하기</h2>
   
   <h4>설문 질문 리스트</h4>

   <div class="questionList container">
      <input type="text" onkeyup="filter()" name="search" id="search"
         placeholder="질문의 키워드를 입력하세요.">

      <c:forEach var="dto" items="${list }">
         <div class="questionList questionItem">
            <input type="checkbox" value="${dto.question_idx }"
               name="question_idx"><span class="eachQuestion">${dto.question_content }</span>
         </div>
      </c:forEach>
   </div>


   <button id="button">질문 생성</button>

   <form method="POST">
      <div class="wrap">
         <div class="items">
            <c:forEach var="dto" items="${qList }" varStatus="status">
               <div class="question" id="question">
                  <input type="text" id="question_content" name="question_content"
                     placeholder="질문 추가" question_idx="${dto.question_idx}"
                     value="${dto.question_content}"><button id="exbutton" type="button">보기추가</button><button id="drop" type="button">삭제</button>
                  <c:forEach var="dtoEX" items="${exList }" varStatus="status">
                     <c:if test="${dto.question_idx == dtoEX.question_idx }">
                        <div class="example">
                           <input type="text" id="example_content" name="example_content"
                              placeholder="보기 추가" question_idx="${dtoEX.question_idx}"
                              value="${dtoEX.example_content }"><button id="delete" type="button">삭제</button>
                        </div>
                     </c:if>
                  </c:forEach>
               </div>
            </c:forEach>
         </div>
         <input id="button" type="submit" value="제출">
      </div>
   </form>

</div>  


    <script src="${cpath }/resources/js/survey/surveyQuestionModify.js"></script>


   <script>
	      
      window.onload = function loadHandler() {
         buttonHandler()
      }
      
      button.onclick = buttonHandler

      form.onsubmit = testHandler
            
    </script>



</body>
</html>