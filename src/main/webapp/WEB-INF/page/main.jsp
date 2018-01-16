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
<link rel="stylesheet" href="res/css/layui.my.css">
<link rel="stylesheet" href="res/css/icon.css" media="all">
<link rel="stylesheet" href="res/css/global.css" id="layuicss-skincodecss" media="all">
<link rel="stylesheet" href="res/css/modules/code.css" id="layuicss-skincodecss" media="all">
<link rel="stylesheet" href="res/css/modules/layer/default/layer.css" id="layuicss-layer" media="all">
<style>
	body { background: url(res/css/006.jpg) }
</style>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<!-- 顶部开始 -->
		<div class="layui-header" style="background-color: transparent;">
			<div class="layui-logo" style="color:#FFFFFF">
				<div style="float:left;margin:0 5px 0 15px"><i class="layui-icon" style="font-size: 45px;">&#xe681;</i></div>
				<div style="float:left;height:100%;font-size: 18px;">资料分享云盘</div>
			</div>
			<!-- 头部区域（可配合layui已有的水平导航） -->
			<%--<ul class="layui-nav layui-layout-left">--%>
				<%--<li class="layui-nav-item"><a href="">查找用户</a></li>--%>
				<%--<li class="layui-nav-item">--%>
					<%--<a href="javascript:;">其它系统</a>--%>
					<%--<dl class="layui-nav-child">--%>
						<%--<dd><a href="">邮件管理</a></dd>--%>
						<%--<dd><a href="">消息管理</a></dd>--%>
						<%--<dd><a href="">授权管理</a></dd>--%>
					<%--</dl>--%>
				<%--</li>--%>
			<%--</ul>--%>
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item">
					<a href="javascript:;"><img src="http://t.cn/RCzsdCq" class="layui-nav-img">${name}</a>
					<dl class="layui-nav-child">
						<dd><a id="info" href="#setting/info.do">基本资料</a></dd>
					</dl>
				</li>
				<li class="layui-nav-item"><a href="${pageContext.request.contextPath }/logout.do">安全退出</a></li>
			</ul>
		</div>
		<!-- 顶部结束 -->
		<!-- 菜单开始 -->
		<div class="layui-side">
			<div class="layui-side-scroll">
				<div class="kit-side-fold">
					<i class="fa fa-navicon" aria-hidden="true"></i>
				</div>
				<!-- 参数 lay-filter 用于局部更新 -->
				<ul class="layui-nav layui-nav-tree" lay-filter="nav-filter">
					<li class="layui-nav-item layui-nav-itemed" id="nav-file">
						<a href="javascript:;">我的硬盘</a>
						<dl class="layui-nav-child">
							<dd><a href="#file/list.do">全部文件</a></dd>
							<dd><a href="#file/search.do">查找文件</a></dd>
							<dd><a href="#file/storage.do">空间管理</a></dd>
						</dl>
					</li>
					<li class="layui-nav-item layui-nav-itemed" id="nav-share">
						<a href="javascript:;">文件共享</a>
						<dl class="layui-nav-child">
							<dd><a href="#group/material.do">资料群组</a></dd>
							<dd><a href="#group/share.do">共享群组</a></dd>
							<dd><a href="javascript:;">任务群组</a></dd>
						</dl>
					</li>
					<li class="layui-nav-item layui-nav-itemed"><a href="#friend/list.do">我的好友</a></li>
					<li class="layui-nav-item layui-nav-itemed"><a href="#time.do">我的日程</a></li>
					<li class="layui-nav-item layui-nav-itemed"><a href="">回收站</a></li>
				</ul>
			</div>
		</div>
		<!-- 菜单结束 -->
		<!-- 内容开始 -->
		<div class="layui-body" id="content" style="background-color:#fafafa;padding: 10px;">
		</div>
		<!-- 内容结束 -->
		<%--<div class="layui-footer">--%>
		<%--<!-- 底部固定区域 -->--%>
		<%--© layui.com - 底部固定区域--%>
		<%--</div>--%>
		<div class="site-tree-mobile layui-hide">
			<i class="layui-icon">&#xe602;</i>
		</div>
		<div class="site-mobile-shade"></div>
	</div>
	<script src="res/jquery.min.js"></script>
	<script src="res/layui.js"></script>
	<script src="res/lay/modules/global.js"></script>
	<script>
	layui.use(['element'], function() {
		var element = layui.element;
		element.on('nav(nav-filter)', function(elem){
			var _a = elem.html();
			var _href = _a.substring(_a.indexOf('#')+1,_a.indexOf('.do'))+".do";
			// 加载页面
			$.get(_href,function(data){
				$("#content").html(data);
				// 渲染文件路径导航栏
				element.render('nabreadcrumbv');
			});
		});
		// 刷新时根据url跳转到对应的页面
		var url = window.location.href;
		if(url.indexOf("#") !== -1) {
			url = url.split("#")[1];
			if(url !== '') {
				$.get(url, function(data){
					$("#content").html(data);
					// 渲染文件路径导航栏
					element.render('nabreadcrumbv');
				});
			}
		}
		$("#info").click(function(){
			$.get("setting/info.do", function(data){
				$("#content").html(data);
			});
		});
		$("#content").height($(window).height()-80);
		$(window).resize(function(){
			$("#content").height($(window).height()-80);
		});
	});
	</script>
</body>
</html>