<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../manage/manageHeader.jsp" %>



	<div id="companyAdd_root">
		<form class="company_Add" method="POST">
			<h1>회사 추가</h1>
			
			<span>회사 아이디</span>
			<p><input type="text" placeholder="회사 아이디" name="company_id"  required></p> 
			
			<span>회사 이름</span>
		    <p><input type="text" placeholder="회사 이름" name="company_name" required></p> 
			
			<span>회사 전화번호</span>
		    <p><input type="text" placeholder="회사 전화번호" name="company_num" required /></p>
		
			<span>사업자등록번호</span>
		    <p><input type="text" name="company_registnum" placeholder="사업자등록번호"required/></p>
		
			<span>주소</span>
		    <p><input type="text" name="company_address" placeholder="주소"required/></p>
		    
		    <span>이메일</span>
		    <p><input type="text" name="company_email" placeholder="이메일"required/></p>
		    
			<p class="companyAdd_button"><input type="submit" value="회사 추가하기"></p>
		</form>
	</div>
</div>

</body>
</html>