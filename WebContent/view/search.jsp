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
<script src="../js/search.js"></script>
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
					<div id="search-input">
						<!-- 查询input组，输入查询框以及选择文件类型 -->
						<div class="input-group">
							<!-- <span class="input-group-addon"> <input type="checkbox" aria-label="search"> 全文检索 </span> -->
							<input id="search_field" type="text" class="form-control"
								placeholder="关键字"> <span class="input-group-btn">
								<button class="btn btn-default" type="button"
									style="width: 100px" onclick="dosearch();">查询</button>
							</span>
						</div>
						<br>
						<div class="form-group">
							<label for="database-type" class="col-sm-1 control-label">数据库</label>
							<div class="col-sm-2">
								<select class="form-control " id="database-type">
									<option>Impala</option>
									<option>Spark</option>
								</select>
							</div>
						</div>
						<div class="form-group input-group radio-list">
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
						<col style="width: 5%;">
						<col style="width: 50%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style>
						<col style>
						<col style>
						<col style="width: 80px; text-align: center">
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
						</tr>

					</thead>

					<tbody id="files_field" class="radio-list">
						<tr class="file-row ">
							<td><input type="checkbox" value="file_title11"
								name="filetitlecheck">img</td>
							<td>file_title-123</td>
							<td>key_words</td>
							<td>author_name</td>
							<td>download_count</td>
							<td>view_count</td>
							<td>file_size</td>
							<td>updata_time</td>
						</tr>
						<tr class="file-row">
							<td><input type="checkbox" value="file_title22"
								name="filetitlecheck">img</td>
							<td>file_title-123</td>
							<td>key_words</td>
							<td>author_name</td>
							<td>download_count</td>
							<td>view_count</td>
							<td>file_size</td>
							<td>updata_time</td>
						</tr>
					</tbody>
				</table>
				<nav id="page_nav" style="text-align:center;">
				<ul class="pagination pagination-lg" id="page_field">
				</ul>
				</nav>
				<div id="ftrresult_field">
					<div id="ftr-row"></div>
				</div>
				<script>
					$(document).ready(function() {
						$("#reslut_label").hide();
						$("#results_table").hide();
						$("#ftr_search-input").hide();
						$("#ftrresult_field").hide();
						$("#page_nav").hide();
					});
				</script>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>