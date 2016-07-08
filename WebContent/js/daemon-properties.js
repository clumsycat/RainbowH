function doupdate()
{
	var jsonresult="{\"Key\":\"UpdateProperties\",\"typeName\": \"webPage\",\"Daemon\": {";
	var pageflag=false;
	var combineflag=false;
	var memcacheflag=false;
	//添加Daemon下的数据，JSON格式，\"转义
	pageflag=$("#enable-pages").is(':checked');
	jsonresult += "\"CACHE_NEXT_PAGES\":\"" + pageflag +"\",";
	jsonresult += "\"ITEM_LIMIT\":" + $("#page-item-limit").val() +",";
	jsonresult += "\"PAGE_LIMIT\":" + $("#page-limit").val() +",";
	jsonresult += "\"THREAD_TIMEOUT\":" + $("#thread-timeout").val() +",";
	combineflag=$("#enable-combine").is(':checked');
	jsonresult += "\"USE_SQL_COMBINE\":\"" +combineflag +"\",";
	jsonresult += "\"SQL_COMBINE_PERIOD\":" + $("#sql-combine-period").val()+ ",";
	jsonresult += "\"SQL_COMBINE_MAXITEMS\":" + $("#sql-combine-maxitems").val() +",";
	memcacheflag=$("#enable-memcache").is(':checked');
	jsonresult += "\"USE_MEMCACHE\":\"" + memcacheflag +"\",";
	jsonresult += "\"SELECT_TARGET_DATABASE\":\"" + $(' input[name="dbtyperadio"]:checked ').val()+ "\",";
	jsonresult += "\"IMPALA_INITIAL_POOL_SIZE\":" + $("#impala-initial-pool-size").val() +",";
	jsonresult += "\"IMPALA_MAX_POOL_SIZE\":" + $("#impala-max-pool-size").val() +",";
	jsonresult += "\"IMPALA_MIN_POOL_SIZE\":" + $("#impala-min-pool-size").val() +",";
	jsonresult += "\"BASE_HDFS_PATH\":\"" + $("#base-hdfs-path").val() +"\","
	jsonresult += "\"UpdateFlag\":1},";
	console.log(jsonresult);
	//添加Memcache下的数据，JSON格式
	jsonresult += "\"Memcache\":{";
	jsonresult += "\"60-m\":" + $("#memcache-60-m").val() +",";
	jsonresult += "\"60-t\":" + $("#memcache-60-t").val() +",";
	jsonresult += "\"61-m\":" + $("#memcache-61-m").val() +",";
	jsonresult += "\"61-t\":" + $("#memcache-61-t").val() +",";
	jsonresult += "\"62-m\":" + $("#memcache-62-m").val() +",";
	jsonresult += "\"62-t\":" + $("#memcache-62-t").val() +",";
	jsonresult += "\"74-m\":" + $("#memcache-74-m").val() +",";
	jsonresult += "\"74-t\":" + $("#memcache-74-t").val() +",";
	jsonresult += "\"85-m\":" + $("#memcache-85-m").val() +",";
	jsonresult += "\"85-t\":" + $("#memcache-85-t").val() +",";
	jsonresult += "\"86-m\":" + $("#memcache-86-m").val() +",";
	jsonresult += "\"86-t\":" + $("#memcache-86-t").val() +",";
	jsonresult += "\"UpdateFlag\":0}}";
	console.log(jsonresult);
	$.ajax({
		type : "GET",
		url : "DaemonProServlet",
		data : {
			action : "UpdateProperties",
			jsons: jsonresult
		},
		success : function(data, textStatus) {
			
		}
	});
}
function dodefault()
{
	document.getElementById("enable-pages").checked=true;
	document.getElementById("page-item-limit").value = 30;
	document.getElementById("page-limit").value =3;
	document.getElementById("thread-timeout").value =60;
	document.getElementById("enable-combine").checked = true;
	document.getElementById("sql-combine-period").value =5 ;
	document.getElementById("sql-combine-maxitems").value =20 ;
	document.getElementById("enable-memcache").checked = true;
	document.getElementById("db_type_impala").checked = true;
	document.getElementById("impala-initial-pool-size").value =10 ;
	document.getElementById("impala-max-pool-size").value =20 ;
	document.getElementById("impala-min-pool-size").value =10 ;
	document.getElementById("base-hdfs-path").value ="hdfs:/hadoop-72:9000" ;
	document.getElementById("memcache-60-m").value = 24576;
	document.getElementById("memcache-60-t").value =12 ;
	document.getElementById("memcache-61-m").value = 24576;
	document.getElementById("memcache-61-t").value =12 ;
	document.getElementById("memcache-62-m").value = 24576;
	document.getElementById("memcache-62-t").value =12 ;
	document.getElementById("memcache-74-m").value = 32768;
	document.getElementById("memcache-74-t").value = 24;
	document.getElementById("memcache-85-m").value = 491520;
	document.getElementById("memcache-85-t").value = 24 ;
	document.getElementById("memcache-86-m").value = 491520;
	document.getElementById("memcache-86-t").value = 24 ;
}