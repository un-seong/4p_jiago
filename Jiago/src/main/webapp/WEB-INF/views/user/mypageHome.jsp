<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="mypage.jsp"%>
<link href="https://webfontworld.github.io/yangheeryu/Dongle.css" rel="stylesheet">
<link rel="stylesheet" href="${cpath }/resources/css/user/mypageHome.css" type="text/css">

<div id="userPoint">
	<div class="pointInfo">
		<c:choose>
			<c:when test="${not empty point}">
				<div class="usertop">
					<div class="usertop_img">
						<img src="${cpath }/resources/userImg/${grade }.png">
					</div>
					<div class="usertop_write">현재
						<span class="usertop_write_grade">&nbsp${leftPoint != 0 ? grade : '자연'}&nbsp</span>
						등급입니다</div>
					<h2>${leftPoint != 0 ? '다음 등급까지 남은 기부 포인트 : ' : '' }
						${leftPoint != 0 ? leftPoint : '' }원 <span><button
								id="open-modal">전체 등급표 보기</button></span>
					</h2>
					<div id="customer-grade-modal" class="modal">
						<div class="modal-content">
							<!-- 고객 등급표 내용 -->
							<div id="gradeForm">
								<img class="gradeForm" src="${cpath }/resources/userImg/등급표.png">
							</div>
						</div>
						<br>
					</div>
				</div>
				<div class="userbottom">
					<div class="userbottom_name">
						<span>${login.user_name }님 POINT</span>
					</div>
					<div class="userbottom_point">
						<div class="nPoint">
							<span>현재 보유 포인트</span>
							<a>
								<span class="nPointL">${point }</span>
								<span>POINT</span>							
							</a>
						</div>
						<div class="nPoint">
							<span>총 기부 포인트</span>
							<a>
								<span class="nPointL">${empty totalPoint ? '0' : totalPoint }</span>
								<span>POINT</span>
							</a>
						</div>
					</div>
					<div class="donation">
						<a href="${cpath }/donate/donateList">기부하러가기</a>
					</div>
				</div>

			</c:when>
			<c:otherwise>
					<div class="first_survey">
						<div class="first_surveyTop">
							아직 설문조사를 한번도 하지 않았네요ㅠㅠ?
						</div>
						<div class="first_surveyBottom donation">
							<a
								href="${cpath }/survey/list?survey_targetAge=&survey_targetGender=&survey_targetJob=">첫
								설문조사 하러가기
							</a>
						</div>		
					</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<script src="${cpath }/resources/js/user/mypageHome.js"></script>

</body>
</html>