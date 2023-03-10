<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<div id="boardNoticeAdd_Root">
<form class="boardNoticeAdd_form" method="POST">
   <span>제목</span>
   <p><input type="text" name="notice_name" placeholder="제목" value="${dto.notice_name }" required></p>
   <span>글쓴이</span>
   <p><input type="text" name="notice_admin" value="${dto.notice_admin }" readonly></p>
   <span>내용</span>
   <p><textarea name="notice_content" placeholder="내용" required>${dto.notice_content }</textarea></p>
   <p class="boardNoticeAdd_button"><input type="submit" value="수정"></p>
</form>
</div>

</body>
</html>