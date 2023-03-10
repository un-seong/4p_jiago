<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../manage/manageHeader.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SurveyList</title>
<link rel="stylesheet" href="${cpath }/resources/css/survey/surveyManage.css" type="text/css">
</head>
<body>
   
   
   <div id="root">
   <h1>설문 목록</h1>
      <table class="surveyManage surveyList">
         <thead>
            <tr>
               <th>설문 번호</th>
               <th>회사 번호</th>
               <th>설문 제목</th>
               <th>조사 기간</th>
            </tr>
         </thead>
         
         <tbody>
            <c:forEach var="dto" items="${list }">
               <tr onclick="location.href = '${cpath }/survey/surveyView/${dto.survey_idx}'">
                  <td>${dto.survey_idx}</td>
                  <td>${dto.company_idx}</td>
                  <td>${dto.survey_title}</td>
                  <td>${dto.survey_date}</td>
               </tr>
            </c:forEach>
         </tbody>
      </table>
      <div class="img_survey"><a href="${cpath }/survey/surveyAdd"><img src="${cpath }/resources/img/설문추가.png">설문 추가</a></div>
      
      <div class="page_wrap">
          <div class="page_nation">
            <c:if test="${paging.prev }">
               <a class="arrow pprev" href="${cpath }/survey/surveyManage?page=1&check=${value }"></a>
            </c:if>   
          
            <c:if test="${paging.prev }">
               <a class="arrow prev" href="${cpath }/survey/surveyManage?page=${paging.begin - 1}&check=${value }">
               
               </a>
            </c:if>
            
            <c:forEach var="i" begin="${paging.begin }" end="${paging.end }">
               <a style="font-size: 20px" class="${paging.page == i ? 'active' : '' }" 
                  href="${cpath }/survey/surveyManage?page=${i}&check=${value }">${i}</a>
            </c:forEach>
            
            <c:if test="${paging.next }">
               <a class="arrow next" href="${cpath }/survey/surveyManage?page=${paging.end + 1}&check=${value }"></a>
            </c:if>
            
            <c:if test="${paging.next }">
               <a class="arrow nnext" href="${cpath }/survey/surveyManage?page=${paging.pageCount }&check=${value }"></a>
            </c:if>   
         </div>
      </div>
    </div>


</body>
</html>