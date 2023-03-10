<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<link rel="stylesheet" href="${cpath }/resources/css/survey/surveyComplete.css" type="text/css">


<div class="main">
	<div class="complete_wrap">
	
		<img src="${cpath }/resources/img/surveyComplete_topImg.png">
	
		<h3>${userName }님이 보유하신 포인트는 ${userPoint } 원 입니다</h3>
		
		<form method="POST" action="${cpath }/survey/surveyComplete">
			<input type="hidden" name="survey_idx" value="${survey_idx }">
			<input type="hidden" name="user_idx" value="${login.user_idx }">
			<input type="number" id="point" name="total_donate" placeholder="기부할 금액 입력하세요" max="${userPoint }" min="0" step="100">
			<input type="submit" value="기부하기">
		</form>
	
		<a href="${cpath }">나중에 기부하기</a>
	</div>
</div>



<div class="surveyCompleteBanner">
	<a href="${cpath }/donate/donateList">
		<img src="${cpath }/resources/img/surveyComplete_bottomImg.png" width="1000px">
	</a>
</div>


<script src="${cpath }/resources/js/survey/surveyComplete.js"></script>


<script>  
    form.onsubmit = formHandler
</script>



</body>
</html>