<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	$(document).on("change","#img",function(){
		alert($(this).val());
		
	})
})
</script>
</head>
<body>
	<div id="top">
		<label>新增员工</label>	
	</div>
	<div id="main">
		<form class="form-horizontal" role="form" action="employee?type=add2" method="post" enctype="multipart/form-data">

			<input type="hidden" name="type" value="add2">
			<div class="form-group">
				<label for="firstname" class="col-sm-5 control-label">员工姓名：</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" name="name" placeholder="请输入姓名">
				</div>
			</div>
			<div class="form-group">
				<label for="firstname" class="col-sm-5 control-label">员工性别：</label>
				<div class="col-sm-5">
					<input type="radio" value="男" name="sex" checked="checked">男</input> 
					<input type="radio" value="女" name="sex" >女</input>
				</div>
			</div>
			<div class="form-group">
				<label for="firstname" class="col-sm-5 control-label">员工年龄：</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" name="age" placeholder="请输入年龄">
				</div>
			</div>
			<div class="form-group">
				<label for="firstname" class="col-sm-5 control-label">员工部门：</label>
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
				<label for="firstname" class="col-sm-5 control-label">员工头像：</label>
				<div class="col-sm-5">
					<input type="file" id="img" name="img" value="上传图片">
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