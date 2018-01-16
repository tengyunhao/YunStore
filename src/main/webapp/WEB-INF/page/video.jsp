<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>云盘</title>
<link rel="stylesheet" href="res/css/layui.css">
<link rel="stylesheet" href="res/css/layui.my.css">
<link rel="stylesheet" href="res/css/modules/code.css" id="layuicss-skincodecss" media="all">
<link rel="stylesheet" href="res/css/modules/layer/default/layer.css" id="layuicss-layer" media="all">
</head>
<body class="layui-layout-body" style="background-color:#F0F0F0">
	<div class="layui-layout layui-layout-admin">
		<!-- 顶部开始 -->
		<div class="layui-header layui-bg-blue">
            <div class="layui-logo" style="color:#FFFFFF">
                <div style="float:left;margin:0 5px 0 15px"><i class="layui-icon" style="font-size: 45px;">&#xe681;</i></div>
                <div style="float:left;height:100%;font-size: 18px;">资料分享云盘</div>
            </div>
			<!-- 头部区域（可配合layui已有的水平导航） -->
			<ul class="layui-nav layui-layout-left">
				<li class="layui-nav-item"><a href="">查找用户</a></li>
				<li class="layui-nav-item">
					<a href="javascript:;">其它系统</a>
					<dl class="layui-nav-child">
						<dd><a href="">邮件管理</a></dd>
						<dd><a href="">消息管理</a></dd>
						<dd><a href="">授权管理</a></dd>
					</dl>
				</li>
			</ul>
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item">
					<a href="javascript:;"><img src="http://t.cn/RCzsdCq" class="layui-nav-img">${name}</a>
					<dl class="layui-nav-child">
						<dd><a href="">基本资料</a></dd>
						<dd><a href="">安全设置</a></dd>
					</dl>
				</li>
				<li class="layui-nav-item"><a href="${pageContext.request.contextPath }/login.do">退了</a></li>
			</ul>
		</div>
		<!-- 顶部结束 -->
		<!-- 内容开始 -->
		<div class="layui-container">
			<div class="layui-row" style="margin-top:20px; margin-bottom:15px;">
				<div class="layui-col-md9">
					<lable style="font-size:18px;">${fileInfo.name}</lable>
				</div>
				<div class="layui-col-md3">
				</div>
			</div>
			<div class="layui-row">
				<!--
				controls 控制条
				preload="none" 预加载
				poster="http://vjs.zencdn.net/v/oceans.png" 初始图片
				-->
				<video id="" class="video-js vjs-default-skin" style="background-color:#000000" controls width="100%" height="600px" data-setup='{ "aspectRatio":"640:267", "playbackRates": [1, 1.5, 2] }'>
					<source src="${fileInfo.url}" type="video/mp4">
					<source src="http://vjs.zencdn.net/v/oceans.webm" type="video/webm">
					<source src="http://vjs.zencdn.net/v/oceans.ogv" type="video/ogg">
					<track kind="captions" src="../shared/example-captions.vtt" srclang="en" label="English"></track>
					<!-- Tracks need an ending tag thanks to IE9 -->
					<track kind="subtitles" src="../shared/example-captions.vtt" srclang="en" label="English"></track>
					<!-- Tracks need an ending tag thanks to IE9 -->
					<p class="vjs-no-js">To view this video please enable JavaScript, and consider upgrading to a web browser that <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a></p>
				</video>
			</div>
			<div class="layui-row" style="margin-top:20px; margin-bottom:15px;">
				<button class="layui-btn layui-btn-primary"><i class="layui-icon">&#xe613;</i>分享</button>
				<button class="layui-btn layui-btn-primary"><i class="layui-icon">&#xe61e;</i>下载</button>
			</div>
		</div>
		<!-- 内容结束 -->
		<%--<div class="layui-footer">--%>
		<%--<!-- 底部固定区域 -->--%>
		<%--© layui.com - 底部固定区域--%>
		<%--</div>--%>
	</div>
	<script src="res/jquery.min.js"></script>
	<script src="res/layui.js"></script>
</body>
</html>