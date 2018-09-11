<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>员工管理</title>
<link rel="stylesheet" type="text/css"
	href="bootstrap/css/bootstrap.min.css">
<style type="text/css">
#top,#main {
	width: 750px;
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

#page {
	width: 700px;
	float: left;
	position: relative;
}

#pages {
	position: relative;
	float: left;
}

#message {
	float: left;
	position: relative;
	margin-top: 30px;
	margin-left: 15px;
	color: #ccc;
	font-size: 14px;
}
#select{
	margin-top: 20px;
	text-align: center;
}
#select {
	width:750px;
	height:50px;
	margin:0 auto;
}
#select div{
	float: left;
	margin-left: 5px;
}
#select button{
	margin-left: 30px;
}
#showImg{
	width:150px;
	height:150px;
	position: absolute;
	display: none;
}
</style>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$().ready(function() {
		
		$("#showAdd").click(function() {
			location.href = "employee?type=showAdd";
		})
		$("#showAdd2").click(function() {
			location.href = "employee?type=showAdd2";
		})
		
		var selectId = -1;
		var selectIds = new Array();
		
		$("tr").click(function() {
			$(this).toggleClass("select");
				selectId = $(this).data("id");
		})

		$("#showUpdate").click(function() {
			if (selectId > -1) {
				location.href = "employee?type=showUpdate&id="+ selectId;
			} else {
				alert("请选择数据");
			}
		})
		
		$("#del").click(function() {
			if (selectId > -1) {
				location.href = "employee?type=del&id="+ selectId;
			} else {
				alert("请选择数据");
			}
		})

		function doBatch(type) {
			var length = $("#table .select").length;
			var ids = new Array();
			if (length > 0) {
				$("#table .select").each(function(index, element) {
					ids.push($(this).data("id"));
				})
				location.href = "employee?type=" + type+ "&ids=" + ids;
			} else {
				alert("请选择数据");
			}
		}

		$("#showUpdateBatch").click(function() {
			doBatch("showUpdateBatch");
		})

		$("#delBatch").click(function() {
			doBatch("delBatch");
		})
		

		$(document).on("dblclick",".emp",function(){
			$(this).unbind("dblclick");
			$(this).unbind("click");
			
			$(this).addClass("selectTr");
			
			$(this).find(".name").css("display","none");
			$(this).find("[name = updateName]").css("display","inline");
			
			$(this).find(".sex").css("display","none");
			$(this).find("[name = updateSex]").css("display","inline");
			
			$(this).find(".age").css("display","none");
			$(this).find("[name = updateAge]").css("display","inline");
	
			$(this).find(".dep").css("display","none");
			$(this).find("[name = updateDep]").css("display","inline");
			
			$(this).find(".updateImg").css("display","inline");
		})
		
		$("#updateBatch").click(function() {
			var length = $("#table .selectTr").length;
			if (length > 0) {
				var array = new Array();
				var nameArray = new Array();
				var sexArray = new Array();
				var ageArray = new Array();
				var depArray = new Array();
				var imgArray = new Array();
				$("#table .selectTr").each(function(index,element) {
					$(this).each(function(index,element) {
						var ids = $(this).find("[name = id]").val();
						var names = $(this).find("[name = updateName]").val();
						var sexs = $(this).find("[name = updateSex]").val();
						var ages = $(this).find("[name = updateAge]").val();
						var imgs = $(this).find("[name = img]").val();
						var dep_id = $(this).find("[name = updateDep]").val();
						var dep_name = $(this).find("[name = updateDep]").find("option:selected").text();
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
						nameArray.push(names);
						sexArray.push(sexs);
						ageArray.push(ages);
						depArray.push(dep_name);
						imgArray.push(imgs);
						array.push(emps);
					})
				})
				var str = JSON.stringify(array);
				//url传输不能有大括号{} 使用str.replace()转换。
				//str = str.replace(/{/g,"%7b");
				//str = str.replace(/}/g,"%7d");
				//alert(str);
				//location.href = "employee?type=updateBatch2&emps="+ str;
				$.ajax({
					url:"employee",
					type:"post",
					dataType:"text",
					data:{type:"updateBatch2",emps:str},
					success:function(data){
						$("#table .selectTr").each(function(index,element) {
							
							$(this).find(".name").css("display","inline");
							$(this).find("[name = updateName]").css("display","none");
							
							$(this).find(".sex").css("display","inline");
							$(this).find("[name = updateSex]").css("display","none");
							
							$(this).find(".age").css("display","inline");
							$(this).find("[name = updateAge]").css("display","none");
					
							$(this).find(".dep").css("display","inline");
							$(this).find("[name = updateDep]").css("display","none");
							
							$(this).find(".updateImg").css("display","none");
							var name = nameArray[index];
							var sex = sexArray[index];
							var age = ageArray[index];
							var dep = depArray[index];
							$(this).find(".name").html(name);
							$(this).find(".sex").html(sex);
							$(this).find(".age").html(age);
							$(this).find(".dep").html(dep);
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
		
		$(".photo").hover(function (event) {
			var src = $(this)[0].src;
			$("#showImg").show(100);
			$("#showImg").css({left:event.pageX+50,top:event.pageY})
			$("#showImg img").attr("src",src); 
		},function(){
			$("#showImg").hide(100);
			$("#showImg img").attr("src","");
		})
		
		var j=0;
		$(document).on("click",".upload",function(){
			var formData = new FormData();
			var photo = $(this).parent().parent().find(".photo");
			var img = $(this).parent().find("[name = img]");
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
</head>
<body>
	<div id="top">
		<h2 align="center">员工管理</h2>
	</div>
	<div id="main">
		<div id="select">
			<form action="employee" method="post">
				<div class="form-group">
					<div>
						<input type="text" class="col-sm-4 form-control" name="name" placeholder="请输入名称" <c:if test="${emp.name!=''}">value="${emp.name}"</c:if>>
					</div>	
					<div>
						<select name="sex"  class="col-sm-4 form-control">
							<option value="">请选择性别</option>
							<option value="男" <c:if test="${emp.sex=='男'}">selected</c:if>>男</option>
							<option value="女" <c:if test="${emp.sex=='女'}">selected</c:if>>女</option>
						</select>
					</div>
					<div>
						<input type="text" class="col-sm-4 form-control" name="age" placeholder="请输入年龄" value="${emp.age!=-1?emp.age:''}">
					</div>
					<div>
						<select name="dep"  class="col-sm-4 form-control">
							<option value="0">请选择部门</option>
							<c:forEach items="${dep}" var="deps">
							<option value="${deps.id}" <c:if test="${emp.dep.id==deps.id}">selected</c:if>>${deps.name}</option>
							</c:forEach>
						</select>
					</div>
					<button type="submit" class="btn btn-primary">查找</button>
				</div>
			</form>
		</div>
		<table id="table"
			class="table table-hover table-bordered table-striped">
			<thead>
				<tr>
					<td>姓名</td>
					<td>性别</td>
					<td>年龄</td>
					<td>部门</td>
					<td>头像</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${emps}" var="emp">
					<tr class="emp" data-id="${emp.id}">
						<input type="hidden" name="id" value="${emp.id}"/>
						<input type="hidden" name="d_id" value="${emp.dep.id}"/>
						<input type="hidden" name="d_count" value="${emp.dep.emp_count}"/>
						<td class="nameTd">
							<p class="name">${emp.name}</p> <input type="text"
							value="${emp.name}" name="updateName" style="display: none;" />
						</td>
						<td class="sexTd">
							<p class="sex">${emp.sex}</p> <select name="updateSex"
							style="display: none;">
								<option value="男"
									<c:if test="${emp.sex == '男'}"> selected </c:if>>男</option>
								<option value="女"
									<c:if test="${emp.sex == '女'}"> selected </c:if>>女</option>
						</select>
						</td>
						<td class="ageTd">
							<p class="age">${emp.age}</p> 
							<input type="text" value="${emp.age}" name="updateAge" style="display: none;" />
						</td>
						<td class="depTd">
							<p class="dep">${emp.dep.name}</p> 
							<select name="updateDep" style="display: none;">
								<option value="0"></option>
								<c:forEach items="${dep}" var="dep">
									<option value="${dep.id}"
										<c:if test="${dep.id == emp.dep.id}"> selected </c:if>>${dep.name}</option>
								</c:forEach>
							</select>
						</td>
						<td>
							<img class="photo" style="width: 45px;height: 45px;float: left;" alt="${emp.name}" src="empImg/${emp.img}">
							<div class="updateImg" style="display: none;float: left;margin-left: 5px;">
								<input type="file" class="img" value="更新头像">
								<input type="hidden" name="img" value="${emp.img}">
								<input class="btn btn-info btn-xs upload" type="button" value="上传">
							</div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="page">
			<div id="pages">
				<ul class="pagination">
					<li id="begin"><a href="employee?ye=1&name=${emp.name}&sex=${emp.sex}&age=${emp.age!=-1?emp.age:''}&dep=${emp.dep.id}">首页</a></li>
					<li id="pre"><a href="employee?ye=${p.ye-1}&name=${emp.name}&sex=${emp.sex}&age=${emp.age!=-1?emp.age:''}&dep=${emp.dep.id}">上一页</a></li>
					<c:forEach begin="${p.beginYe}" end="${p.endYe}" varStatus="status">
						<li <c:if test="${p.ye == status.index}">class="active"</c:if>><a
							href="employee?ye=${status.index}&name=${emp.name}&sex=${emp.sex}&age=${emp.age!=-1?emp.age:''}&dep=${emp.dep.id}">${status.index}</a></li>
					</c:forEach>
					<li id="next"><a href="employee?ye=${p.ye+1}&name=${emp.name}&sex=${emp.sex}&age=${emp.age!=-1?emp.age:''}&dep=${emp.dep.id}">下一页</a></li>
					<li id="end"><a href="employee?ye=${p.maxYe}&name=${emp.name}&sex=${emp.sex}&age=${emp.age!=-1?emp.age:''}&dep=${emp.dep.id}">末页</a></li>
				</ul>
			</div>
			<div id="message">
				<p>共${p.maxYe}页</p>
			</div>
		</div>
		<div>
			<input id="showAdd" class="btn btn-warning" type="button" value="增加">
			<input id="showAdd2" class="btn btn-success" type="button" value="增加ajax">
			<input id="showUpdate" class="btn btn-primary" type="button" value="修改">
			<input id="del" class="btn btn-warning" type="button" value="删除"> 
			<input id="showUpdateBatch" class="btn btn-info" type="button" value="转页修改"> 
			<input id="updateBatch" class="btn btn-primary" type="button" value="直接修改">
			<input id="delBatch" class="btn btn-warning" type="button" value="批量删除"> 
		</div>
	</div>
	<div id="showImg">
		<img style="border:1px solid #000;width: 150px;height: 150px;" alt="" src="">
	</div>
</body>
</html>