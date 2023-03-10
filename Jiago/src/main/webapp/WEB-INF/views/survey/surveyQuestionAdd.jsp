<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="cpath" value="${pageContext.request.contextPath }" />     
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${cpath }/resources/css/survey/surveyQuestionAdd.css" type="text/css">
<script>
	const cpath = '${cpath }'
	
</script>

</head>
<body>

<div class="img_back">
   <a href="javascript:history.back(-1)"><img src="${cpath }/resources/img/뒤로가기.png">뒤로가기</a>
</div>   
   
<div id="survey_wrap">


<h3>설문 질문 추가하기</h3>

<h4>설문 질문 리스트</h4>


<div class="questionList container">
   <input type="text" onkeyup="filter()" name="search" id="search" placeholder="질문의 키워드를 입력하세요.">

   <c:forEach var="dto" items="${list }">
   <div class="questionList questionItem">
      <input type="checkbox" value="${dto.question_idx }" name="question_idx"><span class="eachQuestion">${dto.question_content }</span>
   </div>
   </c:forEach>
</div>


<button id="button">질문 생성</button>   

   <form method="POST">
      <div class="wrap">
         <div class="items">
         </div>          
      </div>
      <input id="submit" type="submit" value="제출">
  </form>
  
  </div>
  
  
    <script src="${cpath }/resources/js/survey/surveyQuestionAdd.js"></script>

  	<script>
  		button.onclick = buttonHandler
      	form.onsubmit = testHandler
        
    </script>



</body>
</html>