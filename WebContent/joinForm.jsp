<%@page import="email.EmailConfirm"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style type="text/css">
body {
	font-family: 'NanumSquareRound', sans-serif;
}

div {
	margin: 0px auto;
}

.joinDiv {
	padding-top: 100px;
	padding-bottom: 100px;
	width: 1080px;
	text-align: center;
}

.footer_wrap {
	position: absolute;
	left: 0px;
	width: 100%;
	background-color: #0099ff;
}

.divEmail {
	width: 300px;
	margin-bottom: 5px;
	text-align: left;
}

.inputTypeEmail {
	width: 225px;
	height: 30px;
}

.btnEmailChk {
	width: 70px;
	height: 30px;
	color: white;
	background-color: #1A7AD9;
	border-color: transparent;
}

.confirmCode {
	width: 225px;
	height: 30px;
	margin-right: 4px;
}

.btnConfirm {
	width: 70px;
	height: 30px;
	border-color: transparent;
}

.inputType {
	width: 300px;
	height: 30px;
}

#spanEmail {
	font-size: 13px;
}

#spanNickname {
	font-size: 13px;
}

.pNickname {
	margin-top: 15px;
	margin-bottom: 5px;
}

.pPassword {
	margin-top: 15px;
}

#submit {
	width: 300px;
	height: 40px;
	color: white;
	background-color: #1A7AD9;
	border-color: transparent;
}

p {
	margin-top: 30px;
	margin-bottom: 30px;
}

h1 {
	margin-bottom: 50px;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	var confirmNum = "";

	$(function() {
		$('#email').change(function() {
			var sendData = 'email=' + $('#email').val();
			
			$.post(
				'joinCheck.jsp',
				sendData,
				function(result) {
					$('#spanEmail').html(result);
			});
		});
	});
	
	$(function() {
		$('#nickname').change(function() {
			var sendData = 'nickname=' + $('#nickname').val();
			
			$.post(
				'joinCheck.jsp',
				sendData,
				function(result) {
					$('#spanNickname').html(result);
			});
		});
	});
	
	function emailCheck(email){
		if (!joinForm.email.value) { 
			alert("이메일 주소를 입력하세요.");
			joinForm.email.focus();
			
			return;
		} else if(joinForm.email.value.indexOf('@') < 0 || joinForm.email.value.indexOf('.') < 0) {
			alert("이메일 주소가 올바르지 않습니다.");
			joinForm.email.focus();
			
			return;
		}
		
		joinForm.btnConfirm.value = "확인";
		$("#confirmCode").prop('disabled', false);
		$("#btnConfirm").prop('disabled', false);
		$("#btnConfirm").css('color', 'white');
		$("#btnConfirm").css('background-color', '#1A7AD9');
		
		var sendData = 'email=' + $('#email').val();
		
		$.post(
			'emailCheck.jsp',
			sendData,
			function(result) {
				confirmNum = result.substr(result.indexOf("authNum:")+8, 6);
		});
	}
	
	$(function() {
		$('#btnConfirm').click(function() {
			if (!joinForm.confirmCode.value) { 
				alert("인증번호를 입력해주세요.");
				
				return;
			}
			
			confirmEmail(joinForm.confirmCode.value, confirmNum);
		});
	});
	
	function confirmEmail(emailconfirm_value, authNum){
		if(!emailconfirm_value || emailconfirm_value != authNum){	// 인증코드가 일치하지 않을 경우
			alert("인증번호가 일치하지 않습니다!");
			joinForm.confirmCode.value = "";
			joinForm.confirmCode.focus();
		} else if(emailconfirm_value == authNum){	// 일치할 경우
			alert("인증에 성공하였습니다.");
			joinForm.btnConfirm.value = "인증완료";
			$("#confirmCode").prop('disabled', true);
			$("#btnConfirm").prop('disabled', true);
			$("#btnConfirm").css('color', '#808080');
			$("#btnConfirm").css('background-color', '#DDDDDD');
		}
		
		return;
	}
	
	function chk() {
		if (joinForm.btnConfirm.value.indexOf("인증완료") < 0) {
			alert("이메일 인증이 처리되지 않았습니다.");
			joinForm.email.focus();
			
			return false;
		}
	}
</script>
</head>
<body>
	<div class="header_wrap">
		<%@ include file="header.jsp"%>
	</div>
	<div class="joinDiv">
		<h1>회원가입</h1>
		<form action="joinPro.do" name="joinForm" method="post" enctype="multipart/form-data" onsubmit="return chk()">
			<div class="divEmail">
				<input type="email" id="email" name="email" class="inputTypeEmail" required="required" placeholder="이메일">
				<input type="button" name="btnEmailChk" class="btnEmailChk" value="인증하기" onclick="emailCheck(joinForm.email.value)"><br>
				<input type="text" id="confirmCode" name="confirmCode" class="confirmCode" placeholder="인증번호" disabled="disabled"><input type="button" id="btnConfirm" name="btnConfirm" class="btnConfirm" value="확인" disabled="disabled">
			</div>
			<span id="spanEmail">　</span>
			<p class="pNickname"><input type="text" id="nickname" name="nickname" class="inputType" required="required" placeholder="별명 (최대 6글자)"></p>
			<span id="spanNickname">　</span>
			<p class="pPassword"><input type="password" name="password" class="inputType" required="required" placeholder="비밀번호"></p>
			<p class="pPasswordChk"><input type="password" name="pPasswordChk" class="inputType" required="required" placeholder="비밀번호 확인"></p>
			<p><input type="tel" name="phone" class="inputType" required="required" placeholder="연락처"></p>
			<p><input type="file" name="profile_url" class="inputType"></p>
			<p><input type="submit" id="submit" value="회원가입"></p>
		</form>
	</div>
	<div class="footer_wrap">
		<%@ include file="footer.jsp"%>
	</div>
</body>
</html>