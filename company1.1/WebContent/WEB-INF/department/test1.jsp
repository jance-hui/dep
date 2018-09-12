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
	var selectId = 0;
	$(document).on("click","tr",function(){
		$(this).toggleClass("select");
		selectId = $(this).data("id");
	})
	$("#add").click(function() {
		var d_id = $("#top").find("[name = d_id]").val();
		var p_id = selectId;
		var i=0;
		$.ajax({
			url:"department",
			type:"post",
			data:{type:"addPro",d_id:d_id,p_id:p_id},
			dataType:"text",
			success:function(data){
				if(data =="true"){
					$("#tableNo tr").each(function(index,element) {
						if($(this).find("[class = idTd]").html()==selectId){
							p_name = $(this).find("[class = nameTd]").text();
							i = index;
						}
					})
					var tr = "<tr data-id='"+p_id+"'><td class='idTd'>"+p_id+"</td><td class='nameTd'>"+p_name+"</td></tr>";
					$("#table").append(tr);
					$("#tableNo tr").eq(i).remove();
				}
			}
		})
	})
	
	$("#del").click(function() {
		var d_id = $("#top").find("[name = d_id]").val();
		var p_id = selectId;
		var i=0;
		$.ajax({
			url:"department",
			type:"post",
			data:{type:"delPro",d_id:d_id,p_id:p_id},
			dataType:"text",
			success:function(data){
				if(data =="true"){
					$("#table tr").each(function(index,element) {
						if($(this).find("[class = idTd]").html()==selectId){
							p_name = $(this).find("[class = nameTd]").text();
							i = index;
						}
					})
					var tr = "<tr data-id='"+p_id+"'><td class='idTd'>"+p_id+"</td><td class='nameTd'>"+p_name+"</td></tr>";
					$("#tableNo").append(tr);
					$("#table tr").eq(i).remove();
				}
			}
		})
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
	height: 500px;
	text-align: center;
	margin:0 auto; 
}
#btn{
	width: 100px;
	float: left;
	
}
#btn div{
	width: 80px;
	margin:80px auto; 
	
}
.mes{
	width: 300px;
	height: 30px;
	font-size: 16px;
	position: absolute;
	bottom: 0;
	margin-left:-123px;
	margin-bottom:-2px;
	background-color: #ccc;
	color:#fff;
	line-height: 30px;
}
#have,#noHave{
	width:250px;
	height:400px;
	margin-top:20px;
	float:left;
	border: 2px solid #ccc;
	position: relative;
}
.aa{
	margin-top:10px;
	background-color: #ccc;
}
.select {
	color: #f40;
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
		<table id="table" class="table table-hover table-bordered table-striped">
			<thead>
				<tr>
					<td>项目ID</td>
					<td>部门名称</td>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${pro}" var="pro">
				<tr data-id="${pro.id}">
					<td class="idTd">${pro.id}</td>
					<td class="nameTd">${pro.name}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>

	<label class="mes">已选</label>
	</div>
	<div id="btn">
		<div>
			<input id="add" class="btn btn-primary" type="button" value="← 加入">
		</div>
		<div>
			<input id="del" class="btn btn-success" type="button" value="移除 →">
		</div>
	</div>
	<div id="noHave">
		<table id="tableNo" class="table table-hover table-bordered table-striped">
			<thead>
				<tr>
					<td>项目ID</td>
					<td>部门名称</td>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${proNo}" var="pro">
				<tr data-id="${pro.id}">
					<td class="idTD">${pro.id}</td>
					<td class="nameTd">${pro.name}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	
	<label class="mes">未选</label>
	</div>
</div>
</body>
</html>