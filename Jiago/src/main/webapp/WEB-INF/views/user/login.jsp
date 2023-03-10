<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<link href="https://webfontworld.github.io/yangheeryu/Dongle.css" rel="stylesheet">
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>로그인 페이지</title>
<style type="text/css">

	html {
		font-family: 'Dongle';
	}

	
	#loginLogo {
		width: 400px;
		margin: 0 auto;
		margin-top: 50px;
	}
	
	#loginLogo > a > img {
		width: 400px;
	}
	
	#accountInput {
		box-sizing: border-box;
		width: 500px;
		margin: 0 auto;
		margin-top: 50px;
		border: 5px solid #648c85;
		border-radius: 25px;
	}
	
	.idForm {
		margin: 50px auto;
	}
	

	.id , .password {
		width: 300px;
		display: flex;
		justify-content: center;
		align-items: center;
		z-index: 1;
  		opacity: 1;	
		border: 1px solid #ccc;
		box-sizing: border-box;
		margin: 0 auto;
		cursor: text;
	}
	
	.idText , .pwText {
		width: 200px;
	}
	
	.idForm > div > input {
		font-size: 25px;
		padding: 10px 20px;
		border:0 solid black;
		font-family: 'Dongle';
	}
	
	
	.loginBtn > input {
		display: flex;
		justify-content: center;
		width: 300px;
		margin: 0 auto;
		margin-top: 30px;
		box-sizing: border-box;
		cursor: pointer;
		background-color: #1D594E;
		font-size: 30px;
		color: white
	}
	
	.idForm > div > input:focus {
		outline-style: none;
	}
	
	.focusColor {
		border: 1px solid #1D594E;
	}
	
	#menuBar {
		width: 600px;
		margin: 50px auto;
		text-align: center;
	}
	
	#menuBar > span {
		margin: 0 10px;
	}
	
	a {
		text-decoration: none;
		color:black;
	}
	
	.rememberId {
		width: 300px;
   	 	margin: 20px auto;
    	font-size: 25px;
	}
	
</style>
</head>
<body>

	<c:set var="addurl" value="${param.url }" scope="session"/>
	<div id="loginLogo"><a href="${cpath }/"><img src="${cpath}/resources/img/logo.png "></a></div>
	
	<form method="POST" action="${cpath }/user/login">
	  <div id="accountInput">
	    <div class="idForm">
	      <div class="id">
	        <img src="${cpath }/resources/loginImg/login.png">
	        <input class="idText" type="text" name="user_id" placeholder="아이디" autocomplete="off" required
	          value="${cookie.user_id.value }">
	        <!-- 쿠키에서 아이디를 읽어서 자동으로 입력 -->
	      </div>
	      <div class="password">
	        <img src="${cpath }/resources/loginImg/password.png">
	        <input class="pwText" type="password" name="user_pw" placeholder="비밀번호" autocomplete="off" required>
	      </div>
	      <div class="rememberId">
	        <input type="checkbox" name="remember_id" value="1" id="rememberId" ${empty cookie.user_id.value ? '' : 'checked'}>
	        <label for="rememberId">아이디 저장</label>
	      </div>
	      <div class="loginBtn">
	        <input type="submit" value="로그인">
	      </div>
	      
	  
<!-- 	<ul> -->
<!-- 	<li onclick="kakaoLogin();"> -->
<!--       <a href="javascript:void(0)"> -->
<!--           <span>카카오 로그인</span> -->
<!--       </a> -->
<!-- 	</li> -->
<!-- 	<li onclick="kakaoLogout();"> -->
<!--       <a href="javascript:void(0)"> -->
<!--           <span>카카오 로그아웃</span> -->
<!--       </a> -->
<!-- 	</li> -->
<!-- </ul> -->
	

	      
	      
	      
	      
	    </div>
	  </div>
	</form>
	
	
	<div id="menuBar">
		<span><a href="${cpath }/user/findLoginPw">비밀번호 찾기</a></span>
		<span>|</span>
		<span><a href="${cpath }/user/findLoginId">아이디 찾기</a></span>
		<span>|</span>
		<span><a href="${cpath }/user/join">회원 가입</a></span>
	</div>

	<script>
		// 전역 변수)) input onfocus시 색상 변경 적용 시킬  div
		const idsolid = document.querySelector('.id')
		const pwsolid = document.querySelector('.password')
		
		// 전역 변수)) onfocus 시킬 input
		const inputId = document.querySelector('.idText')
		const inputPw = document.querySelector('.pwText')

		
		
		// 로그인 폼 포커스 on
		function outlineSet(event) {
			if(event.target.name == 'user_id') idsolid.classList.add('focusColor')
			else pwsolid.classList.add('focusColor')		
		}
		inputId.onfocus = outlineSet
		inputPw.onfocus = outlineSet
	
		
			
		// 로그인 폼 포커스 해제		
		function focusOff(event) {
			if(event.target.name == 'user_id') idsolid.classList.remove('focusColor')
			else pwsolid.classList.remove('focusColor')		 
		}	
		inputId.onblur = focusOff
		inputPw.onblur = focusOff
		
	</script>
	


<!-- 카카오 스크립트 -->
<!-- <script src="https://developers.kakao.com/sdk/js/kakao.js"></script> -->
<script>
// Kakao.init('838b2d684b7a71b5613042d0169ff0ed'); //발급받은 키 중 javascript키를 사용해준다.
// console.log(Kakao.isInitialized()); // sdk초기화여부판단
// //카카오로그인
// function kakaoLogin() {
//     Kakao.Auth.login({
//       success: function (response) {
//         Kakao.API.request({
//           url: '/v2/user/me',
//           success: function (response) {
//         	  console.log(response);
//         	  const account = response.kakao_account;
//         	  console.log(response.id)
//         	  console.log(account.email)
//         	  console.log(account.gender)
        	  
//         	  const url = '${cpath}/user/kakaoCheck'
        	  
//          	  const data = {
// 				id: response.id,
// 				gender: account.gender,
// 				email: account.email
//         	  }
        	  
//         	  console.log(data)
        	  
//         	  const res = {
// 				method: 'POST',
// 				body: JSON.stringify(data),
// 				headers: { 
// 					'Content-Type': 'application/json; charset=utf-8'
// 				}
//         	  }
        	  
//         	  fetch(url , res)
//         	  .then(response => response.text())
//         	  .then(text => {
//         		  console.log(text)
//         	  })
        	  
        	  
//           },
//           fail: function (error) {
//             console.log(error)
//           },
//         })
//       },
//       fail: function (error) {
//         console.log(error)
//       },
//     })
//   }
// //카카오로그아웃  
// function kakaoLogout() {
//     if (Kakao.Auth.getAccessToken()) {
//       Kakao.API.request({
//         url: '/v1/user/unlink',
//         success: function (response) {
//         	console.log(response)
//         },
//         fail: function (error) {
//           console.log(error)
//         },
//       })
//       Kakao.Auth.setAccessToken(undefined)
//     }
//   }  
</script>






	
	
</body>
</html>