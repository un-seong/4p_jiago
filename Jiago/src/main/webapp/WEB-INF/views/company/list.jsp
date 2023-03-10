<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../manage/manageHeader.jsp"%>
<div id="company_root">

	<h1>회사 목록</h1>

	<div class="search">
		<form>
			<input id="add_input" type="text" name="company_name"
				placeholder="조회할 회사이름을 적어주세요" value="${company_name }" /> <input
				id="add_input2" type="submit" value="검색" />
		</form>
	</div>

	<form method="POST" action="${cpath }/memberAjax" class="delForm">
		<table class="companyManage companyList">
			<thead>
				<tr>
					<th><input type="checkbox" name="checkAll" id="th_checkAll" />
					</th>
					<th>회사 번호</th>
					<th>회사 이름</th>
					<th>회사 전화번호</th>
					<th>사업자등록번호</th>
					<th>주소</th>
					<th>이메일</th>
					<th>수정</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${list }">
					<tr>
						<td><input type="checkbox" name="checkRow"
							value="${dto.company_idx}"></td>
						<td>${dto.company_idx}</td>
						<td>${dto.company_name}</td>
						<td>${dto.company_num}</td>
						<td>${dto.company_registnum}</td>
						<td>${dto.company_address}</td>
						<td>${dto.company_email}</td>
						<td class="company_modi"><a
							href="${cpath }/company/modify/${dto.company_idx}"><img
								src="${cpath }/resources/img/수정.png"></a></td>

					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="delete_button hidden">
			<input type="submit" value="삭제">
		</div>

	</form>

	<div class="img_survey">
		<a href="${cpath }/company/add"><img
			src="${cpath }/resources/img/설문추가.png">회사 추가</a>
	</div>



	<div class="page_wrap">
		<div class="page_nation">
			<c:if test="${paging.prev }">
				<a class="arrow pprev"
					href="${cpath }/company/list?page=1&company_name=${company_name}"></a>
			</c:if>

			<c:if test="${paging.prev }">
				<a class="arrow prev"
					href="${cpath }/company/list?page=${paging.begin - 1}&company_name=${company_name}">

				</a>
			</c:if>

			<c:forEach var="i" begin="${paging.begin }" end="${paging.end }">
				<a style="font-size: 20px"
					class="${paging.page == i ? 'active' : '' }"
					href="${cpath }/company/list?page=${i}&company_name=${company_name}">${i}</a>
			</c:forEach>

			<c:if test="${paging.next }">
				<a class="arrow next"
					href="${cpath }/company/list?page=${paging.end + 1}&company_name=${company_name}"></a>
			</c:if>

			<c:if test="${paging.next }">
				<a class="arrow nnext"
					href="${cpath }/company/list?page=${paging.pageCount }&company_name=${company_name}"></a>
			</c:if>
		</div>
	</div>
</div>


<script src="${cpath }/resources/js/company/list.js"></script>


<script>
           
        delForm.onsubmit = delMember

</script>



</body>
</html>