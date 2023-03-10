<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../manage/manageHeader.jsp"%>




	<div id="member_root">
	
		<h1>회원 목록</h1>
	
		<div class="search">
			<form>
				<input id="add_input" type="text" name="user_id"
					placeholder="조회할 회원 아이디를 적어주세요" value="${user_id }" /> <input
					id="add_input2" type="submit" value="검색" />
			</form>
		</div>
	
		<form method="POST" action="${cpath }/memberAjax" class="delForm">
			<table class="memberManage memberList">
				<thead>
					<tr>
						<th><input type="checkbox" name="checkAll" id="th_checkAll" />
						</th>
						<th>회원 번호</th>
						<th>회원 타입</th>
						<th>회원 이름</th>
						<th>회원 아이디</th>
						<th>생일</th>
						<th>성별</th>
						<th>주소</th>
						<th>전화번호</th>
						<th>이메일주소</th>
						<th>직업</th>
						<th>가입일</th>
						<th>약관동의여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="dto" items="${list }">
						<tr class="">
							<td><input type="checkbox" name="checkRow"
								value="${dto.user_idx}"></td>
							<td>${dto.user_idx}</td>
							<td>${dto.user_type}</td>
							<td>${dto.user_name}</td>
							<td>${dto.user_id}</td>
							<td>${dto.user_birth}</td>
							<td>${dto.user_gender}</td>
							<td>${dto.user_address}</td>
							<td>${dto.user_phone}</td>
							<td>${dto.user_email}</td>
							<td>${dto.user_job}</td>
							<td>${dto.user_joindate}</td>
							<td>${dto.user_agree}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="delete_button hidden">
				<input type="submit" value="삭제">
			</div>
	
		</form>
	
		<div class="page_wrap">
			<div class="page_nation">
				<c:if test="${paging.prev }">
					<a class="arrow pprev"
						href="${cpath }/member/list?page=1&user_id=${user_id}"></a>
				</c:if>
	
				<c:if test="${paging.prev }">
					<a class="arrow prev"
						href="${cpath }/member/list?page=${paging.begin - 1}&user_id=${user_id}">
	
					</a>
				</c:if>
	
				<c:forEach var="i" begin="${paging.begin }" end="${paging.end }">
					<a style="font-size: 20px"
						class="${paging.page == i ? 'active' : '' }"
						href="${cpath }/member/list?page=${i}&user_id=${user_id}">${i}</a>
				</c:forEach>
	
				<c:if test="${paging.next }">
					<a class="arrow next"
						href="${cpath }/member/list?page=${paging.end + 1}&user_id=${user_id}"></a>
				</c:if>
	
				<c:if test="${paging.next }">
					<a class="arrow nnext"
						href="${cpath }/member/list?page=${paging.pageCount }&user_id=${user_id}"></a>
				</c:if>
			</div>
		</div>
	</div>
</div>

       
     

        <script src="${cpath }/resources/js/member/list.js"></script>

 
	<script>
	checkbox_top.onchange = allCheckHandler
	
	    
	        delForm.onsubmit = delMember
	
	    </script>
</body>

</html>