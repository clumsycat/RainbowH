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

<script src="../js/exporting.js" type="text/javascript"></script>
<script src="../js/highstock.js" type="text/javascript"></script>
<link href="../css/bootstrap.min.css" rel="stylesheet">

<title>PM2.5和医疗的关系</title>

<jsp:include page="header.jsp" flush="true" />

</head>
<body>

	<div class="container">
		<h1 class="text-muted">
			PM 2.5和肺炎之间的关系<small>伪数据</small>
		</h1>
		<hr>
		<div id="container" style="min-width: 400px; height: 400px"></div>
	</div>
	<!-- /container -->
	<script>
		$(document)
				.ready(
						function() {
							var seriesOptions = [], seriesCounter = 0;
							var createChart = function() {
								$('#container')
										.highcharts(
												'StockChart',
												{
													rangeSelector : {
														selected : 4
													},
													yAxis : {
														labels : {
															formatter : function() {
																return (this.value > 0 ? ' + '
																		: '')
																		+ this.value
																		+ '%';
															}
														},
														plotLines : [ {
															value : 0,
															width : 2,
															color : 'silver'
														} ]
													},
													credits : {

														enabled : false

													},
													plotOptions : {
														series : {
															text : '指数'
														}
													},

													tooltip : {
														pointFormat : '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.change}%)<br/>',
														valueDecimals : 2
													},

													series : seriesOptions
												});
							};
							types = [ "pm", "disease" ];
							$.each(types, function(i, type) {
								$.ajax({
									type : "GET",
									url : "../servlet/PM25Servlet",
									dataType : "json",
									data : {
										"type" : type
									},
									success : function(data) {
										seriesOptions[i] = {
											name : type,
											data : data
										};
										seriesCounter += 1;
										if (seriesCounter === 2) {
											createChart();
										}
									}
								});
							});
						});
	</script>

	<jsp:include page="footer.jsp" flush="true"></jsp:include>