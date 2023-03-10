<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>

<div id="cuscenterBody">
   <div class="cuscenter_img">
      <img src="${cpath }/resources/img/고객센터.png">
   </div>

   <div class="serviceBox">
      <div class="noticeBox">
         <a href="${cpath }/notice/list?notice_name="><img src="${cpath }/resources/img/공지사항.png">공지사항</a>
      </div>
      <div class="noticeBox">
         <a href="${cpath }/board/list?qboard_title="><img src="${cpath }/resources/img/질문게시판.png">질문게시판</a>
      </div>
   </div>
</div>
</body>
</html>