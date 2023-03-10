<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="https://webfontworld.github.io/yangheeryu/Dongle.css" rel="stylesheet">
<link rel="stylesheet" href="${cpath }/resources/css/user/mypage.css" type="text/css">

</head>
<body class="profile_body">
	<div id="giagoid_wrap">
		<header class="header">
			<div class="header_subindex">
				<div class="gnb_area">
					<div class="profile_logo">
						<a href="${cpath }/"><img src="${cpath }/resources/img/logo.png"></a>
					</div>
					<div><h1>지아고ID</h1></div>	
				</div>
				<div class="headerLeft">
					<ul class="leftmenu">
						<li><a href="${cpath }/user/mypageHome">마이페이지 홈</a></li>
						<li><a href="${cpath }/user/mypageSecurity">보안</a></li>
						<li><a href="${cpath }/user/mypageQuit">회원탈퇴</a></li>	
					</ul>
				</div>
				<div class="headerLeft2">
					<ul class="leftmenu2">
						<li><a href="${cpath }/notice/list?notice_name="><img src="${cpath }/resources/img/바로가기.png">고객센터 문의하러 가기</a></li>
						<li><a href="${cpath }/board/list?qboard_title="><img src="${cpath }/resources/img/바로가기.png">공지사항 바로가기</a></li>
					</ul>
				</div>
				<div class="headerLeft3">
					<ul class="leftmenu3">
						<li><a><img src="${cpath }/resources/img/알림.png">[보안] 주기적으로 비밀번호를 바꿔주세요!</a></li>
					</ul>
				</div>
				
				<div class="headerLeft4">
					<ul class="leftmenu4">
						<li class="li_JIAGO"><a href="${cpath }">JIAGO</a></li>
						<li class="li_personal"><a href="${cpath }/footer/personalinform">개인정보처리방침</a></li>
						<li class="li_use"><a href="${cpath }/footer/termofuse">이용약관</a></li>
					</ul>
				</div>
				
			</div>
		</header>
