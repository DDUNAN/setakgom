<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String name = (String) session.getAttribute("name");
	String member_id = (String) session.getAttribute("member_id");
	String backurl = (String)request.getAttribute("backurl");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>세탁곰</title>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.4.1/css/all.css"
	integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./css/default.css" />
<link rel="stylesheet" type="text/css" href="./css/loginform.css" />
<!-- 여기 본인이 지정한 css로 바꿔야함 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<!-- 구글로그인 -->
<script src="https://apis.google.com/js/api:client.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$("#header").load("header.jsp")
		$("#footer").load("footer.jsp")

		/*팝업창*/
		/*아이디찾기*/
		$(".find_id").click(function(event) {
			$(".back").css("display", "block");
			$(".popup").css("display", "block");

		});
		$(".close").click(function(event) {
			$(".back").css("display", "none");
			$(".popup").css("display", "none");
		});

		/*비밀번호찾기*/
		$(".find_pw").click(function(event) {
			$(".back").css("display", "block");
			$(".popup2").css("display", "block");

		});
		$(".close").click(function(event) {
			$(".back").css("display", "none");
			$(".popup2").css("display", "none");
		});

		/*회원가입 클릭*/
		$(".btn_join").click(function(event) {
			$(location.href = "/setak/join.do");
		});

		/*클릭시 사이트이동*/
		$(".kakao").click(function(event) {
			$(location.href = "${kakao_url}");
		});

		$(".naver").click(function(event) {
			$(location.href = "${naver_url}");
		});

	});

	/*구글로그인*/
	var googleUser = {};
	var startApp = function() {
		gapi.load('auth2',function() {
			auth2 = gapi.auth2.init({
				client_id : '114414180398-cjl49jqvelctnaiuvj6vi2ffjbrrv1dc.apps.googleusercontent.com',
				cookiepolicy : 'single_host_origin'
				});
			attachSignin(document.getElementById('customBtn'));
		});
	};

	function attachSignin(element) {
		auth2.attachClickHandler(element, {}, function(googleUser) {
			var profile = googleUser.getBasicProfile();
			console.log("ID: " + profile.getId()); 
			console.log('Full Name: ' + profile.getName());
			console.log("Email: " + profile.getEmail());
			
			var g_id = profile.getId();
			var g_nickname = profile.getName();
			var g_email = profile.getEmail();
			var params = { 
					'member_id' : g_id+"_G",
					'member_name' : g_nickname,
					'member_email' : g_email
 			}
			
			$.ajax({
	            url : '/setak/google.do', 
	            type:'post',
	            data : params,
	            dataType:'json', 
	            contentType : 'application/x-www-form-urlencoded;charset=utf-8',
	            success: function(result) {
	               if(result.res=="OK") {
	            	   location.href="/setak/login.do";
	               }
	               else { // 실패했다면
	            	   location.href="/setak/login.do";
	               }
	            },
	            error:function() {
	               alert("insert ajax 통신 실패");
	            }			
			});

		}, function(error) {
			alert(JSON.stringify(error, undefined, 2));
		});
		

	}
	
	
</script>

</head>
<body>
	<div id="header"></div>

	<!-- 여기서 부터 작성하세요. 아래는 예시입니다. -->
	<section id="title"> <!-- 변경하시면 안됩니다. -->
		<div class="content">
			<!-- 변경하시면 안됩니다. -->
			<div class="title-text">
				<!-- 변경하시면 안됩니다. -->
				<h2>로그인</h2>
			</div>
		</div>
	</section>

	<section id="test"> <!-- id 변경해서 사용하세요. -->
		<div class="content"> 	<!-- class 변경해서 사용하세요. -->
			<form name="loginform" action="loginpro.do" method="post">
				<div class="loginform"> <!-- class 변경해서 사용하세요. -->
						<input type="hidden" name="backurl" value = "<%=backurl%>" />
					<div>
						<input class="txtln" type="text" name="member_id"
							placeholder="아이디" />
					</div>
					<div>
						<input class="txtln" type="password" name="member_password"
							placeholder="비밀번호" />
					</div>
					<div class="login">
						<input class="btn" type="submit" value="로그인" />
					</div>
					<hr>
					<div class="find">
						<div class="find_id">아이디찾기</div>
						<div class="find_pw">비밀번호찾기</div>
						<div class="btn_join">회원가입</div>
					</div>
					<%
						if (name == null) {
					%>
					<div class="extra">
						<h4>다른서비스계정으로 로그인</h4>
						<!--카카오 -->
						<div class="logo kakao">
							<img src="images/logo_kakao.png">
						</div>
						<!-- 구글 -->
						<div id="gSignInWrapper">
							<div id="customBtn" class="customGPlusSignIn">
							<img src="images/logo_gogle.png">
							</div>
						</div>
						<!-- 네이버 -->
						<div class="logo naver">
							<img src="images/logo_naver.PNG">
						</div>
						<script>
							startApp();
						</script>
						<hr>
					</div>
					<%
						} else {
					%>
					<h2>다른 서비스계정 로그인 성공하셨습니다!!</h2>
					<h3>'${name}' 님 환영합니다!</h3>
					<%
						}
					%>
				</div>
			</form>
		</div>
	</section>

	<!-- 팝업창 -->
	<!-- 아이디찾기 -->
	<div class="check_id">
		<div class="back"></div>
		<div class="popup">
			<div class="head">
				<button type="button" class="close">X</button>
				<h4>아이디찾기</h4>
				<hr>
			</div>
			<div class="text">
				<h5>회원정보에 등록한 휴대폰번호를 입력하세요</h5>
				<input type="text" placeholder="이름" />
				<input type="text" placeholder="휴대폰번호" /> 
				<input type="button" class="phone" value="인증번호받기" /> 
				<input type="text" placeholder="인증번호" /> 
				<input type="button" class="ok" value="확인" />
			</div>
		</div>
	</div>

	<!-- 비밀번호찾기 -->
	<div class="check_pw">
		<div class="back"></div>
		<div class="popup2">
			<div class="head">
				<button type="button" class="close">X</button>
				<h4>비밀번호찾기</h4>
				<hr>
			</div>
			<div class="text">
				<h5>회원정보에 등록한 휴대폰번호를 입력하세요</h5>
				<input type="text" placeholder="이름" /> 
				<input type="text" placeholder="아이디" /> 
				<input type="text" placeholder="휴대폰번호" /> 
				<input type="button" class="phone" value="인증번호받기" /> 
				<input type="text" placeholder="인증번호" />
				<input type="button" class="ok" value="확인" />
			</div>
		</div>
	</div>


	<!-- 여기까지 작성하세요. 스크립트는 아래에 더 작성해도 무관함. -->

	<div id="footer"></div>
</body>
</html>
