<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://webfontworld.github.io/yangheeryu/Dongle.css" rel="stylesheet">

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title>회원가입 페이지</title>

<link rel="stylesheet" href="${cpath }/resources/css/user/join.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


</head>




<body>
	
<a href="${cpath }/"><img src="${cpath }/resources/img/logo.png"></a>
<div>
    <form class="contract" action="signup.html">
        <h1 style="color:white;">계정 정보 동의 약관</h1>
	        <div class="text"><span>가.</span> 개인정보의 수집 및 이용 목적
	
			            본 사이트 JIAGO는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.
			    
			    <span>나.</span> 정보주체와 법정대리인의 권리ㆍ의무 및 행사방법
			            ① 정보주체(만 14세 미만인 경우에는 법정대리인을 말함)는 언제든지 개인정보 열람·정정·삭제·처리정지 요구 등의 권리를 행사할 수 있습니다.
			            ② 제1항에 따른 권리 행사는 개인정보보호법 시행규칙 별지 제8호 서식에 따라 작성 후 서면, 전자우편 등을 통하여 하실 수 있으며, 기관은 이에 대해 지체 없이 조치하겠습니다.
			            ③ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.
			            ④ 개인정보 열람 및 처리정지 요구는 개인정보 보호법 제35조 제5항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.
			            ⑤ 개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.
			            ⑥ 정보주체 권리에 따른 열람의 요구, 정정ㆍ삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.
			            
			     <span>다.</span> 수집하는 개인정보의 항목
			      JIAGO 회원정보(필수): 이름, 이메일(아이디), 비밀번호
			            
			     <span>라.</span> 개인정보의 보유 및 이용기간
			      JIAGO는 법령에 따른 개인정보 보유ㆍ이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의 받은 개인정보 보유ㆍ이용기간 내에서 개인정보를 처리ㆍ보유합니다.
			            
			            - 수집근거: 정보주체의 동의
			            - 보존기간: 회원 탈퇴 요청 전까지(1년 경과 시 재동의)
			            - 보존근거: 정보주체의 동의
			            
			     <span>마.</span> 동의 거부 권리 및 동의 거부에 따른 불이익
			            위 개인정보의 수집 및 이용에 대한 동의를 거부할 수 있으나, 동의를 거부할 경우 회원 가입이 제한됩니다.
	        </div>
        <div>
            <p style="font-size: 30px; color:white;"><input type="checkbox" required class="agbtn"> 약관에 동의하면 체크</p>
        </div>
    </form>
</div>



	
	<div id="joinForm" class="hidden"> <!-- class="hidden"  -->
		<form method="POST" action="${cpath }/user/join">
			<div>
				<div style="font-size: 32px;">아이디</div>
				<input type="text" name="" id="joinId" placeholder="신규 아이디 입력" required autocomplete="off"><button type="button" onclick="joinIdCheck()">중복 검사</button><span class="checkIdText"></span>
				<div>영문자로 시작하는 영문자 + 숫자의 조합의 6 ~ 12자 </div>
			</div>
			
			<div>
				<div>비밀번호</div>
				<input type="password" name="" id="joinPw" placeholder="신규 비밀번호 입력" required autocomplete="off"><span class="checkPwText1"></span>
				<div>소문자, 숫자, 특수문자 조합의 8 ~ 20자</div>
			</div>
			<div>
				<div>비밀번호 확인</div>
					<input type="password" id="checkPw" disabled placeholder="신규 비밀번호 확인" required autocomplete="off"><span class="checkPwText2"></span>
				</div>
			<div>
				<div>별명, 닉네임</div>
				<input type="text" id="joinName" name="" placeholder="유저 이름" required autocomplete="off"><span class="nameCheckMessage"></span>
				<div>한글, 숫자 , 영문 자유 형식의 4 ~ 12자</div>
			</div>
			<div>
				<div>생년월일</div>
					<input type="date" name="user_birth" data-placeholder="생일 입력" required>
				</div>
			<div>
				<div>성별</div>
				  <label>
				    <input type="radio" name="user_gender" value="남성" required/>
				    <span class="user_gender">남성</span>
				  </label>
				  <label style="margin-left: 20px;">
				    <input type="radio" name="user_gender" value="여성" required />
				    <span class="user_gender">여성</span>
				  </label>
			</div>
			<div class="addressForm">
				<div>주소</div>
				<input type="text" id="postcode" placeholder="우편번호" required>
				<input type="button" onclick="findUserAddress()" value="우편번호 찾기" required><br>
				<input type="text" id="address" placeholder="주소" required><br>
				<input type="text" id="detailAddress" placeholder="상세주소" required>
				<input type="text" id="extraAddress" placeholder="참고항목" required>
				<input type="hidden" id="userAddress" name="" >
			</div>
			<div class="phone">
				<div>휴대 전화</div>
            	<input id="phone1" type="text" size="1" maxlength="3" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); changePhone1()" required> -
            	<input id="phone2" type="text" size="3" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); changePhone2()" required> -
            	<input id="phone3" type="text" size="3" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); changePhone3()" required>
      			<input type="hidden" id="userPhone" name="" >
      		</div>
      		<div>
      			<div>이메일</div>
      			<input id="email1" type="text"> @ 
      			<select id="email2" required>
      				<option value="">--주소를 선택하세요--</option>
      				<option value="naver.com">naver.com</option>
      				<option value="gmail.com">gmail.com</option>
      				<option value="직접 입력">직접 입력하세요</option>
      			</select>
      			<input type="text" id="directEmail" class="hidden" disabled style="margin-top: 5px;" required placeholder="직접 입력">
      			<button id="checkEmailSend" type="button" style="width: 150px">인증메일 전송</button>
      			<input type="hidden" id="userEmail" name="">
      		</div>
      		
			<div>
				<div>직업</div>
				<select name="user_job" id="job-select" required>
				    <option value="">--직업을 선택하세요--</option>
				    <option value="전업주부">전업주부</option>
				    <option value="학생">학생</option>
				    <option value="무직">무직</option>
				    <option value="생산/기술직/무직">생산/ 기술직/ 노무직</option>
				    <option value="사무직">사무직</option>
				    <option value="교사/학원강사">교사 / 학원강사</option>
				    <option value="공무원 (공기업포함)">공무원 (공기업포함)</option>
				    <option value="경영직">경영직</option>
				    <option value="전문직">전문직</option>
				    <option value="서비스/영업/판매직">서비스 / 영업 / 판매직</option>
				    <option value="농/임/어업">농 / 임 / 어업</option>
				    <option value="자영업">자영업</option>
				    <option value="기타">기타</option>
				</select>
			</div>
			<div><input type="hidden" name="user_type" value="Member"></div> <!-- 얘는 임시 -->
			<div><input type="submit" value="입력"></div>
		</form>
	</div>
	<script>const email = '${email}'
		console.log('email : '+email)
	</script>
	
	
	<script src="${cpath }/resources/js/user/join.js" charset="utf-8" type="text/javascript"></script>
	

<script>
	
	agbtn.onclick = btnHandler
	
	joinPw.addEventListener('keyup', joinPwHandler)
	
	checkPw.addEventListener('keyup', checkPwHandler)
	
	joinName.onkeyup = nameCheckHandler
		
	detailAddress.onchange = addressHandler
	
	inputSelectEmail.onchange = emailHandler
	
	checkEmailSend.onclick = checkEmailSendHandler
	
	joinForm.onsubmit = joinFormHandler
</script>
	




</body>
</html>