<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="bootstrap/css/bootstrap.min.css">
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
</style>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
$().ready(function() {
	$("#upload").click(function(){
		var formData = new FormData();
		for(var i=0;i<$("#img")[0].files.length;i++){
			formData.append("img",$("#img")[0].files[i]);
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
				$("#photo").attr("src","empImg/"+data);
				$("[name = img]").val(data);
			}
		})
	})
})
</script>
</head>
<body>
	<div id="top">
		<label>修改员工</label>	
	</div>
	<div id="main">
		<form class="form-horizontal" role="form" action="employee" method="post">
			<input type="hidden" name="type" value="update">
			<input type="hidden" name="id" value="${emp.id}">
			<div class="form-group">
				<label for="firstname" class="col-sm-5 control-label">修改员工姓名：</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" name="name"
						value="${emp.name}">
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
					<img id="photo" style="width: 100px;height: 100px" alt="${emp.name}" src="empImg/${emp.img}">
					<input type="hidden" name="img" value="${emp.img}">
					<input type="file" id="img" value="上传图片">
				</div>
				<div class="col-sm-2">
					<input id="upload" type="button" class="btn btn-success" value="上传"/>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-5 col-sm-10">
					<button type="submit" class="btn btn-primary">保存</button>
				</div>
			</div>
		</form>
	</div>

</body>
</html>