<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>YAKBBAL</title>
<link href="css/default.css" rel="stylesheet" type="text/css">
<link href="css/header.css" rel="stylesheet" type="text/css">
<link href="css/footer.css" rel="stylesheet" type="text/css">
<link href="css/search.css" rel="stylesheet" type="text/css">

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$('ul.tabs li').click(function(){
			var tab_id = $(this).attr('data-tab');
	
			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');
	
			$(this).addClass('current');
			$("#"+tab_id).addClass('current');
		});

	});
	
	
	$(function(){
		var ser = "${param.ser}";
		$.ajax({
			type:"get",
			url: "search_medicineName.do",
			data: { param : ser },
			success : function(data) {
				if(data == 1){
					$.ajax({
						type:"get",
						url: "info_medicine.do",
						data: { param : ser },
						dataType: "json",
						success : function(data) {
							$("#tab-1").append("<span id='ITEM_SEQ' style='color : #222'>" + data.ITEM_SEQ + "</span>");
							$("#tab-1").append("<br><br>");
							$("#tab-1").append("<span id='ITEM_NAME' style='color : #222'>" + data.ITEM_NAME + "</span>");
							$("#tab-1").append("<br><br>");
							$("#tab-1").append("<span id='ENTP_NAME' style='color : #222'>"+data.ENTP_NAME+ "</span>");
							$("#tab-1").append("<br><br>");
							$("#tab-1").append("<span id='MATERIAL_NAME' style='color : #222'>"+ data.MATERIAL_NAME+"</span>");
							$("#tab-1").append("<br><br>");
							$("#tab-1").append("<span id='VALID_TERM' style='color : #222'>"+ data.VALID_TERM+"</span>");
							$("#tab-1").append("<br><br>");
							$("#tab-2").append("<span id='EFFECT' style='color : #222'>"+ data.EFFECT+"</span>");
							$("#tab-2").append("<br><br>");
							$("#tab-3").append("<span id='USAGE2' style='color : #222'>"+ data.USAGE2+"</span>");
							$("#tab-3").append("<br><br>");
							$("#tab-4").append("<span id='PRECAUTION' style='color : #222'>"+ data.PRECAUTION+"</span>");
							$("#tab-4").append("<br><br>");
						},
						error : function(request, status, error) {
							alert("message:" + request.responseText + "\n" + "error:"
									+ error);
						}
					});
				}
				else{
					alert("????????? ?????? ????????? ?????? ?????? ????????????.");
					location.href="./searchMain_move.do";
				}
			},
			error : function(request, status, error) {
				alert("message:" + request.responseText + "\n" + "error:"
						+ error);
			}
		});
	});
	
	function pill() {
		var cycle = prompt("??? ?????? ????????? ???????????????. (1 ~ 24 ??????)");
		console.log("cycle : " + cycle)
		if (cycle == null){
			return null;
		}
		var ser = "${param.ser}";
			$.ajax({
				type:"get",
				url:"FillAction.me",
				data: {param : ser, cycle : cycle},
				success : function(data) {
					if(data == 1){
						location.href='FillMoveAction.me';
					}
					else if (data == 0){
						alert("?????? ???????????? ??? ?????????.(?????? ?????? ??????)");
					}
					else if (data == 2) {
						alert("????????? ?????? ??????????????????!");
					}
				},
				error : function(request, status, error) {
					alert("message:" + request.responseText + "\n" + "error:"
							+ error);
				}
			});
			
		}
	
</script>
</head>
<body>
	<!-- ?????? (??????,?????? ???) -->
	<div id="header"><%@include file="../inc/header.jsp" %></div>
<!-- ???????????? -->

	<div id="wrap" style="-ms-overflow-style: none;">
	<div id="content">

	<h2 align="center"> ${ param.ser }</h2><br><br>
	<h4>?????? ????????? ???????????? ???????????? ???????????????</h4><br>
	<button class="start" onclick="pill();">?????? ??????</button>
	<br><br><br>
 
 	<div class="container">

		<div id="top">
		<ul class="tabs">
			<li class="tab-link current" data-tab="tab-1">??????</li>
			<li class="tab-link" data-tab="tab-2">??????</li>
			<li class="tab-link" data-tab="tab-3">??????</li>
			<li class="tab-link" data-tab="tab-4">??????</li>
		</ul>
		</div>
		
		<div id="bottom">

		
		<div id="tab-1" class="tab-content current" style="overflow: auto;">
		</div>

		<div id="tab-2" class="tab-content" style="overflow: auto;">
		</div>
		
		<div id="tab-3" class="tab-content" style="overflow: auto;">
		</div>
		
		<div id="tab-4" class="tab-content" style="overflow: auto;">
		</div>
		
		</div>	<!-- bottom -->
		
		</div> <!-- container -->
		
		
	</div>	<!-- content -->
	</div>	<!-- wrap -->
	<!-- ???????????? -->

	<!-- ?????? ?????? -->
	<div id="footer"><%@include file="../inc/footer.jsp" %></div>

</body>
</html>