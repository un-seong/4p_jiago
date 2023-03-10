<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>


<div id="bBody">
   <div id="bRoot">
      <div class="qboard_title">
         <div class="qboard_title_L"><a href="${cpath }/board/list?qboard_title=">질문게시판</a></div>
         <div class="qboard_title_R">Home > 고객센터 > 질문게시판</div>
      </div>
      
      <div class="search">
         <form>
               <input id="input1" type="text" name="qboard_title" placeholder="제목을 입력하세요" value="${qboard_title }"/>
               <input id="input2" type="submit" value="검색"/>
         </form>         
      </div>
         
      
      <div id="lRoot">
         <table id="boardList">
            <thead>
               <tr>
                  <th>게시판 번호</th>
                  <th>제목</th>
                  <th>작성자</th>
                  <th>작성날짜</th>
                  <th>조회수</th>
               </tr>
            </thead>
            
            <tbody>
            <c:forEach var="dto" items="${list }">
            <tr>
               <td>${dto.qboard_idx }</td>
               <td>
               <c:if test="${dto.qboard_privacy eq 'N' }">
                  <img style="height: 17px" src="${cpath }/resources/img/자물쇠3.png">
                  <c:choose>
                     <c:when test="${login.user_id == dto.qboard_writer || login.user_type == 'Admin'}">
                        <a href="${cpath}/board/view/${dto.qboard_idx}"><c:out value="${dto.qboard_title }"></c:out></a>
                     </c:when>
                     <c:otherwise><a style="font-weight: bolder">비밀글은 작성자와 관리자만 볼수 있습니다!</a></c:otherwise>
                  </c:choose>
               </c:if>
               <c:if test="${dto.qboard_privacy eq 'Y' }">
                  <a href="${cpath}/board/view/${dto.qboard_idx}"><c:out value="${dto.qboard_title }"></c:out></a>
               </c:if>
               </td>
               <td>${dto.qboard_writer }</td>
               <td><fmt:formatDate value="${dto.qboard_date }"/></td>
               <td>${dto.qboard_view }</td>
               
            </tr>
            </c:forEach>
            </tbody>
         </table>
         
         <div class="page_wrap">
          <div class="page_nation">
            <c:if test="${paging.prev }">
               <a class="arrow pprev" href="${cpath }/board/list?page=1&qboard_title=${qboard_title}"></a>
            </c:if>   
          
            <c:if test="${paging.prev }">
               <a class="arrow prev" href="${cpath }/board/list?page=${paging.begin - 1}&qboard_title=${qboard_title}"></a>
            </c:if>
            
            <c:forEach var="i" begin="${paging.begin }" end="${paging.end }">
               <a style="font-size: 20px" class="${paging.page == i ? 'active' : '' }" 
                  href="${cpath }/board/list?page=${i}&qboard_title=${qboard_title}">${i}</a>
            </c:forEach>
            
            <c:if test="${paging.next }">
               <a class="arrow next" href="${cpath }/board/list?page=${paging.end + 1}&qboard_title=${qboard_title}"></a>
            </c:if>
            
            <c:if test="${paging.next }">
               <a class="arrow nnext" href="${cpath }/board/list?page=${paging.pageCount }&qboard_title=${qboard_title}"></a>
            </c:if>   
         </div>
        </div>
        <div>
           <div class="boardNoticeWrite_button"><a href="${cpath }/board/write">작성</a></div>
        </div>
     </div>
   </div>
</div>
</body>
</html>