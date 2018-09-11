<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
</head>
<body>
<div id="top">
		<label>新增部门</label>	
	</div>
	<div id="main">
		<form class="form-horizontal" role="form" action="department" method="post">
			<input type="hidden" name="type" value="add">
			<input type="hidden" name="count" value="0">
			<div class="form-group">
				<label class="col-sm-4 control-label">部门名称：</label>
				<div class="col-sm-7">
					<input type="text" class="form-control" name="name" placeholder="请输入部门名称">
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