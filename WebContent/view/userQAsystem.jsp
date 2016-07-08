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
<script src="../js/jquery.tmpl.min.js"></script>

<title>QA问答系统</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<div class="container col-sm-offset-1 col-xs-offset-1 col-sm-10">
		<form>
			<div class="input-group  col-sm-10">
				<div class="input-title">
					<h2>请输入问题~</h2>
				</div>
				<div class="input-content form-group ">
					<div id="search-input" class="row ">
						<input id="question" name="question" type="text"
							style="width: 80%" class="form-control " placeholder="how to ...">
						<span class="input-group-btn">
							<button class="btn btn-info" type="button"
								data-loading-text="查询中..." style="width: 100px"
								onclick="askQuestion()">查询</button>
						</span>
					</div>
				</div>
			</div>
		</form>
		<div id="result_field"></div>

	</div>
	<!-- <pre>{{= contents}}</pre> -->
	<script id="result" type="text/x-jquery-tmpl">
   			<div class="result">
    　　		<h3 class="t">{{= path}}</h3>
    　　		<p>	{{html highlight}} </p>
				<div class="text"><pre>{{= contents}}</pre></div>
    		</div>
			</script>
	<script type="text/javascript">
		function askQuestion() {
			var question = $("#question")[0].value;
			url = "../servlet/luceneServlet?question=" + encodeURI(question);
			$.ajax({
				url : url,
				type : "GET",
				dataType : "json",
				contentType : 'text/html; charset=UTF-8',
				success : function(data) {
					//data=JSON.parse(data);
					console.log(data);
					//data=data.replace("\n"," &lt;br>");
					$("#result_field").empty();
					$("#result").tmpl(data).appendTo("#result_field");
					highword(question);
					$('.result h3').on({
						click : function() {
							$(this).siblings(".text").toggle();
						}
					});
				}
			});
			function high(keyword) {
				$("pre:contains('" + keyword + "')").each(
						function() {
							var t = $(this).html();
							var re = eval('/' + keyword + '/img');
							$(this).html(
									t.replace(re,
											"<b style='background:yellow'>"
													+ keyword + "</b>"));
						});
			}
			function highword(nWord) {
				if (ifChinese(nWord))
					var array = nWord.split("");
				else
					var array = nWord.split(" ");
				for (var i = 0; i < array.length; i++) {
					high(array[i]);
				}
			}
			function ifChinese(str){
				var reg = new RegExp("[\\u4E00-\\u9FFF]+","g");
				return reg.test(str);
			}
		}
	</script>


	<jsp:include page="footer.jsp" flush="true"></jsp:include>