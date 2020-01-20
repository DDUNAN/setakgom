<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*, com.spring.setak.*" %>
<%
	List<MendingVO> mendinglist = (ArrayList<MendingVO>)request.getAttribute("mendinglist");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>세탁곰</title>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="./css/default.css"/>
	<link rel="stylesheet" type="text/css" href="./css/orderview.css"/><!-- 여기 본인이 지정한 css로 바꿔야함 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script type="text/javascript">
      $(document).ready(function(){
         $("#header").load("./frame/header.jsp")
         $("#footer").load("./frame/footer.jsp")     
      });
    </script>
    <script language='javascript'>
    	function cancle() {
			alert("주문을 취소하시겠습니까?");
		}
    </script>
</head>
<body>
	<div id="header"></div>
	
	<!-- 여기서 부터 작성하세요. 아래는 예시입니다. -->
	<section id="test"> <!-- id 변경해서 사용하세요. -->
		<div class="content"> <!-- 변경하시면 안됩니다. -->
			<div class="mypage_head">
				<ul>
					<li class="mypage-title">마이페이지</li>
					<li>
						<ul class="mypage_list">
							<li>주문관리</li>
							<li><a href="orderview.do">주문/배송현황</a></li>
							<li><a href="mykeep.do">보관현황</a></li>
						</ul>
						<ul class="mypage_list">
							<li>정기구독</li>
							<li><a href="mysub.jsp">나의 정기구독</a></li>
						</ul>
						<ul class="mypage_list">
							<li>고객문의</li>
							<li><a href="qnainquiry.do">Q&amp;A 문의내역</a></li>
						</ul>
						<ul class="mypage_list">
							<li>정보관리</li>
							<li><a href="password.jsp">개인정보수정</a></li>
							<li><a href="mycoupon.do">쿠폰조회</a></li>
							<li><a href="mysavings.do">적립금 조회</a></li>
							<li><a href="withdraw.jsp">회원탈퇴</a></li>
						</ul>
					</li>
				</ul>
			</div>
			
			<div class="mypage_content">
				<h2>주문/배송현황</h2>
				<div class="mypage_content_cover">
					<p>
						<font size=2.5rem>※ 취소 버튼은 신청 당일 밤 10시 전까지만 활성화됩니다. 이후 취소는 불가합니다.</font>
					</p>
					<% 
						try{
							MendingVO vo = (MendingVO)request.getAttribute("mendingVO");		
							OrderVO ovo = (OrderVO)request.getAttribute("orderVO");
						%>
					<div class="accordion">
						<div class="accordion-header">주문일자 : 2020/01/18 03:42</div>
						<div class="accordion-content">
							<!--snb -->
							<div class="snb">
								<div class="ordernumber">
									<p>주문 번호 :</p>
									<p><%=ovo.getOrder_num() %></p>
								</div>
								<div class="addr">
									<p>주소 :</p>
									<p><%=ovo.getOrder_address() %></p>
								</div>
								<br><br><br><br><br>
								<a href="#" class="button" id="order_false" disabled="">주문 취소</a>
							</div>
							<!--//snb -->
							<!--content -->
							<div class="row_content">
								<div class="row_content2">
								<div class="my_laundry">
									<p>세탁 :</p>
									<p><%=vo.getRepair_seq()%><%=vo.getRepair_code() %></p>
								</div>
								<div class="my_mending">
									<p>수선 :</p>
									<p>abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎㄲㄸㅃㅆㅉㅏㅑㅓㅕㅗㅛㅜㅠㅡㅣ가나다라마바사아자차카타하아야여어오요우유으이123456789
								</div>
								<div class="my_keep">
									<p>보관 :</p>
									<p>abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎㄲㄸㅃㅆㅉㅏㅑㅓㅕㅗㅛㅜㅠㅡㅣ가나다라마바사아자차카타하아야여어오요우유으이123456789
								</div>
								</div>
								<div class="price">
									<p>합계 : <%=vo.getRepair_price() %>원</p>
								</div>
							</div>
						</div>
					</div>
					<%
	}
	catch(Exception ex) {} 
%>
				</div>
				<div class="page1">
				<table class="page">
					<tr align = center height = 20>
              			<td>
              				<div class="page_a"><a href = "#">&#60;</a></div>
                  			<div class="page_a"><a>1</a></div>
                  			<div class="page_a"><a>2</a></div>
                  			<div class="page_a"><a>3</a></div>
                  			<div class="page_a"><a href = "#">&#62;</a></div>
                  		</td>
               		</tr>
				</table>
				</div>
			</div>
			
		</div>
	</section>
	<!-- 여기까지 작성하세요. 스크립트는 아래에 더 작성해도 무관함. -->
	
	<div id="footer"></div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</body>
<script>
$("#order_false").on('click', function (event) {
	if(현재일시 > 체크일시) 
		$('#order_false').attr('disabled', true); 
	return false;
 });
</script>
<script>
    $(document).ready(function() {
    	  jQuery(".accordion-content").hide();
    	//content 클래스를 가진 div를 표시/숨김(토글)
    	  $(".accordion-header").click(function(){
    		$except = $(this);
  			$except.toggleClass("active");
    	    $(".accordion-content")
    	    	.not($(this).next(".accordion-content").slideToggle(500)).slideUp();
    	    $('.mypage_content_cover').find('.accordion>.accordion-header').not($except).removeClass("active");
    	  });
    	});
    
   setTimeout(function() {
	
}, 10000); 
</script>
</html>