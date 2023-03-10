<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../manage/manageHeader.jsp"%>

<link rel="stylesheet" href="${cpath }/resources/css/manage/surveyPreferAll.css" type="text/css">


	<div class="preferenceBox">
		<div class="preferenceBox_div">
			<a href="${cpath }/manage/surveyPreferAge"><img src="${cpath }/resources/img/연령대.png">연령대별 선호설문</a>
		</div>
		<div class="preferenceBox_div">
			<a href="${cpath }/manage/surveyPreferGender"><img src="${cpath }/resources/img/성별.png">성별별 선호설문</a>
		</div>
		<div class="preferenceBox_div">
			<a href="${cpath }/manage/surveyPreferJob"><img src="${cpath }/resources/img/직업.png">직업별 선호설문</a>
		</div>
	</div>
</body>
</html>