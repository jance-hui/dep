<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>项目管理</title>
<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery.js"></script>
<style type="text/css">
#top,#main {
	width: 600px;
	margin: 30px auto;
}

#main .select {
	background: #337ab7;
	color: #fff;
	font-weight: bold;
}
#table td {
	width: 120px;
}
#table input {
	width: 180px;
	height: 25px;
}

select {
	width: 80px;
	height: 25px;
}
#page{
	width: 100%;
	float: left;
}
#pages{
	position:relative;
	float: left;
}
#message{
	float: left;
	position:relative;
	margin-top:30px;
	margin-left:15px;
	color:#ccc;
	font-size: 14px;
}
#select{
	margin-top: 20px;
	text-align: center;
}
#select div{
	float: left;
	margin-left: 10px;
}
#select button{
	margin-left: 30px;
}
</style>
<script type="text/javascript">
	$().ready(function() {
		
		$("#showAdd").click(function() {
			location.href = "project?type=showAdd";
		})
		
		
		$("tr").click(function() {
			$(this).toggleClass("select");
		})

		var selectIds = new Array();
		function doBatch(type) {
			var length = $("#table .select").length;
			var ids = new Array();
			if (length > 0) {
				$("#table .select").each(function(index, element) {
					ids.push($(this).find(".id").text());
				})
				location.href = "project?type=" + type+ "&ids=" + ids;
			} else {
				alert("请选择数据");
			}
		}
		$("#showUpdate").click(function() {
			doBatch("showUpdate");
		})
		$("#del").click(function() {
			doBatch("del");
		})
		$(document).on("dblclick",".pro",function(){
			$(this).unbind("dblclick");
			$(this).unbind("click");
			
			$(this).addClass("selectTr");
			
			$(this).find(".name").css("display","none");
			$(this).find("[name = updateName]").css("display","inline");	
		})
		
		$("#updateBatch").click(function() {
			var length = $("#table .selectTr").length;
			if (length > 0) {
				var array = new Array();
				var nameArray = new Array();
				$("#table .selectTr").each(function(index,element) {
					$(this).each(function(index,element) {
						var id = $(this).find(".id").html();
						var name = $(this).find("[name = updateName]").val();
						var pros ={
								id:id,
								name:name
						};
						nameArray.push(name);
						array.push(pros);
					})
				})
				var str = JSON.stringify(array);
				$.ajax({
					url:"project",
					type:"post",
					dataType:"text",
					data:{type:"update2",pros:str},
					success:function(data){
						$("#table .selectTr").each(function(index,element) {
							$(this).find(".name").css("display","inline");
							$(this).find("[name = updateName]").css("display","none");
							var name = nameArray[index];
							$(this).find(".name").html(name);
							$(this).removeClass("selectTr");
						})
					}
				})
			} else {
				alert("请选择数据");
			}
		})
		if(${p.ye}<=1){
			$("#pre").addClass("disabled");
			$("#pre").find("a").attr("onclick","return false");
			$("#begin").addClass("disabled");
			$("#begin").find("a").attr("onclick","return false")
		}
		if(${p.ye}>=${p.maxYe}){
			$("#next").addClass("disabled");
			$("#next").find("a").attr("onclick","return false");
			$("#end").addClass("disabled");
			$("#end").find("a").attr("onclick","return false")
		}
	})
</script>
</head>
<body>
<div id="top">
	<h2 align="center">项目管理</h2>
</div>
<div id="main">
	<div id="select">
			<form action="project" method="post">
				<div class="form-group">
					<div>
						<input type="text" class="col-sm-4 form-control" name="name" placeholder="请输入名称" <c:if test="${pro.name!=''}">value="${pro.name}"</c:if> >
					</div>
					<button type="submit" class="btn btn-primary">查找</button>
				</div>
			</form>
		</div>

		<table id="table" class="table table-hover table-bordered table-striped">
			<thead>
				<tr>
					<td>项目ID</td>
					<td>项目名称</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${proList}" var="pros">
				<tr class="pro">
					<td class="idTd">
						<p class="id">${pros.id}</p>
					</td>
					<td class="nameTd">
						<p class="name">${pros.name}</p>
						<input type="text" value="${pros.name}" name="updateName" style="display: none;"/>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="page">
		<div id="pages">
			<ul class="pagination">
				<li id="begin"><a href="project?ye=1&name=${pro.name}">首页</a></li>
				<li id="pre"><a href="project?ye=${p.ye-1}&name=${pro.name}">上一页</a></li>
			<c:forEach begin="${p.beginYe}" end="${p.endYe}" varStatus="status">
				<li <c:if test="${p.ye == status.index}">class="active"</c:if>><a href="project?ye=${status.index}&name=${pro.name}">${status.index}</a></li>
			</c:forEach>
				<li id="next"><a href="project?ye=${p.ye+1}&name=${pro.name}">下一页</a></li>
				<li id="end"><a href="project?ye=${p.maxYe}&name=${pro.name}">末页</a></li>
			</ul>
			</div>
			<div id="message"><p>共${p.maxYe}页</p></div>
		</div>
		<div>
			<input id="showAdd" class="btn btn-primary" type="button" value="增加">
			<input id="showUpdate" class="btn btn-info" type="button" value="修改"> 
			<input id="del" class="btn btn-warning" type="button" value="删除">  
			<input id="updateBatch" class="btn btn-success" type="button" value="直接修改">
		</div>
	</div>
</body>
</html>