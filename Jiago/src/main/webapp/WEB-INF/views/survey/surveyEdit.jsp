<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../manage/manageHeader.jsp" %>
    

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SurveyEdit</title>

<link rel="stylesheet" href="${cpath }/resources/css/survey/surveyEdit.css" type="text/css">    

</head>
<body>
   
   
   <div id="root">
   <h1>설문 수정</h1>
      <table class="surveyManage surveyList">
         <thead>
            <tr>
               <th>설문 번호</th>
               <th>회사 번호</th>
               <th>설문 제목</th>
               <th>조사 기간</th>
               <th></th>
            </tr>
         </thead>
         
         <tbody>
            <c:forEach var="dto" items="${list }">
               <tr onclick="location.href = '${cpath }/survey/surveyView/${dto.survey_idx}'">
                  <td>${dto.survey_idx}</td>
                  <td>${dto.company_idx}</td>
                  <td>${dto.survey_title}</td>
                  <td>${dto.survey_date}</td>
                  <td><a href="${cpath }/survey/surveyModify/${dto.survey_idx}"><button>수정</button></a></td>
               </tr>
            </c:forEach>
         </tbody>
      </table>
     
      <div class="page_wrap">
          <div class="page_nation">
            <c:if test="${paging.prev }">
               <a class="arrow pprev" href="${cpath }/survey/surveyEdit?page=1&check=${value }"></a>
            </c:if>   
          
            <c:if test="${paging.prev }">
               <a class="arrow prev" href="${cpath }/survey/surveyEdit?page=${paging.begin - 1}&check=${value }">
               
               </a>
            </c:if>
            
            <c:forEach var="i" begin="${paging.begin }" end="${paging.end }">
               <a style="font-size: 20px" class="${paging.page == i ? 'active' : '' }" 
                  href="${cpath }/survey/surveyEdit?page=${i}&check=${value }">${i}</a>
            </c:forEach>
            
            <c:if test="${paging.next }">
               <a class="arrow next" href="${cpath }/survey/surveyEdit?page=${paging.end + 1}&check=${value }"></a>
            </c:if>
            
            <c:if test="${paging.next }">
               <a class="arrow nnext" href="${cpath }/survey/surveyEdit?page=${paging.pageCount }&check=${value }"></a>
            </c:if>   
         </div>
      </div>
    </div>


</body>
</html>