<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<script>
   const cpath = '${cpath}'
   const qboard_idx = '${dto.qboard_idx}'
   const login_user_id = '${login.user_id}'
   const login_user_idx = '${login.user_idx}'
</script>


<div id="vBody">
   <div id="vRoot">
   
      <div class="vMDL">
      <c:choose>
         <c:when test="${login.user_id == dto.qboard_writer }">
            <div>
               <a href="${cpath }/board/modify/${dto.qboard_idx}"><button class="boardNoticeUpdate_Button">수정</button></a>
               <a href="${cpath }/board/delete/${dto.qboard_idx}"><button class="boardNoticeUpdate_Button">삭제</button></a>
            </div>
         </c:when>
         
         <c:when test="${login.user_type eq 'Admin'}">
             <a href="${cpath }/board/delete/${dto.qboard_idx}"><button class="boardNoticeUpdate_Button">삭제</button></a>
         
         
         </c:when>
      </c:choose>
         
         
         <div class="boardNoticeListButton_div">
            <a href="${cpath }/board/list?qboard_title="><button class="boardNoticeList_button">목록</button></a>
         </div>
        
      </div>
      
      <table id="viewList">
         <tr class="viewListTop">
            <td class="bTitle">${dto.qboard_title } </td>
            <td class="bWriter">${dto.qboard_writer }</td>
            <td class="bView">${dto.qboard_view }</td>
         </tr>
                  
         <tr>
            <td class="bContent" colspan="3"><pre>${dto.qboard_content }</pre></td>
         </tr>
       </table>
       <div class="reply_title">답변</div> 
         <div id="reply">
              <h3>답변은 로그인한 회원만 확인할 수 있습니다.</h3>
            </div>
         
          <c:if test="${login.user_type == 'Admin' }"> 
            <form id="replyWriteForm">
               <p>
                  <textarea name="content" 
                             placeholder="고객님에게 친절하게 댓글을 달아주세요" 
                             ${empty login ? 'readonly' : '' }></textarea>
                  <button class="boardNoticeUpdate_Button" >작성</button>
               </p>
            </form>
           </c:if> 
   </div>
</div>


<script src="${cpath }/resources/js/board/viewscript.js"></script>

<script>
	const replyWriteForm = document.getElementById('replyWriteForm')
	
	document.body.onload = replyLoadHandler
	replyWriteForm.onsubmit = replyWriteHandler
</script>

</body>
</html>