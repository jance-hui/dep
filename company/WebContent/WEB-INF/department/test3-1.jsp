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
	var haveTop = $("#have").offset().top;
	var haveLeft = $("#have").offset().left;
	var haveWidth =  parseFloat($("#have").css("width"));
	var haveHeight =  parseFloat($("#have").css("height"));
	var noHaveTop = $("#noHave").offset().top;
	var noHaveLeft = $("#noHave").offset().left;
	var noHaveWidth =  parseFloat($("#noHave").css("width"));
	var noHaveHeight =  parseFloat($("#noHave").css("height"));
	
	$("#have,#noHave").sortable({
      connectWith: ".connectedSortable"
    });
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
	<div id="have" class="connectedSortable">
		<c:forEach items="${pro}" var="pro">
			<div class="pro" data-id="${pro.id}">
				${pro.name}
			</div>
		</c:forEach>
	</div>

	<h4>未选项目</h4>
	<div id="noHave" class="connectedSortable">
		<c:forEach items="${proNo}" var="pro">
			<div class="pro" data-id="${pro.id}">
				${pro.name}
			</div>
		</c:forEach>
	</div>
</div>
</body>
</html>