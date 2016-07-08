<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="../js/jquery-1.11.2.min.js"></script>
<script src="../js/jquery.validate.js"></script>
<!-- 用于表单验证 -->
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="../js/bootstrap.min.js"></script>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<title>RainBowH 用户界面</title>

</head>
<body>

	<jsp:include page="header.jsp" flush="true" />
	<div class="container">
		<h2>
			上传文件<small>只支持PDF、TXT、XML文件</small>
		</h2>
		<hr>
		<form class="form-horizontal " id="upload_form">
			<div class="form-group">
				<label for="file_upload" class="col-sm-2 control-label ">
					上传文件</label>
				<div class="col-sm-8">
					<input type="file" id="file_upload"
						accept="application/pdf, text/plain, text/xml" required>
					<p id="file-help-block"></p>
				</div>
			</div>

			<div class="form-group">
				<label for="file_name" class="col-sm-2 control-label">* 文件名</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" id="file_name" name="file_name"
						placeholder="File Name" required>
				</div>
			</div>
			<div class="form-group">
				<label for="key_words" class="col-sm-2 control-label">* 关键字</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" id="key_words" name="key_words"
						placeholder="Key Words" required>
				</div>
			</div>
			<div class="form-group">
				<label for="author_name" class="col-sm-2 control-label">*
					作者名称</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" id="author_name" name="author_name"
						placeholder="Author Name" required>
				</div>
			</div>
			<div class="form-group">
				<label for="abstract" class="col-sm-2 control-label">* 摘要</label>
				<div class="col-sm-8">
					<textarea class="form-control" id="abstract" rows=4 name="abstract"
						placeholder="abstract" required></textarea>
				</div>
			</div>

			<div class="form-group" id="file-size-div">
				<label for="file_size" class="col-sm-2 control-label">文件大小</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" id="file_size" name="file_size"
						placeholder="File Size">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-8">
					<button type="submit" class="btn btn-primary btn-lg">上传</button>
				</div>
			</div>
			<div class="progress col-sm-offset-2 col-sm-8" id="progress-div">
				<div class="progress-bar progress-bar-striped active" id="progress"
					role="progressbar" aria-valuenow="0" aria-valuemin="0"
					aria-valuemax="100" style="width: 0%"></div>
			</div>

		</form>
	</div>

	<script type="text/javascript">
		$("#file_upload")
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
								document.getElementById("file_size").value = size;
								document.getElementById("file_name").value = name;
							}
							$("#progress-div").hide();
							$('#progress').css({
								width : "0%"
							});
						});
		/**  
		 * ajax 上传。  
		 */
		function uploadByForm() {
			var formData = new FormData($("#upload_form")[0]);
			$("#progress-div").show();
			//用form 表单直接 构造formData 对象; 就不需要下面的append 方法来为表单进行赋值了。  

			//var formData = new FormData();//构造空对象，下面用append 方法赋值。  
			//          formData.append("policy", "");  
			//          formData.append("signature", "");  
			//          formData.append("file", $("#file_upload")[0].files[0]);  
			var url = "http://10.10.108.86:6666/UPLOAD?";
			console.log(formData.toString);
			$.ajax({
				url : url,
				type : 'POST',
				data : formData,
				xhr : function() { // custom xhr
					myXhr = $.ajaxSettings.xhr();
					if (myXhr.upload) { // check if upload property exists
						myXhr.upload.addEventListener('progress',
								progressHandlingFunction, false); // for handling the progress of the upload
					}
					return myXhr;
				},
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
					alert("成功：" + JSON.stringify(responseStr));
					//                  var jsonObj = $.parseJSON(responseStr);//eval("("+responseStr+")");  

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
			submitHandler : function() {
				$('#progress').css({
					width : "0%"
				});
				uploadByForm();
				alert("submitted!");
			}
		});

		$(document).ready(function() {
			$("#upload_form").validate();
			$("#progress-div").hide();
			$("#file-size-div").hide();
		});
	</script>



	<jsp:include page="footer.jsp" flush="true"></jsp:include>