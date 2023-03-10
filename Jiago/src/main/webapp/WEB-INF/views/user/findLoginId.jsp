<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://webfontworld.github.io/yangheeryu/Dongle.css" rel="stylesheet">
<title>아이디 찾기</title>

<link rel="stylesheet" href="${cpath }/resources/css/user/findLoginId.css" type="text/css">


</head>
<body>

	
<div class="imglogo hidden"><a href="${cpath }/"><img src="${cpath }/resources/img/logo.png"></a></div>
<div id="findUserId">
	<div class="message">회원가입시 설정한 이메일을 입력해주세요</div>
	<div id="inputEmail">
		<form id="idForm">
			<div><input id="userEmail" type="email" name="id" placeholder="인증번호를 받을 이메일 주소 입력"></div>
			<div><input type="submit" value="전송"></div>
		</form>
	</div>	
	<div class="otherlink">비밀번호가 기억나지 않는다면?&nbsp; &nbsp;<a href="${cpath }/user/findLoginPw">비밀번호 찾기</a></div>
</div>



<div id="check" class="hidden">	<!-- class="hidden"  -->
	<form id="checkForm">
		<p><input type="text" id="checkNumber" name="checkNumber" placeholder="인증번호를 입력하세요"></p>
		<div id="timer" style="font-family: 'dongle'; font-size: 20px; margin-left: 165px;"></div>
		<p><input type="submit" value="인증"></p>
	</form>
</div>


<div id="result">
	<div class="otherlink hidden">비밀번호가 기억나지 않는다면?&nbsp; &nbsp;<a href="${cpath }/user/findLoginPw">비밀번호 찾기</a></div>
</div>

<p id="next" class="hidden">
	<a href="${cpath }/"><button>home으로 이동</button></a>
</p>



<div class="foot"><a href="${cpath }/" style="font-weight: bolder;">JIAGO</a><span style="margin: 0 5px;">|</span><a href="${cpath }/cuscenter">회원정보 고객센터</a></div>
	


	
	
<script src="${cpath }/resources/js/user/findLoginId.js"></script>
	


<script>

	sendmessage.onsubmit = sendmail
	checkmessage.onsubmit = checknumber
</script>


</body>
</html>