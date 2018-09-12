<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
$().ready(function () {
	$("#saveBtn").click(function () {
		var array = new Array();
		$(".emp").each(function(index,element){
			var ids = $(this).find("[name = id]").val();
			var names = $(this).find("[name = name]").val();
			var sexs = $(this).find("[name = sex]:checked").val();
			var ages = $(this).find("[name = age]").val();
			var imgs = $(this).find("[name = img]").val();
			var dep_id = $(this).find("[name = dep]").val();
			var dep_name = $(this).find("[name = d_id]").val();
			var dep_count = $(this).find("[name = d_count]").val();
		
			var deps ={
					id:dep_id,
					name:dep_name,
					emp_count:dep_count
			};
			var emps ={
					id:ids,
					name:names,
					sex:sexs,
					age:ages,
					dep:deps,
					img:imgs
			};
			array.push(emps);
		})
		var str = JSON.stringify(array);
		//url传输不能有大括号{} 使用str.replace()转换。
		str = str.replace(/{/g,"%7b");
		str = str.replace(/}/g,"%7d");
		//alert(str);
		location.href = "employee?type=updateBatch&emps=" +str;
	})
	var j=0;
	$(".upload").click(function(){
		var formData = new FormData();
		var photo = $(this).parent().prev().find(".photo");
		var img = $(this).parent().prev().find("[name = img]");
		for(var i=0;i<$(".img")[j].files.length;i++){
			formData.append("img",$(".img")[j].files[i]);
		}
		$.ajax({
			url:"employee?type=upload",
			type : "post",
			data : formData,
			cache : false,
			processData : false,
			contentType : false,
			dataType : "text",
			success : function(data){
				photo.attr("src","empImg/"+data);
				img.val(data);
			}
		});
		j+=1;
	})
})
</script>
<style type="text/css">
#main {
	width: 400px;
	margin: 20px auto;
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
#saveBtn{
	text-align: center;
}
</style>
</head>
<body>
	<div id="top">
		<label>批量修改员工</label>	
	</div>
	<div id="main">
	<c:forEach items="${emp}" var="emp">
		<form class="form-horizontal emp" role="form" action="employee" method="post">
			<input type="hidden" name="id" value="${emp.id}">
			<input type="hidden" name="d_id" value="${emp.dep.id}">
			<input type="hidden" name="d_count" value="${emp.dep.emp_count}">
			<div class="form-group">
				<label for="firstname" class="col-sm-5 control-label">修改员工姓名：</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" name="name" value="${emp.name}">
				</div>
			</div>
			<div class="form-group">
				<label for="firstname" class="col-sm-5 control-label">修改员工性别：</label>
				<div class="col-sm-5">
					<input type="radio" value="男" name="sex"
						<c:if test="${emp.sex == '男'}"> checked </c:if>>男
					<input type="radio" value="女" name="sex"
						<c:if test="${emp.sex == '女'}"> checked </c:if>>女
				</div>
			</div>
			<div class="form-group">
				<label for="firstname" class="col-sm-5 control-label">修改员工年龄：</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" name="age"
						value="${emp.age}">
				</div>
			</div>
			<div class="form-group">
				<label for="firstname" class="col-sm-5 control-label">修改员工部门：</label>
				<div class="col-sm-5">
					<select name="dep" class="form-control">
						<option value="0">请选择部门</option>
						<c:forEach items="${dep}" var="dep">
						<option value="${dep.id}" <c:if test="${dep.name == emp.dep.name}"> selected </c:if>>${dep.name}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="firstname" class="col-sm-5 control-label">修改员工头像：</label>
				<div class="col-sm-5">
					<input type="hidden" name="img" value="${emp.img}">
					<input type="file" class="img" value="上传图片">
					<img class="photo" style="width: 100px;height: 100px" alt="${emp.name}" src="empImg/${emp.img}">
				</div>
				<div class="col-sm-2">
					<input type="button" class="upload btn btn-success" value="上传"/>
				</div>
			</div>
			
		</form>
		<hr>
		</c:forEach>
		<div id="saveBtn" class="form-group">
			<div class="col-sm-offset-1 col-sm-10">
				<button type="button" class="btn btn-primary">保存</button>
			</div>
		</div>
	</div>
</body>
</html>