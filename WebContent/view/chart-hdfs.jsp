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
<script type="text/javascript" src="../js/highcharts.js"></script>
<script type="text/javascript" src="../js/exporting.js"></script>
<style>
div .chart {
	float: left;
	padding: 5px;
	margin: 20px;
}
</style>
<title>实时监控</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$
									.getJSON(
											'http://10.10.108.72:50070/jmx?qry=Hadoop:service=NameNode,name=NameNodeInfo&callback=?',
											function(resp) {
												var data = resp.beans[0];
												var liveNodesStr = data.LiveNodes;

												var liveNodesJSON = JSON
														.parse(liveNodesStr
																.replace(/-/g,
																		"_"));

												var usedArray = new Array();
												var nonDfsArray = new Array();
												var remainingArr = new Array();
												var serverList = new Array();
												for ( var key in liveNodesJSON) {
													usedArray
															.push(liveNodesJSON[key].usedSpace);
													nonDfsArray
															.push(liveNodesJSON[key].nonDfsUsedSpace);
													remainingArr
															.push(liveNodesJSON[key].remaining);
													serverList.push(key);
												}

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
												function getKMG(bvalue) {
													if (bvalue < 1024)
														return bvalue
																.toFixed(2)
																+ "B";
													bvalue /= 1024;
													if (bvalue < 1024)
														return bvalue
																.toFixed(2)
																+ "KB";
													bvalue /= 1024;
													if (bvalue < 1024)
														return bvalue
																.toFixed(2)
																+ "MB";
													bvalue /= 1024;
													if (bvalue < 1024)
														return bvalue
																.toFixed(2)
																+ "GB";
													bvalue /= 1024;
													if (bvalue < 1024)
														return bvalue
																.toFixed(2)
																+ "TB";
													bvalue /= 1024;
													if (bvalue < 1024)
														return bvalue
																.toFixed(2)
																+ "PB";
												}
												var chartArray = new Array(9);
												var renderToArray = [
														'container0',
														'container1',
														'container2',
														'container3',
														'container4',
														'container5',
														'container6',
														'container7',
														'container8' ];
												//	var serverList=['10.10.108.60','10.10.108.61','10.10.108.62','10.10.108.72','10.10.108.74','10.10.108.75','10.10.108.76','10.10.108.85','10.10.108.86'];
												for (var server = 0; server < serverList.length; server++) {
													chartArray[server] = new Highcharts.Chart(
															{
																chart : {
																	renderTo : renderToArray[server],
																	plotBackgroundColor : null,
																	plotBorderWidth : null,
																	plotShadow : false,
																	type : 'pie'
																},
																title : {
																	text : (function() {
																		return serverList[server]
																				.replace(
																						/hadoop_/,
																						"10.10.108.");
																	}())
																},
																credits : {
																	enabled : false
																},
																tooltip : {
																	pointFormat : '{series.name}: <b>{point.x} {point.percentage:.1f}%</b>'
																},
																 exporting: {
															            filename: 'hdfs-'+serverList[server],
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
																	name : "Brands",
																	colorByPoint : true,
																	data : [
																			{
																				name : "DFS Used",
																				y : usedArray[server],
																				x : getKMG(usedArray[server]),
																				sliced : true,
																				selected : true
																			},
																			{
																				name : "Non DFS Used",
																				y : nonDfsArray[server],
																				x : getKMG(nonDfsArray[server])
																			},
																			{
																				name : "Remaining",
																				y : remainingArr[server],
																				x : getKMG(remainingArr[server])
																			} ]
																} ]
															});//chartArray end

												}//for end	

											});
						});
	</script>
	<div class="container">
		<div class="btn-group btn-group-justified" role="group">
			<a href="chart-daemon.jsp" class="btn btn-default" role="button">Daemon</a>
			<a href="chart-impala.jsp" class="btn btn-default" role="button">Impala</a>
			<a href="chart-memcache.jsp" class="btn btn-default" role="button">Memcache</a>
			<a href="chart-ganglia.jsp" class="btn btn-default" role="button">服务器情况</a>
			<a href="#" class="btn btn-default" role="button">HDFS用量</a>
		</div>
		<h2>HDFS</h2>

		<div id="container0" class="chart"
			style="width: 400px; height: 400px; margin: 0 auto"></div>
		<div id="container1" class="chart"
			style="width: 400px; height: 400px; margin: 0 auto"></div>
		<div id="container2" class="chart"
			style="width: 400px; height: 400px; margin: 0 auto"></div>
		<div id="container3" class="chart"
			style="width: 400px; height: 400px; margin: 0 auto"></div>
		<div id="container4" class="chart"
			style="width: 400px; height: 400px; margin: 0 auto"></div>
		<div id="container5" class="chart"
			style="width: 400px; height: 400px; margin: 0 auto"></div>
		<div id="container6" class="chart"
			style="width: 400px; height: 400px; margin: 0 auto"></div>
		<div id="container7" class="chart"
			style="width: 400px; height: 400px; margin: 0 auto"></div>
		<div id="container8" class="chart"
			style="width: 400px; height: 400px; margin: 0 auto"></div>

	</div>

	<jsp:include page="footer.jsp" flush="true"></jsp:include>