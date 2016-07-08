<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>500-服务器错误</title>
<script src="../js/jquery-1.11.2.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="../js/bootstrap.min.js"></script>
<link href="../css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div id="cl-wrapper" class="error-container">
	<div class="page-error">
		<h1 class="number text-center">500</h1>
		<h2 class="description text-center">对不起，出错了，请联系管理员！</h2>
		<h3 class="text-center">异常信息如下：<%=exception.getMessage() %></h3>
	</div>
</div>
</body>
</html>