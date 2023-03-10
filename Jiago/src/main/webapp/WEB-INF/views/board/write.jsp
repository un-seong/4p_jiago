<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

   <div id="boardNoticeAdd_Root">
      <form class="boardNoticeAdd_form" method="POST" enctype="multipart/form-data">
         <span>제목</span>
         <p><input type="text" name="qboard_title" placeholder="제목" required></p>
         <span>글쓴이</span>
         <p><input type="text" name="qboard_writer" value="${login.user_id }" readonly></p>
         <span>내용</span>
         <p><textarea name="qboard_content" placeholder="내용" required></textarea></p>
         <span>공개여부</span>
         <p class="boardNotice_Add_radio">
            <label><input type="radio" name="qboard_privacy" value="Y" required>공개</label>
            <label><input type="radio" name="qboard_privacy" value="N" required>비공개</label>
         </p>
         <p class="boardNoticeAdd_button">
            <input type="submit" value="작성">
         </p>
      </form>
   </div>
</body>
</html>