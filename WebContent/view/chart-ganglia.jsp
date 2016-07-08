<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.ser1 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="../js/jquery-1.11.2.min.js" type="text/javascript"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="../js/bootstrap.min.js" type="text/javascript"></script>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="../js/highcharts.js"></script>
<script type="text/javascript" src="../js/exporting.js"></script>
<style type="text/css">
div .chart {
	float: left;
	padding: 5px;
	margin: 2serpx;
}
</style>
<title>实时监控</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<div class="container">
		<div class="btn-group btn-group-justified" role="group">
			<a href="chart-daemon.jsp" class="btn btn-default" role="button">Daemon</a>
			<a href="chart-impala.jsp" class="btn btn-default" role="button">Impala</a>
			<a href="chart-memcache.jsp" class="btn btn-default" role="button">Memcache</a>
			<a href="#" class="btn btn-default" role="button">服务器情况</a> <a
				href="chart-hdfs.jsp" class="btn btn-default" role="button">HDFS用量</a>
		</div>
		<h2>物理结点信息</h2>
		<div id="init-charts"></div>
	</div>

	<script type="text/javascript">
		var serverList = new Array();
		var renderToArray = new Array();
		$(document)
				.ready(
						function() {
							$
									.ajax({
										type : "GET",
										url : "AllState",
										dataType : "json",
										success : function(data, textStatus) {
											$("#init-charts")
													.html(
															"<div id=\"chart-sum\" 	style=\"width: 500px; height: 400px;\"></div><hr>");
											for (ser in data.Ganglia) {
												serverList
														.push(data.Ganglia[ser].hostIp);
												$("#init-charts")
														.append(
																"<div id=\"chart-"+data.Ganglia[ser].hostIp+"\" class=\"chart\"	style=\"width: 400px; height: 300px;\"></div>");
												renderToArray
														.push("chart-"
																+ data.Ganglia[ser].hostIp);
											}
											serverList.push("Ganglia 内存分布");
											Highcharts.setOptions({
												global : {
													useUTC : false
												}
											});
											var chartArray = new Array(
													renderToArray.length);
											for (var server = 0; server < chartArray.length; server++) {
												chartArray[server] = new Highcharts.Chart(
														{
															chart : {
																renderTo : renderToArray[server],
																type : 'spline'
															},
															title : {
																text : serverList[server]
															},
															credits : {
																enabled : false
															},
															xAxis : {
																type : 'datetime'

															},
															yAxis : [
																	{
																		title : {
																			text : 'KB/s'
																		},
																		labels : {
																			format : "{value} KB"
																		},
																		startOnTick : true, //为true时，设置min才有效
																		min : 0,
																		plotLines : [ {
																			value : 0,
																			width : 1,
																			color : '#808080'
																		} ]
																	},
																	{
																		title : {
																			text : '%',
																			style : {
																				color : '#4572A7'
																			}
																		},
																		labels : {
																			format : "{value} %",
																			style : {
																				color : '#4572A7'
																			}
																		},
																		allowDecimals : false,
																		opposite : true
																	} ],
															tooltip : {
																shared : true
															},
															legend : {
																enabled : true
															},
															exporting : {
																filename : 'Ganglia-'
																		+ serverList[server],
																enabled : true
															},
															series : [
																	{
																		name : '网路下行/s',
																		yAxis : 0,
																		data : (function() {
																			// generate an array of random data
																			var data = [], time = (new Date())
																					.getTime(), i;

																			for (i = -19; i <= 0; i++) {
																				data
																						.push({
																							x : time
																									+ i
																									* 5000,
																							y : 0
																						});
																			}
																			return data;
																		})()
																	},
																	{
																		name : '网络上行/s',
																		yAxis : 0,
																		data : (function() {
																			// generate an array of random data
																			var data = [], time = (new Date())
																					.getTime(), i;

																			for (i = -19; i <= 0; i++) {
																				data
																						.push({
																							x : time
																									+ i
																									* 5000,
																							y : 0
																						});
																			}
																			return data;
																		})()
																	},
																	{
																		name : '磁盘读/s',
																		yAxis : 0,
																		data : (function() {
																			// generate an array of random data
																			var data = [], time = (new Date())
																					.getTime(), i;

																			for (i = -19; i <= 0; i++) {
																				data
																						.push({
																							x : time
																									+ i
																									* 5000,
																							y : 0
																						});
																			}
																			return data;
																		})()
																	},
																	{
																		name : '磁盘写/s',
																		yAxis : 0,
																		data : (function() {
																			// generate an array of random data
																			var data = [], time = (new Date())
																					.getTime(), i;

																			for (i = -19; i <= 0; i++) {
																				data
																						.push({
																							x : time
																									+ i
																									* 5000,
																							y : 0
																						});
																			}
																			return data;
																		})()
																	},
																	{
																		name : 'CPU使用%',
																		yAxis : 1,
																		data : (function() {
																			// generate an array of random data
																			var data = [], time = (new Date())
																					.getTime(), i;

																			for (i = -19; i <= 0; i++) {
																				data
																						.push({
																							x : time
																									+ i
																									* 5000,
																							y : 0
																						});
																			}
																			return data;
																		})()
																	},
																	{
																		name : '内存使用%',
																		yAxis : 1,
																		data : (function() {
																			// generate an array of random data
																			var data = [], time = (new Date())
																					.getTime(), i;

																			for (i = -19; i <= 0; i++) {
																				data
																						.push({
																							x : time
																									+ i
																									* 5000,
																							y : 0
																						});
																			}
																			return data;
																		})()
																	} ]
														});
											}
											$("#chart-sum")
													.highcharts(
															{
																chart : {
																	plotBackgroundColor : null,
																	plotBorderWidth : null,
																	plotShadow : false
																},
																title : {
																	text : '各节点内存容量'
																},
																credits : {
																	enabled : false
																},
																legend : {
																	enabled : true
																},
																exporting : {
																	filename : '物理机-内存分布',
																	enabled : true
																},
																tooltip : {
																	pointFormat : '{series.name}: <b>{point.x} {point.percentage:.1f}%</b>'
																},
																plotOptions : {
																	pie : {
																		allowPointSelect : true,
																		cursor : 'pointer',
																		dataLabels : {
																			enabled : false
																		},
																		showInLegend : true
																	}
																},
																series : [ {
																	type : 'pie',
																	name : '服务器 内存分布'
																} ]

															});

											function getKMG(bvalue) {
												if (bvalue < 1024)
													return bvalue.toFixed(2)
															+ "KB";
												bvalue /= 1024;
												if (bvalue < 1024)
													return bvalue.toFixed(2)
															+ "MB";
												bvalue /= 1024;
												if (bvalue < 1024)
													return bvalue.toFixed(2)
															+ "GB";
												bvalue /= 1024;
												if (bvalue < 1024)
													return bvalue.toFixed(2)
															+ "TB";
												bvalue /= 1024;
												if (bvalue < 1024)
													return bvalue.toFixed(2)
															+ "PB";
											}
											function getServletData() {
												$
														.ajax({
															type : "GET",
															url : "AllState",
															dataType : "json",
															success : function(
																	data,
																	textStatus) {
																var ganglia = data.Ganglia;
																var mempie = new Array();
																var x = (new Date())
																		.getTime(), y;
																mempie[renderToArray.length] = 0;
																for (ser in ganglia) {
																	mempie[renderToArray.length] += parseFloat(ganglia[ser].mem_total);
																	y = parseFloat((ganglia[ser].bytes_out / 1024)
																			.toFixed(2));
																	chartArray[ser].series[0]
																			.addPoint(
																					[
																							x,
																							y ],
																					true,
																					true);
																	y = parseFloat((ganglia[ser].bytes_in / 1024)
																			.toFixed(2));
																	chartArray[ser].series[1]
																			.addPoint(
																					[
																							x,
																							y ],
																					true,
																					true);
																	y = parseFloat((ganglia[ser].diskstat_read_bytes_per_sec / 1024)
																			.toFixed(2));
																	chartArray[ser].series[2]
																			.addPoint(
																					[
																							x,
																							y ],
																					true,
																					true);
																	y = parseFloat((ganglia[ser].diskstat_write_bytes_per_sec / 1024)
																			.toFixed(2));
																	chartArray[ser].series[3]
																			.addPoint(
																					[
																							x,
																							y ],
																					true,
																					true);
																	y = parseFloat(ganglia[0].cpu_user)
																			+ parseFloat(ganglia[0].cpu_system);
																	chartArray[ser].series[4]
																			.addPoint(
																					[
																							x,
																							y ],
																					true,
																					true);
																	y = parseFloat(((1 - ganglia[0].mem_free
																			/ ganglia[0].mem_total) * 100)
																			.toFixed(2));
																	chartArray[ser].series[5]
																			.addPoint(
																					[
																							x,
																							y ],
																					true,
																					true);
																}
																var data = new Array();
																for (ser in ganglia) {
																	mempie[ser] = new Array();
																	mempie[ser][0] = parseFloat(ganglia[ser].mem_total
																			/ mempie[renderToArray.length]);
																	mempie[ser][1] = getKMG(parseFloat(ganglia[ser].mem_total));
																	data
																			.push({
																				name : ganglia[ser].hostIp,
																				x : mempie[ser][1],
																				y : mempie[ser][0]
																			});
																}
																var chart = $(
																		'#chart-sum')
																		.highcharts();
																chart.series[0]
																		.setData(data);

															}//success function end
														});//ajax end
											}//getServletData end
											getServletData();
											setInterval(getServletData, 5000);
										}
									});
						});
	</script>

	<jsp:include page="footer.jsp" flush="true"></jsp:include></body>
</html>