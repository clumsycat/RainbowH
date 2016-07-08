<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../css/bootstrap.min.css" rel="stylesheet">

<title>误删恢复</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<div class="container">
		<h3>误删恢复</h3>
		<p>下面列出了所有用户删除的文件</p>
		<table id="recovery-table"
			class="table  table-striped table-hover col-sm-8">
			<colgroup>
				<col style="width: 40%;">
				<col>
				<col>
				<col>
				<col style="width: 5%;">
			</colgroup>
			<thead>
				<tr>
					<th>文件名</th>
					<th>关键字</th>
					<th>操作者</th>
					<th>删除日期</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody id="result-tbody">
				<tr>
					<th>文件1</th>
					<th>关键字</th>
					<th>root</th>
					<th>2015-9-23</th>
					<th><span class="glyphicon glyphicon-repeat hand" onclick=""></span></th>
				</tr>
				<tr>
					<th>文件2</th>
					<th>关键字</th>
					<th>root</th>
					<th>2015-9-23</th>
					<th><span class="glyphicon glyphicon-repeat hand" onclick=""></span></th>
				</tr>
			</tbody>
		</table>

		<script id="recovery-tbody" type="text/x-jquery-tmpl">
			<tr>
					<th>{{= file_title}}</th>
					<th>{{= key_words}}</th>
					<th>{{= delete_user}}</th>
					<th>{{= delete_time}}</th>
					<th><span class="glyphicon glyphicon-repeat hand" onclick="recovery('{{= file_id}}',this);"></span>
							<span class="glyphicon glyphicon-trash hand" onclick="del('{{= file_id}}',this);"></span></th>
				</tr>
		</script>
		<script src="../js/jquery-1.11.2.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="../js/bootstrap.min.js"></script>
		<script src="../js/jquery.tmpl.min.js"></script>
		<script>
			$(document).ready(
					function() {
						var json = {
							"action" : "show"
						};
						$.ajax({
							url : "../servlet/RecoveryServlet",
							type : "GET",
							dataType : "json",
							data : json,
							contentType : 'text/html; charset=UTF-8',
							success : function(data) {
								$("#result-tbody").empty();
								$("#recovery-tbody").tmpl(data).appendTo(
										"#result-tbody");
							}
						});
					});
			//恢复文件
			function recovery(id) {
				//待做 发送消息给Daemon
				var json = {
					"action" : "recovery",
					"file_id" : id
				};
				$.ajax({
					url : "../servlet/RecoveryServlet",
					type : "GET",
					dataType : "json",
					data : json,
					contentType : 'text/html; charset=UTF-8',
					success : function(data) {
						delRow(obj);
					}
				});
			};
			//删除文件
			function del(id, obj) {
				var json = {
					"action" : "delete",
					"file_id" : id
				};
				$.ajax({
					url : "../servlet/RecoveryServlet",
					type : "GET",
					dataType : "json",
					data : json,
					contentType : 'text/html; charset=UTF-8',
					success : function(data) {
						delRow(obj);
					}
				});
			};
			//清空文件
			function clear() {
				var json = {
					"action" : "clear"
				};
				$.ajax({
					url : "../servlet/RecoveryServlet",
					type : "GET",
					dataType : "json",
					data : json,
					contentType : 'text/html; charset=UTF-8',
					success : function(data) {

					}
				});
			};

			// 删除行
			function delRow(obj) { // 参数为A标签对象
				var row = obj.parentNode.parentNode; // A标签所在行
				var tb = row.parentNode; // 当前表格
				var rowIndex = row.rowIndex - 1; // A标签所在行下标
				tb.deleteRow(rowIndex); // 删除当前行
			}
		</script>
	</div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>