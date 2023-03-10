<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath"  value="${pageContext.request.contextPath }"/>

<%@ include file="../manage/manageHeader.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="${cpath }/resources/css/survey/surveyDetailPage.css" type="text/css">
</head>
<body>


<div id="companyModify_root">
   <form class="company_Modify" method="POST">
      <h1>회사 수정</h1>
         
      <span>회사 번호</span>
      <p><input type="number" name="company_idx" min="0" value="${dto.company_idx}" readonly="readonly"></p>	
      
      <span>회사 아이디</span>
      <p><input type="text" name="company_id" value="${dto.company_id}" readonly="readonly"></p>
       
      <span>회사 이름</span>
      <p><input type="text" name="company_name" value="${dto.company_name}" readonly="readonly" ></p>
       
      <span>회사 전화번호</span>
      <p><input type="text" name="company_num" value="${dto.company_num}" required ></p>
      
      <span>사업자등록번호</span>   
      <p><input type="text" name="company_registnum" value="${dto.company_registnum}" required ></p>
      
      <span>주소</span>
      <p><input type="text" name="company_address" value="${dto.company_address}" required></p>
      
      <span>이메일</span>
      <p><input type="text" name="company_email" value="${dto.company_email}" required></p>
      
      
      <p class="companyModify_button"><input type="submit" value="회사 정보 수정하기"></p>
      
   </form>
</div>

</body>
</html>