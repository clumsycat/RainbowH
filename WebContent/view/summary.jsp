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
<script src="../js/ping.js"></script>
<title>RainBowH 用户界面</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
<body>
	<div class="container">
		<h1>RainbowH 版本</h1>
		<div class="alert alert-info">RainbowH version v0.4</div>
		<h1>服务器状态</h1>
		<div class="alert alert-info">
			<h3>服务器状态说明：</h3>
			<p>服务器图标颜色蓝色为正常（小于0.5s）、黄色为普通（小于1s）、橙色为较慢（小于2s）、红色为极慢（小于5s）、灰色为服务器无响应</p>
		</div>
		<div class="container">
			<h2>Impala</h2>
			<div id="impala" class="row alert alert-info">
				<div class="col-xs-6 col-sm-3 col-lg-2 text-center">
					<img class="img-circle" src="../img/fast.png" id="impala-70"
						alt="Impala" ></img>
					<h4 id="impala-70-title">Imapla-70</h4>
				</div>
				<div class="col-xs-6 col-sm-3 col-lg-2 text-center">
					<img class="img-circle" src="../img/fast.png" id="impala-71"
						alt="Impala" ></img>
					<h4 id="impala-71-title">Imapla-71</h4>
				</div>
				<div class="col-xs-6 col-sm-3 col-lg-2 text-center">
					<img class="img-circle" src="../img/fast.png" id="impala-73"
						alt="Impala" ></img>
					<h4 id="impala-73-title">Imapla-73</h4>
				</div>
			</div>
			<hr>
			<h2>Hadoop</h2>
			<div id="Hadoop" class="row alert alert-info">

				<div class="col-xs-6 col-sm-3 col-lg-2 text-center">
					<img class="img-circle hadoop-mem-60" src="../img/fast.png"
						id="hadoop-60" alt="Hadoop" ></img>
					<h4>Hadoop-60</h4>
				</div>
				<div class="col-xs-6 col-sm-3 col-lg-2 text-center">
					<img class="img-circle hadoop-mem-61" src="../img/fast.png"
						id="hadoop-61" alt="Hadoop" ></img>
					<h4>Hadoop-61</h4>
				</div>
				<div class="col-xs-6 col-sm-3 col-lg-2 text-center">
					<img class="img-circle hadoop-mem-62" src="../img/fast.png"
						id="hadoop-62" alt="Hadoop" ></img>
					<h4>Hadoop-62</h4>
				</div>
				<div class="col-xs-6 col-sm-3 col-lg-2 text-center">
					<img class="img-circle" src="../img/fast.png" id="hadoop-72"
						alt="Hadoop" ></img>
					<h4 id="hadoop-title-72">Hadoop-72</h4>
				</div>
				<div class="col-xs-6 col-sm-3 col-lg-2 text-center">
					<img class="img-circle hadoop-mem-74" src="../img/fast.png"
						id="hadoop-74" alt="Hadoop" ></img>
					<h4>Hadoop-74</h4>
				</div>
				<div class="col-xs-6 col-sm-3 col-lg-2 text-center">
					<img class="img-circle" src="../img/fast.png" id="hadoop-75"
						alt="Hadoop" ></img>
					<h4 id="hadoop-75-title">Hadoop-75</h4>
				</div>
				<div class="col-xs-6 col-sm-3 col-lg-2 text-center">
					<img class="img-circle" src="../img/fast.png" id="hadoop-76"
						alt="Hadoop" ></img>
					<h4 id="hadoop-76-title">Hadoop-76</h4>
				</div>
				<div class="col-xs-6 col-sm-3 col-lg-2 text-center">
					<img class="img-circle hadoop-mem-85" src="../img/fast.png"
						id="hadoop-85" alt="Hadoop" ></img>
					<h4>Hadoop-85</h4>
				</div>
				<div class="col-xs-6 col-sm-3 col-lg-2 text-center">
					<img class="img-circle hadoop-mem-86" src="../img/fast.png"
						id="hadoop-86" alt="Hadoop" ></img>
					<h4>Hadoop-86</h4>
				</div>
			</div>
			<hr>
			<h2>MemCache</h2>
			<div id="Memcache" class="row alert alert-info">

				<div class="col-xs-6 col-sm-3 col-lg-2 text-center">
					<img class="img-circle hadoop-mem-60" src="../img/fast.png"
						id="memcache-60" alt="Memcache" ></img>
					<h4>Memcache-60</h4>
				</div>
				<div class="col-xs-6 col-sm-3 col-lg-2 text-center">
					<img class="img-circle hadoop-mem-61" src="../img/fast.png"
						id="memcache-61" alt="Memcache" ></img>
					<h4>Memcache-61</h4>
				</div>
				<div class="col-xs-6 col-sm-3 col-lg-2 text-center">
					<img class="img-circle hadoop-mem-62" src="../img/fast.png"
						id="memcache-62" alt="Memcache" ></img>
					<h4>Memcache-62</h4>
				</div>
				<div class="col-xs-6 col-sm-3 col-lg-2 text-center">
					<img class="img-circle hadoop-mem-74" src="../img/fast.png"
						id="memcache-74" alt="Memcache" ></img>
					<h4>Memcache-74</h4>
				</div>
				<div class="col-xs-6 col-sm-3 col-lg-2 text-center">
					<img class="img-circle hadoop-mem-85" src="../img/fast.png"
						id="memcache-85" alt="Memcache" ></img>
					<h4>Memcache-85</h4>
				</div>
				<div class="col-xs-6 col-sm-3 col-lg-2 text-center">
					<img class="img-circle hadoop-mem-86" src="../img/fast.png"
						id="memcache-86" alt="Memcache" ></img>
					<h4>Memcache-86</h4>
				</div>
			</div>
		</div>
	</div>

	<div id="divContent"></div>
	<script>
		$(document).ready(
				function() {
					setInterval(function() {
						var p = new Ping();
						p.ping("10.10.108.70", function(data) {
							if (data < 500)
								$("#impala-70").attr("src", "../img/fast.png");
							else if (data < 1000)
								$("#impala-70").attr("src",
										"../img/little-slow.png");
							else if (data < 2000)
								$("#impala-70").attr("src", "../img/slow.png");
							else if (data < 5000)
								$("#impala-70").attr("src",
										"../img/warning.png");
							else
								$("#impala-70").attr("src", "../img/dead.png");
						});

						var p2 = new Ping();
						p2.ping("10.10.108.71", function(data) {
							if (data < 500)
								$("#impala-71").attr("src", "../img/fast.png");
							else if (data < 1000)
								$("#impala-71").attr("src",
										"../img/little-slow.png");
							else if (data < 2000)
								$("#impala-71").attr("src", "../img/slow.png");
							else if (data < 5000)
								$("#impala-71").attr("src",
										"../img/warning.png");
							else
								$("#impala-71").attr("src", "../img/dead.png");
						});

						var p3 = new Ping();
						p3.ping("10.10.108.73", function(data) {
							if (data < 500)
								$("#impala-73").attr("src", "../img/fast.png");
							else if (data < 1000)
								$("#impala-73").attr("src",
										"../img/little-slow.png");
							else if (data < 2000)
								$("#impala-73").attr("src", "../img/slow.png");
							else if (data < 5000)
								$("#impala-73").attr("src",
										"../img/warning.png");
							else
								$("#impala-73").attr("src", "../img/dead.png");
						});

						var p4 = new Ping();
						p4.ping("10.10.108.60", function(data) {
							if (data < 500)
								$(".hadoop-mem-60").attr("src",
										"../img/fast.png");
							else if (data < 1000)
								$(".hadoop-mem-60").attr("src",
										"../img/little-slow.png");
							else if (data < 2000)
								$(".hadoop-mem-60").attr("src",
										"../img/slow.png");
							else if (data < 5000)
								$(".hadoop-mem-60").attr("src",
										"../img/warning.png");
							else
								$(".hadoop-mem-60").attr("src",
										"../img/dead.png");
						});

						var p5 = new Ping();
						p5.ping("10.10.108.61", function(data) {
							if (data < 500)
								$(".hadoop-mem-61").attr("src",
										"../img/fast.png");
							else if (data < 1000)
								$(".hadoop-mem-61").attr("src",
										"../img/little-slow.png");
							else if (data < 2000)
								$(".hadoop-mem-61").attr("src",
										"../img/slow.png");
							else if (data < 5000)
								$(".hadoop-mem-61").attr("src",
										"../img/warning.png");
							else
								$(".hadoop-mem-61").attr("src",
										"../img/dead.png");
						});

						var p6 = new Ping();
						p6.ping("10.10.108.62", function(data) {
							if (data < 500)
								$(".hadoop-mem-62").attr("src",
										"../img/fast.png");
							else if (data < 1000)
								$(".hadoop-mem-62").attr("src",
										"../img/little-slow.png");
							else if (data < 2000)
								$(".hadoop-mem-62").attr("src",
										"../img/slow.png");
							else if (data < 5000)
								$(".hadoop-mem-62").attr("src",
										"../img/warning.png");
							else
								$(".hadoop-mem-62").attr("src",
										"../img/dead.png");
						});

						var p7 = new Ping();
						p7.ping("10.10.108.72", function(data) {
							if (data < 500)
								$("#hadoop-72").attr("src", "../img/fast.png");
							else if (data < 1000)
								$("#hadoop-72").attr("src",
										"../img/little-slow.png");
							else if (data < 2000)
								$("#hadoop-72").attr("src", "../img/slow.png");
							else if (data < 5000)
								$("#hadoop-72").attr("src",
										"../img/warning.png");
							else
								$("#hadoop-72").attr("src", "../img/dead.png");
						});

						var p8 = new Ping();
						p8.ping("10.10.108.74", function(data) {
							if (data < 500)
								$(".hadoop-mem-74").attr("src",
										"../img/fast.png");
							else if (data < 1000)
								$(".hadoop-mem-74").attr("src",
										"../img/little-slow.png");
							else if (data < 2000)
								$(".hadoop-mem-74").attr("src",
										"../img/slow.png");
							else if (data < 5000)
								$(".hadoop-mem-74").attr("src",
										"../img/warning.png");
							else
								$(".hadoop-mem-74").attr("src",
										"../img/dead.png");
						});

						var p9 = new Ping();
						p9.ping("10.10.108.85", function(data) {
							if (data < 500)
								$(".hadoop-mem-85").attr("src",
										"../img/fast.png");
							else if (data < 1000)
								$(".hadoop-mem-85").attr("src",
										"../img/little-slow.png");
							else if (data < 2000)
								$(".hadoop-mem-85").attr("src",
										"../img/slow.png");
							else if (data < 5000)
								$(".hadoop-mem-85").attr("src",
										"../img/warning.png");
							else
								$(".hadoop-mem-85").attr("src",
										"../img/dead.png");
						});

						var p10 = new Ping();
						p10.ping("10.10.108.86", function(data) {
							if (data < 500)
								$(".hadoop-mem-86").attr("src",
										"../img/fast.png");
							else if (data < 1000)
								$(".hadoop-mem-86").attr("src",
										"../img/little-slow.png");
							else if (data < 2000)
								$(".hadoop-mem-86").attr("src",
										"../img/slow.png");
							else if (data < 5000)
								$(".hadoop-mem-86").attr("src",
										"../img/warning.png");
							else
								$(".hadoop-mem-86").attr("src",
										"../img/dead.png");
						});

						var p11 = new Ping();
						p11.ping("10.10.108.75", function(data) {
							if (data < 500)
								$("#hadoop-75").attr("src", "../img/fast.png");
							else if (data < 1000)
								$("#hadoop-75").attr("src",
										"../img/little-slow.png");
							else if (data < 2000)
								$("#hadoop-75").attr("src", "../img/slow.png");
							else if (data < 5000)
								$("#hadoop-75").attr("src",
										"../img/warning.png");
							else
								$("#hadoop-75").attr("src", "../img/dead.png");
						});

						var p12 = new Ping();
						p12.ping("10.10.108.76", function(data) {
							if (data < 500)
								$("#hadoop-76").attr("src", "../img/fast.png");
							else if (data < 1000)
								$("#hadoop-76").attr("src",
										"../img/little-slow.png");
							else if (data < 2000)
								$("#hadoop-76").attr("src", "../img/slow.png");
							else if (data < 5000)
								$("#hadoop-76").attr("src",
										"../img/warning.png");
							else
								$("#hadoop-76").attr("src", "../img/dead.png");
						});

					}, 3000);
				});
	</script>

	<jsp:include page="footer.jsp" flush="true"></jsp:include>