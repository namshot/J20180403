<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="https://cdn.rawgit.com/innks/NanumSquareRound/master/nanumsquareround.min.css">
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
.post-header {
	margin: 20px 0 0 0;
	width: 100%;
	height: 150px;
	border: solid;
	display: flex;
	left: 1em;
 	background-color: #EAEAEA;
}

.post-header-img {
	margin: auto 20px;
	height: 120px;
	width: 120px;
	background-image: url("${profile_url}");
	background-color: white;
	border-radius: 50%;
	background-size: 100% 100%;
	border: solid;
}
.reply-wrapper{
	margin: 20px 0 0 0;
	width: 100%;
	border: solid;
	display: flex;
	left: 1em;
 	background-color: #EAEAEA;
}
.reply-image { 
	margin: auto 20px;
	background-size: 100% 100%; 
	width: 80px; 
	height: 80px; 
	border-radius: 50%;
}

.post-body {
	width: 100%;
	border: solid;
	padding : 1em 0 1em 1em;
}

tr.highlight td {
	padding-top: 1px; 
	padding-bottom: 1px
}

#apply-div {
	position: absolute;
	top:50%;
	left: 50%;
    width: 100%;
    height: 100%;
    background-color: black;
}
</style>
</head>
<body>
	<div id="apply-div" style="display: none">
		<form action="">
			메시지: <textarea rows="5" style="width: 100%"></textarea>
			카카오톡 아이디: <input type="text">
		</form>
	</div>
	<div class="section">
		<div class="main-image">
			<img id="center-image" alt="centerimage" src="images/korea1.jpg">
			<div class="center-label">
				<!-- 텍스트 ! -->
			</div>
		</div>
		
		<div class="post-header">
			<div class="post-header-img"></div>
			<table>
				<tr><td><h2>제목: </h2></td><td><h2>${board.title }</h2></td></tr>
				<tr class="highlight"><td></td><td></td></tr>
				<tr><td>작성자: </td><td>${board.nickname } | 등록일:${board.post_date }</td></tr>
				<tr><td>게시물 번호: </td><td>${post_num }</td></tr>
			</table>
		</div>
		<div class="post-body">
			<pre>${board.content }</pre>
			<img src="${board.image_url }">
		</div>
		<c:if test="${email != null }">
			<button onclick="apply()">동행 신청하기</button>
		</c:if>
		<hr>
		<c:forEach var="reply" items="${list }">
		<div class="reply-wrapper">
			 <div class ="reply-image" style="background-image: url('${reply.profile_url}');"></div>
				<h2>작성자: ${reply.nickname }</h2>
				등록일: ${reply.reply_date }<br>
				<pre>내용: ${reply.content }</pre>
		</div>
		</c:forEach>
		<div class="post-footer">
			<c:if test="${email != null }">
				<form action="writeReplyAB.do">
					<input type="hidden" value="${post_num }"name="post_num">
					<textarea rows="12" style="width: 70%;" name="content"></textarea>
					<input type="submit" value="확인">
				</form>
			</c:if>
			<c:if test="${email == null }">
				<form action="writeReplyAB.do">
					<input type="hidden" value="${post_num }"name="post_num">
					<textarea rows="12" style="width: 70%;" name="content" placeholder="로그인하고 댓글을 작성해 주세요!" disabled></textarea>
				</form>
			</c:if>
		</div>		
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
			
	</script>
	<script type="text/javascript">
	function apply() {
	    var apply_div = document.getElementById("apply-div");
	    if (apply_div.style.display === "none") {
	    	apply_div.style.display = "block";
	    } else {
	    	apply_div.style.display = "none";
	    }
	}
	</script>
</body>
</html>