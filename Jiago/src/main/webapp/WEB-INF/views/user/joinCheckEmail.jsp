<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://webfontworld.github.io/yangheeryu/Dongle.css" rel="stylesheet">
<title>이메일 인증</title>

<link rel="stylesheet" href="${cpath }/resources/css/user/joinCheckEmail.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

</head>


<body>
	<div id="emailForm" class="hidden">
		<form class="form">
			<input id="inputNum" type="text" placeholder="인증번호 입력" required><br>
			<div id="timer" style="font-family: 'dongle'; font-size: 20px;"></div>
			<input type="submit" value="입력">
		</form>
	</div>
	
	
<script>const email = '${email}'

	console.log(email)</script>
	
<script src="${cpath }/resources/js/user/joinCheckEmail.js" charset="utf-8" type="text/javascript"></script>
	
<script>
	
	form.onsubmit = formHandler

	
</script>
</body>
</html>