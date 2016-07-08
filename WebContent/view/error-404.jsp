<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="refresh" content="3;url=${pageContext.request.contextPath}/index.jsp">
<title>404-页面不存在</title>
<script src="${base}/Rainbow/js/jquery-1.11.2.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="${base}/Rainbow/js/bootstrap.min.js"></script>
<link href="${base}/Rainbow/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div id="cl-wrapper" class="error-container">
	<div class="page-error">
		<h1 class="number text-center">404</h1>
		<h2 class="description text-center">对不起，没有这个页面！</h2>
		<h3 class="text-center">3秒后将返回首页，如果没有跳转，请点击<a href="${pageContext.request.contextPath}/index.jsp">返回首页</a></h3>
	</div>
</div>
</body>
</html>