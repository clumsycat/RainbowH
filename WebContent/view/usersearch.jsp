<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--为了避免在jsp页面中出现java代码，这里引入jstl标签库，利用jstl标签库提供的标签来做一些逻辑判断处理 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link href="../css/rainbow.css" rel="stylesheet">
<script src="../js/search.js"></script>
<script src="../js/jquery.tmpl.min.js"></script>
<title>RainBowH 用户界面</title>
</head>
<body>
	<!-- 上方导航栏 -->
	<jsp:include page="header.jsp" flush="true" />
	<!-- 搜索页面 -->
	<div class="rainbow-search">
		<div class="container">
			<form>
				<div class="input-title">
					<h2>查询</h2>
				</div>
				<div class="input-content form-group">
					<div id="search-input" class="row">
						<div class="col-sm-2">
							<!-- 查询input组，输入查询框以及选择文件类型 -->
							<select class="form-control " id="database_type">
								<option>Impala</option>
								<option>Spark</option>
								<option>Mysql</option>
								<option>MongoDB</option>
								<option>Oracle</option>
							</select>
						</div>
						<div class="input-group  col-sm-8">
							<!-- <span class="input-group-addon"> <input type="checkbox" aria-label="search"> 全文检索 </span> -->
							<input id="search_field" type="text"
								class="form-control col-sm-4" placeholder="关键字"> <span
								class="input-group-btn">
								<button class="btn btn-default" type="button"
									data-loading-text="查询中..." style="width: 100px"
									onclick="dosearch('${user.group}');">查询</button>
							</span>
						</div>
						<br>
						<div class="form-group input-group radio-list col-sm-offset-2">
							<label class="radio-inline" style="width: 100px"> <input
								type="radio" name="filetyperadio" id="file_type_1" value="all"
								checked> 全部
							</label> <label class="radio-inline" style="width: 100px"> <input
								type="radio" name="filetyperadio" id="file_type_2" value="pdf">
								PDF
							</label> <label class="radio-inline" style="width: 100px"> <input
								type="radio" name="filetyperadio" id="file_type_3" value="txt">
								TXT
							</label> <label class="radio-inline" style="width: 100px"> <input
								type="radio" name="filetyperadio" id="file_type_4" value="xml">
								XML
							</label>
						</div>

					</div>
					<div id="ftr_search-input">
						<!-- 全文检索输入组 -->
						<div class="input-group">
							<input id="ftr_field" type="text" class="form-control"
								placeholder="全文检索：请选择需要检索的文件，并输入全文检索关键字"> <span
								class="input-group-btn">
								<button class="btn btn-default" type="button"
									style="width: 100px" onclick="doftrsearch();">全文检索</button>
							</span>
						</div>
					</div>
				</div>
			</form>
			<div id="result_field">
				<label id="reslut_label"></label>
				<table id="results_table" class="table table-striped">
					<colgroup>
						<col style="width: 10%;">
						<col style="width: 40%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style>
						<col style>
						<col style>
						<col style="width: 80px; text-align: center">
						<c:if test="${user.group=='admin'}">
							<col style="width: 5%;">
						</c:if>
					</colgroup>

					<thead id="results_head">
						<tr>
							<th>下载</th>
							<th>名称</th>
							<th>关键字</th>
							<th>作者</th>
							<th>下载量</th>
							<th>浏览量</th>
							<th>文件大小</th>
							<th>更新日期</th>
							<c:if test="${user.group=='admin'}">
								<th>删除</th>
							</c:if>
						</tr>

					</thead>

					<tbody id="files_field" class="radio-list">
						<tr class="file-row ">
							<td><input type="checkbox" value="file_title11"
								name="filetitlecheck">img1</td>
							<td>file_title-123</td>
							<td>key_words</td>
							<td>author_name</td>
							<td>download_count</td>
							<td>view_count</td>
							<td>file_size</td>
							<td>updata_time</td>
							<c:if test="${user.group=='admin'}">
								<td><span class="glyphicon glyphicon-trash"
									onclick="del('id1','path1',this);"></span></td>
							</c:if>
						</tr>
						<tr class="file-row">
							<td><input type="checkbox" value="file_title22"
								name="filetitlecheck">img2</td>
							<td>file_title-123</td>
							<td>key_words</td>
							<td>author_name</td>
							<td>download_count</td>
							<td>view_count</td>
							<td>file_size</td>
							<td>updata_time</td>
							<td><span class="glyphicon glyphicon-trash"
								onclick="del('id1','path1',this);"></span></td>
						</tr>
					</tbody>
				</table>
				<div>
					<nav id="page_nav" style="text-align:center;">
					<ul class="pagination pagination-lg" id="page_field">
					</ul>
					</nav>
				</div>
				<div id="ftrresult_field">
				</div>
				<script id="result" type="text/x-jquery-tmpl">
   			<div class="result">
    　　		<h3 class="t">{{= path}}</h3>
    　　		<p>	{{html highlight}} </p>
				<div class="text"><pre class="pre-scrollable ">{{= contents}}</pre></div>
    		</div>
			</script>
				<script>
					$(document).ready(function() {
						$("#reslut_label").hide();
						$("#results_table").hide();
						$("#ftr_search-input").hide();
						$("#ftrresult_field").hide();
						$("#page_nav").hide();
					});
				</script>
				<script type="text/javascript">
					
				</script>

			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>