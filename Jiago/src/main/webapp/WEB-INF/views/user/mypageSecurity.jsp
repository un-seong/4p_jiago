<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="mypage.jsp" %>

<link rel="stylesheet" href="${cpath }/resources/css/user/mypageSecurity.css" type="text/css">


<div class="security_wrap">
	<h1>내 정보 관리</h1>
	<div id="guideLine">
		<div class="guide_left">
			<span>정확한 정보를 입력하셔야 조사 참여의 기회가 제공됩니다</span>
		</div>
		<div class="guide_right">
			<span>체크 표시는 필수 입력 항목입니다.</span>
		</div>
	</div>
	
		
	<form method="POST" action="${cpath }/user/userModify" >
		<div id="customerData">
			
			<div class="info">
				<div><div class="innerTitle">이름</div>: <span class="innerData">${dto.user_name }</span></div>
				<div><div class="innerTitle">생년월일 / 성별</div>: <span class="innerData">${dto.user_joindate} / ${dto.user_gender }</span></div>
				<div><div class="innerTitle">거주지역</div>: <span class="innerData"><input type="text"  name="user_address" value="${dto.user_address }" required autocomplete="off"></span></div>
				<div><div class="innerTitle">휴대폰정보</div>: <span class="innerData"><input type="text"  name="user_phone" value="${dto.user_phone }" required autocomplete="off"></span></div>
				<div><div class="innerTitle">이메일</div>: <span class="innerData"><input type="text"  name="user_email" value="${dto.user_email }" required autocomplete="off"></span></div>
				<div><div class="innerTitle">직업</div>: <span class="innerData">
					<select name="user_job" id="job-select" required>
					    <option value="${dto.user_job }">${dto.user_job }</option>
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
				</span>
				</div>
				<input type="hidden"  name="user_idx" value="${dto.user_idx }">
				<!-- 비밀번호 변경은 따로 영역을 만들어서 처리할거임 -->
				<div><div class="innerTitle">비밀번호</div>: <span class="innerData"><button type="button" id="pwbtn">비밀번호 변경</button></span></div>
			</div>
			
		</div>
		
		<div class="end"><input type="submit" value="수정완료"></div>
	</form>
</div>



<script src="${cpath }/resources/js/user/mypageSecurity.js"></script>

<script>

	pwbtn.onclick = pwmodify


</script>



</body>
</html>