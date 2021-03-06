<%@page import="java.util.Locale"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<title>Insert title here</title>
<style>
* {
	margin: 0px;
	padding: 0px;
	font-family: 'NanumSquareRound', sans-serif;
}

div {
	margin: 0px auto;
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

.center-label {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	font-size: 30px
}

.planDiv {
	width: 1200px;
	border-radius: 10px;
	margin: 10px 0 0 0;
}

.planTop {
	background-color: gray;
	width: 1200px;
	height: 30px;
	border-radius: 10px;
	text-align: center;
	vertical-align: center;
	display: table;
}

.planTopInner {
	display: table-cell;
	vertical-align: middle;
	color: white;
	font-size: 25px;
}

.dayDiv {
	background-color: #39A2D8;
	width: 1200px;
	height: 30px;
	border-radius: 10px;
	border-color: #39A2D8;
	color: white;
}

.dayP {
	margin: 10px 0 0 5px;
}

.contentDiv {
	width: 1200px;
	height: 30px;
	border: 1px solid gray;
	border-radius: 10px;
	background-color: #33cc33;
	color: white;
}

.contentP {
	margin: 5px 0 0 5px;
}

.contentTextDiv {
	width: 1200px;
	border-radius: 10px;
}

.textarea {
	width: 1200px;
	height: 100px;
}

.bottomButtons{
	width : 200px;
	height: 50px;
	background-color: #ff9933;
	color: white;
	font-size: 25px;
	border: 1px solid #ff9933;
}
</style>

<script type="text/javascript">
	$(document).on('click','#tempSaveBtn',function() {
		
//		console.log(jsonArr);
	});
	
	$(function(){
		$('#form').on('submit', function(e){
			var jsonArr = [];
			var wrapper = $(".wrapper");
			jQuery.each(wrapper, function(index, value) {
				jsonArr.push({
					"dayvalue" : $(value).children(".contentTextDiv").children().attr('dayValue'),
					"areaCode" : $(value).children(".contentTextDiv").children().attr('areaCode'),
					"areaName" : $(value).children(".contentTextDiv").children().attr('areaName'),
					"sigunguCode" : $(value).children(".contentTextDiv").children().attr('sigunguCode'),
					"sigunguName" : $(value).children(".contentTextDiv").children().attr('sigunguName'),
					"contentId" : $(value).children(".contentTextDiv").children().attr('contentId'),
					"elemTitle" : $(value).children(".contentDiv").children(".contentP").text().trim(),
					"mapx" : $(value).children(".contentTextDiv").children().attr('mapx'),
					"mapy" : $(value).children(".contentTextDiv").children().attr('mapy'),
					"imagePath" : $(value).children(".contentTextDiv").children().attr('imagePath'),
					"detail" : $(value).children(".contentTextDiv").children().val()
				});
			});
			var jsonString = JSON.stringify(jsonArr);
			$("#jsonString").val(jsonString);
			alert("저장이 완료되었습니다.");
			return true;
		});
	});
</script>
</head>
<body>
	<%
		// date calculating start
		request.setCharacterEncoding("UTF-8");
		String title = request.getParameter("title");
		String jsonString = request.getParameter("jsonArr");
		String date = request.getParameter("date");
		date = date.replace("-", "/");
		String paraDay = "";
		System.out.println("date parameter : " + date);
			System.out.println("jsonString : " + jsonString);
		
		JSONArray ja1 = new JSONArray(jsonString);
		JSONObject lastObj = ja1.getJSONObject(ja1.length()-1);
		System.out.println("dayValue in plannerDetail : " + lastObj.get("dayvalue"));
		int max = Integer.parseInt((String) lastObj.get("dayvalue"));
		
		System.out.println("date : " +date);
		Date firstDay = new SimpleDateFormat("yyyy/MM/dd").parse(date);
		String strFirstDay = new SimpleDateFormat("yyyy/MM/dd").format(firstDay);
			//System.out.println(strFirstDay);
		
		Calendar cal = new GregorianCalendar(Locale.KOREA);
		cal.setTime(firstDay);
		cal.add(Calendar.DAY_OF_YEAR, max-1);
		Date lastDay = cal.getTime();
		String strLastDay = new SimpleDateFormat("yyyy/MM/dd").format(lastDay);
			//System.out.println(strLastDay);
		
		for(int i = 0; i < ja1.length(); i++) {
			JSONObject jo1 = ja1.getJSONObject(i);
			int dayValue = Integer.parseInt((String)jo1.get("dayvalue"));
			Date dayf = new SimpleDateFormat("yyyy/MM/dd").parse(date);
			Calendar calendar = new GregorianCalendar(Locale.KOREA);
			cal.setTime(dayf);
			cal.add(Calendar.DAY_OF_YEAR, dayValue);
			Date day = cal.getTime();
			String strDay = new SimpleDateFormat("yyyy/MM/dd").format(day);
			paraDay += "," + strDay;			
		}
		paraDay = paraDay.substring(1, paraDay.length());
			//System.out.println("paraDay : " + paraDay);
		// date calculating end
		int status = 0;
		if(request.getParameter("status") != null){
			status = Integer.parseInt(request.getParameter("status"));
		}
		String sl_code = "";
		if(request.getParameter("sl_code") != null){
			sl_code = request.getParameter("sl_code");
		}
				
	%>

	<div class="section">
		<div class="main-image">
			<img id="center-image" alt="centerimage" src="images/korea1.jpg">
			<div class="center-label">
				<!-- 텍스트 ! -->
			</div>
		</div>

		<div class="pageDesc">
			<br>
			<h2><%=title%></h2>
			<br> 
			<h3><%=strFirstDay %> ~ <%= strLastDay %></h3><br>
		</div>
		
	
		<div class="planDiv">
			<form action="insertPlanAction.do" id="form" method="post">
				<div class="planTop">
				<input type="hidden" name="email" value="<%=session.getAttribute("email")%>">
				<input type="hidden" name="title" value="<%=title %>">
				<input type="hidden" name="firstDate" value="<%=strFirstDay %>">
				<input type="hidden" name="lastDate" value="<%=strLastDay %>">
				<input type="hidden" name="jsonString" id="jsonString">
				<input type="hidden" name="strDays" id="strDays" value="<%=paraDay%>">
				<input type="hidden" name="sl_code" id="sl_code" value="<%=sl_code%>">
				<input type="hidden" name="status" id="status" value="<%=status%>">
					<div class="planTopInner">PLAN</div>
				</div>
				<%
					JSONArray ja = new JSONArray(jsonString);
					JSONObject firstObj = ja.getJSONObject(0);
					String min = (String) firstObj.get("dayvalue");
				%>
				<div class="dayDiv">
					<p class="dayP">
						Day
						<%=min%>
					</p>
				</div>
				<%
						String slcode = " ";
						String smcode = " ";
						String sscode = " ";
					for (int i = 0; i < ja.length(); i++) {

						JSONObject jo = ja.getJSONObject(i);
						String dayValue = (String) jo.get("dayvalue");
						String areaCode = (String) jo.get("areaCode");
						String areaName = (String) jo.get("areaName");
						String sigunguCode = (String) jo.get("sigunguCode");
						String sigunguName = (String) jo.get("sigunguName");
						String planTitle = (String) jo.get("elemTitle");
						String contentId = (String) jo.get("contentId");
						String mapx = (String) jo.get("mapx");
						String mapy = (String) jo.get("mapy");
						String imagePath = (String) jo.get("imagePath");
						if(jo.get("slcode") != null){
							slcode = (String) jo.get("slcode");
						}
						if(jo.get("smcode") != null){
							smcode = (String) jo.get("smcode");
						}
						if(jo.get("sscode") != null){
							sscode = (String) jo.get("sscode");
						}
						if (!dayValue.equals(min)) {
							min = dayValue;
				%>
				<div class="dayDiv">
					<p class="dayP">
						Day
						<%=dayValue%>
					</p>
				</div>
				<div class="wrapper">
					<div class="contentDiv">
						<input type="hidden" name="jsonArr" id="jsonArr">
						<p class="contentP">
							<%=planTitle%>
						</p>
					</div>

					<div class="contentTextDiv">
						<textarea class="textarea" dayValue="<%=dayValue%>"
							areaCode="<%=areaCode%>" areaName = "<%=areaName %>" sigunguCode="<%=sigunguCode%>" sigunguName="<%=sigunguName %>"
							planTitle="<%=planTitle%>" contentId="<%=contentId%>" mapx="<%=mapx%>" mapy="<%=mapy%>" imagePath="<%=imagePath%>"
							slcode="<%=slcode%>" smcode="<%=smcode%>" sscode="<%=sscode%>"></textarea>
					</div>
				</div>
				<%
					} else {
				%>
				<div class="wrapper">
					<div class="contentDiv">
						<input type="hidden" name="jsonArr" id="jsonArr">
						<p class="contentP">
							<%=planTitle%>
						</p>
					</div>

					<div class="contentTextDiv">
						<textarea class="textarea" dayValue="<%=dayValue%>"
							areaCode="<%=areaCode%>" areaName = "<%=areaName %>" sigunguCode="<%=sigunguCode%>" sigunguName="<%=sigunguName %>"
							planTitle="<%=planTitle%>" contentId="<%=contentId%>" mapx="<%=mapx%>" mapy="<%=mapy%>" imagePath="<%=imagePath%>"
							sl_code="<%=slcode%>" sm_code="<%=smcode%>" ss_code="<%=sscode%>"></textarea>
					</div>
				</div>
				<%}
				}%>
				<br>
				<center>
					<input type="submit" value="저장" class="bottomButtons">
				</center>
			</form>
		</div>
		<div class="bottom">
		</div>
		
		
	</div>
</body>
</html>
<%@ include file="footer.jsp"%>