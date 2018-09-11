<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="js/jquery.js"></script>
<link rel="stylesheet" type="text/css"
	href="bootstrap/css/bootstrap.min.css">
<title>Insert title here</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}
body {
	/* 加载背景图 */
	/* background-image: url(picture/bg1.jpg);
	/* 背景图垂直、水平均居中 */
	/* background-position: center center;
	/* 背景图不平铺 */
	/* background-repeat: no-repeat;*/
	/* 当内容高度大于图片高度时，背景图像的位置相对于viewport固定 */
	/* background-attachment: fixed;*/
	/* 让背景图基于容器大小伸缩 */
	/* background-size: cover; */
	/* 设置背景颜色，背景图加载过程中会显示背景色 */
	background-color: #464646;
}

a {
	color: #31b0d5;
	text-decoration:none;
}

#top, #bottom {
	clear: both;
	width: 100%;
	height: 80px;
	color:#fff;
	font-family:KaiTi ;
}

#top {
	text-align: center;
	font-size: 28px;
	font-weight: bold;
	line-height: 80px;
	margin: 0 auto;
	position: relative;
}

#left {
	width: 20%;
	height: 600px;
	text-align: center;
	float: left;
}

#lefts {
	width: 100%;
	height: 560px;
	padding-top:30px;
}
.yi {
	height: 60px;
	line-height: 60px;
	font-size:17px;
	padding: 0 10px;
	color: #fff;
	margin-top: 10px;
	cursor:pointer; 
}
.er{
	display: none;
}
.er li {
	list-style: none;
	height: 40px;
	line-height: 40px;
	padding: 0 10px;
	color: #fff;
}

#right{
	width: 70%;
	height: 600px;
	float: left;
}
#right iframe{
	width: 1069px;
	height: 600px;
}
#control{
	height: 30px;
	line-height: 30px;
	font-size:12px;
	position: absolute;
	font-weight:normal;
	right: 15px;
	margin-top:-30px;
	padding: 0 22px;
	color: #ccc;
	font-family:SongTi ;
	cursor:pointer; 
}
#controls{
	display: none;
	right: 10px;
	position: absolute;
	width: 150px;
	height: 180px;
}
#controls li{
	font-weight:normal;
	list-style: none;
	height: 35px;
	line-height: 35px;
	font-size:13px;
	padding: 0 22px;
	color: #31b0d5;
	font-family:SongTi ;
}
.mouseOn{
	color: #f40;
	font-weight: bold;
}
.count{
	height: 30px;
	line-height: 30px;
	font-size:12px;
	margin-left:5%;
	padding: 0 22px;
	color: #ccc;
	font-family:SongTi ;
	cursor:pointer; 
}
</style>
<script type="text/javascript">
	$().ready(function() {
/* 		var time;
		$(".yi").hover(function() {
			clearTimeout(time);
			$(this).next(".er").show(500);
		}, function() {
			time = setTimeout(function() {
				$(this).next(".er").hide(500);
			}, 500)
		});
		$(".er ul").hover(function() {
			clearTimeout(time);
		}, function() {
			$(".er").hide(500)
		}); */
		$(".yi").click(function() {
			$(".er").hide(500);
			var next = $(this).next();
			if(next.css("display") == "none"){
				next.show(500);
			}
		})
		
		var time;
		$("#control").hover(function() {
			clearTimeout(time);
			$("#controls").show(500);
		},function(){
			time = setTimeout(function() {
				$("#controls").hide(500);
			}, 500)
		})
		$("#controls").hover(function() {
			clearTimeout(time);
		}, function() {
			$("#controls").hide(500)
		})
		
		$(".yi").hover(function() {
			$(this).addClass("mouseOn");
		},function(){
			$(this).removeClass("mouseOn");
		})
	})
	
	var websocket = null;

	//判断当前浏览器是否支持WebSocket
	if ('WebSocket' in window) {
		websocket = new WebSocket("ws://192.168.0.133:8080/dep2/websocket");
	} else {
		alert('没有建立websocket连接')
	}

	//连接发生错误的回调方法
	websocket.onerror = function() {
		//setMessage("错误");
	};

	//连接成功建立的回调方法
	websocket.onopen = function(event) {
		//setMessage("建立连接");
	}

	//接收到消息的回调方法
	websocket.onmessage = function(event) {
		var data = event.data;
		var arr = new Array();
		arr = data.split(":");
		if("num" == arr[0]){
			$("#count").html("当前访问人数："+arr[1]);
		}else if("distoryNum" == arr[0]){
			$("#diatoryCount").html("历史访问人数："+arr[1]);
		}
	}

	//连接关闭的回调方法
	websocket.onclose = function() {
		//setMessage("close");
	}

	//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口。
	window.onbeforeunload = function() {
		websocket.close();
	}
	//关闭连接
	function closeWebSocket() {
		websocket.close();
	}
</script>
</head>
<body>
	<div id="top">
		<lable>公司管理系统</lable>	
		<div id="control">当前管理员:${user.username}</div>
		<input type="hidden" name="userId" value="${user.id}">
		<div id="controls">
			<ul>
				<li><a target="right" href="user?type=showUpdate&name=${user.username}">修改信息</a></li>
				<li><a href="user?type=showAdd">新增管理员</a></li>
				<li><a href="user">退出</a></li>
			</ul>
		</div>
		
	</div>
	<div id="main">
		<div id="left">
			<div id="lefts">
				<div class="yi">员 工 面 板</div>
				<div class="er">
					<ul>
						<li><a target="right" href="employee">员工管理</a></li>
						<li><a target="right" href="employee?type=showAdd">员工添加</a></li>
					</ul>
				</div>
				<div class="yi">部 门 面 板</div>
				<div class="er">
					<ul>
						<li><a target="right" href="department">部门管理</a></li>
						<li><a target="right" href="department?type=showAdd">部门添加</a></li>
					</ul>
				</div>
				<div class="yi">项 目 面 板</div>
				<div class="er">
					<ul>
						<li><a target="right" href="project">项目管理</a></li>
						<li><a target="right" href="project?type=showAdd">项目添加</a></li>
					</ul>
				</div>
				<div class="yi">绩 效 面 板</div>
				<div class="er">
					<ul>
						<li><a target="right" href="score?type=show">绩效查询</a></li>
						<li><a target="right" href="score">绩效管理</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div id="right">
			<iframe name="right" scrolling="no" frameborder="0" src=""></iframe>
		</div>
	</div>
	<div id="bottom">
		<div id="count" class="count">当前访问人数：<%=application.getAttribute("num") %></div>
		<div id="diatoryCount" class="count">历史访问人数：<%=application.getAttribute("distoryNum") %></div>
	</div>
</body>
</html>