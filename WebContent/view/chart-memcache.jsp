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
	padding: 15px;
	margin: 2serpx;
}
</style>
<title>实时监控</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<div class="container">
		<div class="btn-group btn-group-justified" role="group">
			<a href="chart-daemon.jsp" class="btn btn-default" role="button">Memcache</a> <a
				href="chart-impala.jsp" class="btn btn-default" role="button">Impala</a>
			<a href="#" class="btn btn-default" role="button">Memcache</a>
			<a href="chart-ganglia.jsp" class="btn btn-default" role="button">服务器情况</a>
			<a href="chart-hdfs.jsp" class="btn btn-default" role="button">HDFS用量</a>
		</div>
		<h2>Memcache</h2>
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
											var storage = window.localStorage;
											storage
													.setItem(
															"memcache-now",
															JSON
																	.stringify(data.Memcache));
											$("#init-charts")
													.html(
															"<div id=\"chart-sum\" 	style=\"width: 500px; height: 400px;\"></div>");
											for (ser in data.Memcache) {
												serverList
														.push(data.Memcache[ser].serverName);
												$("#init-charts")
														.append(
																"<div id=\"chart-"+data.Memcache[ser].serverName+"\" class=\"chart\"	style=\"width: 500px; height: 400px;\"></div>");
												renderToArray
														.push("chart-"
																+ data.Memcache[ser].serverName);
											}
											serverList.push("Memcache 内存分布");

											Highcharts.setOptions({
												global : {
													useUTC : false
												},
													lang:{
													       contextButtonTitle:"图表导出菜单",
													       decimalPoint:".",
													       downloadJPEG:"下载JPEG图片",
													       downloadPDF:"下载PDF文件",
													       downloadPNG:"下载PNG文件",
													       downloadSVG:"下载SVG文件",
													       drillUpText:"返回 {series.name}",
													       loading:"加载中",
													       months:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
													       noData:"没有数据",
													       numericSymbols: [ "千" , "兆" , "G" , "T" , "P" , "E"],
													       resetZoom:"恢复缩放",
													       resetZoomTitle:"恢复图表",
													       shortMonths: [ "Jan" , "Feb" , "Mar" , "Apr" , "May" , "Jun" , "Jul" , "Aug" , "Sep" , "Oct" , "Nov" , "Dec"],
													       thousandsSep:",",
													       weekdays: ["星期一", "星期二", "星期三", "星期三", "星期四", "星期五", "星期六","星期天"]
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
															 exporting: {
														            filename: 'MemCache-'+serverList[server],
																	enabled:true
														        },
															series : [
																	{
																		name : 'get/s',
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
																		}())
																	},
																	{
																		name : 'set/s',
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
																		}())
																	},
																	{
																		name : 'hit%',
																		yAxis : 1,
																		data : (function() {
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
																		}())
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
																tooltip : {
																	pointFormat : '{series.name}: <b>{point.x} {point.percentage:.1f}%</b>'
																},
																 exporting: {
															            filename: 'MemCache-内存分布',
																		enabled:true
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
																	name : 'Memcache 内存分布'
																} ]

															});
											function getKMG(bvalue) {
												if (bvalue < 1024)
													return bvalue.toFixed(2)
															+ "B";
												bvalue /= 1024;
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
																var storage = window.localStorage;
																var last = JSON
																		.parse(storage
																				.getItem("memcache-now"));

																var memcache = data.Memcache;
																storage
																		.setItem(
																				"memcache-now",
																				JSON
																						.stringify(memcache));
																var mempie = new Array();
																var x = (new Date())
																		.getTime(), y;
																mempie[renderToArray.length] = 0;
																var timemin=memcache[ser].uptime - last[ser].uptime;
																if (timemin==0)
																	{timemin=5;}
																for (ser in memcache) {
																	mempie[renderToArray.length] += parseFloat(memcache[ser].limit_maxbytes);
																	y = parseFloat((memcache[ser].cmd_get - last[ser].cmd_get)
																			/timemin);
																	chartArray[ser].series[0]
																			.addPoint(
																					[
																							x,
																							0 ],
																					true,
																					true);
																	y = parseFloat((memcache[ser].cmd_set - last[ser].cmd_set)
																			/timemin);
																	chartArray[ser].series[1]
																			.addPoint(
																					[
																							x,
																							0 ],
																					true,
																					true);
																	y = parseFloat((memcache[ser].get_hits
																			/ (memcache[ser].get_hits + memcache[ser].get_misses)).toFixed(2));
																	chartArray[ser].series[2]
																			.addPoint(
																					[
																							x,
																							y ],
																					true,
																					true);
																}
																var data = new Array();
																for (ser in memcache) {
																	mempie[ser] = new Array();
																	mempie[ser][0] = parseFloat(memcache[ser].limit_maxbytes
																			/ mempie[renderToArray.length]);
																	mempie[ser][1] = getKMG(parseFloat(memcache[ser].limit_maxbytes));
																	data
																			.push({
																				name : memcache[ser].serverName,
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