<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>��Ź�� ������������</title>
	<link rel="stylesheet" type="text/css" href="../css/admin.css"/>
	<link rel="stylesheet" type="text/css" href="../css/adminorder.css"/><!-- ���� ������ ������ css�� �ٲ���� -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	
	<!-- datepicker -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<script type="text/javascript">
		$(document).ready(function() {
			//���, Ǫ�Ϳ���
			$("#admin").load("./admin.jsp")
			
		
		});
	</script>
</head>
<body>
		<div id="admin"></div>
		<div class="content">
			<!-- ���⼭���� �۾��ϼ���. -->
			<h1>��ü��������</h1>
			<ul class="coupon_title">
				<li><input type="checkbox" id="allcheck"></li>
				<li>ȸ�����̵�</li>
				<li>��������</li>
				<li>����������</li>
				<li>���Ⱓ</li>
			</ul>
			<form id="coupon_form">
				<div class="coupon_list paginated">
					<input type="button" value="���û���" class="checkdelete">
				</div>
			</form>
			</div>
		<!-- ���  div ��-->
	<!-- ������������ -->
</body>
</html>
