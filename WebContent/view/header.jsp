<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" style="padding: 2px;"
					href="${base}/Rainbow/"> <img alt="RainbowH"
					style="height: 45px;" src="${base}/Rainbow//img/RainbowH-small.png"></a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="${base}/Rainbow/view/summary.jsp">资源管理</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-expanded="false">组件监控
							<span class="caret"></span>
					</a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="${base}/Rainbow/view/impala.jsp">Impala</a></li>
							<li class="divider"></li>
							<li><a href="${base}/Rainbow/view/hadoop.jsp">Hadoop</a></li>
							<li><a href="${base}/Rainbow/view/hdfs.jsp">HDFS</a></li>
						</ul></li>

					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-expanded="false">业务应用
							<span class="caret"></span>
					</a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="${base}/Rainbow/view/search.jsp">查询（全文检索）</a></li>
							<li><a href="${base}/Rainbow/view/upload.jsp">上传</a></li>
							<li class="divider"></li>
							<%-- 						<li><a href="${base}/Rainbow/view/SQLedit.jsp">SQL编辑执行</a></li> --%>
							<li><a href="${base}/Rainbow/view/dataload.jsp">数据装载</a></li>
							<%-- 							<li><a href="${base}/Rainbow/view/upload.jsp">MR作业提交</a></li> --%>
						</ul></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-expanded="false">实时负载
							<span class="caret"></span>
					</a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="${base}/Rainbow/view/status.jsp">实时负载(表格)</a></li>
							<li><a href="${base}/Rainbow/view/chart-ganglia.jsp">实时负载(图形)</a></li>
						</ul></li>
					<%--<li><a href="${base}/Rainbow/view/status.jsp">实时监控</a></li> --%>
					<%-- 					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-expanded="false">配置
							<span class="caret"></span>
					</a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="${base}/Rainbow/view/daemon-properties.jsp">系统配置</a></li>
						</ul></li> --%>
					<li><a href="${base}/Rainbow/view/daemon-properties.jsp">系统配置</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>