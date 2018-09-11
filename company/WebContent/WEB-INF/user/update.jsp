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
	width: 300px;
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
p{
	color: red;
	display: none;
}
</style>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.md5.js"></script>
<script type="text/javascript">
$().ready(function() {
	$("#newName").blur(function() {
		var newName ="";
		if($(this).val() != '${user.username}'){
			newName = $(this).val();
			$.ajax({
				url:"user",
				type:"post",
				data:{"type":"search","newName":newName},
				dataType:"text",
				success: function (data) {
					if(data == 'true'){
						$("#newNameP").show(200);
					}else{
						$("#newNameP").hide(200);
						$("#saveBtn").attr('disabled',false); 
					}
				}
			})
		}else {
			$("#newNameP").hide(200);
		}
	})
	$("#oldPwd").blur(function() {
		if($.md5($(this).val()) != '${user.password}'){
			$("#oldPwdP").show(200);
		}else{
			$("#oldPwdP").hide(200);
			$("#saveBtn").attr('disabled',false); 
		}
	})
})
</script>
</head>
<body>
	<div id="top">
		<label>修改管理员信息</label>	
	</div>
	<div id="main">
		<form class="form-horizontal" role="form" action="user" method="post">
			<input type="hidden" name="type" value="update">
			<input type="hidden" name="id" value="${user.id}">
			<div class="form-group">
				<label class="col-sm-4 control-label">用户名：</label>
				<div class="col-sm-8">
					<input id="newName" type="text" class="form-control" name="name" placeholder="请输入新的用户名" autocomplete="off">
					<p id="newNameP">用户名重复</p>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">旧密码：</label>
				<div class="col-sm-8">
					<input id="oldPwd" type="password" class="form-control" placeholder="请输入旧的密码">
					<p id="oldPwdP">密码不一致</p>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">新密码：</label>
				<div class="col-sm-8">
					<input type="password" class="form-control" name="pwd" placeholder="请输入新的密码">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-4 col-sm-10">
					<button id="saveBtn" type="submit" class="btn btn-primary" disabled="disabled">确认修改</button>
				</div>
			</div>
		</form>
	</div>

</body>
</html>