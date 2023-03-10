<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://webfontworld.github.io/yangheeryu/Dongle.css" rel="stylesheet">
<title>비밀번호 찾기</title>

<link rel="stylesheet" href="${cpath }/resources/css/user/findLoginPw.css" type="text/css">

</head>
<body>


<div id="findUserPw">
	<div class="imglogo"><img src="${cpath }/resources/img/logo.png"></div>
	<div class="message">비밀번호를 찾고자 하는 아이디를 입력해주세요</div>
	<div id="inputId">
		<form id="idForm">
			<div><input type="text" name="id" placeholder="지아고 아이디  또는 단체 아이디"></div>
			<div><input type="submit" value="입력"></div>
		</form>
	</div>	
	<div class="otherlink">아이디가 기억나지 않는다면?&nbsp; &nbsp;<a href="${cpath }/user/findLoginId">아이디 찾기</a></div>
</div>

<div class="foot"><a href="${cpath }/" style="font-weight: bolder;">JIAGO</a><span style="margin: 0 5px;">|</span><a href="${cpath }/cuscenter">회원정보 고객센터</a></div>		





<script src="${cpath }/resources/js/user/findLoginPw.js"></script>


<script>
	sendId.onsubmit = checkUserId
</script>

</body>
</html>