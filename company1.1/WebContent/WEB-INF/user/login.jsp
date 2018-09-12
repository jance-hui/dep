<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>登录</title>
<link rel="stylesheet" type="text/css"
	href="bootstrap/css/bootstrap.min.css">
<style type="text/css">
#top, #login {
	width: 300px;
	margin: 60px auto;
	color: #fff;
}

#top {
	margin-top: 120px;
}

#login div {
	margin-top: 5px
}

body {
	/* 加载背景图 */
	background-image: url(picture/bg2.jpg);
	/* 背景图垂直、水平均居中 */
	background-position: center center;
	/* 背景图不平铺 */
	background-repeat: no-repeat;
	/* 当内容高度大于图片高度时，背景图像的位置相对于viewport固定 */
	background-attachment: fixed;
	/* 让背景图基于容器大小伸缩 */
	background-size: cover;
	/* 设置背景颜色，背景图加载过程中会显示背景色 */
	background-color: #464646;
}
p{
	color: red;
	display: none;
	height: 25px;
	line-height: 25px;
}
</style>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
if(self != top){
	top.location = "user";
}

$().ready(function() {
	$("#img").click(function() {
		$(this).attr("src","authImage?a="+Math.random());
	})
	if("${error}"=="img"){
		$("#imgP").show(200);
	}
	$("[name = rand]").focus(function () {
		$("#imgP").hide(200);
	})
	if("${error}" =="pwd"){
		$("#pwdP").show(200);
	}
	$("[name = username]").focus(function () {
		$("#pwdP").hide(200);
	})
	$("[name = password]").focus(function () {
		$("#pwdP").hide(200);
	})
})
</script>
</head>
<body>
	<div id="top">
		<h1 align="center" style="font-family:KaiTi ;">登录</h1>
	</div>
	<div id="login">
		<form action="user" method="post">
			<input type="hidden" name="type" value="doLogin">
			<div class="form-group col-sm-12">
				<input type="text" class="form-control" name="username" placeholder="请输入用户名" value="${name}">
			</div>
			<div class="form-group col-sm-12">
				<input type="password" class="form-control" name="password" placeholder="请输入密码">
				<p id="pwdP">用户名或密码错误</p>
			</div>
			<div class="form-group col-sm-12">
				<input type="text" class="form-control" name="rand" placeholder="请输入下方验证码" autocomplete="off"> 
				<p id="imgP">验证码错误</p>
				<img id="img" style="margin-top: 10px;" alt="验证码" src="authImage">
			</div>
			<div class="form-group">
				<button type="submit" class="btn btn-primary btn-lg btn-block">登录</button>
			</div>
		</form>
	</div>
</body>
</html>