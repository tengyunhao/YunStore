<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>云盘</title>
	<link rel="stylesheet" type="text/css" href="res/css/login-normalize.css" />
	<link rel="stylesheet" type="text/css" href="res/css/login-demo.css" />
	<!--必要样式-->
	<link rel="stylesheet" type="text/css" href="res/css/login-component.css" />
	<!--[if IE]>
	<script src="res/js/html5.js"></script>
	<![endif]-->
    <link rel="stylesheet" href="res/css/layui.css">
	<style>
	body { background: url(res/css/006.jpg) }
	</style>
</head>
<body>
	<div class="container demo-1">
		<div class="content">
			<div id="large-header" class="large-header">
				<div class="logo_box">
					<h3>欢迎你</h3>
                    <form class="layui-form" action="">
						<div class="layui-form-item">
							<label class="layui-form-label">单行输入框</label>
							<div class="layui-input-block">
							<input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">验证必填项</label>
							<div class="layui-input-block">
							<input type="text" name="username" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
							</div>
						</div>
                    </form>
					<%--<form id="form" action="login-check.do" name="f" method="post">--%>
						<%--<div class="input_outer">--%>
							<%--<span class="u_user"></span>--%>
							<%--<input id="username" name="username" class="text" style="color: #FFFFFF !important" type="text" placeholder="请输入账户">--%>
						<%--</div>--%>
						<%--<div class="input_outer">--%>
							<%--<span class="us_uer"></span>--%>
							<%--<input id="password" name="password" class="text" style="color: #FFFFFF !important; position:absolute; z-index:100;"value="" type="password" placeholder="请输入密码">--%>
						<%--</div>--%>
						<%--<div class="mb2"><a id="login" class="act-but submit" href="javascript:;" style="color: #FFFFFF">登录</a></div>--%>
					<%--</form>--%>
					<lable style="float:left"><a href="#">忘记密码？</a></lable>
					<lable style="float:right"><a href="register.do">新用户注册</a></lable>
				</div>
			</div>
		</div>
	</div><!-- /container -->
	<script src="res/js/TweenLite.min.js"></script>
	<script src="res/js/EasePack.min.js"></script>
	<script src="res/js/rAF.js"></script>
	<script src="res/js/demo-1.js"></script>
	<script src="res/jquery.min.js"></script>
	<script src="res/layui.js"></script>
	<script>
	$("#login").click(function () {
		$("#form").submit();
	})

	</script>
	<script>
	layui.use('form', function(){
	    var form = layui.form;

	});
	</script>
</body>
</html>