<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>세탁곰 관리자페이지</title>
	<link rel="stylesheet" type="text/css" href="../css/admin.css"/>
	<link rel="stylesheet" type="text/css" href="../css/admin_keep.css"/>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			//헤더, 푸터연결
			$("#admin").load("./admin.jsp")
			
			//목록 띄우기
			function selectData(){
				
				$.ajax({
					url : '/setak/getKeepList.do',
					type : 'POST',
					dataType : 'json',
					contentType : 'application/x-www-form-urlencoded; charset=utf-8',
					success:function(data){
						$.each(data, function(index, item){
							var str = '';
							
							str += '<ul>'
							str += '<li class="listtd"><input type="checkbox"></li>';
							str += '<li class="listtd">' + item.keep_rnum + '</li>';
							str += '<li class="listtd">' + item.order_num + '</li>';
							str += '<li class="listtd">' + item.member_id + '</li>';
							str += '<li class="listtd"><input type="text" class="keep_kind" value="' + item.keep_kind + '" disabled></li>';
							str += '<li class="listtd"><input type="number" class="keep_count" value="' + item.keep_count + '" disabled></li>';
							str += '<li class="listtd"><input type="number" class="keep_box" name="keep_box" min="1" value="' + item.keep_box + '" disabled></li>';
							str += '<li class="listtd"><input type="date" class="keep_day" name="keep_start" value="' + item.keep_start + '" disabled></li>';
							str += '<li class="listtd"><input type="date" class="keep_day" name="keep_end" value="' + item.keep_end + '" disabled></li>';
							str += '<li class="listtd"><select class="keep_now" name="keep_now" disabled>';
							str += '<option value=' + item.keep_now + '>'+ item.keep_now +'</option>';
							str += '<option value="입고전">입고전</option>';
							str += '<option value="보관중">보관중</option>';
							str += '<option value="부분반환">부분반환</option>';
							str += '<option value="전체반환">전체반환</option>';
							str += '</select></li>';
							str += '<li class="listtd"><input type="button" class="keep_img_popup" value="사진"></li>';
							str += '<li class="listtd"><a class="update">수정</a>';
							str += '<a style="display: none;" value="/setak/updateKeep.do?keep_seq=' + item.keep_seq + '" class="after">수정</a></li>';
							str += '<li class="listtd" style="display:none;"><input type="text" class="keep_cate" value="' + item.keep_cate + '" disabled></li>';
							str += '</ul>';
							$(".keep_list").append(str);
						});
						page();
					},
					error:function(){
						alert("ajax통신 실패!!!");
					}
				});
			}
			
			selectData();
			
			//수정 눌렀을 때
			var update_keep_cate ="";
			var update_keep_kind ="";
			$(document).on('click','.update',function(event) {
				$(".after").css("display","none");
				$(".update").css("display","block");
				$(".keep_count").attr("disabled","disabled");
				$(".keep_box").attr("disabled","disabled");
				$(".keep_day").attr("disabled","disabled");
				$(".keep_now").attr("disabled","disabled");
				$(".keep_count").removeClass("upadte_select");
				$(".keep_box").removeClass("upadte_select");
				$(".keep_day").removeClass("upadte_select");
				$(".keep_now").removeClass("upadte_select");
				$('.listtd').removeClass("update_count");
				
				$($(this).parent().children(".after")).css("display","block");
				$(this).css("display","none");
				$($(this).parent().parent().children().children('.keep_count')).removeAttr("disabled");
				$($(this).parent().parent().children().children('.keep_box')).removeAttr("disabled");
				$($(this).parent().parent().children().children('.keep_day')).removeAttr("disabled");
				$($(this).parent().parent().children().children('.keep_now')).removeAttr("disabled");
				$($(this).parent().parent().children().children('.keep_count')).addClass("upadte_select");
				$($(this).parent().parent().children().children('.keep_box')).addClass("upadte_select");
				$($(this).parent().parent().children().children('.keep_day')).addClass("upadte_select");
				$($(this).parent().parent().children().children('.keep_now')).addClass("upadte_select");
				$($(this).parent().parent().children('.listtd:nth-child(5)')).addClass("update_count"); //팝업창 누를 수 있게 됨
				
				//나중에 옷종류 값 변경 시키기위해서.
				update_keep_cate = $($(this).parent().parent().children('.listtd:nth-child(13)').children(".keep_cate"));
				update_keep_kind = $($(this).parent().parent().children('.listtd:nth-child(5)').children(".keep_kind"));
				
				//다른 수정버튼 눌렀을 때 기본값으로 돌리기 위해서
				$('#keep_form')[0].reset();
			});

			//수정 활성화 됐을 때 종류 값 클릭시 팝업생성
			$(document).on('click','.update_count',function(event) {
				$(".popup_back").addClass("popup_on");
			});
			$(document).on('click','.close',function(event) {
	            $(".popup_back").removeClass("popup_on");
				$(".keep-list").removeClass("tab_active");
	        });

			//팝업에서 탭 눌렀을 때
			$(".tab").on("click", function() {
				$(".tab").removeClass("tab_active");
				$(".tab-content").removeClass("show");
				$(this).addClass("tab_active");
				$($(this).attr("href")).addClass("show");
			});
			$(".keep-list").on("click", function() {
				$(".keep-list").removeClass("tab_active");
				$(this).addClass("tab_active");
			});
			
			//팝업에서 확인 눌렀을 때
			var popup_keep_cate = "";	//큰카테
			var popup_keep_kind = "";	//작은카테
			$(document).on('click','.commit',function(event) {
				popup_keep_cate = document.getElementsByClassName('tab tab_active');
	            popup_keep_kind = document.getElementsByClassName('keep-list tab_active');
	            
	            if(!$(".keep-list").hasClass("tab_active")){
					alert("종류를 선택하지 않았습니다.");
					return false;
				}
	            
	            //팝업닫기
	            $(".popup_back").removeClass("popup_on");

	            //옷종류 바꾼거 적용시키기 
	            $(update_keep_cate).val(popup_keep_cate[0].innerHTML);
	            $(update_keep_kind).val(popup_keep_kind[0].innerHTML);

	            $(".keep-list").removeClass("tab_active");
			});
			
			//수정 ajax
			$(document).on('click','.after', function(event){
				var cate = $(this).parents().eq(1).children().eq(12).children().val();
				var kind = $(this).parents().eq(1).children().eq(4).children().val();
				var count = $(this).parents().eq(1).children().eq(5).children().val();
				var box = $(this).parents().eq(1).children().eq(6).children().val();
				var sd = $(this).parents().eq(1).children().eq(7).children().val();
				var fd = $(this).parents().eq(1).children().eq(8).children().val();
				var now = $(this).parents().eq(1).children().eq(9).children().val();
				
				var params = {"keep_cate":cate,"keep_kind":kind,"keep_box":box,"keep_start":sd,"keep_end":fd,"keep_now":now,"keep_count":count}
				
				jQuery.ajax({
					url : $(this).attr("value"), 
					type : 'post',
					data : params,
					contentType : 'application/x-www-form-urlencoded;charset=utf-8',
					dataType : "json", //서버에서 보내줄 데이터 타입
					success:function(retVal){
						if(retVal.res == "OK"){
							$('.keep_list').empty()
							selectData();
						} else {
							alert("수정 실패");
						}
					},
					error:function(){
						alert("ajax통신 실패");
					}
				});
				event.preventDefault();
			}); 
			
			//페이징 작업
			function page(){ 
				$('div.paginated').each(function() {
					var pagesu = 10;  //페이지 번호 갯수
					var currentPage = 0;
					var numPerPage = 10;  //목록의 수
					var $table = $(this);    
					  
					//length로 원래 리스트의 전체길이구함
					var numRows = $table.find('ul').length;
					//Math.ceil를 이용하여 반올림
					var numPages = Math.ceil(numRows / numPerPage);
					//리스트가 없으면 종료
					if (numPages==0) return;
					//pager라는 클래스의 div엘리먼트 작성
					var $pager = $('<div id="remo"></div>');
					 
					var nowp = currentPage;
					var endp = nowp+10;
				  
					//페이지를 클릭하면 다시 셋팅
					$table.bind('repaginate', function() {
					//기본적으로 모두 감춘다, 현재페이지+1 곱하기 현재페이지까지 보여준다
						$table.find('ul').hide().slice(currentPage * numPerPage, (currentPage + 1) * numPerPage).show();
						$("#remo").html("");
						
						if (numPages > 1) {     // 한페이지 이상이면
							if (currentPage < 5 && numPages-currentPage >= 5) {   // 현재 5p 이하이면
								nowp = 0;     // 1부터 
								endp = pagesu;    // 10까지
							}else{
								nowp = currentPage -5;  // 6넘어가면 2부터 찍고
								endp = nowp+pagesu;   // 10까지
								pi = 1;
							}
							if (numPages < endp) {   // 10페이지가 안되면
								endp = numPages;   // 마지막페이지를 갯수 만큼
								nowp = numPages-pagesu;  // 시작페이지를   갯수 -10
							}
							if (nowp < 1) {     // 시작이 음수 or 0 이면
								nowp = 0;     // 1페이지부터 시작
							}
						}else{       // 한페이지 이하이면
							nowp = 0;      // 한번만 페이징 생성
							endp = numPages;
						}
						
						// [<<]
						$('<span class="page-number" cursor: "pointer"><<</span>').bind('click', {newPage: page},function(event) {
							currentPage = 0;
							$table.trigger('repaginate');  
							$($(".page-number")[2]).addClass('active').siblings().removeClass('active');
						}).appendTo($pager).addClass('clickable');
						// [<]
						$('<span class="page-number" cursor: "pointer"><</span>').bind('click', {newPage: page},function(event) {
							if(currentPage == 0) return;
							currentPage = currentPage-1;
							$table.trigger('repaginate');
							$($(".page-number")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');
						}).appendTo($pager).addClass('clickable');
						// [1,2,3,4,5,6,7,8]
						for (var page = nowp ; page < endp; page++) {
							$('<span class="page-number" cursor: "pointer"></span>').text(page + 1).bind('click', {newPage: page}, function(event) {
								currentPage = event.data['newPage'];
								$table.trigger('repaginate');
								$($(".page-number")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');
							}).appendTo($pager).addClass('clickable');
						}
						// [>]
						$('<span class="page-number" cursor: "pointer">></span>').bind('click', {newPage: page},function(event) {
							if(currentPage == numPages-1) return;
							currentPage = currentPage+1;
							$table.trigger('repaginate'); 
							$($(".page-number")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');
						}).appendTo($pager).addClass('clickable');
						// [>>]
						$('<span class="page-number" cursor: "pointer">>></span>').bind('click', {newPage: page},function(event) {
							currentPage = numPages-1;
							$table.trigger('repaginate');
							$($(".page-number")[endp-nowp+1]).addClass('active').siblings().removeClass('active');
						}).appendTo($pager).addClass('clickable');
						$($(".page-number")[2]).addClass('active');
					});
					$pager.insertAfter($table).find('span.page-number:first').next().next().addClass('active'); 
					$pager.appendTo($table);
					$table.trigger('repaginate');
				});
			}
		});
		
		//사진 클릭시 팝업생성
		$(document).on('click','.keep_img_popup',function(event) {
			$(".popup_img_back").addClass("popup_on");
		});
		$(document).on('click','.keep_img_close',function(event) {
            $(".popup_img_back").removeClass("popup_on");
            $(".imgs_wrap").empty();
        });
		
		//이미지 정보들 담을 배열
		var sel_files = [];
		$(document).ready(function(){
			$("#input_imgs").on("change", handleImgFileSelect);	
		});
		function handleImgFileSelect(e){
			//이미지 정보 초기화
			sel_files = [];
			
			var files = e.target.files;
			var filesArr = Array.prototype.slice.call(files);
			
			var index = 0;
			filesArr.forEach(function(f){
				if(!f.type.match("image.*")){
					alert("확장자는 이미지 확장자만 가능합니다.");
					return;
				}
				
				sel_files.push(f);
				
				var reader = new FileReader();
				reader.onload = function(e) {
					var html = "<a href=\"javascript:void(0);\" onclick=\"deleteImageAction("+index+")\" id=\"img_id_"+index+"\"><img src=\"" + e.target.result + "\" data-file='"+f.name + "' title='Click to remove'></a>";
					$(".imgs_wrap").append(html);
					index++;
				}
				reader.readAsDataURL(f);
			});
		}
		
		//이미지 삭제
 		function deleteImageAction(index){
			sel_files.splice(index,1);
			
			var img_id = "#img_id_" + index;
			$(img_id).remove();
			
			alert(img_id);
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		var filecontent;
		var filename;
		var data = new FormData();// key/value로 채워지는것임 참고.
		var dbfilename = "";
		
		$(document).on("change","#input_imgs",function(){
			filecontent = null;
			data = new FormData();
			dbfilename = "";
			for(i =0; i<$(this)[0].files.length; i++){
				filecontent = $(this)[0].files[i];
				filename = Date.now() + "_" + $(this)[0].files[i].name;
				data.append("files", filecontent);
				data.append("filename", filename);			
				dbfilename += filename +",";
			}
		}); 
		
		$(document).on("submit", "#imgform", function(){
			if(filecontent != null){
				data.append("purpose", "keep");
				
				$("#input_imgs2").val(dbfilename);
				$.ajax({
					type: "POST",
		            enctype: 'multipart/form-data',
		            url: "/setak/testImage.do",
		            data: data,
		            processData: false,
		            contentType: false,
		            cache: false,
		            dataType: 'text',
		            success: function (data) {
					},
	                error: function (e) {
	                	alert("실패실패실패!!")
	                	console.log(e);
					}
				});
			}
			else{
				alert("선택된 파일이 없습니다.")
				event.preventDefault();
			}
		});   
	</script>
</head>
<body>
		<div id="admin"></div>
		<div class="content">
			<!-- 여기서부터 작업하세요. -->
			<h1>보관관리</h1>
			<ul class="keep_title">
				<li><input type="checkbox" id = "allcheck"></li>
				<li>NO</li>
				<li>주문번호</li>
				<li>아이디</li>
				<li>종류</li>
				<li>의류수량</li>
				<li>박스수량</li>
				<li>신청날짜</li>
				<li>반환날짜</li>
				<li>상황</li>
				<li>사진</li>
				<li>수정</li>
			</ul>
			<form id="keep_form">
				<div class="keep_list paginated">
					<input type="button" value="선택삭제" class="chkdelete">
				</div>
			</form>
		</div>
		<div class="popup_back">
			<div class="popup">
			    <div class="tabs">
					<div class="tab-list">
						<a href="#one" id="tab" class="tab tab_active">상의</a>
						<a href="#two" id="tab" class="tab">하의</a>
						<a href="#three" id="tab" class="tab">아우터</a>
						<a href="#four" id="tab" class="tab">아동</a>
					</div>
					<div class="tab-list">
						<a href="#five" id="tab" class="tab">침구</a>
						<a href="#six" id="tab" class="tab">리빙</a>
						<a href="#seven" id="tab" class="tab">신발</a>
						<a href="#eight" id="tab" class="tab">잡화</a>
					</div>
				</div>
	
				<div id="one" class="tab-content show">
					<ul class="top">
						<li class="keep-list" value="셔츠">셔츠</li>
						<li class="keep-list" value="티셔츠">티셔츠</li>
						<li class="keep-list" value="블라우스">블라우스</li>
						<li class="keep-list" value="후드티,맨투맨티">후드티,맨투맨티</li>
					</ul>
					<ul class="top">
						<li class="keep-list" value="니트,스웨터">니트,스웨터</li>
						<li class="keep-list" value="원피스/점프수트">원피스/점프수트</li>
						<li class="keep-list" value="원피스(니트,실크,레자)">원피스(니트,실크,레자)</li>
						<li class="keep-list" value="후리스">후리스</li>
					</ul>
				</div>
				
				<div id="two" class="tab-content">
					<ul class="top">
						<li class="keep-list" value="바지">바지</li>
						<li class="keep-list" value="바지(니트,레자,패딩)">바지(니트,레자,패딩)</li>
						<li class="keep-list" value="스커트">스커트</li>
						<li class="keep-list" value="스커트(니트,레자,패딩)">스커트(니트,레자,패딩)</li>
					</ul>
				</div>
				
				<div id="three" class="tab-content">
					<ul class="top">
						<li class="keep-list" value="가디건">가디건</li>
						<li class="keep-list" value="롱가디건">롱가디건</li>
						<li class="keep-list" value="점퍼(야상,청자켓,항공점퍼,집업)">점퍼(야상,청자켓,항공점퍼,집업)</li>
						<li class="keep-list" value="자켓">자켓</li>
					</ul>
					<ul class="top">
						<li class="keep-list" value="패딩">패딩</li>
						<li class="keep-list" value="롱패딩">롱패딩</li>
						<li class="keep-list" value="프리미엄패딩">프리미엄패딩</li>
						<li class="keep-list" value="코트">코트</li>
					</ul>
					<ul class="top">
						<li class="keep-list" value="기능성의류(등산용,바람막이)">기능성의류(등산용,바람막이)</li>
						<li></li>
						<li></li>
						<li></li>
					</ul>
				</div>
				
				<div id="four" class="tab-content">
					<ul class="top">
						<li class="keep-list" value="아동">아동</li>
						<li class="keep-list" value="아동 바지/치마">아동 바지/치마</li>
						<li class="keep-list" value="아동 자켓/점퍼">아동 자켓/점퍼</li>
						<li class="keep-list" value="아동 코트">아동 코트</li>
					</ul>
					<ul class="top">
						<li class="keep-list" value="아동 패딩">아동 패딩</li>
						<li class="keep-list" value="아동 원피스">아동 원피스</li>
						<li class="keep-list" value="아동 운동화">아동 운동화</li>
						<li class="keep-list" value="아동 부츠">아동 부츠</li>
					</ul>
				</div>
				
				<div id="five" class="tab-content">
					<ul class="top">
						<li class="keep-list" value="베개,쿠션 커버">베개,쿠션 커버</li>
						<li class="keep-list" value="침대,매트리스,이불커버,홑이불">침대,매트리스,이불커버,홑이불</li>
						<li class="keep-list" value="일반 이불">일반 이불</li>
						<li class="keep-list" value="극세사,일반 토퍼">극세사,일반 토퍼</li>
					</ul>
					<ul class="top">
						<li class="keep-list" value="구스이불,양모이불">구스이불,양모이불</li>
						<li class="keep-list" value="실크이불">실크이불</li>
						<li></li>
						<li></li>
					</ul>
				</div>
				
				<div id="six" class="tab-content">
					<ul class="top">
						<li class="keep-list" value="발매트">발매트</li>
						<li class="keep-list" value="원룸커튼">원룸커튼</li>
						<li class="keep-list" value="일반커튼">일반커튼</li>
						<li class="keep-list" value="벨벳커튼">벨벳커튼</li>
					</ul>
					<ul class="top">
						<li class="keep-list" value="러그,카펫">러그,카펫</li>
						<li class="keep-list" value="식탁보">식탁보</li>
						<li></li>
						<li></li>
					</ul>
				</div>
				
				<div id="seven" class="tab-content">
					<ul class="top">
						<li class="keep-list" value="운동화,스니커즈">운동화,스니커즈</li>
						<li class="keep-list" value="캐주얼샌들/슬리퍼">캐주얼샌들/슬리퍼</li>
						<li class="keep-list" value="구두,로퍼">구두,로퍼</li>
						<li class="keep-list" value="등산화">등산화</li>
					</ul>
					<ul class="top">
						<li class="keep-list" value="부츠화">부츠화</li>
						<li class="keep-list" value="롱부츠">롱부츠</li>
						<li class="keep-list" value="가죽부츠(발목)">가죽부츠(발목)</li>
						<li class="keep-list" value="어그부츠">어그부츠</li>
					</ul>
				</div>
				
				<div id="eight" class="tab-content">
					<ul class="top">
						<li class="keep-list" value="니트모자">니트모자</li>
						<li class="keep-list" value="스카프,장갑">스카프,장갑</li>
						<li class="keep-list" value="숄">숄</li>
						<li class="keep-list" value="넥타이">넥타이</li>
					</ul>
					<ul class="top">
						<li class="keep-list" value="에코백">에코백</li>
						<li class="keep-list" value="목도리">목도리</li>
						<li></li>
						<li></li>
					</ul>
				</div>
				<div class="popup_count">
				
				</div>
				<div class="keep_button">
					<input type="button" value="취소" class="close">
					<input type="button" value="확인" class="commit">
				</div>
			</div>
		</div>

		<form id="imgform" action=".././keepImg.do" method="post" enctype="multipart/form-data">
			<div class="popup_img_back">
				<div class="popup_img">
					<h2>등록된 사진</h2>
					<div class="before_img">
					</div>
					
					<hr />
					<h2>업로드할 사진</h2>
					<div class="input_wrap">
						<input type="file" id="input_imgs" accept="image/*" multiple />
						<input type="hidden" name="keep_file" id="input_imgs2">
						<input type="hidden" name="keep_seq" value="103" id="input_keep_seq">
					</div>
					<div class="imgs_wrap">
						
					</div>
				</div>
				<div class="keep_button">
					<input type="button" value="취소" class="keep_img_close">
					<input type="submit" value="등록">
				</div>
			</div>
		</form>

	</div><!-- 지우지마세요 -->
</body>
</html>