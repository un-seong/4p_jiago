<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<link rel="stylesheet" href="${cpath }/resources/css/footer/footer.css" type="text/css">

<div id="main">
	<div id="fBody">
		<div id="fRoot">
			<div class="intro_title">
				<div id="intro_box1">
					<div class="bIntro_title">회사소개</div>
					<div class="sIntro_title">No.1 온라인서치, 지아고를 소개합니다.</div>
					<div class="intro_tab">
						<ul>
							<li>
								<a href="#intro_box1">
									<span class="intro_span">개요</span>
								</a>
							</li>
							<li>
								<a href="#intro_box2">
									<span class="intro_span">연혁</span>
								</a>
							</li>
							<li>
								<a href="#intro_box3">
									<span class="intro_span">경영이념</span>
								</a>
							</li>
						</ul>
					</div>
					<div class="mIntro_title">개요</div>
					<div class="intro_img">
						<img src="${cpath }/resources/img/지아고로비.png">	
					</div>
					<div class="intro_main">
						<dl>
							<dt>설립</dt>
							<dd>1996.01</dd>
						</dl>
						<dl>
							<dt>대표</dt>
							<dd>유지은 (하버드대학교 Harvard University 컴퓨터공학 박사)</dd>
						</dl>
						<dl>
							<dt>매출</dt>
							<dd>1조2000억 (FY22: 2021.07~2022.06)</dd>
						</dl>
						<dl>
							<dt>직원</dt>
							<dd>1250명 (2023년 1월 기준)</dd>
						</dl>
						<dl>
							<dt>본사</dt>
							<dd>부산광역시 해운대구 센텀2로 25 센텀드림월드 11층</dd>
						</dl>
					</div>
					<div class="intro_img2">
						<img src="${cpath }/resources/img/매출액.jpg">	
					</div>
				</div>
				<div id="intro_box2">
					<div class="mIntro_title">연혁</div>
					<div class="intro_img3">
						<img src="${cpath }/resources/img/지아고연혁2.jpg">	
					</div>
				</div>
				<div id="intro_box3">
					<div class="mIntro_title">경영이념</div>
					<div class="itro_img4">
						<img src="${cpath }/resources/img/경영이념.jpg">	
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../footer.jsp" %>
</body>
</html>