<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<style type="text/css">
#top,#main{
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
	width: 80px;
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
#iframe{
	width: 560px;
	height: 500px;
	margin-left: -10px;
}
</style>
<script type="text/javascript">
	$().ready(function() {
		
		$("#showAdd").click(function() {
			location.href = "department?type=showAdd";
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
				location.href = "department?type=" + type+ "&ids=" + ids;
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
		$("#showPro").click(function() {
			var length = $("#table .select").length;
			var d_id = "";
			var d_name = "";
			if (length==1) {
				$("#table .select").each(function(index, element) {
					d_id+=$(this).find(".id").text();
					d_name+=$(this).find(".name").text();
				})
				location.href = "department?type=showPro&d_id=" + d_id+"&d_name="+d_name;
			} else {
				alert("请选择一条数据");
			}
		})
		
		$("#showPro1").click(function() {
			var length = $("#table .select").length;
			var d_id = "";
			var d_name = "";
			if (length==1) {
				$("#table .select").each(function(index, element) {
					d_id+=$(this).find(".id").text();
					d_name+=$(this).find(".name").text();
				})
				location.href = "department?type=showPro1&d_id=" + d_id+"&d_name="+d_name;
			} else {
				alert("请选择一条数据");
			}
		})
		$("#showPro2").click(function() {
			var length = $("#table .select").length;
			var d_id = "";
			var d_name = "";
			if (length==1) {
				$("#table .select").each(function(index, element) {
					d_id+=$(this).find(".id").text();
					d_name+=$(this).find(".name").text();
				})
				location.href = "department?type=showPro2&d_id=" + d_id+"&d_name="+d_name;
			} else {
				alert("请选择一条数据");
			}
		})
		$("#showPro3").click(function() {
			var length = $("#table .select").length;
			var d_id = "";
			var d_name = "";
			if (length==1) {
				$("#table .select").each(function(index, element) {
					d_id+=$(this).find(".id").text();
					d_name+=$(this).find(".name").text();
				})
				location.href = "department?type=showPro3&d_id=" + d_id+"&d_name="+d_name;
			} else {
				alert("请选择一条数据");
			}
		})
		$("#showPro4").click(function() {
			var length = $("#table .select").length;
			var d_id = "";
			var d_name = "";
			if (length==1) {
				$("#table .select").each(function(index, element) {
					d_id=$(this).find(".id").text();
					d_name=$(this).find(".name").text();
				})
				$(".modal-body").empty();
				var iframe = "<iframe id='iframe' scrolling='no' frameborder='0' src='department?type=showPro2&d_id="+d_id+"&d_name="+d_name+"'></iframe>";
				$(".modal-body").append(iframe);
			} else {
				alert("请选择一条数据");
			}
		})
		
		$(document).on("dblclick",".dep",function() {
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
						var emp_count = $(this).find(".count").html();
						var deps ={
								id:id,
								name:name,
								emp_count:emp_count
						};
						nameArray.push(name);
						array.push(deps);
					})
				})
				var str = JSON.stringify(array);
				$.ajax({
					url:"department",
					type:"post",
					dataType:"text",
					data:{type:"update2",deps:str},
					success:function(data){
						$("#table .selectTr").each(function(index,element) {
							$(this).find(".name").css("display","inline");
							$(this).find("[name = updateName]").css("display","none");
							var name = nameArray[index];
							$(this).find(".name").html(name);
							$(this).removeClass("selectTr");
						})
					},
					error:function(data){
						alert("保存失败");
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
<title>部门管理</title>
</head>
<body>
<div id="top">
	<h2 align="center">部门管理</h2>
</div>
<div id="main">
	<div id="select">
			<form action="department?type=search" method="post">
				<div class="form-group">
					<div>
						<input type="text" class="col-sm-6 form-control" name="name" placeholder="请输入名称" <c:if test="${dep.name!=''}">value="${dep.name}"</c:if>>
					</div>	
					<div>
						<input type="text" class="col-sm-3 form-control" name="count" placeholder="请输入年龄" value="${dep.emp_count!=-1?dep.emp_count:''}">
					</div>
					<button type="submit" class="btn btn-primary">查找</button>
				</div>
			</form>
		</div>

		<table id="table"
			class="table table-hover table-bordered table-striped">
			<thead>
				<tr>
					<td>部门ID</td>
					<td>部门名称</td>
					<td>部门人数</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${depList}" var="deps">
				<tr class="dep">
					<td class="idTd">
						<p class="id">${deps.id}</p>
					</td>
					<td class="nameTd">
						<p class="name">${deps.name}</p>
						<input type="text" value="${deps.name}" name="updateName" style="display: none;"/>
					</td>
					<td class="countTd">
						<p><a class="count" href="employee?type=search&dep=${deps.id}">${deps.emp_count}</a></p>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="page">
		<div id="pages">
			<ul class="pagination">
				<li id="begin"><a href="department?type=search&ye=1&name=${dep.name}&count=${dep.emp_count}">首页</a></li>
				<li id="pre"><a href="department?type=search&ye=${p.ye-1}&name=${dep.name}&count=${dep.emp_count}">上一页</a></li>
			<c:forEach begin="${p.beginYe}" end="${p.endYe}" varStatus="status">
				<li <c:if test="${p.ye == status.index}">class="active"</c:if>><a href="department?type=search&ye=${status.index}&name=${dep.name}&count=${dep.emp_count}">${status.index}</a></li>
			</c:forEach>
				<li id="next"><a href="department?type=search&ye=${p.ye+1}&name=${dep.name}&count=${dep.emp_count}">下一页</a></li>
				<li id="end"><a href="department?type=search&ye=${p.maxYe}&name=${dep.name}&count=${dep.emp_count}">末页</a></li>
			</ul>
			</div>
			<div id="message"><p>共${p.maxYe}页</p></div>
		</div>
		<div>
			<input id="showAdd" class="btn btn-success" type="button" value="增加">
			<input id="showUpdate" class="btn btn-primary" type="button" value="修改"> 
			<input id="del" class="btn btn-warning" type="button" value="删除">  
			<input id="updateBatch" class="btn btn-info" type="button" value="直接修改">
		</div>
		<br>
		<div>
			<input id="showPro" class="btn btn-success" type="button" value="项目管理传统">
			<input id="showPro1" class="btn btn-primary" type="button" value="项目管理左右移">
			<input id="showPro2" class="btn btn-warning" type="button" value="项目管理批量">
			<input id="showPro3" class="btn btn-info" type="button" value="项目管理拖拽">
			<button id="showPro4" class="btn btn-primary" data-toggle="modal" data-target="#myModal">弹窗显示项目 </button>
			<!-- 模态框（Modal） -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
		</div>
	</div>
</div>
</body>
</html>