<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="../js/jquery-1.11.2.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="../js/bootstrap.min.js"></script>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<script src="../js/dataload.js"></script>

<title>RainBowH 用户界面</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"/>
	<div class="rainbow-dataload">
		<div class="container">
			<div class="title">
				<h2>数据装载</h2>
			</div>
			<div role="tabpanel">

				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
					<li role="presentation" class="active"><a href="#home"
						aria-controls="home" role="tab" data-toggle="tab">Oracle &
							Impala</a></li>
					<li role="presentation"><a href="#profile"
						aria-controls="profile" role="tab" data-toggle="tab"> Oracle &
							HDFS</a></li>
				</ul>

				<!-- Tab panes -->
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="home">
						<form class="src-form form-horizontal ">
							<!-- 控制Oracle部分 -->
							<h3>
								Oracle <small id="tip"></small>
							</h3>
							<div class="form-group">
								<label for="Oracle-role" class="col-sm-2 control-label">选择角色</label>
								<div class="col-sm-6">
									<select class="form-control " id="Oracle-role">
										<option>导出</option>
										<option>导入</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="Oracle-DB-name" class="col-sm-2 control-label">库名</label>
								<div class="col-sm-6">
									<select class="form-control " id="Oracle-DB-name">
									 <option>orcl</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="Oracle-Table-name" class="col-sm-2 control-label">表名</label>
								<div class="col-sm-6">
									<select class="form-control " id="Oracle-Table-name">
									</select>
								</div>
							</div>
						</form>
						<!-- 来源结束，下面是目的 -->
						<form class="des-form form-horizontal">
							<!-- 控制Impala部分 -->
							<h3>Impala</h3>
							<div class="form-group">
								<label for="Impala-DB-name" class="col-sm-2 control-label">库名</label>
								<div class="col-sm-6">
									<select class="form-control " id="Impala-DB-name">
									   <option>tmp</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="Impala-Table-name" class="col-sm-2 control-label">表名</label>
								<div class="col-sm-6">
									<select class="form-control " id="Impala-Table-name">
									</select>
								</div>
							</div>
							<h3>数据量</h3>
							<div class="form-group">
								<label for="start-num" class="col-sm-2 control-label">起始行</label>
								<div class="col-sm-6">
									<input id="start-num" type="text" class="form-control "
										style="width: 100px" placeholder="0">
								</div>
							</div>
							<div class="form-group">
								<label for="end-num" class="col-sm-2 control-label">结束行</label>
								<div class="col-sm-6">
									<input id="end-num" type="text" style="width: 100px"
										class="form-control " placeholder="10000">
								</div>
							</div>
							<div class="col-sm-4 col-sm-offset-2">
								<button id="load_button" class="btn btn-default " type="button"
									style="width: 100px" onclick="doload();">开始装载</button>
							</div>
							<div id="log"></div>
						</form>
					</div>
					<!-- oracle & HDFS -->
					<div role="tabpanel" class="tab-pane" id="profile">
						<form class="src-form form-horizontal ">
							<!-- 控制Oracle部分 -->
							<h3>
								Oracle <small id="tipH"></small>
							</h3>
							<div class="form-group">
								<label for="Oracle-roleH" class="col-sm-2 control-label">选择角色</label>
								<div class="col-sm-6">
									<select class="form-control " id="Oracle-roleH">
										<option>导出</option>
										<option>导入</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="Oracle-DB-nameH" class="col-sm-2 control-label">库名</label>
								<div class="col-sm-6">
									<select class="form-control " id="Oracle-DB-nameH">
									 <option>orcl</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="Oracle-Table-nameH" class="col-sm-2 control-label">表名</label>
								<div class="col-sm-6">
									<select class="form-control " id="Oracle-Table-nameH">
									</select>
								</div>
							</div>
						</form>
						<!-- 来源结束，下面是目的 -->
						<form class="des-form form-horizontal">
							<!-- 控制HDFS部分 -->
							<h3>HDFS</h3>
							<div class="form-group">
								<label for="hdfs-file" class="col-sm-2 control-label">文件名</label>
								<div class="col-sm-6">
									<input id="hdfs-file" type="text" style="width: 500px"
										class="form-control " placeholder="test.cvs">
								</div>
							</div>
							<h3>数据量</h3>
							<div class="form-group">
								<label for="start-num" class="col-sm-2 control-label">起始行</label>
								<div class="col-sm-6">
									<input id="start-num" type="text" class="form-control "
										style="width: 100px" placeholder="0">
								</div>
							</div>
							<div class="form-group">
								<label for="end-num" class="col-sm-2 control-label">结束行</label>
								<div class="col-sm-6">
									<input id="end-num" type="text" style="width: 100px"
										class="form-control " placeholder="10000">
								</div>
							</div>
							<div class="col-sm-4 col-sm-offset-2">
								<button id="load_button" class="btn btn-default " type="button"
									style="width: 100px" onclick="doloadH();">开始装载</button>
							</div>
							<div id="logH"></div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
// 		$(document)
// 				.ready(
// 						function() {
// 							$
// 									.ajax(
// 											{//获取Oracle的库
// 												url : 'http://10.10.108.85:6666/QUERYDATABASE?database_type=Oracle&return_type=json',
// 												dataType : 'jsonp',
// 												crossDomain : true,
// 												success : function(data) {
// 													for (var i = 0; i < data.total_count; i++) {
// 														$("#Oracle-DB-name")
// 																.append(
// 																		"<option>"
// 																				+ data.databases[i]
// 																				+ "</option>");
// 													}
// 												}
// 											}).fail(function() {
// 										alert("获取Oracle数据库失败:服务器没响应");
// 									});
// 							$
// 									.ajax(
// 											{//获取Impala的库 
// 												url : 'http://10.10.108.85:6666/QUERYDATABASE?database_type=Impala&return_type=json',
// 												dataType : 'jsonp',
// 												crossDomain : true,
// 												success : function(data) {
// 													for (var i = 0; i < data.total_count; i++) {
// 														$("#Impala-DB-name")
// 																.append(
// 																		"<option>"
// 																				+ data.databases[i]
// 																				+ "</option>");
// 													}
// 												}
// 											}).fail(function() {
// 										alert("获取Impala数据库失败:服务器没响应");
// 									});
// 						});
		$("#Impala-DB-name")
				.change(
						function() {
							var str = "";
							$("#Impala-DB-name option:selected")
									.each(
											function() {
												str = $(this).text();
												$("#Impala-Table-name").empty();
												$
														.ajax(
																{//获取Impala的库 
																	url : 'http://10.10.108.85:6666/QUERYTABLE?database_type=Impala&database_name='
																			+ str
																			+ '&return_type=json',
																	dataType : 'jsonp',
																	crossDomain : true,
																	success : function(
																			data) {
																		for (var i = 0; i < data.total_count; i++) {
																			$(
																					"#Impala-Table-name")
																					.append(
																							"<option>"
																									+ data.databases[i]
																									+ "</option>");
																		}
																	}
																})
														.fail(
																function() {
																	alert("获取Impala数据库失败:服务器没响应");
																});
											});
						}).trigger('change');

		$("#Oracle-DB-name")
				.change(
						function() {
							var str = "";
							$("#Oracle-DB-name option:selected")
									.each(
											function() {
												str = $(this).text();
												$("#Oracle-Table-name").empty();
												$
														.ajax(
																{//获取Oracle的表  
																	url : 'http://10.10.108.85:6666/QUERYTABLE?database_type=Oracle&database_name='
																			+ str
																			+ '&user_name=xiao&return_type=json',
																	dataType : 'jsonp',
																	crossDomain : true,
																	success : function(
																			data) {
																		for (var i = 0; i < data.total_count; i++) {
																			$(
																					"#Oracle-Table-name")
																					.append(
																							"<option>"
																									+ data.databases[i]
																									+ "</option>");
																		}
																	}
																})
														.fail(
																function() {
																	alert("获取Oracle库中表失败:服务器没响应");
																});
											});
						}).trigger('change');
		$("#Oracle-DB-nameH")
				.change(
						function() {
							var str = "";
							$("#Oracle-DB-nameH option:selected")
									.each(
											function() {
												str = $(this).text();
												$("#Oracle-Table-nameH")
														.empty();
												$
														.ajax(
																{//获取Oracle的表  
																	url : 'http://10.10.108.85:6666/QUERYTABLE?database_type=Oracle&database_name='
																			+ str
																			+ '&user_name=xiao&return_type=json',
																	dataType : 'jsonp',
																	crossDomain : true,
																	success : function(
																			data) {
																		for (var i = 0; i < data.total_count; i++) {
																			$(
																					"#Oracle-Table-nameH")
																					.append(
																							"<option>"
																									+ data.databases[i]
																									+ "</option>");
																		}
																	}
																})
														.fail(
																function() {
																	alert("获取Oracle表失败:服务器没响应");
																});
											});
						}).trigger('change');
		$("#Oracle-role").change(function() {
			var str = "";
			$("#Oracle-role option:selected").each(function() {
				str = $(this).text();
				$("#tip").empty();
				switch (str) {
				case "导入":
					$("#tip").html("从Impala导至Oracle");
					break;
				case "导出":
					$("#tip").html("从Oracle导至Impala");
					break;
				}
			});
		}).trigger('change');
		$("#Oracle-roleH").change(function() {
			var str = "";
			$("#Oracle-roleH option:selected").each(function() {
				str = $(this).text();
				$("#tipH").empty();
				switch (str) {
				case "导入":
					$("#tipH").html("从HDFS导至Oracle");
					break;
				case "导出":
					$("#tipH").html("从Oracle导至HDFS");
					break;
				}
			});
		}).trigger('change');
		//$("#se option:selected").text()读取select的值
	</script>
<jsp:include page="footer.jsp" flush="true"></jsp:include>