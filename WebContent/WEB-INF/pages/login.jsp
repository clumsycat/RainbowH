<%@ page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- basic styles -->
<link href="../css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="../css/font-awesome.min.css" />

<!-- ace styles -->
<link rel="stylesheet" href="../css/ace.min.css" />
<link rel="stylesheet" href="../css/ace-rtl.min.css" />
</head>

<body class="login-layout">
	<div class="main-content">
		<div class="row col-sm-10 col-sm-offset-1">
			<div class="login-container">
				<div class="center" style="padding-top: 50px;">
					<h1>
						<span class="glyphicon glyphicon-cloud blue" aria-hidden="true"></span></i>
						<span class="red">Rainbow H</span> <span class="white">管理工具</span>
					</h1>
					<h4 class="blue">&copy; 孙毓忠课题组</h4>
				</div>

				<div class="space-6"></div>
				<!-- 登陆 -->
				<div class="position-relative">
					<div id="login-box" class="login-box visible widget-box no-border">
						<div class="widget-body">
							<div class="widget-main">
								<h4 class="header blue lighter bigger">
									<span class="glyphicon glyphicon-equalizer" aria-hidden="true"></span>
									请输入登陆信息
								</h4>

								<div class="space-6"></div>

								<form id="login-form" action="${pageContext.request.contextPath}/servlet/LoginServlet" method="post">
									<fieldset>
										<label class="block clearfix"> <span
											class="block input-icon input-icon-right"> <input
												id="login_username" name="login_username" type="text"
												class="form-control" placeholder="用户名" /> <span
												class="glyphicon glyphicon-user" aria-hidden="true"></span>
										</span>
										</label> <label class="block clearfix"> <span
											class="block input-icon input-icon-right"> <input
												id="login_password" name="login_password" type="password"
												class="form-control" placeholder="密码" /> <span
												class="glyphicon glyphicon-lock" aria-hidden="true"></span>
										</span>
										</label>


										<div class="checkbox ">
											<label> <input id="remember_user" type="checkbox"
												checked> 记住我
											</label>
										</div>

										<button type="button submit"
											class="width-35 pull-right btn btn-sm btn-primary submit">
											<span class="glyphicon glyphicon-home" aria-hidden="true"></span>
											登陆
										</button>

										<div class="space-4"></div>
									</fieldset>
								</form>

							</div>
							<!-- /widget-main -->

							<div class="toolbar clearfix">
								<div>
									<a href="#" onclick="show_box('forgot-box'); return false;"
										class="forgot-password-link"> <span
										class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
										忘记密码
									</a>
								</div>

								<div>
									<a href="#" onclick="show_box('signup-box'); return false;"
										class="user-signup-link"> 注册 <span
										class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span>
									</a>
								</div>
							</div>
						</div>
						<!-- /widget-body -->
					</div>
					<!-- /login-box -->

					<div id="forgot-box" class="forgot-box widget-box no-border">
						<div class="widget-body">
							<div class="widget-main">
								<h4 class="header red lighter bigger">
									<span class="glyphicon glyphicon-star" aria-hidden="true"></span>
									找回密码
								</h4>

								<div class="space-6"></div>
								<p>填入邮箱，联系管理员</p>

								<form id="forget-form">
									<fieldset>
										<label class="block clearfix"> <span
											class="block input-icon input-icon-right"> <input
												id="forget_email" name="forget_email" type="email"
												class="form-control" placeholder="Email" /> <span
												class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
										</span>
										</label>

										<div class="clearfix">
											<button type="button submit"
												class="width-35 pull-right btn btn-sm btn-danger submit">
												<span class="glyphicon glyphicon-send" aria-hidden="true"></span>
												发送
											</button>
										</div>
									</fieldset>
								</form>
							</div>
							<!-- /widget-main -->

							<div class="toolbar center">
								<a href="#" onclick="show_box('login-box'); return false;"
									class="back-to-login-link"> 返回登录 <span
									class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span>
								</a>
							</div>
						</div>
						<!-- /widget-body -->
					</div>
					<!-- /forgot-box -->

					<div id="signup-box" class="signup-box widget-box no-border">
						<div class="widget-body">
							<div class="widget-main">
								<h4 class="header green lighter bigger">
									<span class="glyphicon glyphicon-user blue" aria-hidden="true"></span>
									新用户注册
								</h4>

								<div class="space-6"></div>
								<p>请填入以下信息:</p>

								<form id="register-form" action="${pageContext.request.contextPath}/servlet/RegisterServlet" method="post">
									<fieldset>
										<label class="block clearfix"> <span
											class="block input-icon input-icon-right"> <input
												id="register_email" name="register_email" type="email"
												class="form-control" placeholder="邮箱" /> <span
												class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
										</span>
										</label> <label class="block clearfix"> <span
											class="block input-icon input-icon-right"> <input
												id="register_username" name="register_username" type="text"
												class="form-control" placeholder="用户名" /> <span
												class="glyphicon glyphicon-user" aria-hidden="true"></span>
										</span>
										</label> <label class="block clearfix"> <span
											class="block input-icon input-icon-right"> <input
												id="register_password" name="register_password"
												type="password" class="form-control" placeholder="密码" /> <span
												class="glyphicon glyphicon-lock" aria-hidden="true"></span>
										</span>
										</label> <label class="block clearfix"> <span
											class="block input-icon input-icon-right"> <input
												id="register_confirm_password"
												name="register_confirm_password" type="password"
												class="form-control" placeholder="密码确认" /> <span
												class="glyphicon glyphicon-retweet" aria-hidden="true"></span>
										</span>
										</label>

										<!-- 													<label class="block">
														<input type="checkbox" class="ace" />
														<span class="lbl">
															I accept the
															<a href="#">User Agreement</a>
														</span>
													</label> -->

										<div class="clearfix">
											<button type="reset"  id="reset" class="width-30 pull-left btn btn-sm" >
												<span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
												重置
											</button>

											<button type="button submit"
												class="width-65 pull-right btn btn-sm btn-success submit">
												注册 <span class="glyphicon glyphicon-arrow-right"
													aria-hidden="true"></span>
											</button>
										</div>
									</fieldset>
								</form>
							</div>

							<div class="toolbar center">
								<a href="#" onclick="show_box('login-box'); return false;"
									class="back-to-login-link"> <span
									class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
									返回登陆
								</a>
							</div>
						</div>
						<!-- /widget-body -->
					</div>
					<!-- /signup-box -->
				</div>
				<!-- /position-relative -->
			</div>
		</div>
		<!-- /.col -->
	</div>
	<!-- /.row -->
	<!-- /.main-container -->


	<!-- inline scripts related to this page -->
	<script src="../js/jquery-1.11.2.min.js" type="text/javascript"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="../js/bootstrap.min.js" type="text/javascript"></script>
	<script src="../js/jquery.validate.js"></script>

	<script type="text/javascript">
		function show_box(id) {
			jQuery('.widget-box.visible').removeClass('visible');
			jQuery('#' + id).addClass('visible');
		}

		$().ready(function() {
			$("#login-form").validate({
				rules : {
					login_username : "required",
					login_password : "required"
				},
				messages : {
					login_username : "请输入用户名",
					login_password : "请输入密码"
				},
				submitHandler : function(form) {
					form.submit();
				}
			});
			$("#forget-form").validate({
				rules : {
					forget_email : {
						required : true,
						email : true
					}
				},
				messages : {
					forget_email : "请输入邮箱",
					email : "请输入正确格式的邮箱"
				},
				submitHandler : function(form) {
					form.submit();
				}
			});
			var registervali=$("#register-form").validate({
				rules : {
					register_username : {
						required : true,
						minlength : 4,
					},
					register_email : {
						required : true,
						email : true
					},
					register_password : {
						required : true,
						minlength : 6
					},
					register_confirm_password : {
						required : true,
						minlength : 6,
						equalTo : "#register_password"
					}
				},
				messages : {
					register_username : {
						required : "请输入用户名",
						minlength :"用户名不能小于4个字符"
					},
					register_email : "请输入邮箱",
					register_password : {
						required : "请输入密码",
						minlength : "密码不能小于6个字符"
					},
					register_confirm_password : {
						required : "请输入确认密码",
						minlength : "确认密码不能小于6个字符",
						equalTo : "两次输入密码不一致"
					}
				},
				submitHandler : function(form) {
					form.submit();
				}
			});
			$("#reset").click(function() {
				registervali.resetForm();
		    });
		})
	</script>
	<script type="text/javascript">

	</script>
</body>



</html>