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
<script src="../js/highcharts.js" type="text/javascript"></script>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/bootstrap.min.css" rel="stylesheet">

<title>聚类算法实例</title>

<jsp:include page="header.jsp" flush="true" />

</head>
<body>

	<div class="container">

		<h1 class="text-muted">大数据建模实例</h1>
		<hr>

		<div class="row marketing">
			<div class="col-lg-6 col-md-6 col-xs-12">

				<div id="container1" style="min-width: 400px; height: 400px"></div>
				<hr>
				<div id="container2" style="min-width: 400px; height: 400px"></div>
				<hr>
				<p>表1:分析文档生成话题中的前5个热词</p>
				<table class="table table-striped">
					<thead id="table-head" style="font-weight: bold;">
					</thead>
					<tbody id="table-body">
					</tbody>
				</table>
			</div>



			<div class="col-lg-6 col-md-6 col-xs-12">
				<h3>1、实验说明</h3>
				<p>本次实验主要是基于RainBowH大数据平台，对大规模的数据集进行建模分析，寻找文章背后的话题模型。</p>
				<h3>2、RainBowH平台信息</h3>
				<p>
					本次建模所用RainBowH平台由一台namenode节点和四台datanode节点组成<br> Configured
					Capacity: 7.57 TB<br> DFS Used: 433.78 GB<br> Non DFS
					Used: 440.13 GB<br> DFS Remaining: 6.72 TB<br> DFS Used%:
					5.6%<br> DFS Remaining%: 88.73%<br> Block Pool Used:
					433.78 GB<br> Block Pool Used%: 5.6%<br> DataNodes
					usages% (Min/Median/Max/stdDev): 0.02% / 4.15% / 30.75% / 12.25%

				</p>

				<h3>3、数据集说明</h3>
				<p>本次实验采用的是维基百科提供的官网文档数据集，最大的数据集的压缩文件为12.3G，解压后达到54G，其中包含47,687,611篇英文文档，本次实验的饼图显示的建模结果便是来源于对该数据集的计算。
				</p>

				<h3>4、kmeans聚类算法介绍</h3>
				<p>本次实验模型主要采用KMeans算法来对文档进行建模,这里暂且省去了数据分析与特征提取等一系列数据预处理的工作原理，只给出kmeans算法的数学思想。</p>
				<h3>5、结论</h3>
				<p>
					由图1可以看出，随着数据集量级的增大，模型运行时间并没有量级的变化，也没有线性增长，这充分显示了RainBowH平台对大数据建模的可扩展性；<br>
					图2是对47,687,611篇英文文档聚类的结果，使用我们的模型，这些文档被聚类成了10类，图中给出了每个类的前5个关键词。总耗时为:
					32.3分钟，如果在单机环境上处理这么多的数据,总耗时将超过一整天；<br>
					表1是经过对这些文档建模后生成的话题类，这里只呈现出每个话题中出现频率最高的前5个单词。
				</p>
			</div>
		</div>
	</div>
	<!-- /container -->
	<script>
		$(document)
				.ready(
						function() {
							$
									.ajax({
										type : "GET",
										url : "../servlet/ClusterServlet",
										dataType : "json",
										success : function(data) {
											console.log(data);
											Highcharts.setOptions({
												global : {
													useUTC : false
												},
												colors : [ '#FF99CC',
														'#FFCC99', '#00BFFF',
														'#66B2EE', '#FFFF99',
														'#FF9655', '#CCFF99',
														'#FDBB3D', '#DDF263',
														'#A9CC33', '#CCCCFF',
														'#00FF00', '#6AF9C4',
														'#66FA9A', '#FDE93D',
														'#bbF5FF', '#33EEEE' ]
											});
											var x = [];
											var y = [];
											for (i in data.chart) {
												x[i] = data.chart[i].name;
												y[i] = parseFloat(data.chart[i].value);
											}
											chart = new Highcharts.Chart(
													{
														chart : {
															renderTo : 'container1',
															type : 'line'
														},
														title : {
															text : '图1:作业运行时间与数据量关系图'
														},
														xAxis : {
															categories : x
														},
														yAxis : {
															title : {
																text : '运行时间（s）'
															}
														},
														credits : {
															enabled : false
														},
														tooltip : {
															enabled : true,
															formatter : function() {
																return '<b>'
																		+ this.series.name
																		+ '为</b><br>'
																		+ this.x
																		+ '时，运行时间'
																		+ this.y
																		+ 's';
															}
														},
														plotOptions : {
															line : {
																dataLabels : {
																	enabled : true
																}
															}
														},
														series : [ {
															name : '数据量',
															data : y
														} ]
													});
											$('#container2')
													.highcharts(
															{
																chart : {
																	type : 'pie',
																	plotBackgroundColor : null,
																	plotBorderWidth : null,
																	plotShadow : false
																},
																title : {
																	text : '图2:47,687,611篇文档聚类结果'
																},
																tooltip : {
																	pointFormat : '{series.name}: <b>{point.x}个  {point.percentage:.1f}%</b>'
																},
																credits : {
																	enabled : false
																},
																plotOptions : {
																	pie : {
																		allowPointSelect : true,
																		colorByPoint : true,
																		cursor : 'pointer',
																		// 																	dataLabels : {//指向型 
																		// 																		enabled : true,
																		// 																		color : '#000000',
																		// 																		connectorColor : '#000000',
																		// 																		format : '<b>{point.name}</b>:{point.x}个   {point.percentage:.1f} %'
																		// 																	},
																		dataLabels : {//在饼图下方，图例 
																			enabled : false
																		},
																		showInLegend : true
																	}
																},
																series : [ {
																	type : 'pie',
																	name : '聚类结果'
																} ]
															});
											var piedata = new Array();
											for (ser in data.pie) {
												piedata
														.push({
															name : data.pie[ser].name,
															y : parseInt(data.pie[ser].value),
															x : data.pie[ser].value
														});
											}
											var chart = $('#container2')
													.highcharts();
											chart.series[0].setData(piedata);
											var head = "<tr>";
											var body = new Array();
											var bodyhtml = "";
											for (col in data.table) {
												head += "<th>"
														+ data.table[col].name
														+ "</th>";
												body[col] = new Array();
												for (i in data.table[col].value)
													body[col][i] = data.table[col].value[i];
											}
											for (i = 0; i < 5; i++) {
												bodyhtml += "<tr>";
												for (j = 0; j < body.length; j++) {
													bodyhtml += "<td>"
															+ body[j][i]
															+ "</td>"
												}
												bodyhtml += "</tr>";
											}
											$("#table-head").html(head);
											$("#table-body").html(bodyhtml);
										}
									});
						});
	</script>

	<jsp:include page="footer.jsp" flush="true"></jsp:include>