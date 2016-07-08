<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="refresh" content="10">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="../js/jquery-1.11.2.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="../js/bootstrap.min.js"></script>
<link href="../css/bootstrap.min.css" rel="stylesheet">

<title>base监控界面</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<iframe name="impala-frame" frameborder="0" id="impala-frame"
		scrolling="no" width="100%" height="auto"
		src="http://10.10.108.13/base/base_main.php"> </iframe>

	<jsp:include page="footer.jsp" flush="true"></jsp:include>