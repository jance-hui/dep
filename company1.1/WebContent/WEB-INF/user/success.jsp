<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
<title>选择</title>
<style type="text/css">
#top{
	width: 100%;
	height: 20px;
}
#top ul{list-style: none;}
#top li,a{
	float: left;
	margin-left: 30px;
	color: #f40;
}
#chose{
	width: 400px;
	margin: 30px auto;
}
</style>
</head>
<body>
<div id="top">
	<ul>
		<li>用户：${user.username} </li>
		<li><a href="user?type=showUpdate&name=${user.username}">修改</a></li>
		<li><a href="user">退出</a></li>
		<li><a href="user?type=showAdd">新增管理员</a></li>
	</ul>
</div>
<div id="chose">
		<a href="employee" class="btn btn-primary btn-lg btn-block">员工管理</a>
		<a href="department" class="btn btn-info btn-lg btn-block">部门管理</a>
		<a href="project" class="btn btn-warning btn-lg btn-block">项目管理</a>	
		<a href="score" class="btn btn-success btn-lg btn-block">绩效管理</a>
</div>
	
</body>
</html>