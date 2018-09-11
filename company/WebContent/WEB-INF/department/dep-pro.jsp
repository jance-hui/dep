<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
	$().ready(function(){
/* 		
		$("tr").click(function() {
			$(this).toggleClass("select");
		}) */
		
		$("#back").click(function(){
			location.href = "department";
		})
		
		$("#addPro").click(function(){
			var d_id = $("#top").find("[name = d_id]").val();
			var p_id = $("#selectPro").val();
			var p_name = $("#selectPro").find("option:selected").html();
			var i = 0;
			//location.href = "department?type=addPro&d_id="+ d_id+"&p_id="+p_id+"&d_name="+d_name;
			$.ajax({
				url:"department",
				type:"post",
				data:{type:"addPro",d_id:d_id,p_id:p_id},
				dataType:"text",
				success: function(data) {
					if(data=="true"){
						$("#selectPro").children().each(function(index,element) {
							if($(this).val()==p_id){
								p_name = $(this).text();
								i = index;
							}
						})
						var tr = "<tr><td>"+p_id+"</td><td>"+p_name+"</td></tr>"
						$("#table").append(tr);
						$("#selectPro").children().eq(i).remove();
					}
				}
				
			}) 
		})	
		var selectId = 0;
		$(document).on("click","tr",function(){
			$(this).toggleClass("select");
			selectId = $(this).data("id");
		})
		$("#delPro").click(function(){
			var d_id = $("#top").find("[name = d_id]").val();
			var p_name = "";
			var i = 0;
			//location.href = "department?type=addPro&d_id="+ d_id+"&p_id="+p_id+"&d_name="+d_name;
			$.ajax({
				url:"department",
				type:"post",
				data:{type:"delPro",d_id:d_id,p_id:selectId},
				dataType:"text",
				success: function(data) {
					if(data=="true"){
						$("tr").each(function(index,element) {
							if($(this).find("[class = idTD]").html()==selectId){
								p_name = $(this).find("[class = nameTd]").text();
								i = index;
							}
						})
						var option = "<option value='"+selectId+"'>"+p_name+"</option>";
						$("#selectPro").append(option);
						$("tr").eq(i).remove();
					}
				}
				
			}) 
		})	
	})

</script>
<style type="text/css">
#main {
	width: 600px;
	margin: 20px auto;
}
#main .select {
	background: #337ab7;
	color: #fff;
	font-weight: bold;
}
#btn div{
	float: left;
	margin-left: 30px;
	text-align: center;
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
</style>
</head>
<body>
	<div id="main">
		<div id="top">
			<input type="hidden" name="d_id" value="${d_id}">
			<label name="d_name">${d_name}</label>	
		</div>
		<div>		
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
						<td class="idTD">${pro.id}</td>
						<td class="nameTd">${pro.name}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<div id="btn">
			<div>
				<select id="selectPro" name="select" class="form-control">
					<c:forEach items="${proNo}" var="proNo">
					<option value="${proNo.id}">${proNo.name}</option>
					</c:forEach>
				</select>	
			</div>
			<div>
				<input id="addPro" class="btn btn-primary" type="button" value="增加项目">	
				<input id="delPro" class="btn btn-primary" type="button" value="删除项目">	
				<input id="back" class="btn btn-primary" type="button" value="返回">
			</div>
		</div>
	</div>
</body>
</html>