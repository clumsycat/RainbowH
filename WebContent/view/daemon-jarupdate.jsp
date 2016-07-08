<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../css/bootstrap.min.css" rel="stylesheet">
<title>版本更新</title>

</head>
<body>

	<jsp:include page="header.jsp" flush="true" />
	<div class="container">
		<h2>上传新jar文件</h2>
		<hr>
		<div id="now-edition-info"></div>
		<form class="form-horizontal " id="upload_form"
			enctype="MULTIPART/FORM-DATA">
			<div class="form-group">
				<label for="jar_upload" class="col-sm-2 control-label ">
					*jar包</label>
				<div class="col-sm-8">
					<input type="file" id="jar_upload" name="jar_upload"
						accept="application/pdf, text/plain, text/xml" required>
					<p id="file-help-block"></p>
				</div>
			</div>

			<div class="form-group">
				<label for="jar_name" class="col-sm-2 control-label">* 版本名称</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" id="jar_name"
						name="jar_name" placeholder="WebServerV6.jar" required>
				</div>
			</div>
			<div class="form-group">
				<label for="jar_id" class="col-sm-2 control-label">* 版本号</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" id="jar_id" name="jar_id"
						placeholder="6.0" required>
				</div>
			</div>
			<div class="form-group">
				<label for="hdfs_path" class="col-sm-2 control-label">*
					HDFS路径</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" id="hdfs_path"
						name="hdfs_path" disabled="true" placeholder="/user/updateIndex">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-8">
					<button type="button submit" class="btn btn-primary btn-lg submit">上传</button>
				</div>
			</div>
			<div class="progress col-sm-offset-2 col-sm-8" id="progress-div">
				<div class="progress-bar progress-bar-striped active" id="progress"
					role="progressbar" aria-valuenow="0" aria-valuemin="0"
					aria-valuemax="100" style="width: 0%""></div>
			</div>
		</form>
	</div>

	<script src="../js/jquery-1.11.2.min.js"></script>
	<script src="../js/jquery.validate.js"></script>
	<script src="../js/jquery.tmpl.min.js"></script>
	<script type="text/javascript">
		$("#jar_upload")
				.change(
						function() {
							var file = this.files[0];
							name = file.name;
							size = file.size;
							var fileSize = 0;
							if (file.size > 1024 * 1024)
								fileSize = (Math.round(file.size * 100
										/ (1024 * 1024)) / 100).toString()
										+ 'MB';
							else
								fileSize = (Math.round(file.size * 100 / 1024) / 100)
										.toString()
										+ 'KB';

							type = file.type;
							console.log("file type:" + type);
							if (type == "application/pdf"
									|| type == "text/plain"
									|| type == "text/xml") {
								console.log(name);
								console.log(size);
								$("#file-help-block").text("文件大小：" + fileSize);
								document.getElementById("jar_name").value = name;
							}
						});
		/**  
		 * ajax 上传。  
		 */
		function uploadByForm() {
			var formData = new FormData($("#upload_form")[0]);
			$("#progress-div").show();
			//用form 表单直接 构造formData 对象; 就不需要下面的append 方法来为表单进行赋值了。  
			//formData.append("file",$("#jar_upload")[0].files[0]);
			//var formData = new FormData();//构造空对象，下面用append 方法赋值。  
			formData.append("filename", $("#jar_name").text());
			formData.append("file", $("#jar_upload")[0].files[0]);
			var jar_name = $("#jar_name").val();
			var jar_id = $("#jar_id").val();
			var data = {
				"jar_name" : jar_name,
				"jar_id" : jar_id,
			};
			console.log(formData);
			$.ajaxFileUpload({
				url : "../servlet/JarUpdate",
				fileElementId : 'jar_upload',
				secureuri : false,
				dataType : 'json',
				data : data,
				/**   
				 * 必须false才会避开jQuery对 formdata 的默认处理   
				 * XMLHttpRequest会对 formdata 进行正确的处理   
				 */
				processData : false,
				/**   
				 *必须false才会自动加上正确的Content-Type   
				 */
				contentType : false,
				success : function(responseStr) {
					alert("成功上传至HDFS，且将文件信息写入Impala");
				},
				error : function(responseStr) {
					alert("失败:" + JSON.stringify(responseStr));//将    json对象    转成    json字符串。  
				}
			});
		}

		function progressHandlingFunction(e) {
			if (e.lengthComputable) {
				var length = e.loaded + "%";
				$('#progress').css({
					width : length
				});
			}
		}
		$.validator.setDefaults({
			submitHandler : function(form) {
				$('#progress').css({
					width : "0%"
				});
				uploadByForm();
				alert("submitted!");
			}
		});

		$(document).ready(function() {
			$.ajax({
				url:"../servlet/getCurrentEdition",
				type : "GET",
				dataType : "json",
				contentType : 'text/html; charset=UTF-8',
				success : function(data) {
					$("#now-edition").tmpl(data).appendTo("#now-edition-info");
					$("#jar_id").val(parseFloat(data.id)+0.01);
				}
			});
			$("#upload_form").validate();
			$("#progress-div").hide();
			$("#file-size-div").hide();
		});
	</script>
				<script id="now-edition" type="text/x-jquery-tmpl">
					<blockquote>
					  <p>当前版本：</p>
					  <p>版本号：{{= id}}<br>
				      版本名称：{{= name}}<br>
					  上次更新日期：{{= updatetime}}</p>
					</blockquote>
			</script>

	<!-- 用于表单验证 -->
	<script type="text/javascript" src="../js/ajaxfileupload.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="../js/bootstrap.min.js"></script>

	<jsp:include page="footer.jsp" flush="true"></jsp:include>