<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="js/jquery.js"></script>
<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
<script type="text/javascript">
$().ready(function() {
	$(".pro").click(function(){
		$(this).toggleClass("select");
	})
	$("#add").click(function() {
		if($("#noHave").find(".select").length>0){
			var d_id = $("#top").find("[name = d_id]").val();
			var p_id = new Array();
			$("#noHave").find(".select").each(function() {
				p_id.push($(this).data("id"));
			})
			$.ajax({
				url:"department",
				type:"post",
				data:{type:"addPro",d_id:d_id,p_id:p_id},
				traditional: true,
				dataType:"text",
				success:function(data){
					if(data =="true"){
						$("#noHave").find(".select").each(function() {
							var pro = $(this);
							pro.removeClass("select");
							$("#have").append(pro);
						})
					}
				}
			})
		}else{
			alert("请选择下面的数据");
		}
	})
	
	$("#del").click(function() {
		if($("#have").find(".select").length>0){
			var d_id = $("#top").find("[name = d_id]").val();
			var p_id = new Array();
			$("#have").find(".select").each(function() {
				p_id.push($(this).data("id"));
			})
			$.ajax({
				url:"department",
				type:"post",
				data:{type:"delPro",d_id:d_id,p_id:p_id},
				traditional: true,
				dataType:"text",
				success:function(data){
					if(data =="true"){
						$("#have").find(".select").each(function() {
							var pro = $(this);
							pro.removeClass("select");
							$("#noHave").append(pro);
						})
					}
				}
			})
		}else{
			alert("请选择上面的数据");
		}
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
	height: 60px;
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
#btn{
	width: 700px;
	height:50px;
	
}
#btn div{
	width: 120px;
	float:left;
	margin:0 auto; 
	margin-left:153px;
}
#have,#noHave{
	width:350px;
	height:150px;
	margin:10px auto; 
	border: 2px solid #ccc;
	
}
.pro{
	margin: 10px auto;
	margin-left: 10px;
	padding: 5px;
	background: #ccc;
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
	<label name="d_name">${d_name}</label>	
</div>
<div id="main">
	<div id="have">
		<c:forEach items="${pro}" var="pro">
			<div class="pro" data-id="${pro.id}">
				${pro.name}
			</div>
		</c:forEach>
	</div>
	<div id="btn">
		<div>
			<input id="add" class="btn btn-primary" type="button" value="加入↑">
		</div>
		<div>
			<input id="del" class="btn btn-success" type="button" value="移除 ↓">
		</div>
	</div>
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