<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://webfontworld.github.io/yangheeryu/Dongle.css" rel="stylesheet">
<title>비밀번호 이메일 찾기 페이지</title>
<link rel="stylesheet" href="${cpath }/resources/css/user/pwCheckEmail.css" type="text/css">
</head>

<body>
	<%-- <h1>이메일 = ${email }</h1> --%>
	
	
	
	
	<div>
		<form id="mainForm" method="POST">
			<div><input type="radio" name="check" value="email"> 본인확인 이메일로 인증 (${user[1] })</div>
			<div><input type="submit" value="선택" class="mainSelect"></div>
		</form>
	</div>
	

	<div id="checkNumber" class="hidden">
		<form id="checkForm" method="POST">
			<p>
				<input type="text" name="checkNumber" placeholder="인증번호를 입력하세요">
				<span id="timer" style="font-family: 'dongle'; font-size: 20px;"></span><br>
				<input type="submit" value="인증">
			</p>
		</form>
	</div>
	
	
	
	
	<div id="newPassword" class="hidden">
		<form method="POST" action="${cpath }/user/newPasswordSet">
			<div>
				<div>새로 변경할 비밀번호</div>
				<input type="password" name="password" placeholder="신규 비밀번호 입력" required autocomplete="off">
				<span id="pwMessage1"></span>
				<div style="margin-bottom: 20px; font-size: 20px;">소문자, 숫자, 특수문자 조합의 8 ~ 20자</div>
			</div>
			<div>
				<div>변경된 비밀번호 확인</div>
				<input type="password" name="passwordCheck" disabled placeholder="신규 비밀번호 확인" required autocomplete="off">
				<span id="pwMessage2"></span>
			</div>
			<div><input type="submit" value="변경" disabled class="btn"></div>
		</form>
	</div>
	
	<script src="${cpath }/resources/js/user/pwCheckEmail.js"></script>
	
	<script>
		const cpath = '${cpath}'
		const mainResult = '${mainSelect }'
		const user0 = '${user[0]}'
		
		addPassword.onkeyup = pwHandler1
				
		checkPassword.onkeyup = pwHandler2
		
	</script>
	
	
	
	
</body>
</html>