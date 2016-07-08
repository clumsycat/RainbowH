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

<title>RainBowH 用户界面</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"/>
	<div id="left_database" class="col-sm-4">
		<form class="aim-form form-horizontal">
			<h3>Impala</h3>
			<div class="form-group">
				<label for="DB" class="col-sm-2 control-label">库名</label>
				<div class="col-sm-6">
					<select class="form-control " id="se-database">
					</select>
				</div>
			</div>
			<div class="list-group">
				<!-- 显示表名的地方 -->
				<ul class="table-list">
					<li>
						<div>
							<ul class="col-list">
								<!-- 显示列名的地方 -->
							</ul>
						</div>

					</li>
				</ul>
			</div>
			<div class="col-sm-4"></div>

		</form>

	</div>
	<div id="sql&result" class="col-sm-6">
		<div id="sql"></div>
		<div id="result"></div>
	</div>
	<script language="javascript" type="text/javascript">
		$(document).ready(
				function() {
					$('#mySelect')
							.change(
									function() {
										alert($(this).children(
												'option:selected').val());
										var p1 = $(this).children(
												'option:selected').val();//这就是selected的值 
										var p2 = $('#param2').val();//获取本页面其他标签的值 
										window.location.href = "xx.php?param1="
												+ p1 + "¶m2=" + p2 + "";//页面跳转并传参 
									})
				});
	</script>
</body>
</html>