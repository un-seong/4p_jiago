<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../manage/manageHeader.jsp" %>
 
   
   <div id="root">
   <h1>설문별 통계보기</h1>
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
               <tr onclick="location.href = '${cpath }/manage/surveyDetailResult/${dto.survey_idx}'">
                  <td>${dto.survey_idx}</td>
                  <td>${dto.company_idx}</td>
                  <td>${dto.survey_title}</td>
                  <td>${dto.survey_date}</td>
               </tr>
            </c:forEach>
         </tbody>
      </table>
      
      <div class="page_wrap">
          <div class="page_nation">
            <c:if test="${paging.prev }">
               <a class="arrow pprev" href="${cpath }/manage/surveyResultList?page=1"></a>
            </c:if>   
          
            <c:if test="${paging.prev }">
               <a class="arrow prev" href="${cpath }/manage/surveyResultList?page=${paging.begin - 1}&check=${value }">
               
               </a>
            </c:if>
            
            <c:forEach var="i" begin="${paging.begin }" end="${paging.end }">
               <a style="font-size: 20px" class="${paging.page == i ? 'active' : '' }" 
                  href="${cpath }/manage/surveyResultList?page=${i}">${i}</a>
            </c:forEach>
            
            <c:if test="${paging.next }">
               <a class="arrow next" href="${cpath }/manage/surveyResultList?page=${paging.end + 1}"></a>
            </c:if>
            
            <c:if test="${paging.next }">
               <a class="arrow nnext" href="${cpath }/manage/surveyResultList?page=${paging.pageCount }"></a>
            </c:if>   
         </div>
      </div>
    </div>
</div>

</body>
</html>