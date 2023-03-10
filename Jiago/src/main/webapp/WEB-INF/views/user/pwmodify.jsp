<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://webfontworld.github.io/yangheeryu/Dongle.css" rel="stylesheet">
<title>비밀번호 변경</title>

<link rel="stylesheet" href="${cpath }/resources/css/user/pwmodify.css" type="text/css">


</head>
<body>
	
	
	<div class="pwChangeLogo"><img src="${cpath}/resources/img/logo.png"></div>
	
	<div id="pwCheck">
		<form method="POST">
			<div class="inputLocation"><input type="password" name="input_pw" placeholder="비밀번호를 입력하세요" required autocomplete="off"></div>
			<div class="inputLocation"><input type="submit" value="입력"></div>
		</form>
	</div>



	<div id="changePw" class="hidden">
		<form id="modifyStart" method="POST">
			<div class="inputLocation">
				<div style="margin-bottom: 20px; font-size: 15px;">소문자, 숫자, 특수문자 조합의 8 ~ 20자</div>
				<input id="modifyPw" type="password" placeholder="변경할 비밀번호를 입력">
				<span class="checkPwText1"></span>
			</div>
			<div class="inputLocation">
				<input id="changeCheckPw" type="password" name="user_pw_check" placeholder="비밀번호 확인">
				<span class="checkPwText2"></span>
			</div>
			<div class="inputLocation"><input type="submit" value="변경" class="btn"></div>
		</form>
	</div>
	
	<script>const user_idx = '${login.user_idx }'</script>
	

<script src="${cpath }/resources/js/user/pwmodify.js"></script>
	
	<script>


	modifyPw.addEventListener('keyup', modifyPwHandler)	
	
	changeCheckPw.addEventListener('keyup', checkPwHandler)
	
		
	modifyStart.onsubmit = pwUpdate
	
	
	</script>
	
	
	
	
</body>
</html>