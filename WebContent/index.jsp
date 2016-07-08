<%@ page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="css/bootstrap.min.css" rel="stylesheet">

<title>RainBowH 用户界面</title>
</head>
<body>
	<jsp:include page="view/header.jsp" flush="true" />
	<div class="containner"
		style="padding-left: 60px; padding-right: 60px;">
		<div class="jumbotron"
			style="padding-left: 60px; padding-right: 60px;">
			<h1>RainbowH</h1>
			<p>同时支持结构化/非结构化数据存储/分析/管理
				结构化数据的增/删/改/查<br> 非结构化数据的存储/分析/查找/上传/下载
			<p>与Hadoop兼容和集成<br>支持类似百度文库的文件检索<br>
			支持全文检索</p>
		</div>
		<div class="row" style="text-align: center;">
			<div class="col-lg-4">
				<img class="img-circle" src="img/hadoop-logo.png" alt="Hadoop"
					width="140" height="140">
				<h2>Hadoop</h2>
				<p>RainbowH采用Hadoop的HDFS作为非结构化数据的存储</p>
			</div>
			<!-- /.col-lg-4 -->
			<div class="col-lg-4">
				<img class="img-circle" src="img/impala-logo.png" alt="Impala"
					width="140" height="140">
				<h2>Imapla</h2>
				<p>用来做结构化数据的查询</p>

			</div>
			<!-- /.col-lg-4 -->
			<div class="col-lg-4">
				<img class="img-circle" src="img/memcache-logo.png" alt="Memcache"
					width="140" height="140">
				<h2>Memcache</h2>
				<p>使用Memcache作为一个大内存，对查询结果以及MapReduce任务中的中间块缓存。</p>

			</div>
			<!-- /.col-lg-4 -->
		</div>
	</div>

	<script src="js/jquery-1.11.2.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
	<jsp:include page="view/footer.jsp"></jsp:include>