function doload() {
	var baseurl = 'http://10.10.108.86:6666';
	var start = $("#start-num")[0].value, end = $("#end-num")[0].value;
	var opt="",srcdb="",srctable="",desdb="",destable="",
			ordb=	$("#Oracle-DB-name option:selected").text();
			ortable=$("#Oracle-Table-name option:selected").text(),
			impdb=$("#Impala-DB-name option:selected").text(),
			imptable=$("#Impala-Table-name option:selected").text();
	$("#log").html("<h3><small>" + "装载中……请耐心等候" + "</small><h3>");
	$("#Oracle-role option:selected").each(function() {
		str = $(this).text();
		$("#tip").empty();
		switch (str) {
		case "导入":
			opt="ImpalaToOracle";
			srcdb=impdb;
			srctable=imptable;
			desdb=ordb;
			destable=ortable;
			break;
		case "导出":
			opt="OracleToImpala";
			srcdb=ordb;
			srctable=ortable;
			desdb=impdb;
			destable=imptable;
			break;
		}
	});
	if (start == "")
		start = "0";
	if (end == "")
		end = "10000";
	var newurl = baseurl + '/DATALOAD?opt=' + opt + "&srcDB="
			+ srcdb + "&srcTable=" + srctable + "&start=" + start + "&end="
			+ end + "&dstDB=" + desdb + "&dstTable=" + destable;
	console.log(newurl);
	$.ajax({
		url : newurl,
		dataType : 'jsonp',
		crossDomain : true,
		success : function(data) {

			if (data.state == "success")
				$("#log").html("<h3><small>" + "装载成功" + "</small><h3>");
			else if (data.state == "failure")
				$("#log").html("<h3><small>" + "装载失败" + "</small><h3>");
		}

	}).fail(function() {
		$("#log").html("<h3><small>" + "装载失败:服务器没响应" + "</small><h3>");
	});
	// /DATALOAD?opt=OracleToImpala&srcDB=DBname&srcTable=Tablename&start=0&end=10000&
	// dstDB=DBname&dstTable=Tablename

}

// TODO: Oracle & HDFS
function doloadH() {
	var baseurl = 'http://10.10.108.86:6666';
	var start = $("#start-num")[0].value, end = $("#end-num")[0].value;
	var opt="",srcdb="",srctable="",dst_file="",
			ordb=	$("#Oracle-DB-nameH option:selected").text();
			ortable=$("#Oracle-Table-nameH option:selected").text(),
			hdfsfile=$("# option:selected").text(),
	$("#logH").html("<h3><small>" + "装载中……请耐心等候" + "</small><h3>");
	$("#Oracle-role option:selected").each(function() {
		str = $(this).text();
		$("#tipH").empty();
		switch (str) {
		case "导入":
			opt="HDFSToOracle";
			srcdb=impdb;
			srctable=imptable;
			desdb=ordb;
			destable=ortable;
			break;
		case "导出":
			opt="OracleToHDFS";
			srcdb=ordb;
			srctable=ortable;
			desdb=impdb;
			destable=imptable;
			break;
		}
	});
	if (start == "")
		start = "0";
	if (end == "")
		end = "10000";
	var newurl = baseurl + '/DATALOAD?opt=' + opt + "&srcDB="
			+ srcdb + "&srcTable=" + srctable + "&start=" + start + "&end="
			+ end + "&dstDB=" + desdb + "&dstTable=" + destable;
	console.log(newurl);
	$.ajax({
		url : newurl,
		dataType : 'jsonp',
		crossDomain : true,
		success : function(data) {

			if (data.state == "success")
				$("#log").html("<h3><small>" + "装载成功" + "</small><h3>");
			else if (data.state == "failure")
				$("#log").html("<h3><small>" + "装载失败" + "</small><h3>");
		}

	}).fail(function() {
		$("#log").html("<h3><small>" + "装载失败:服务器没响应" + "</small><h3>");
	});
	// /DATALOAD?opt=OracleToImpala&srcDB=DBname&srcTable=Tablename&start=0&end=10000&
	// dstDB=DBname&dstTable=Tablename

}