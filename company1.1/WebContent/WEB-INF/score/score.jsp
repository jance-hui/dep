<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>绩效管理</title>
<link rel="stylesheet" type="text/css"
	href="bootstrap/css/bootstrap.min.css">
<style type="text/css">
#top {
	width: 100%;
	height: 60px;
	text-align: center;
	font-size: 28px;
	font-weight: bold;
	line-height: 60px;
	margin: 0 auto;
}
#main {
	width: 900px;
	margin: 30px auto;
}

#main .select {
	background: #337ab7;
	color: #fff;
	font-weight: bold;
}
#table{margin-left: 10px;}
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
	width: 100%;
	float: left;
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
#select div{
	float: left;
	margin-left: 10px;
}
#select button{
	margin-left: 30px;
}
#page,#save{margin-left: 20px;}
</style>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$().ready(function() {
		if($("#selectDep").val() != ""){
			var d_id = $("#selectDep").val();
			$.ajax({
				url:"score",
				type:"post",
				data:{type:"findPro",d_id:d_id},
				dataType:"json",
				success: function(data) {
					var result = data;
					var pro = "<option value='''>请选择项目</option>";
					$.each(result,function(index, n){
						pro+="<option value='"+result[index].id+"'>"+result[index].name+"</option>";
					});
					$("#selectPro").empty();
					$("#selectPro").html(pro); 
				}
			})
		}
		
		$(document).on("dblclick",".emp",function(){
			$(this).unbind("dblclick");
			$(this).unbind("click");
			$(this).addClass("selectTr");
	
			$(this).find(".value").css("display","none");
			$(this).find("[name = updateValue]").css("display","inline");
		
		})
		$(document).on("blur",".selectTr .updateValue",function(){
			
			var length = $("#table .selectTr").length;
			if (length > 0) {
				var array = new Array();
				var select = $("#table .selectTr");
				var value = select.find("[name = updateValue]").text();
				var e_id = select.find("[name = empId]").val();
				var p_id = select.find("[name = proId]").val();
				var id = select.find("[name = scId]").val();
				var value = 0;
				if(select.find("[name = updateValue]").val() != ""){
					value = select.find("[name = updateValue]").val();
				}
				$.ajax({
					url:"score",
					type:"post",
					data:{type:"update",id:id,e_id:e_id,p_id:p_id,value:value},
					dataType:"json",
					success:function(data){
						select.find(".value").css("display","inline");
						select.find("[name = updateValue]").css("display","none");
						select.find(".value").html(data.value);
						select.find(".scGrade").html(data.grade);
						select.find("[name = scId]").val(data.id);
						$(".emp").removeClass("selectTr");
					}
				})
			} else {
				alert("请选择数据");
			}
		})
		
		$(document).on("change","#selectDep",function(){
			var d_id = $(this).val();
			$.ajax({
				url:"score",
				type:"post",
				data:{type:"findPro",d_id:d_id},
				dataType:"json",
				success: function(data) {
					var result = data;
					var pro = "<option value='''>请选择项目</option>";
					$.each(result,function(index, n){
						pro+="<option value='"+result[index].id+"'>"+result[index].name+"</option>";
					});
					$("#selectPro").empty();
					$("#selectPro").html(pro); 
				}
			})
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
</head>
<body>
	<div id="top">
		<label>绩效管理</label>	
	</div>
	<div id="main">
		<div id="select">
			<form action="score?type=search" method="post">
				<div class="form-group">
					<div>
						<input type="text" class="col-sm-4 form-control" name="empName" placeholder="请输入姓名" <c:if test="${sc.emp.name!=''}">value="${sc.emp.name}"</c:if>>
					</div>
					<div>
						<select id="selectDep" name="dep" class="col-sm-4 form-control">
							<option value="">请选择部门</option>
							<c:forEach items="${dep}" var="deps">
							<option value="${deps.id}" <c:if test="${sc.emp.dep.id==deps.id}">selected</c:if>>${deps.name}</option>
							</c:forEach>
						</select>
					</div>
					<div>
						<select id="selectPro" name="pro" class="col-sm-4 form-control">
							<option value="">请选择项目</option>
							<c:forEach items="${pro}" var="pros">
							<option value="${pros.id}" <c:if test="${sc.pro.id==pros.id}">selected</c:if>>${pros.name}</option>
							</c:forEach>
						</select>
					</div>
					<div>
						<select name="grade" class="col-sm-4 form-control">
							<option value="">请选择等级</option>
							<option value="优秀" <c:if test="${sc.grade=='优秀'}">selected</c:if>>优秀</option>
							<option value="良好" <c:if test="${sc.grade=='良好'}">selected</c:if>>良好</option>
							<option value="一般" <c:if test="${sc.grade=='一般'}">selected</c:if>>一般</option>
							<option value="及格" <c:if test="${sc.grade=='及格'}">selected</c:if>>及格</option>
							<option value="不及格" <c:if test="${sc.grade=='不及格'}">selected</c:if>>不及格</option>
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
					<td>部门</td>
					<td>项目</td>
					<td>成绩</td>
					<td>等级</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${scList}" var="scs">
					<tr class="emp" data-id="${scs.id}">
						<input type="hidden" name="empId" value="${scs.emp.id}">
						<input type="hidden" name="proId" value="${scs.pro.id}">
						<input type="hidden" name="scId" value="${scs.id}">
										
						<td class="empNameTd">
							<p class="empName">${scs.emp.name}</p>
						</td>
						<td class="depNameTd">
							<p class="depName">${scs.emp.dep.name}</p>
						</td>
						<td class="proNameTd">
							<p class="proName">${scs.pro.name}</p>
						</td>
						<td class="valueTd">
							<p class="value">${scs.value}</p> 
							<input type="text" value="${scs.value}" class="updateValue" name="updateValue" style="display: none;" />
						</td>
						<td class="gradeTd">
							<p class="scGrade">${scs.grade}</p>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="page">
			<div id="pages">
				<ul class="pagination">
					<li id="begin"><a href="score?type=search&ye=1&empName=${sc.emp.name}&dep=${sc.emp.dep.id!=-1?sc.emp.dep.id:''}&pro=${sc.pro.id!=-1?sc.pro.id:''}&grade=${sc.grade}">首页</a></li>
					<li id="pre"><a href="score?type=search&ye=${p.ye-1}&empName=${sc.emp.name}&dep=${sc.emp.dep.id!=-1?sc.emp.dep.id:''}&pro=${sc.pro.id!=-1?sc.pro.id:''}&grade=${sc.grade}">上一页</a></li>
					<c:forEach begin="${p.beginYe}" end="${p.endYe}" varStatus="status">
						<li <c:if test="${p.ye == status.index}">class="active"</c:if>><a
							href="score?type=search&ye=${status.index}&empName=${sc.emp.name}&dep=${sc.emp.dep.id!=-1?sc.emp.dep.id:''}&pro=${sc.pro.id!=-1?sc.pro.id:''}&grade=${sc.grade}">${status.index}</a></li>
					</c:forEach>
					<li id="next"><a href="score?type=search&ye=${p.ye+1}&empName=${sc.emp.name}&dep=${sc.emp.dep.id!=-1?sc.emp.dep.id:''}&pro=${sc.pro.id!=-1?sc.pro.id:''}&grade=${sc.grade}">下一页</a></li>
					<li id="end"><a href="score?type=search&ye=${p.maxYe}&empName=${sc.emp.name}&dep=${sc.emp.dep.id!=-1?sc.emp.dep.id:''}&pro=${sc.pro.id!=-1?sc.pro.id:''}&grade=${sc.grade}">末页</a></li>
				</ul>
			</div>
			<div id="message">
				<p>共${p.maxYe}页</p>
			</div>
		</div>
	</div>
</body>
</html>