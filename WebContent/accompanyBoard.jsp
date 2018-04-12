<%@page import="java.util.ArrayList"%>
<%@page import="dao.AccompanyBoardDto"%>
<%@page import="dao.AccompanyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/innks/NanumSquareRound/master/nanumsquareround.min.css">
<link href="css/accompanyBoardCSS.css" rel="stylesheet" type="text/css" media="all">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">

div {
	margin: 0px auto;
}

* {
	padding: 0px;
	margin: 0px;
	font-family: 'NanumSquareRound', sans-serif;
}

.section {
	width: 1200px;
}

.main-image {
	border-radius: 5px;
	margin-left: auto;
	margin-right: auto;
	width: 100%;
	height: 400px;
	overflow: hidden;
	position: relative;
}

.centerimage {
	min-height: 100%;
	min-width: 100%;
	width: 100%;
	height: auto;
}

.section-card {
	width: 100%;
	margin-top: 35px;
	margin-left: auto;
	margin-right: auto;
	display: inline-block;
	border: solid;
	border-color: #F6F6F6;
}

.pagenumber {
	width: 1080px;
	height: 100px;
}

.pagenumber {
	margin-top: 30px;
	text-align: center;
}

.footer_wrap {
	padding-top: 20px;
	margin-left: auto;
	margin-right: auto;
	margin-left: auto;
}

.container {
	padding: 15px;
	height: 150px;
	clear: both;
}

.card {
	height: 400px;
	width: 350px;
	border: solid;
	border-radius: 10px;
	border-color: #F6F6F6;
	display: inline-block;
	margin-left: 30px;
	margin-bottom: 30px;
	position: relative;
}

.card:hover {
	border-color: #A6A6A6
}

.pagination {
	display: flex;
	justify-content: center;
	margin: 50px 0 35px 0;
	clear: both;
}

.pagination a {
	color: black;
	padding: 8px 16px;
	font-size: 20px;
	text-decoration: none;
}

.pagination a.active {
	background-color: #4CAF50;
	color: white;
}

.pagination a:hover:not {
	background-color: #ddd;
	border-radius: 5px;
}

.card-image {
	width: 300px;
	height: 60%;
}

.container {
	padding: 15px;
	height: 40%;
	border: solid;
}

.search {
	display: inline-flex;
	clear: both;
}

.search-bar {
	font-size: 15px;
	width: 400px;
	height: 30px;
}

.search-submit {
	font-size: 15px;
	width: 70px;
	background-color: #AA1212;
	color: white;
}

.search-select {
	font-size: 15px;
	margin-right: 5px;
}

.align {
	margin-top: 30px;
	width: 100%;
	margin-left: auto;
	margin-right: auto;
}

.align button {
	width: 100px;
	height: 30px;
}

.center-label {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	font-size: 30px
}

.write-button {
	width: 70px;
	height: 30px;
	display: flex;
	float: right;
	font-size: 15px;
	justify-content: center;
	margin-top: 20px;
}
</style>

</head>
<body>

	<div class="section">
		<div class="main-image">
			<img id="center-image" alt="centerimage" src="images/korea1.jpg">
			<div class="center-label">
				<!-- 텍스트 ! -->
			</div>
		</div>
		<div class="align">
			<button>조회순</button>
			<button>인기순</button>
			<button>최신순</button>
		</div>
		<div class="section-card">
			
		<c:forEach var="board" items="${list }">
			<a href="viewActionAB.do?post_num=${board.post_num }">
			<div class="card">
				<!-- 카드 헤더 -->
				<div class="card-header" style="background: url('${board.image_url}'); background-size: 100% 280px; background-repeat: no-repeat;">
					
					<div class="card-header-is_closed">
						<c:if test="${board.is_closed == 0 }">
							<div class="card-header-text">모집중</div>
							<div class="card-header-number">${board.current_num } / ${board.minimum_num }</div>
						</c:if>
						<c:if test="${board.is_closed == 1 }">
							<div class="card-header-text">마감</div>
							<div class="card-header-number">${board.current_num } / ${board.minimum_num }</div>
						</c:if>
					</div>
				</div>
				<!--  카드 바디 -->
				<div class="card-body">
					<!--  카드 바디 헤더 -->
					<div class="card-body-header">
						<p style="overflow: hidden"><h2>제목: ${board.title }</h2></p>
						<c:set var="tags" value="${fn:split(board.tag, ' ')}"/>
						<div class="card-body-hashtag">
								<c:forEach var="t" items="${tags }">
									<c:out value="${t }"></c:out>
								</c:forEach>
						</div>
						<p class="card-body-nickname">작성자: ${board.nickname }</p>
					</div>
					<!--  카드 바디 본문 -->
					<textarea class="card-body-description" rows="7" disabled="disabled" style="background-color: white; width:87%; border:none; overflow:hidden; resize: none">${board.content }</textarea>
					<!--  카드 바디 푸터 -->
					<div class="card-body-footer">
						<hr style="margin-bottom: 8px; opacity: 0.5; border-color: #EF5A31">
						<i class="icon icon-view_count"></i>조회 ${board.view_count }회 
						<i class="icon icon-comments_count"></i>댓글 ${board.comment_count }개
						<i class="reg_date"></i>${board.post_date }
					</div>
				</div>
			</div>
			</a>
			</c:forEach>
			</div>
				<!--section card -->
				<div>
					<c:if test="${email != null }">
						<a href="writeFormAB.jsp"><button class="write-button">글쓰기</button></a>
					</c:if>
				</div>
				<div class="pagination">
					
					<c:if test="${startPage!=1 }">
						<a href='listAction.do?pageNum=${startPage-blockSize }'>&laquo;</a>
					</c:if>
					<c:if test="${startPage==1 }">
						<a href='listAction.do?pageNum=1'>&laquo;</a>
					</c:if>
					<c:if test="${currentPage!=1 }">
						<a href='listAction.do?pageNum=${currentPage-1}'>&#9665</a>
					</c:if>
					<c:if test="${currentPage==1 }">
						<a href='listAction.do?pageNum=1'>&#9665</a>
					</c:if>

					<c:forEach var="i" begin="${startPage }" end="${endPage }">
						<a href='listAction.do?pageNum=${i }'>${i }</a>
					</c:forEach>

					<c:if test="${currentPage==totalPage }">
						<a href='listAction.do?pageNum=${totalPage }'>&#9655</a>
					</c:if>
					<c:if test="${currentPage!=totalPage }">
						<a href='listAction.do?pageNum=${currentPage+1 }'>&#9655</a>
					</c:if>
					<c:if test="${endPage>=totalPage }">
						<a href='listAction.do?pageNum=${totalPage}'>&raquo;</a>
					</c:if>
					<c:if test="${endPage<totalPage }">
						<a href='listAction.do?pageNum=${endPage+blockSize }'>&raquo;</a>
					</c:if>
				</div>
				<div class="search">
					<select class="search-select">
						<option>제목</option>
						<option>지역명</option>
						<option>닉네임</option>
						<option>날짜</option>
					</select> 
					<input type="text" class="search-bar" placeholder="지금 바로 동행을 검색해보세요!">
					<button type="submit" class="search-submit">검색</button>
				</div>
		</div>
		<div class="footer_wrap">
			<%@ include file="footer.jsp"%>
		</div>

		<script type="text/javascript">
						var image = document.getElementById("center-image");
			var current = 0;
			var images = [ "images/korea2.jpg", 
			               "images/korea3.jpg",
						   "images/korea4.jpg", 
						   "images/korea5.jpg",
						   "images/korea1.jpg" ]
			function replacePhoto() {
				++current;
				if (current >= images.length)
					current = 0;
				image.src = images[current];
			}
			setInterval(replacePhoto, 3000);

			var submit = document.getElementByClassName("search-submit");
			function replaceCard() {
				submit.style.color = "Orange";
			}
		</script>
</body>
</html>