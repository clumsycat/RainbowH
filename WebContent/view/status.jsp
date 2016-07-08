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

<title>实时监控</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<div class="container">
		<h2>Daemon</h2>
		<table id="daemon_table" class="table table-striped">
			<thead id="daemon_head">
				<tr>
					<th>主机IP</th>
					<th>接受/s</th>
					<th>返回/s</th>
					<th>Impala</th>
					<th>memcache</th>
					<th>本地LRU</th>
					<th>平均响应时间</th>
					<th>更新日期</th>
				</tr>
			</thead>
			<tbody id="daemon_field" class="radio-list">
			</tbody>
		</table>
		<hr>
		<h2>Impala</h2>
		<table id="impala_table" class="table table-striped">
			<thead id="impala_head">
				<tr>
					<th>主机IP</th>
					<th>接受/s</th>
					<th>返回/s</th>
				</tr>
			</thead>
			<tbody id="impala_field" class="radio-list">
			</tbody>
		</table>
		<hr>

		<h2>Memcache</h2>
		<table id="memcache_table" class="table table-striped">
			<thead id="memcache_head">
				<tr>
					<th>机器名称</th>
					<th>总大小</th>
					<th>%HIT</th>
					<th>请求/s</th>
					<th>GET/s</th>
					<th>SET/s</th>
					<th>DEL/s</th>
					<th>EVI/s</th>
					<th>读Byte/s</th>
					<th>写Byte/s</th>

				</tr>
			</thead>
			<tbody id="memcache_field">
			</tbody>
		</table>
		<h2>物理节点信息</h2>
		<table id="ganglia_table" class="table table-striped">
			<thead id="ganglia_head">
				<tr>
					<th>机器名称</th>
					<th>总内存</th>
					<th>内存用量</th>
					<th>CPU核数</th>
					<th>用户CPU</th>
					<th>系统CPU</th>
					<th>磁盘总量</th>
					<th>磁盘用量</th>
					<th>网络in</th>
					<th>网络out</th>
				</tr>
			</thead>
			<tbody id="ganglia_field">
			</tbody>
		</table>
	</div>
	<script>
		$(document).ready(function() {
			GetStatus();
			setInterval(GetStatus, 5000);
		});
		function GetStatus() {
			$
					.ajax({
						type : "GET",
						url : "AllState",
						dataType : "json",
						success : function(data) {
							var storage = window.localStorage;
							var last = JSON.parse(storage
									.getItem("memcache-now"));
							var memcache = data.Memcache;
							storage.setItem("memcache-now", JSON
									.stringify(memcache));
							//daemon+impala 部分
							var webserver, webserverList = "";
							var impalaArray = new Array();
							var k = 0;
							var impi;
							var imIP = [ "10.10.108.70", "10.10.108.71",
									"10.10.108.73" ];
							for (i = 0; i < 3; i++) {
								impalaArray[i] = new Array();
								impalaArray[i][0] = imIP[i];
								impalaArray[i][1] = 0;
								impalaArray[i][2] = 0;
								impalaArray[i][3] = -1;
							}
							for (webserver in data.Daemon) {
								// true if "dead" doesn't exist in object
								if (!("dead" in data.Daemon[webserver])) {
									webserverList += "<tr class = \"file-row\" style=\"background:"+"#E1FFDE" + "\"><td>"
											+ data.Daemon[webserver].IP
											+ "</td><td>"
											+ data.Daemon[webserver].Receive
											+ "</td><td>"
											+ data.Daemon[webserver].Return
											+ "</td><td>"
											+ data.Daemon[webserver].Impala
											+ "</td><td>"
											+ data.Daemon[webserver].Memcache
											+ "</td><td>"
											+ data.Daemon[webserver]["Local LRU"]
											+ "</td><td>"
											+ data.Daemon[webserver].AvgResponse
											+ "</td><td>"
											+ data.Daemon[webserver].UpdateTime
											+ "</td></tr>";

									for (impi in data.Daemon[webserver].ImpalaStat) {
										if (data.Daemon[webserver].ImpalaStat[impi].IP == "10.10.108.70") {
											impalaArray[0][1] += parseFloat(data.Daemon[webserver].ImpalaStat[impi].ImpalaRec);
											impalaArray[0][2] += parseFloat(data.Daemon[webserver].ImpalaStat[impi].ImpalaRet);
											impalaArray[0][3]++;
										} else if (data.Daemon[webserver].ImpalaStat[impi].IP == "10.10.108.71") {
											impalaArray[1][1] += parseFloat(data.Daemon[webserver].ImpalaStat[impi].ImpalaRec);
											impalaArray[1][2] += parseFloat(data.Daemon[webserver].ImpalaStat[impi].ImpalaRet);
											impalaArray[1][3]++;
										} else if (data.Daemon[webserver].ImpalaStat[impi].IP == "10.10.108.73") {
											impalaArray[2][1] += parseFloat(data.Daemon[webserver].ImpalaStat[impi].ImpalaRec);
											impalaArray[2][2] += parseFloat(data.Daemon[webserver].ImpalaStat[impi].ImpalaRet);
											impalaArray[2][3]++;
										}
									}//impala else
								}//daemon else
								else {
									console.log("dead!");
									webserverList += "<tr class = \"file-row\" style=\"background:"+"#FFE0E2" + "\"><td>"
											+ data.Daemon[webserver].IP
											+ "</td><td colspan=\"7\">WebServer is Dead   上次活动时间 "
											+ data.Daemon[webserver].time
											+ "</td></tr>";
								}
							}
							//impala部分
							var ImpalaList = "";
							for (i = 0; i < 3; i++) {
								if (impalaArray[i][3] > -1) {
									{
										ImpalaList += "<tr class = \"file-row\" style=\"background:"+"#E1FFDE" + "\"><td>"
												+ impalaArray[i][0]
												+ "</td><td>"
												+ (impalaArray[i][1])
														.toFixed(2)
												+ "</td><td>"
												+ (impalaArray[i][2])
														.toFixed(2)
												+ "</td></tr>";
									}
									ImpalaList += "</tr>";
								} else {
									ImpalaList = "<tr class = \"file-row\" style=\"background:"+"#FFE0E2" + "\"><td colspan=\"3\">Impala"
											+ impalaArray[i][0]
											+ " 未被使用</td></tr>";
								}
							}
							//memcache部分 
							var server, serverList = "", difftime;
							var gets = 0;
							var hit = 0;
							var bgcolor;
							for (server in memcache) {
								if (last == null) {
									difftime = 5;
									last = memcache;
								} else
									difftime = memcache[server].uptime
											- last[server].uptime;
								if (difftime == 0)
									difftime = 5;
								hit = memcache[server].get_hits
										/ (memcache[server].get_hits + memcache[server].get_misses);
								if (memcache[server].get_hits == null) {
									bgcolor = "#FFE0E2"
								} else if (hit == "NaN" || hit == 0) {
									bgcolor = "#FFFEDE"
								} else {
									bgcolor = "#E1FFDE";
								}
								gets = parseInt(parseInt(memcache[server].cmd_get)
										+ parseInt(memcache[server].cmd_set)
										+ parseInt(memcache[server].cmd_flush)
										+ parseInt(memcache[server].cmd_touch)
										+ parseInt(memcache[server].delete_misses)
										+ parseInt(memcache[server].delete_hits)
										+ parseInt(memcache[server].incr_misses)
										+ parseInt(memcache[server].incr_hits)
										+ parseInt(memcache[server].decr_misses)
										+ parseInt(memcache[server].decr_hits)
										+ parseInt(memcache[server].cas_misses)
										+ parseInt(memcache[server].cas_hits)
										- last[server].cmd_get
										- last[server].cmd_set
										- last[server].cmd_flush
										- last[server].cmd_touch
										- last[server].delete_misses
										- last[server].delete_hits
										- last[server].incr_misses
										- last[server].incr_hits
										- last[server].decr_misses
										- last[server].decr_hits
										- last[server].cas_misses
										- last[server].cas_hits)
										/ difftime;
								serverList += "<tr class = \"file-row\" style=\"background:"+bgcolor + "\"><td>"
										+ memcache[server].serverName
										+ "</td><td>"
										+ getKMG(memcache[server].limit_maxbytes)
										+ "</td><td>"
										+ hit.toFixed(2)
										+ "</td><td>"
										+ gets.toFixed(2)
										+ "</td><td>"
										+ (parseFloat(memcache[server].cmd_get
												- last[server].cmd_get) / difftime)
												.toFixed(2)
										+ "</td><td>"
										+ (parseFloat(memcache[server].cmd_set
												- last[server].cmd_set) / difftime)
												.toFixed(2)
										+ "</td><td>"
										+ (parseFloat(memcache[server].delete_misses
												+ memcache[server].delete_hits) / memcache[server].uptime)
												.toFixed(2)
										+ "</td><td>"
										+ (memcache[server].evictions / memcache[server].uptime)
												.toFixed(2)
										+ "</td><td>"
										+ (parseFloat(memcache[server].bytes_read
												- last[server].bytes_read) / (difftime * 1024))
												.toFixed(2)
										+ "</td><td>"
										+ (parseFloat(memcache[server].bytes_written
												- last[server].bytes_written) / (difftime * 1024))
												.toFixed(2) + "</td></tr>";
							}
							//Ganglia部分 
							var host;
							var gangList = "";
							var memused = 0;
							var diskused = 0;
							for (host in data.Ganglia) {
								memused = (1 - (data.Ganglia[host].mem_free / data.Ganglia[host].mem_total)) * 100;
								diskused = (1 - (data.Ganglia[host].disk_free / data.Ganglia[host].disk_total)) * 100;
								gangList += "<tr class = \"file-row\" style=\"background:"+"#E1FFDE" + "\"><td>"
										+ data.Ganglia[host].hostName
										+ "</td><td>"
										+ (data.Ganglia[host].mem_total / 1024 / 1024)
												.toFixed(1)
										+ " GB</td><td>"
										+ memused.toFixed(2)
										+ "%</td><td>"
										+ data.Ganglia[host].cpu_num
										+ "</td><td>"
										+ data.Ganglia[host].cpu_user
										+ "</td><td>"
										+ data.Ganglia[host].cpu_system
										+ "</td><td>"
										+ (data.Ganglia[host].disk_total / 1)
												.toFixed(0)
										+ " GB</td><td>"
										+ diskused.toFixed(2)
										+ "%</td><td>"
										+ (data.Ganglia[host].bytes_in / 1024)
												.toFixed(2)
										+ " KB</td><td>"
										+ (data.Ganglia[host].bytes_out / 1024)
												.toFixed(2) + " KB</td></tr>";
							}

							$("#daemon_field").html(webserverList);
							$("#impala_field").html(ImpalaList);
							$("#memcache_field").html(serverList);
							$("#ganglia_field").html(gangList)
							function getKMG(bvalue) {
								if (bvalue < 1024)
									return bvalue.toFixed(2) + "B";
								bvalue /= 1024;
								if (bvalue < 1024)
									return bvalue.toFixed(2) + "KB";
								bvalue /= 1024;
								if (bvalue < 1024)
									return bvalue.toFixed(2) + "MB";
								bvalue /= 1024;
								if (bvalue < 1024)
									return bvalue.toFixed(2) + "GB";
								bvalue /= 1024;
								if (bvalue < 1024)
									return bvalue.toFixed(2) + "TB";
								bvalue /= 1024;
								if (bvalue < 1024)
									return bvalue.toFixed(2) + "PB";
							}
						}
					});
		}
	</script>

	<jsp:include page="footer.jsp" flush="true"></jsp:include>