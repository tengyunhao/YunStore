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
<link rel="stylesheet" href="res/css/layui.css">
<link rel="stylesheet" href="res/css/modules/code.css" id="layuicss-skincodecss" media="all">
<link rel="stylesheet" href="res/css/modules/layer/default/layer.css" id="layuicss-layer" media="all">
<style type="text/css">
.layui-table-hover {
	
}
</style>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<div style="position: absolute; left: 50%; top: 50%; width:360px; height:200px; margin-left:-180px; margin-top:-100px;">
			<div class="layui-form-item">
				<label class="layui-form-label">用户名</label>
				<div class="layui-input-inline">
					<input type="text" name="username" lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">密码</label>
				<div class="layui-input-inline">
					<input type="password" name="password" lay-verify="pass" placeholder="请输入密码" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button class="layui-btn" lay-submit="" lay-filter="demo1">登陆</button>
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				</div>
			</div>
		</div>
	</div>
	<script src="res/jquery.min.js"/></script>
	<script src="res/layui.js"></script>

</body>
</html>