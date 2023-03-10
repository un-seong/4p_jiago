<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<link rel="stylesheet"
	href="${cpath }/resources/css/donateList/donateList.css"
	type="text/css">


<div class="main2">
	<div class="donate">
		<div class="donate_topImg">
			<img src="${cpath }/resources/img/donateList_top.png">
		</div>
		<div class="donate_total">
			<div class="left">
				<div class="donate_subtitle">총 기부금액</div>
				<div class="donate_value">
					<fmt:formatNumber value="${sum }" pattern="#,###원" />
				</div>
			</div>
			<div class="right">
				<div class="donate_subtitle">심은 나무수</div>
				<div class="donate_value">${tree }그루</div>
			</div>
		</div>
		<hr>
		<div class="give">
			<div class="left">
				<img src="${cpath }/resources/img/나무 이미지.png" width="300px">
			</div>
			<div class="right">
				<div class="joinPerson">현재 ${count }명 참여중</div>
				<c:choose>
					<c:when test="${not empty login }">
						<div class="currentPoint">
							<c:choose>
								<c:when test="${not empty point }">
									<h1 class="currentPoint_User">
										당신의 포인트는 : <span><fmt:formatNumber value="${point }"
												pattern="#,###원" /></span>
									</h1>
									<form method="POST" action="${cpath }/donate/donateList">
										<input type="number" class="donate_input" id="point"
											name="total_donate" placeholder="포인트 입력" min="0"
											max="${point }" step="100">
										<button type="submit">기부하기</button>
									</form>
								</c:when>
								<c:otherwise>
									<h1 class="nonePoint_User">설문에 참여하고, 기부에 동참해보세요!</h1>
								</c:otherwise>
							</c:choose>
						</div>

					</c:when>

					<c:otherwise>
						<h1>로그인을 하고, 기부에 동참해보세요!</h1>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="donate_detail">
			<button type="button">자세히 보기</button>
		</div>
	</div>
</div>
<div class="add">
	<img src="${cpath }/resources/img/donateList.png">
</div>


<div class="modal hidden">
	<div class="modal_background"></div>
	<div class="modal_content">
		<h3>월별 기부 내역</h3>
		<div class="donateList">
			<table class="donateListTable">
				<thead>
					<tr>
						<th>기부 월</th>
						<th>참여자 수</th>
						<th>기부 금액</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="dto" items="${list }">
						<tr>
							<td>${dto.month }</td>
							<td>${dto.member }명</td>
							<td><fmt:formatNumber value="${dto.total }" pattern="#,###원" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="closeButton">
			<button name="close">닫기</button>
		</div>
	</div>

</div>

<%@ include file="../footer.jsp"%>

<script src="${cpath }/resources/js/donate/donateList.js"></script>

<script>
	openButton.addEventListener("click", displayModal);
	closeButton.addEventListener("click", closeHandler)
	modalBackground.addEventListener("click", closeHandler);

	form.onsubmit = formHandler
</script>

</body>
</html>