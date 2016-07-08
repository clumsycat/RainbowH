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
<script src="../js/jquery.validate.js"></script>

<title>生成数据</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />

	<div class="container">
		<h2>
			生成数据<small>所填入的生成数据大小为每台节点的数据大小</small>
		</h2>
		<hr>
		<form class="form-horizontal " id="generate_form">
			<div class="form-group">
				<label for="data_size" class="col-md-2 col-sm-3 control-label">*生成数据大小</label>
				<div class="col-md-2 col-sm-4">
					<input type="text" class="form-control" id="data_size"
						name="data_size" placeholder="1">
				</div>
				<div class="col-md-2 col-sm-4">
					<select class="form-control" name="data_unit" id="data_unit">
						<option>TB</option>
						<option>GB</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="hdfs_path" class="col-md-2 col-sm-3 control-label">*HDFS存放路径</label>
				<div class="col-md-6 col-sm-8">
					<input type="text" class="form-control" id="hdfs_path"
						name="hdfs_path" placeholder="/benchmark">
				</div>
			</div>
			<div class="form-group">
				<label for="csv_path" class="col-md-2 col-sm-3 control-label">*数据表(.csv)存放路径</label>
				<div class="col-md-6 col-sm-8">
					<input type="text" class="form-control" id="csv_path"
						name="csv_path" placeholder="/root/wjq">
				</div>
			</div>
			<div class="form-group">
				<label for="machine_ids" class="col-md-2 col-sm-3 control-label">*生成数据的结点</label>
				<div class="col-md-6 col-sm-8">
					<div class="checkbox" id="machine_ids">
						<label> <input type="checkbox" id="hadoop-50" value="50"
							name="machines">50
						</label> <label> <input type="checkbox" id="hadoop-85" value="85"
							name="machines">85
						</label> <label> <input type="checkbox" id="hadoop-86" value="86"
							name="machines">86
						</label> <label> <input type="checkbox" id="hadoop-72" value="72"
							name="machines">72
						</label><label> <input type="checkbox" id="hadoop-74" value="74"
							name="machines">74
						</label> <label> <input type="checkbox" id="hadoop-61" value="61"
							name="machines">61
						</label> <label> <input type="checkbox" id="hadoop-62" value="62"
							name="machines">62
						</label>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="col-md-offset-2 col-md-6 col-sm-offset-3 col-sm-8">
					<button type="button submit" class="btn btn-primary submit">生成数据</button>
				</div>
			</div>
		</form>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="comfirm_modal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">信息确认</h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">否</button>
					<button type="button" id="confirm_button" class="btn btn-primary"
						data-dismiss="modal" onclick="generate();">生成数据</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$()
				.ready(
						function() {
							$("#comfirm_modal")
									.on(
											'show.bs.modal',
											function() {
												var size = $("#data_size")
														.val();
												var unit = $("#data_unit")
														.find("option:selected")
														.text();
												var hdfspath = $("#hdfs_path")
														.val();
												var csvpath = $("#csv_path")
														.val();
												var mas = "";
												var manumber = 0;
												$(
														"[name='machines']:checkbox:checked")
														.each(
																function() {
																	temp = $(
																			this)
																			.val();
																	manumber++;
																	if (mas == "")
																		mas = temp;
																	else
																		mas = mas
																				+ ","
																				+ temp; // 分隔符为|
																});
												var html = "<p>将总共生成<b style='color:red'>"
														+ size
														* manumber
														+ unit
														+ " </b>的数据</p><p>HDFS存放路径为：<b style='color:red'>"
														+ hdfspath
														+ "</b></p><p>本地存放CVS文件路径为：<b style='color:red'>"
														+ csvpath
														+ "</b></p><p>生成数据的节点为：<b style='color:red'>"
														+ mas
														+ "</b></p><p>确认生成吗？<p>";
												$(".modal-body").html(html);
											})
							$("#generate_form")
									.validate(
											{
												rules : {
													data_size : "required",
													hdfs_path : "required",
													csv_path : "required",
													machines : {
														required : true,
														minlength : 2
													}
												},
												messages : {
													data_size : "请输入生成数据的大小",
													hdfs_path : "请输入在HDFS存放数据的路径",
													csv_path : "请输入在本地存放CSV文件的路径",
													machines : {
														required : "必选项",
														minlength : "请至少选择2个节点"
													}
												},
												submitHandler : function(form) {
													$('#comfirm_modal').modal(
															'toggle');
												},
												errorPlacement : function(
														error, element) {
													if (element.is(":checkbox"))
														error.appendTo(element
																.parent()
																.parent()
																.parent());
													else
														error.appendTo(element
																.parent());
												}
											});
						});
		function generate() {
			$.ajax({
				url : "../servlet/GenerateServlet",
				type : "GET",
				dataType : "json",
				data : $('#generate_form').serialize(),
				contentType : 'text/html; charset=UTF-8',
				success : function() {
					
				}
			})
		}
	</script>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>