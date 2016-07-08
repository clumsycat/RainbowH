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
	<div class="container">
		<h2>Daemon</h2>

		<hr>
		<h2>Impala</h2>
		<div id="impala-chart"></div>
		<hr>


		<div class="container">
			<h2>Memcache</h2>
			<div id="mem-chart-74" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="mem-chart-85" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="mem-chart-86" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="mem-chart-61" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="mem-chart-62" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="mem-chart-60" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
		</div>
		<hr>
		<div class="container">
			<h2>物理节点信息</h2>
			<div id="ganglia-74" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="ganglia-75" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="ganglia-76" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="ganglia-85" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="ganglia-86" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="ganglia-60" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="ganglia-61" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="ganglia-70" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="ganglia-62" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="ganglia-71" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="ganglia-72" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
			<div id="ganglia-73" class="chart"
				style="width: 400px; height: 300px; margin: 10 auto"></div>
		</div>
	</div>

	<script>
		$(document)
				.ready(
						function() {
							setInterval(function() {
								$.ajax({
									type : "GET",
									url : "AllState",
									dataType : "json",
									success : function(data) {
										var storage = window.localStorage;
										var last = JSON.parse(storage
												.getItem("memcache-now"));
										storage.setItem("memcache-last", JSON
												.stringify(last));
										storage.setItem("memcache-now", JSON
												.stringify(data.Memcache));
										storage.setItem("ganglia", JSON
												.stringify(data.Ganglia));
										storage.setItem("daemon", JSON
												.stringify(data.Daemon));
									}
								});
							}, 5000);
							Highcharts.setOptions({
								global : {
									useUTC : false
								},
							});
							var options_74 = {
								chart : {
									renderTo : 'mem-chart-74',
									type : 'spline',
									marginRight : 10,
									events : {
										load : function() {
											var series_get = this.series[0];
											var series_set = this.series[1];
											setInterval(
													function() {
														var x = (new Date())
																.getTime(), y;
														var storage = window.localStorage;
														var memcache = JSON
																.parse(storage
																		.getItem("memcache-now"));
														var last = JSON
																.parse(storage
																		.getItem("memcache-last"));
														y = (memcache[0].cmd_get - last[0].cmd_get)
																/ (memcache[0].uptime - last[0].uptime);
														series_get.addPoint([
																x, y ], true,
																true);
														y = (memcache[0].cmd_set - last[0].cmd_set)
																/ (memcache[0].uptime - last[0].uptime);
														series_set.addPoint([
																x, y ], true,
																true);
													}, 5000);
										}
									}
								},
								title : {
									text : '实时set/get'
								},
								credits : {
									enabled : false
								},
								xAxis : {
									type : 'datetime',
									tickPixelInterval : 150
								},
								yAxis : {
									title : {
										text : '次/s'
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
									formatter : function() {
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts.dateFormat(
														'%Y-%m-%d %H:%M:%S',
														this.x)
												+ '<br/>'
												+ '<span style="color:#08c">'
												+ Highcharts.numberFormat(
														this.y, 2) + ' 次'
												+ '</span>';
									}
								},
								legend : {
									enabled : true
								},
								exporting : {
									enabled : false
								},
								series : [
										{
											name : '74 get/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										},
										{
											name : '74 set/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										} ]
							};
							//85
							var options_85 = {
								chart : {
									renderTo : 'mem-chart-85',
									type : 'spline',
									marginRight : 10,
									events : {
										load : function() {
											// set up the updating of the chart each second
											var series_get = this.series[0];
											var series_set = this.series[1];
											setInterval(
													function() {
														var storage = window.localStorage;
														var x = (new Date())
																.getTime(), y;
														var memcache = JSON
																.parse(storage
																		.getItem("memcache-now"));
														var last = JSON
																.parse(storage
																		.getItem("memcache-last"));
														y = (memcache[1].cmd_get - last[1].cmd_get)
																/ (memcache[1].uptime - last[1].uptime);
														series_get.addPoint([
																x, y ], true,
																true);
														y = (memcache[1].cmd_set - last[1].cmd_set)
																/ (memcache[1].uptime - last[1].uptime);
														series_set.addPoint([
																x, y ], true,
																true);
													}, 5000);
										}
									}
								},
								title : {
									text : '实时set/get'
								},
								credits : {
									enabled : false
								},
								xAxis : {
									type : 'datetime',
									tickPixelInterval : 150
								},
								yAxis : {
									title : {
										text : '次/s'
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
									formatter : function() {
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts.dateFormat(
														'%Y-%m-%d %H:%M:%S',
														this.x)
												+ '<br/>'
												+ '<span style="color:#08c">'
												+ Highcharts.numberFormat(
														this.y, 2) + ' 次'
												+ '</span>';

									}
								},
								legend : {
									enabled : true
								},
								exporting : {
									enabled : false
								},
								series : [
										{
											name : '85 get/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										},
										{
											name : '85 set/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										} ]
							};
							//86
							var options_86 = {
								chart : {
									renderTo : 'mem-chart-86',
									type : 'spline',
									marginRight : 10,
									events : {
										load : function() {
											// set up the updating of the chart each second
											var series_get = this.series[0];
											var series_set = this.series[1];
											setInterval(
													function() {
														var storage = window.localStorage;
														var x = (new Date())
																.getTime(), y;
														var memcache = JSON
																.parse(storage
																		.getItem("memcache-now"));
														var last = JSON
																.parse(storage
																		.getItem("memcache-last"));
														y = (memcache[2].cmd_get - last[2].cmd_get)
																/ (memcache[2].uptime - last[2].uptime);
														series_get.addPoint([
																x, y ], true,
																true);
														y = (memcache[2].cmd_set - last[2].cmd_set)
																/ (memcache[2].uptime - last[2].uptime);
														series_set.addPoint([
																x, y ], true,
																true);
													}, 5000);
										}
									}
								},
								title : {
									text : '实时set/get'
								},
								credits : {
									enabled : false
								},
								xAxis : {
									type : 'datetime',
									tickPixelInterval : 150
								},
								yAxis : {
									title : {
										text : '次/s'
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
									formatter : function() {
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts.dateFormat(
														'%Y-%m-%d %H:%M:%S',
														this.x)
												+ '<br/>'
												+ '<span style="color:#08c">'
												+ Highcharts.numberFormat(
														this.y, 2) + ' 次'
												+ '</span>';

									}
								},
								legend : {
									enabled : true
								},
								exporting : {
									enabled : false
								},
								series : [
										{
											name : '86 get/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										},
										{
											name : '86 set/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										} ]
							};
							//61
							var options_61 = {
								chart : {
									renderTo : 'mem-chart-61',
									type : 'spline',
									marginRight : 10,
									events : {
										load : function() {
											// set up the updating of the chart each second
											var series_get = this.series[0];
											var series_set = this.series[1];
											setInterval(
													function() {
														var storage = window.localStorage;
														var x = (new Date())
																.getTime(), y;
														var memcache = JSON
																.parse(storage
																		.getItem("memcache-now"));
														var last = JSON
																.parse(storage
																		.getItem("memcache-last"));
														y = (memcache[3].cmd_get - last[3].cmd_get)
																/ (memcache[3].uptime - last[3].uptime);
														series_get.addPoint([
																x, y ], true,
																true);
														y = (memcache[3].cmd_set - last[3].cmd_set)
																/ (memcache[3].uptime - last[3].uptime);
														series_set.addPoint([
																x, y ], true,
																true);
													}, 5000);
										}
									}
								},
								title : {
									text : '实时set/get'
								},
								credits : {
									enabled : false
								},
								xAxis : {
									type : 'datetime',
									tickPixelInterval : 150
								},
								yAxis : {
									title : {
										text : '次/s'
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
									formatter : function() {
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts.dateFormat(
														'%Y-%m-%d %H:%M:%S',
														this.x)
												+ '<br/>'
												+ '<span style="color:#08c">'
												+ Highcharts.numberFormat(
														this.y, 2) + ' 次'
												+ '</span>';

									}
								},
								legend : {
									enabled : true
								},
								exporting : {
									enabled : false
								},
								series : [
										{
											name : '61 get/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										},
										{
											name : '61 set/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										} ]
							};
							//62
							var options_62 = {
								chart : {
									renderTo : 'mem-chart-62',
									type : 'spline',
									marginRight : 10,
									events : {
										load : function() {
											// set up the updating of the chart each second
											var series_get = this.series[0];
											var series_set = this.series[1];
											setInterval(
													function() {
														var storage = window.localStorage;
														var x = (new Date())
																.getTime(), y;
														var memcache = JSON
																.parse(storage
																		.getItem("memcache-now"));
														var last = JSON
																.parse(storage
																		.getItem("memcache-last"));
														y = (memcache[4].cmd_get - last[4].cmd_get)
																/ (memcache[4].uptime - last[4].uptime);
														series_get.addPoint([
																x, y ], true,
																true);
														y = (memcache[4].cmd_set - last[4].cmd_set)
																/ (memcache[4].uptime - last[4].uptime);
														series_set.addPoint([
																x, y ], true,
																true);
													}, 5000);
										}
									}
								},
								title : {
									text : '实时set/get'
								},
								credits : {
									enabled : false
								},
								xAxis : {
									type : 'datetime',
									tickPixelInterval : 150
								},
								yAxis : {
									title : {
										text : '次/s'
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
									formatter : function() {
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts.dateFormat(
														'%Y-%m-%d %H:%M:%S',
														this.x)
												+ '<br/>'
												+ '<span style="color:#08c">'
												+ Highcharts.numberFormat(
														this.y, 2) + ' 次'
												+ '</span>';

									}
								},
								legend : {
									enabled : true
								},
								exporting : {
									enabled : false
								},
								series : [
										{
											name : '62 get/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										},
										{
											name : '62 set/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										} ]
							};
							//60
							var options_60 = {
								chart : {
									renderTo : 'mem-chart-60',
									type : 'spline',
									marginRight : 10,
									events : {
										load : function() {
											// set up the updating of the chart each second
											var series_get = this.series[0];
											var series_set = this.series[1];
											setInterval(
													function() {
														var storage = window.localStorage;
														var x = (new Date())
																.getTime(), y;
														var memcache = JSON
																.parse(storage
																		.getItem("memcache-now"));
														var last = JSON
																.parse(storage
																		.getItem("memcache-last"));
														y = (memcache[5].cmd_get - last[5].cmd_get)
																/ (memcache[5].uptime - last[5].uptime);
														series_get.addPoint([
																x, y ], true,
																true);
														y = (memcache[5].cmd_set - last[5].cmd_set)
																/ (memcache[5].uptime - last[5].uptime);
														series_set.addPoint([
																x, y ], true,
																true);
													}, 5000);
										}
									}
								},
								title : {
									text : '实时set/get'
								},
								credits : {
									enabled : false
								},
								xAxis : {
									type : 'datetime',
									tickPixelInterval : 150
								},
								yAxis : {
									title : {
										text : '次/s'
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
									formatter : function() {
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts.dateFormat(
														'%Y-%m-%d %H:%M:%S',
														this.x)
												+ '<br/>'
												+ '<span style="color:#08c">'
												+ Highcharts.numberFormat(
														this.y, 2) + ' 次'
												+ '</span>';

									}
								},
								legend : {
									enabled : true
								},
								exporting : {
									enabled : false
								},
								series : [
										{
											name : '60 get/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										},
										{
											name : '60 set/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										} ]
							};

							chart = new Highcharts.Chart(options_74);
							chart = new Highcharts.Chart(options_85);
							chart = new Highcharts.Chart(options_86);
							chart = new Highcharts.Chart(options_61);
							chart = new Highcharts.Chart(options_62);
							chart = new Highcharts.Chart(options_60);
							//ganglia
							//74
							var ganglia_74 = {
								chart : {
									renderTo : 'ganglia-74',
									type : 'spline',
									marginRight : 10,
									events : {
										load : function() {
											// set up the updating of the chart each second
											var series_out = this.series[0];
											var series_in = this.series[1];
											setInterval(
													function() {
														var storage = window.localStorage;
														var x = (new Date())
																.getTime(), y;
														var ganglia = JSON
																.parse(storage
																		.getItem("ganglia"));
														y = ganglia[0].bytes_out / 1024;
														series_out.addPoint([
																x, y ], true,
																true);
														y = ganglia[0].bytes_in / 1024;
														series_in
																.addPoint([ x,
																		y ],
																		true,
																		true);
													}, 5000);
										}
									}
								},
								title : {
									text : '实时网络I/O'
								},
								credits : {
									enabled : false
								},
								xAxis : {
									type : 'datetime',
									tickPixelInterval : 150
								},
								yAxis : {
									title : {
										text : 'KB/s'
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
									formatter : function() {
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts.dateFormat(
														'%Y-%m-%d %H:%M:%S',
														this.x)
												+ '<br/>'
												+ '<span style="color:#08c">'
												+ Highcharts.numberFormat(
														this.y, 2) + ' KB'
												+ '</span>';

									}
								},
								legend : {
									enabled : true
								},
								exporting : {
									enabled : false
								},
								series : [
										{
											name : '74 out/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										},
										{
											name : '74 in/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										} ]
							};
							//75
							var ganglia_75 = {
								chart : {
									renderTo : 'ganglia-75',
									type : 'spline',
									marginRight : 10,
									events : {
										load : function() {
											// set up the updating of the chart each second
											var series_out = this.series[0];
											var series_in = this.series[1];
											setInterval(
													function() {
														var storage = window.localStorage;
														var x = (new Date())
																.getTime(), y;
														var ganglia = JSON
																.parse(storage
																		.getItem("ganglia"));
														y = ganglia[1].bytes_out / 1024;
														series_out.addPoint([
																x, y ], true,
																true);
														y = ganglia[1].bytes_in / 1024;
														series_in
																.addPoint([ x,
																		y ],
																		true,
																		true);
													}, 5000);
										}
									}
								},
								title : {
									text : '实时网络I/O'
								},
								credits : {
									enabled : false
								},
								xAxis : {
									type : 'datetime',
									tickPixelInterval : 150
								},
								yAxis : {
									title : {
										text : 'KB/s'
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
									formatter : function() {
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts.dateFormat(
														'%Y-%m-%d %H:%M:%S',
														this.x)
												+ '<br/>'
												+ '<span style="color:#08c">'
												+ Highcharts.numberFormat(
														this.y, 2) + ' KB'
												+ '</span>';

									}
								},
								legend : {
									enabled : true
								},
								exporting : {
									enabled : false
								},
								series : [
										{
											name : '75 out/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										},
										{
											name : '75 in/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										} ]
							};
							//76
							var ganglia_76 = {
								chart : {
									renderTo : 'ganglia-76',
									type : 'spline',
									marginRight : 10,
									events : {
										load : function() {
											// set up the updating of the chart each second
											var series_out = this.series[0];
											var series_in = this.series[1];
											setInterval(
													function() {
														var storage = window.localStorage;
														var x = (new Date())
																.getTime(), y;
														var ganglia = JSON
																.parse(storage
																		.getItem("ganglia"));
														y = ganglia[2].bytes_out / 1024;
														series_out.addPoint([
																x, y ], true,
																true);
														y = ganglia[2].bytes_in / 1024;
														series_in
																.addPoint([ x,
																		y ],
																		true,
																		true);
													}, 5000);
										}
									}
								},
								title : {
									text : '实时网络I/O'
								},
								credits : {
									enabled : false
								},
								xAxis : {
									type : 'datetime',
									tickPixelInterval : 150
								},
								yAxis : {
									title : {
										text : 'KB/s'
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
									formatter : function() {
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts.dateFormat(
														'%Y-%m-%d %H:%M:%S',
														this.x)
												+ '<br/>'
												+ '<span style="color:#08c">'
												+ Highcharts.numberFormat(
														this.y, 2) + ' KB'
												+ '</span>';

									}
								},
								legend : {
									enabled : true
								},
								exporting : {
									enabled : false
								},
								series : [
										{
											name : '76 out/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										},
										{
											name : '76 in/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										} ]
							};
							//85
							var ganglia_85 = {
								chart : {
									renderTo : 'ganglia-85',
									type : 'spline',
									marginRight : 10,
									events : {
										load : function() {
											// set up the updating of the chart each second
											var series_out = this.series[0];
											var series_in = this.series[1];
											setInterval(
													function() {
														var storage = window.localStorage;
														var x = (new Date())
																.getTime(), y;
														var ganglia = JSON
																.parse(storage
																		.getItem("ganglia"));
														y = ganglia[3].bytes_out / 1024;
														series_out.addPoint([
																x, y ], true,
																true);
														y = ganglia[3].bytes_in / 1024;
														series_in
																.addPoint([ x,
																		y ],
																		true,
																		true);
													}, 5000);
										}
									}
								},
								title : {
									text : '实时网络I/O'
								},
								credits : {
									enabled : false
								},
								xAxis : {
									type : 'datetime',
									tickPixelInterval : 150
								},
								yAxis : {
									title : {
										text : 'KB/s'
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
									formatter : function() {
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts.dateFormat(
														'%Y-%m-%d %H:%M:%S',
														this.x)
												+ '<br/>'
												+ '<span style="color:#08c">'
												+ Highcharts.numberFormat(
														this.y, 2) + ' KB'
												+ '</span>';

									}
								},
								legend : {
									enabled : true
								},
								exporting : {
									enabled : false
								},
								series : [
										{
											name : '85 out/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										},
										{
											name : '85 in/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										} ]
							};
							//86
							var ganglia_86 = {
								chart : {
									renderTo : 'ganglia-86',
									type : 'spline',
									marginRight : 10,
									events : {
										load : function() {
											// set up the updating of the chart each second
											var series_out = this.series[0];
											var series_in = this.series[1];
											setInterval(
													function() {
														var storage = window.localStorage;
														var x = (new Date())
																.getTime(), y;
														var ganglia = JSON
																.parse(storage
																		.getItem("ganglia"));
														y = ganglia[4].bytes_out / 1024;
														series_out.addPoint([
																x, y ], true,
																true);
														y = ganglia[4].bytes_in / 1024;
														series_in
																.addPoint([ x,
																		y ],
																		true,
																		true);
													}, 5000);
										}
									}
								},
								title : {
									text : '实时网络I/O'
								},
								credits : {
									enabled : false
								},
								xAxis : {
									type : 'datetime',
									tickPixelInterval : 150
								},
								yAxis : {
									title : {
										text : 'KB/s'
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
									formatter : function() {
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts.dateFormat(
														'%Y-%m-%d %H:%M:%S',
														this.x)
												+ '<br/>'
												+ '<span style="color:#08c">'
												+ Highcharts.numberFormat(
														this.y, 2) + ' KB'
												+ '</span>';

									}
								},
								legend : {
									enabled : true
								},
								exporting : {
									enabled : false
								},
								series : [
										{
											name : '86 out/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										},
										{
											name : '86 in/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										} ]
							};
							//60
							var ganglia_60 = {
								chart : {
									renderTo : 'ganglia-60',
									type : 'spline',
									marginRight : 10,
									events : {
										load : function() {
											// set up the updating of the chart each second
											var series_out = this.series[0];
											var series_in = this.series[1];
											setInterval(
													function() {
														var storage = window.localStorage;
														var x = (new Date())
																.getTime(), y;
														var ganglia = JSON
																.parse(storage
																		.getItem("ganglia"));
														y = ganglia[5].bytes_out / 1024;
														series_out.addPoint([
																x, y ], true,
																true);
														y = ganglia[5].bytes_in / 1024;
														series_in
																.addPoint([ x,
																		y ],
																		true,
																		true);
													}, 5000);
										}
									}
								},
								title : {
									text : '实时网络I/O'
								},
								credits : {
									enabled : false
								},
								xAxis : {
									type : 'datetime',
									tickPixelInterval : 150
								},
								yAxis : {
									title : {
										text : 'KB/s'
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
									formatter : function() {
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts.dateFormat(
														'%Y-%m-%d %H:%M:%S',
														this.x)
												+ '<br/>'
												+ '<span style="color:#08c">'
												+ Highcharts.numberFormat(
														this.y, 2) + ' KB'
												+ '</span>';

									}
								},
								legend : {
									enabled : true
								},
								exporting : {
									enabled : false
								},
								series : [
										{
											name : '60 out/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										},
										{
											name : '60 in/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										} ]
							};
							//61
							var ganglia_61 = {
								chart : {
									renderTo : 'ganglia-61',
									type : 'spline',
									marginRight : 10,
									events : {
										load : function() {
											// set up the updating of the chart each second
											var series_out = this.series[0];
											var series_in = this.series[1];
											setInterval(
													function() {
														var storage = window.localStorage;
														var x = (new Date())
																.getTime(), y;
														var ganglia = JSON
																.parse(storage
																		.getItem("ganglia"));
														y = ganglia[6].bytes_out / 1024;
														series_out.addPoint([
																x, y ], true,
																true);
														y = ganglia[6].bytes_in / 1024;
														series_in
																.addPoint([ x,
																		y ],
																		true,
																		true);
													}, 5000);
										}
									}
								},
								title : {
									text : '实时网络I/O'
								},
								credits : {
									enabled : false
								},
								xAxis : {
									type : 'datetime',
									tickPixelInterval : 150
								},
								yAxis : {
									title : {
										text : 'KB/s'
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
									formatter : function() {
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts.dateFormat(
														'%Y-%m-%d %H:%M:%S',
														this.x)
												+ '<br/>'
												+ '<span style="color:#08c">'
												+ Highcharts.numberFormat(
														this.y, 2) + ' KB'
												+ '</span>';

									}
								},
								legend : {
									enabled : true
								},
								exporting : {
									enabled : false
								},
								series : [
										{
											name : '61 out/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										},
										{
											name : '61 in/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										} ]
							};
							//70
							var ganglia_70 = {
								chart : {
									renderTo : 'ganglia-70',
									type : 'spline',
									marginRight : 10,
									events : {
										load : function() {
											// set up the updating of the chart each second
											var series_out = this.series[0];
											var series_in = this.series[1];
											setInterval(
													function() {
														var storage = window.localStorage;
														var x = (new Date())
																.getTime(), y;
														var ganglia = JSON
																.parse(storage
																		.getItem("ganglia"));
														y = ganglia[7].bytes_out / 1024;
														series_out.addPoint([
																x, y ], true,
																true);
														y = ganglia[7].bytes_in / 1024;
														series_in
																.addPoint([ x,
																		y ],
																		true,
																		true);
													}, 5000);
										}
									}
								},
								title : {
									text : '实时网络I/O'
								},
								credits : {
									enabled : false
								},
								xAxis : {
									type : 'datetime',
									tickPixelInterval : 150
								},
								yAxis : {
									title : {
										text : 'KB/s'
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
									formatter : function() {
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts.dateFormat(
														'%Y-%m-%d %H:%M:%S',
														this.x)
												+ '<br/>'
												+ '<span style="color:#08c">'
												+ Highcharts.numberFormat(
														this.y, 2) + ' KB'
												+ '</span>';

									}
								},
								legend : {
									enabled : true
								},
								exporting : {
									enabled : false
								},
								series : [
										{
											name : '70 out/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										},
										{
											name : '70 in/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										} ]
							};
							//62
							var ganglia_62 = {
								chart : {
									renderTo : 'ganglia-62',
									type : 'spline',
									marginRight : 10,
									events : {
										load : function() {
											// set up the updating of the chart each second
											var series_out = this.series[0];
											var series_in = this.series[1];
											setInterval(
													function() {
														var storage = window.localStorage;
														var x = (new Date())
																.getTime(), y;
														var ganglia = JSON
																.parse(storage
																		.getItem("ganglia"));
														y = ganglia[8].bytes_out / 1024;
														series_out.addPoint([
																x, y ], true,
																true);
														y = ganglia[8].bytes_in / 1024;
														series_in
																.addPoint([ x,
																		y ],
																		true,
																		true);
													}, 5000);
										}
									}
								},
								title : {
									text : '实时网络I/O'
								},
								credits : {
									enabled : false
								},
								xAxis : {
									type : 'datetime',
									tickPixelInterval : 150
								},
								yAxis : {
									title : {
										text : 'KB/s'
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
									formatter : function() {
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts.dateFormat(
														'%Y-%m-%d %H:%M:%S',
														this.x)
												+ '<br/>'
												+ '<span style="color:#08c">'
												+ Highcharts.numberFormat(
														this.y, 2) + ' KB'
												+ '</span>';

									}
								},
								legend : {
									enabled : true
								},
								exporting : {
									enabled : false
								},
								series : [
										{
											name : '62 out/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										},
										{
											name : '62 in/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										} ]
							};

							//71
							var ganglia_71 = {
								chart : {
									renderTo : 'ganglia-71',
									type : 'spline',
									marginRight : 10,
									events : {
										load : function() {
											// set up the updating of the chart each second
											var series_out = this.series[0];
											var series_in = this.series[1];
											setInterval(
													function() {
														var storage = window.localStorage;
														var x = (new Date())
																.getTime(), y;
														var ganglia = JSON
																.parse(storage
																		.getItem("ganglia"));
														y = ganglia[9].bytes_out / 1024;
														series_out.addPoint([
																x, y ], true,
																true);
														y = ganglia[9].bytes_in / 1024;
														series_in
																.addPoint([ x,
																		y ],
																		true,
																		true);
													}, 5000);
										}
									}
								},
								title : {
									text : '实时网络I/O'
								},
								credits : {
									enabled : false
								},
								xAxis : {
									type : 'datetime',
									tickPixelInterval : 150
								},
								yAxis : {
									title : {
										text : 'KB/s'
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
									formatter : function() {
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts.dateFormat(
														'%Y-%m-%d %H:%M:%S',
														this.x)
												+ '<br/>'
												+ '<span style="color:#08c">'
												+ Highcharts.numberFormat(
														this.y, 2) + ' KB'
												+ '</span>';

									}
								},
								legend : {
									enabled : true
								},
								exporting : {
									enabled : false
								},
								series : [
										{
											name : '71 out/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										},
										{
											name : '71 in/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										} ]
							};
							//72
							var ganglia_72 = {
								chart : {
									renderTo : 'ganglia-72',
									type : 'spline',
									marginRight : 10,
									events : {
										load : function() {
											// set up the updating of the chart each second
											var series_out = this.series[0];
											var series_in = this.series[1];
											setInterval(
													function() {
														var storage = window.localStorage;
														var x = (new Date())
																.getTime(), y;
														var ganglia = JSON
																.parse(storage
																		.getItem("ganglia"));
														y = ganglia[10].bytes_out / 1024;
														series_out.addPoint([
																x, y ], true,
																true);
														y = ganglia[10].bytes_in / 1024;
														series_in
																.addPoint([ x,
																		y ],
																		true,
																		true);
													}, 5000);
										}
									}
								},
								title : {
									text : '实时网络I/O'
								},
								credits : {
									enabled : false
								},
								xAxis : {
									type : 'datetime',
									tickPixelInterval : 150
								},
								yAxis : {
									title : {
										text : 'KB/s'
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
									formatter : function() {
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts.dateFormat(
														'%Y-%m-%d %H:%M:%S',
														this.x)
												+ '<br/>'
												+ '<span style="color:#08c">'
												+ Highcharts.numberFormat(
														this.y, 2) + ' KB'
												+ '</span>';

									}
								},
								legend : {
									enabled : true
								},
								exporting : {
									enabled : false
								},
								series : [
										{
											name : '72 out/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										},
										{
											name : '72 in/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										} ]
							};
							//73
							var ganglia_73 = {
								chart : {
									renderTo : 'ganglia-73',
									type : 'spline',
									marginRight : 10,
									events : {
										load : function() {
											// set up the updating of the chart each second
											var series_out = this.series[0];
											var series_in = this.series[1];
											setInterval(
													function() {
														var storage = window.localStorage;
														var x = (new Date())
																.getTime(), y;
														var ganglia = JSON
																.parse(storage
																		.getItem("ganglia"));
														y = ganglia[11].bytes_out / 1024;
														series_out.addPoint([
																x, y ], true,
																true);
														y = ganglia[11].bytes_in / 1024;
														series_in
																.addPoint([ x,
																		y ],
																		true,
																		true);
													}, 5000);
										}
									}
								},
								title : {
									text : '实时网络I/O'
								},
								credits : {
									enabled : false
								},
								xAxis : {
									type : 'datetime',
									tickPixelInterval : 150
								},
								yAxis : {
									title : {
										text : 'KB/s'
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
									formatter : function() {
										return '<b>'
												+ this.series.name
												+ '</b><br/>'
												+ Highcharts.dateFormat(
														'%Y-%m-%d %H:%M:%S',
														this.x)
												+ '<br/>'
												+ '<span style="color:#08c">'
												+ Highcharts.numberFormat(
														this.y, 2) + ' KB'
												+ '</span>';

									}
								},
								legend : {
									enabled : true
								},
								exporting : {
									enabled : false
								},
								series : [
										{
											name : '73 out/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										},
										{
											name : '73 in/s',
											data : (function() {
												// generate an array of random data
												var data = [], time = (new Date())
														.getTime(), i;

												for (i = -19; i <= 0; i++) {
													data.push({
														x : time + i * 5000,
														y : 0
													});
												}
												return data;
											})()
										} ]
							};
							chart = new Highcharts.Chart(ganglia_74);
							chart = new Highcharts.Chart(ganglia_75);
							chart = new Highcharts.Chart(ganglia_76);
							chart = new Highcharts.Chart(ganglia_85);
							chart = new Highcharts.Chart(ganglia_86);
							chart = new Highcharts.Chart(ganglia_60);
							chart = new Highcharts.Chart(ganglia_61);
							chart = new Highcharts.Chart(ganglia_70);
							chart = new Highcharts.Chart(ganglia_62);
							chart = new Highcharts.Chart(ganglia_71);
							chart = new Highcharts.Chart(ganglia_72);
							chart = new Highcharts.Chart(ganglia_73);
						});
	</script>

	<jsp:include page="footer.jsp" flush="true"></jsp:include>