<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>


<div class="main">
	<div class="surveyList title">
		<a
			href="${cpath }/survey/list?survey_targetAge=&survey_targetGender=&survey_targetJob=">설문
			목록</a>
	</div>

	<div class="survey_filter">
		<form id="filter_all">
			<div id="filter">
				<p class="filter_targetAge">
					<select name="survey_targetAge">
						<option value="">타겟 연령대</option>
						<option value="10대 이전"
							${survey_targetAge == '10대 이전' ? 'selected' : '' }>10대
							이전</option>
						<option value="10대"
							${survey_targetAge == '10대' ? 'selected' : '' }>10대</option>
						<option value="20대"
							${survey_targetAge == '20대' ? 'selected' : '' }>20대</option>
						<option value="30대"
							${survey_targetAge == '30대' ? 'selected' : '' }>30대</option>
						<option value="40대"
							${survey_targetAge == '40대' ? 'selected' : '' }>40대</option>
						<option value="50대"
							${survey_targetAge == '50대' ? 'selected' : '' }>50대</option>
						<option value="60대"
							${survey_targetAge == '60대' ? 'selected' : '' }>60대</option>
						<option value="70대 이상"
							${survey_targetAge == '70대 이상' ? 'selected' : '' }>70대
							이상</option>
						<option value="공통" ${survey_targetAge == '공통' ? 'selected' : '' }>공통</option>
					</select>
				</p>
			</div>
			<div id="filter2">
				<p class="filter_targetGender">
					<select name="survey_targetGender">
						<option value="">타겟 성별</option>
						<option value="남성"
							${survey_targetGender == '남성' ? 'selected' : '' }>남성</option>
						<option value="여성"
							${survey_targetGender == '여성' ? 'selected' : '' }>여성</option>
						<option value="공통"
							${survey_targetGender == '공통' ? 'selected' : '' }>공통</option>
					</select>
				</p>
			</div>
			<div id="filter3">
				<p class="filter_targetJob">
					<select name="survey_targetJob">
						<option value="">타겟 직업</option>
						<option value="전문직"
							${survey_targetJob == '전문직' ? 'selected' : '' }>전문직</option>
						<option value="경영직"
							${survey_targetJob == '경영직' ? 'selected' : '' }>경영직</option>
						<option value="사무직"
							${survey_targetJob == '사무직' ? 'selected' : '' }>사무직</option>
						<option value="서비스/영업/판매직"
							${survey_targetJob == '서비스/영업/판매직' ? 'selected' : '' }>서비스/영업/판매직</option>
						<option value="생산/기술직/노무직"
							${survey_targetJob == '생산/기술직/노무직' ? 'selected' : '' }>생산/기술직/노무직</option>
						<option value="교사/학원강사"
							${survey_targetJob == '교사/학원강사' ? 'selected' : '' }>교사/학원강사</option>
						<option value="공무원(공기업 포함)"
							${survey_targetJob == '공무원(공기업 포함)' ? 'selected' : '' }>공무원(공기업
							포함)</option>
						<option value="학생" ${survey_targetJob == '학생' ? 'selected' : '' }>학생</option>
						<option value="전업주부"
							${survey_targetJob == '전업주부' ? 'selected' : '' }>전업주부</option>
						<option value="농/임/어업"
							${survey_targetJob == '농/임/어업' ? 'selected' : '' }>농/임/어업</option>
						<option value="자영업"
							${survey_targetJob == '자영업' ? 'selected' : '' }>자영업</option>
						<option value="자유직/프리랜서"
							${survey_targetJob == '자유직/프리랜서' ? 'selected' : '' }>자유직/프리랜서</option>
						<option value="무직" ${survey_targetJob == '무직' ? 'selected' : '' }>무직</option>
						<option value="기타" ${survey_targetJob == '기타' ? 'selected' : '' }>기타</option>
						<option value="공통" ${survey_targetJob == '공통' ? 'selected' : '' }>공통</option>
					</select>
				</p>
			</div>
			<input id="survey_filter_input" type="submit" value="검색" />
		</form>
	</div>

	<div class="surveyList items">
		<c:forEach var="dto" items="${list }">
			<a href="${cpath }/survey/surveyDetailPage/${dto.survey_idx}">
				<div class="surveyList item">
					<div class="surveyList surveyTitle">${dto.survey_title}</div>
					<div class="surveyList surveyDate subject">조사기간</div>
					<div class="surveyList surveyDate content">${dto.survey_date}</div>
					<div class="surveyList surveyTime subject">응답시간</div>
					<div class="surveyList surveyTime content">${dto.survey_time}</div>
					<div class="surveyList surveyPoint subject">포인트</div>
					<div class="surveyList surveyPoint content">${dto.survey_point}</div>
				</div>
			</a>
		</c:forEach>



	</div>

	<div class="page_wrap">
		<div class="page_nation">
			<c:if test="${paging.prev }">
				<a class="arrow pprev"
					href="${cpath }/survey/list?page=1&survey_targetAge=${survey_targetAge }&survey_targetGender=${survey_targetGender }&survey_targetJob=${survey_targetJob }"></a>
			</c:if>

			<c:if test="${paging.prev }">
				<a class="arrow prev"
					href="${cpath }/survey/list?page=${paging.begin - 1}&survey_targetAge=${survey_targetAge }&survey_targetGender=${survey_targetGender }&survey_targetJob=${survey_targetJob }"></a>
			</c:if>

			<c:forEach var="i" begin="${paging.begin }" end="${paging.end }">
				<a style="font-size: 20px"
					class="${paging.page == i ? 'active' : '' }"
					href="${cpath }/survey/list?page=${i}&survey_targetAge=${survey_targetAge }&survey_targetGender=${survey_targetGender }&survey_targetJob=${survey_targetJob }">${i}</a>
			</c:forEach>

			<c:if test="${paging.next }">
				<a class="arrow next"
					href="${cpath }/survey/list?page=${paging.end + 1}&survey_targetAge=${survey_targetAge }&survey_targetGender=${survey_targetGender }&survey_targetJob=${survey_targetJob }"></a>
			</c:if>

			<c:if test="${paging.next }">
				<a class="arrow nnext"
					href="${cpath }/survey/list?page=${paging.pageCount }&survey_targetAge=${survey_targetAge }&survey_targetGender=${survey_targetGender }&survey_targetJob=${survey_targetJob }"></a>
			</c:if>
		</div>
	</div>
</div>

<div class="space"></div>
<%@ include file="../footer.jsp" %>


</body>
</html>