<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>


<div id="boardNoticeAdd_Root">
   <form class="boardNoticeAdd_form" method="POST" enctype="multipart/form-data">
      <span>제목</span>
      <p><input type="text" name="notice_name" placeholder="제목" required></p>
      <span>글쓴이</span>
      <p><input type="text" name="notice_admin" value="${login.user_id }" readonly required></p>
      <span>내용</span>
      <p><textarea name="notice_content" placeholder="내용" required></textarea></p>
      <p class="boardNoticeAdd_button"><input type="submit" value="작성"></p>
   </form>
</div>
</body>
</html>