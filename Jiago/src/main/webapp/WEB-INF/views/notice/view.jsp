<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<script>
   const cpath = '${cpath}'
   const board_idx = '${dto.notice_idx}'
   const login_userid = '${login.user_id}'
</script>
<script src="${cpath }/resources/js/script.js"></script>


<div id="vBody">
   <div id="vRoot">
      <div class="vMDL">
         <div>
            <c:if test="${ login.user_type == 'Admin'}">
               <a href="${cpath }/notice/modify/${dto.notice_idx}"><button class="boardNoticeUpdate_Button">수정</button></a>
               <a href="${cpath }/notice/delete/${dto.notice_idx}"><button class="boardNoticeUpdate_Button">삭제</button></a>
            </c:if>
         </div>
         <div>
            <a href="${cpath }/notice/list?notice_name="><button class="boardNoticeList_button">목록</button></a>
         </div>
      </div>
      <table id="viewList">
         <tr class="viewListTop">
            <td class="bTitle">${dto.notice_name } </td>
            <td class="bWriter">${dto.notice_admin }</td>
         </tr>
         <tr>
            <td class="bContent" colspan="2">
         <pre>${dto.notice_content }</pre>
            </td>
         </tr>
      
      </table>
   </div>
</div>

</body>
</html>