<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cpath"  value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://webfontworld.github.io/yangheeryu/Dongle.css" rel="stylesheet">
    <title>자연에 설문을 담다 지아고 입니다.</title>

<link rel="stylesheet" href="${cpath }/resources/css/header.css" type="text/css">

</head>
<body>

<header>

   <div id="root">
      
      <div class="logo">
          <a href="${cpath }/"><img src="${cpath }/resources/img/logo.png" class="logoImg"></a>
      </div>
      
      <div class="nav">
          <ul>
              <li><a href="${cpath }/">홈</a></li>
              <li><a href="${cpath }/survey/list?survey_targetAge=&survey_targetGender=&survey_targetJob=">설문참여</a></li>
              <li><a href="${cpath }/donate/donateList">나무심기</a></li>
              <li><a href="${cpath }/cuscenter">고객센터</a></li>
         	  <c:if test="${not empty login }">
                    <c:if test="${login.user_type eq 'Admin'}">
                    	<li><a href="${cpath }/manage/manageHome">설문관리</a></li></c:if>  
              </c:if>       
          </ul>
      </div>
            
      <div class="loginBar">
             <c:choose>
           <c:when test="${empty login }">
              <span class="login"><a href="${cpath }/user/login">로그인</a></span>
              <span class="join"><a href="${cpath }/user/join">회원가입</a></span>
           </c:when>
           <c:otherwise>
              <span><a href="${cpath }/user/mypageHome"><b style="color:red">${login.user_name }</b>님 환영합니다</a></span>
              <span><a href="${cpath }/user/logout">로그아웃</a></span>
           </c:otherwise>
        </c:choose>
      </div>
     
      </div>
</header>   
   