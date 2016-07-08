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
<style type="text/css">
li>a {
	line-height:2;
}
</style>
<script src="../js/daemon-properties.js"></script>
<title>RainBowH 用户界面</title>
</head>
<body data-spy="scroll" data-target="#myScrollspy">
	<jsp:include page="header.jsp" flush="true" />

	<!-- Daemon：
6,7,8
6为true时 7,8

10，超时值 

17,18,19, SQL语句合并配置 
时间窗口，合并最大数

29 use memcache,默认不改 

40 选择目标数据库（hive impala spark orcale） 选择数据库

63-65 impala连接池最大，最小数 

92 HDFS目标地址，显示不改


Memcached：列出来机器，填入启动内存大小（-m），连接数（-t CPU核数相关 不改） done,没显示连接数
 -->
 <div class="col-xs-2 " id="myScrollspy">
		<!-- 右侧导航目录 -->

		<ul class="nav bs-docs-sidenav nav-pills nav-stacked  bs-docs-sidenav" data-spy="affix">
			<li class="active"><a href="#Daemon">Daemon</a>
				<ul>
					<li><a href="#daemon-pages">分页配置</a></li>
					<li><a href="#daemon-timeout">请求超时设置</a></li>
					<li><a href="#daemon-sql-combine">SQL语句合并设置</a></li>
					<li><a href="#daemon-memcache">启用Memcache</a></li>
					<li><a href="#daemon-db-type">选择查询数据库</a></li>
					<li><a href="#impala-pool">Impala连接池设定</a></li>
					<li><a href="#hdfs-path">HDFS目标地址</a></li>
				</ul></li>
			<li><a href="#Memcache">Memcache</a>
				<ul>
					<li><a href="#mem-60">60</a></li>
					<li><a href="#mem-61">61</a></li>
					<li><a href="#mem-62">62</a></li>
					<li><a href="#mem-74">74</a></li>
					<li><a href="#mem-85">85</a></li>
					<li><a href="#mem-86">86</a></li>
				</ul></li>
		</ul>
	</div>
 <div style="padding-left: 15px">
	<form class="form-horizontal ">
		<div class="col-xs-9" id="lists">
			<h2 id="Daemon">Daemon启动项配置</h2>
			<div class="alert alert-warning">
				<p>通过改变相关参数，设置Daemon的运行环境以及功能。</p>
				<p>
				注意：在某些场景下，个别参数的修改会造成系统运行不稳定。<br>
				例如： 重启Memcache会清空现有的所有缓存，对系统性能产生影响。
				</p>
				<p>
				请慎重修改，推荐默认配置。
				</p>
			</div>
			<!-- 分页 -->
			<h3 id="daemon-pages">分页设置</h3>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-6">
					<div class="checkbox ">
						<label> <input id="enable-pages" type="checkbox" checked>
							启用分页
						</label>
					</div>
				</div>
			</div>
			<div class="form-group ">
				<label for="page-item-limit" class="col-sm-2 control-label">每页项目数</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="page-item-limit"
						placeholder="30">
				</div>
			</div>
			<div class="form-group">
				<label for="page-limit" class="col-sm-2 control-label">分页数</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="page-limit"
						placeholder="3">
				</div>
			</div>
			<hr>

			<!-- 请求超时 -->
			<h3 id="daemon-timeout">请求超时设置</h3>
			<div class="form-group">
				<label for="thread-timeout" class="col-sm-2 control-label">超时时间定义</label>
				<div class="col-sm-6">
					<input type="text" class="form-control " id="thread-timeout"
						placeholder="60">
				</div>
			</div>
			<hr>

			<!-- 语句合并配置 -->
			<h3 id="daemon-sql-combine">SQL语句合并设置</h3>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-6">
					<div class="checkbox ">
						<label> <input id="enable-combine" type="checkbox" checked>
							启用语句合并
						</label>
					</div>
				</div>
			</div>
			<div class="form-group ">
				<label for="sql-combine-period" class="col-sm-2 control-label">合并时间窗口（秒）</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="sql-combine-period"
						placeholder="5">
				</div>
			</div>
			<div class="form-group ">
				<label for="sql-combine-maxitems" class="col-sm-2 control-label">合并最大语句数</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="sql-combine-maxitems"
						placeholder="20">
				</div>
			</div>
			<hr>

			<!-- Memcached启用 -->
			<h3 id="daemon-memcache">
				启用Memcache<small>不建议更改</small>
			</h3>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-6">
					<div class="checkbox ">
						<label> <input id="enable-memcache" type="checkbox"
							checked> 启用memcache
						</label>
					</div>
				</div>
			</div>
			<hr>

			<!-- 选择数据库 -->
			<h3 id="daemon-db-type">选择查询数据库</h3>
			<div class="radio col-sm-offset-2">
				<label> <input type="radio" name="dbtyperadio"
					id="db_type_impala" value="impala" checked> Impala
				</label>
			</div>
			<div class="radio col-sm-offset-2">
				<label> <input type="radio" name="dbtyperadio"
					id="db_type_spark" value="spark"> Spark
				</label>
			</div>
			<div class="radio col-sm-offset-2">
				<label> <input type="radio" name="dbtyperadio"
					id="db_type_hive" value="hive"> Hive
				</label>
			</div>
			<div class="radio col-sm-offset-2">
				<label> <input type="radio" name="dbtyperadio"
					id="db_type_oracle" value="oracle"> Oracle
				</label>
			</div>
			<hr>

			<!-- impala连接池设定 -->
			<h3 id="impala-pool">Impala连接池设定</h3>
			<div class="form-group ">
				<label for="impala-initial-pool-size" class="col-sm-2 control-label">连接池初始大小</label>
				<div class="col-sm-6">
					<input type="text" class="form-control"
						id="impala-initial-pool-size" placeholder="10">
				</div>
			</div>
			<div class="form-group ">
				<label for="impala-max-pool-size" class="col-sm-2 control-label">连接池最大连接数</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="impala-max-pool-size"
						placeholder="20">
				</div>
			</div>
			<div class="form-group ">
				<label for="impala-min-pool-size" class="col-sm-2 control-label">连接池最小保留数量</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="impala-min-pool-size"
						placeholder="10">
				</div>
			</div>
			<hr>

			<!-- HDFS默认连接 -->
			<h3 id="hdfs-path">
				HDFS目标地址<small>不可更改</small>
			</h3>
			<div class="form-group ">
				<label for="base-hdfs-path" class="col-sm-2 control-label">HDFS默认路径</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="base-hdfs-path"
						disabled="true" placeholder="hdfs:/hadoop-72:9000">
				</div>
			</div>
			<hr>

			<!-- Memcache启动配置 -->
			<h2 id="Memcache">Memcache启动配置项</h2>
			<h3 id="mem-60">60</h3>
			<div class="form-group ">
				<label for="memcache-60-m" class="col-sm-2 control-label">内存大小（MB）</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="memcache-60-m"
						placeholder="30720">
				</div>
			</div>
			<div class="form-group">
				<label for="memcache-60-t" class="col-sm-2 control-label">所用线程数</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="memcache-60-t"
						placeholder="12" disabled>
				</div>
			</div>
			<hr>
			<h3 id="mem-61">61</h3>
			<div class="form-group ">
				<label for="memcache-61-m" class="col-sm-2 control-label">内存大小（MB）</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="memcache-61-m"
						placeholder="30720">
				</div>
			</div>
			<div class="form-group">
				<label for="memcache-61-t" class="col-sm-2 control-label">所用线程数</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="memcache-61-t"
						placeholder="12" disabled>
				</div>
			</div>
			<hr>
			<h3 id="mem-62">62</h3>
			<div class="form-group ">
				<label for="memcache-62-m" class="col-sm-2 control-label">内存大小（MB）</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="memcache-62-m"
						placeholder="30720">
				</div>
			</div>
			<div class="form-group">
				<label for="memcache-62-t" class="col-sm-2 control-label">所用线程数</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="memcache-62-t"
						placeholder="12" disabled>
				</div>
			</div>
			<hr>
			<h3 id="mem-74">74</h3>
			<div class="form-group ">
				<label for="memcache-74-m" class="col-sm-2 control-label">内存大小（MB）</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="memcache-74-m"
						placeholder="30720">
				</div>
			</div>
			<div class="form-group">
				<label for="memcache-74-t" class="col-sm-2 control-label">所用线程数</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="memcache-74-t"
						placeholder="24" disabled>
				</div>
			</div>
			<hr>
			<h3 id="mem-85">85</h3>
			<div class="form-group ">
				<label for="memcache-85-m" class="col-sm-2 control-label">内存大小（MB）</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="memcache-85-m"
						placeholder="30720">
				</div>
			</div>
			<div class="form-group">
				<label for="memcache-85-t" class="col-sm-2 control-label">所用线程数</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="memcache-85-t"
						placeholder="24" disabled>
				</div>
			</div>
			<hr>
			<h3 id="mem-86">86</h3>
			<div class="form-group ">
				<label for="memcache-86-m" class="col-sm-2 control-label">内存大小（MB）</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="memcache-86-m"
						placeholder="30720">
				</div>
			</div>
			<div class="form-group">
				<label for="memcache-86-t" class="col-sm-2 control-label">所用线程数</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="memcache-86-t"
						placeholder="24" disabled>
				</div>
			</div>
			<hr>
			<div class="col-sm-8 col-sm-offset-2">
			<button id="default_button " class="btn btn-primary" type="button"
				style="width: 100px" onclick="dodefault();">默认配置</button>
			<button id="update_button" class="btn btn-info " type="button"
				style="width: 100px" onclick="doupdate();">更改配置</button>
			<button id="update_button" class="btn  btn-danger " type="button"
				style="width: 100px" onclick="doupdate();">重启</button>
		</div>
		<div id="log" style="height:200px" class="col-sm-8">logs</div>
		</div>
		
	</form>
	</div>
	

	<script>
		$(document).ready(function() {
			dodefault();
			$.ajax({
				type : "GET",
				url : "DaemonProServlet",
				data : {
					action : "GetProperties",
					jsons : "{\"Key\":\"GetProperties\",\"typeName\": \"webPage\"}"
				},
				success : function(data, textStatus) {
					
				}
			});
		});
		
	</script>
<jsp:include page="footer.jsp" flush="true"></jsp:include>