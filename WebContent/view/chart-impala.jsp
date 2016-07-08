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
			<a href="chart-daemon.jsp" class="btn btn-default" role="button">Daemon</a> <a
				href="#" class="btn btn-default" role="button">Impala</a>
			<a href="chart-memcache.jsp" class="btn btn-default" role="button">Memcache</a>
			<a href="chart-ganglia.jsp" class="btn btn-default" role="button">服务器情况</a>
			<a href="chart-hdfs.jsp" class="btn btn-default" role="button">HDFS用量</a>
		</div>
		<h2>Impala</h2>
		<div id="init-charts">
			<div id="im-chart-sum" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="im-chart-70" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="im-chart-71" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="im-chart-73" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
		</div>
	</div>

	<script type="text/javascript">
		var serverList = [ "10.10.108.70", "10.10.108.71", "10.10.108.73",
				"impala 总体" ];
		var impalaArray = new Array(3);
		var renderToArray = [ "im-chart-70", "im-chart-71", "im-chart-73",
				"im-chart-sum" ];
		$(document)
				.ready(
						function() {
							for (i = 0; i < 3; i++) {
								impalaArray[i] = new Array();
								impalaArray[i][0] = serverList[i];
								impalaArray[i][1] = 0;
								impalaArray[i][2] = 0;
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
							var chartArray = new Array(renderToArray.length);
							for (var server = 0; server < chartArray.length; server++) {
								chartArray[server] = new Highcharts.Chart(
										{
											chart : {
												renderTo : renderToArray[server],
												type : 'spline',
												marginRight : 10,
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
											yAxis : {
												title : {
													text : '个/s'
												},
												startOnTick : true, //为true时，设置min才有效
												min : 0,
												plotLines : [ {
													value : 0,
													width : 1,
													color : '#808080'
												} ]
											},
											tooltip : {
												shared : true
											},
											legend : {
												enabled : true
											},
											 exporting: {
										            filename: 'Impala-'+serverList[server],
													enabled:true
										        },
											series : [
													{
														name : '接收/s',
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
														name : '返回/s',
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
													} ]
										});
							}
							function getServletData() {
								$
										.ajax({
											type : "GET",
											url : "AllState",
											dataType : "json",
											success : function(data, textStatus) {
												for (i = 0; i < 3; i++) {
													impalaArray[i][1] = 0;
													impalaArray[i][2] = 0;
												}
												var sumdata = [ 0, 0, ];
												var x = (new Date()).getTime(), y;
												for (ser in data.Daemon) {
													if (!("dead" in data.Daemon[ser])) {
														for (impi in data.Daemon[ser].ImpalaStat) {
															if (data.Daemon[ser].ImpalaStat[impi].IP == "10.10.108.70") {
																impalaArray[0][1] += parseFloat(data.Daemon[ser].ImpalaStat[impi].ImpalaRec);
																impalaArray[0][2] += parseFloat(data.Daemon[ser].ImpalaStat[impi].ImpalaRet);
															} else if (data.Daemon[ser].ImpalaStat[impi].IP == "10.10.108.71") {
																impalaArray[1][1] += parseFloat(data.Daemon[ser].ImpalaStat[impi].ImpalaRec);
																impalaArray[1][2] += parseFloat(data.Daemon[ser].ImpalaStat[impi].ImpalaRet);
															} else if (data.Daemon[ser].ImpalaStat[impi].IP == "10.10.108.73") {
																impalaArray[2][1] += parseFloat(data.Daemon[ser].ImpalaStat[impi].ImpalaRec);
																impalaArray[2][2] += parseFloat(data.Daemon[ser].ImpalaStat[impi].ImpalaRet);
															}
														}//end for in impalastat
													}// end if dead
												}//end for in Daemon
												for (i = 0; i < 3; i++) {
													y = parseFloat(impalaArray[i][1]);
													sumdata[0] += y;
													chartArray[i].series[0]
															.addPoint([ x, y ],
																	false,
																	true, true);
													y = parseFloat(impalaArray[i][2]);
													sumdata[1] += y;
													chartArray[i].series[1]
															.addPoint([ x, y ],
																	false,
																	true, true);
													chartArray[i].redraw();
												}
												for (ser in sumdata) {
													chartArray[renderToArray.length - 1].series[ser]
															.addPoint(
																	[
																			x,
																			sumdata[ser] ],
																	true, true);
												}
												chartArray[renderToArray.length - 1]
														.redraw();
											}//success function end
										});//ajax end
							}//getServletData end
							getServletData();
							setInterval(getServletData, 5000);

						});
	</script>

	<jsp:include page="footer.jsp" flush="true"></jsp:include></body>
</html>