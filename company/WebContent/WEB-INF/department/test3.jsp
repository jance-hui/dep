<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="js/jquery.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
<script type="text/javascript">
$().ready(function() {
	var left = 0;
	var top = 0;
	var haveTop = $("#have").offset().top;
	var haveLeft = $("#have").offset().left;
	var haveWidth =  parseFloat($("#have").css("width"));
	var haveHeight =  parseFloat($("#have").css("height"));
	var noHaveTop = $("#noHave").offset().top;
	var noHaveLeft = $("#noHave").offset().left;
	var noHaveWidth =  parseFloat($("#noHave").css("width"));
	var noHaveHeight =  parseFloat($("#noHave").css("height"));
	
	
	$(document).on("mouseenter","#noHave .pro",function(){
		$(this).draggable({
			start: function() {
				left = $(this).offset().left;
				top = $(this).offset().top;
			},
			drag: function() {
				var proTop = $(this).offset().top;
				var proLeft = $(this).offset().left;
				var proWidth =  parseFloat($(this).css("width"));
				var proHeight =  parseFloat($(this).css("height"));
				if(proTop>haveTop && left>haveLeft && proTop+proHeight<haveTop+haveHeight && proLeft+proWidth<haveLeft+haveWidth){
					$("#have").css("border","1px solid #f40");
				}else{
					$("#have").css("border","1px solid #ccc");
				}
			},
			stop: function() {
				var proTop = $(this).offset().top;
				var proLeft = $(this).offset().left;
				var proWidth =  parseFloat($(this).css("width"));
				var proHeight =  parseFloat($(this).css("height"));
				if(proTop>haveTop && left>haveLeft && proTop+proHeight<haveTop+haveHeight && proLeft+proWidth<haveLeft+haveWidth){
					var d_id = $("#top").find("[name = d_id]").val();
					var p_id = $(this).data("id");
					var pro = $(this);
					$.ajax({
						url:"department",
						type:"post",
						data:{type:"addPro",d_id:d_id,p_id:p_id},
						dataType:"text",
						success:function(data){
							if(data =="true"){
								pro.css("position","static");
								$("#have").append(pro);
								pro.css("position","relative");
								pro.css("left","0");
								pro.css("top","0");
							}
						}
					})
				}else{
					$(this).offset({top:top,left:left});
				}
				$("#have").css("border","1px solid #ccc");
			}
		});
	})
	
	$(document).on("mouseenter","#have .pro",function(){
		$(this).draggable({
			start: function() {
				left = $(this).offset().left;
				top = $(this).offset().top;
			},
			drag: function() {
				var proTop = $(this).offset().top;
				var proLeft = $(this).offset().left;
				var proWidth =  parseFloat($(this).css("width"));
				var proHeight =  parseFloat($(this).css("height"));
				if(proTop>noHaveTop && proLeft>noHaveLeft && proTop+proHeight<noHaveTop+noHaveHeight && proLeft+proWidth<noHaveLeft+noHaveWidth){
					$("#noHave").css("border","1px solid #f40");
				}else{
					$("#noHave").css("border","1px solid #ccc");
				}
			},
			stop: function() {
				var proTop = $(this).offset().top;
				var proLeft = $(this).offset().left;
				var proWidth =  parseFloat($(this).css("width"));
				var proHeight =  parseFloat($(this).css("height"));
				if(proTop>noHaveTop && proLeft>noHaveLeft && proTop+proHeight<noHaveTop+noHaveHeight && proLeft+proWidth<noHaveLeft+noHaveWidth){
					var d_id = $("#top").find("[name = d_id]").val();
					var p_id = $(this).data("id");
					var pro = $(this);
					$.ajax({
						url:"department",
						type:"post",
						data:{type:"delPro",d_id:d_id,p_id:p_id},
						dataType:"text",
						success:function(data){
							if(data =="true"){
								pro.css("position","static");
								$("#noHave").append(pro);
								pro.css("position","relative");
								pro.css("left","0");
								pro.css("top","0");
							}
						}
					})
				}else{
					$(this).offset({top:top,left:left});
				}
				$("#noHave").css("border","1px solid #ccc");
			}
		});
	})
})
</script>
<style type="text/css">
*{
	margin: 0;
	padding: 0;
}
#top {
	width: 100%;
	height: 30px;
	text-align: center;
	font-size: 28px;
	font-weight: bold;
	line-height: 60px;
	margin: 0 auto;
}
#main{
	width: 700px;
	height: 600px;
	text-align: center;
	margin:0 auto; 
}
#have,#noHave{
	width:400px;
	height:200px;
	margin:0 auto; 
	border: 1px solid #ccc;
	border-radius: 5px;
}
.pro{
	margin: 10px 10px auto;
	padding: 5px;
	background: #6495ED;
	color: #fff;
	float: left;
	border-radius: 5px;
}
.select {
	color: #fff;
	background-color:#f40;
	font-weight: bold;
}
</style>
<title>Insert title here</title>
</head>
<body>

<div id="top">
	<input type="hidden" name="d_id" value="${d_id}">
	<h3>${d_name}</h3>	
</div>
<div id="main">
	<h4>已选项目</h4>
	<div id="have">
		<c:forEach items="${pro}" var="pro">
			<div class="pro" data-id="${pro.id}">
				${pro.name}
			</div>
		</c:forEach>
	</div>

	<h4>未选项目</h4>
	<div id="noHave">
		<c:forEach items="${proNo}" var="pro">
			<div class="pro" data-id="${pro.id}">
				${pro.name}
			</div>
		</c:forEach>
	</div>
</div>
</body>
</html>