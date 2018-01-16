	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">
.layui-border-box {margin:0}
</style>
<div class="layui-container">
	<div class="layui-col-xs3 layui-col-sm3 layui-col-md3">
		<div class="layui-row" style="margin-top: 10px;background-color:#fcfcfc">
			<div class="layui-collapse">
				<div class="layui-colla-item">
					<table lay-filter="groupEvent"></table>
				</div>
				<div class="layui-colla-item">
					<div class="layui-btn-group" style="padding: 0px;">
					<button id="add-group" class="layui-btn">创建共享组</button>
					<button id="apply-group" class="layui-btn">加入共享组</button>
					<button class="layui-btn">设置</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="share-index" class="layui-col-xs9 layui-col-sm9 layui-col-md9">
		<div class="layui-tab layui-tab-card" style="height:696px; margin-left:10px">
			<img src="res/img/share.png" style="height:100%;width:100%;" alt="上海鲜花港 - 郁金香" />
		</div>
	</div>
	<div id="share-content" class="layui-hide layui-col-xs9 layui-col-sm9 layui-col-md9">
		<div class="layui-tab layui-tab-card" lay-filter="test" style="margin-left:10px">
			<div class="layui-tab-title" style="padding: 8px;">
				<button id="file-return" style="position:relative;float:left" class="layui-hide layui-btn">返回文件库</button>
				<div id="file-operator" style="position:relative;float:left">
					<button id="file-share" class="layui-btn layui-btn-normal">文件分享</button>
					<button id="file-store" class="layui-hide layui-btn">文件转存</button>
				</div>
				<div id="friend-operator" style="position:relative;float:left" class="layui-hide">
					<button id="friend-invite" class="layui-btn layui-btn-normal">邀请好友</button>
					<button id="friend-setting" class="layui-hide layui-btn">设置权限</button>
				</div>
				<ul id="group-tab" style="position:relative;float:right;">
					<li class="layui-this" lay-id="11">文件库</li>
					<li lay-id="22">群成员</li>
				</ul>
				<div style="font-size:16px; width:200px;margin-top: 7px; margin-left:auto; margin-right:auto;text-align:center">
					<lable id="group-name"></lable>
					<lable id="file-path" class="layui-hide">文件库：</lable>
					<span class="layui-breadcrumb" id="path"></span>
				</div>
			</div>
			<div class="layui-tab-content" style="padding: 0; margin: 0;">
				<div class="layui-tab-item layui-show">
					<table id="files" lay-filter="filesEvent"></table>
				</div>
				<div class="layui-tab-item">
					<table id="users" lay-filter="usersEvent"></table>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="res/lay/modules/table.js"></script>
<script src="res/lay/modules/laytpl.js"></script>
<script src="res/lay/modules/tree.js"></script>
<script type="text/html" id="usernameTpl">
{{#  if(d.type === '-'){ }}
<!-- 文件夹 -->
<i class="iconfont" style="float:left; font-size: 32px; color: #EDCA50;">&#xe600;</i>
<div style="float:left"><lable>&nbsp&nbsp{{ d.name }}</lable></div>
{{#  } else if(d.type === 'txt') { }}
<!-- txt -->
<i class="iconfont" style="float:left; font-size: 32px; color: #edcd77;">&#xe8b9;</i>
<div style="float:left"><lable>&nbsp&nbsp{{ d.name }}</lable></div>
<!-- doc -->
{{#  } else if(d.type === 'doc' || d.type === 'docx') { }}
<i class="iconfont" style="float:left; font-size: 32px; color: #00aded;">&#xe8bb;</i>
<div style="float:left"><lable>&nbsp&nbsp{{ d.name }}</lable></div>
<!-- ppt -->
{{#  } else if(d.type === 'ppt' || d.type === 'pptx') { }}
<i class="iconfont" style="float:left; font-size: 32px; color: #ed5252;">&#xe8b4;</i>
<div style="float:left"><lable>&nbsp&nbsp{{ d.name }}</lable></div>
<!-- xls -->
{{#  } else if(d.type === 'xls' || d.type === 'xlsx') { }}
<i class="iconfont" style="float:left; font-size: 32px; color: #05c319;">&#xe8a8;</i>
<div style="float:left"><lable>&nbsp&nbsp{{ d.name }}</lable></div>
{{#  } else if(d.type === 'pdf') { }}
<!-- pdf -->
<i class="iconfont" style="float:left; font-size: 32px; color: #e1716b;">&#xe8b3;</i>
<div style="float:left"><lable>&nbsp&nbsp{{ d.name }}</lable></div>
{{#  } else if(d.type === 'jpeg' || d.type === 'jpg') { }}
<!-- 图片 -->
<i class="iconfont" style="float:left; font-size: 32px; color: #f69283;">&#xe8b0;</i>
<div style="float:left"><lable>&nbsp&nbsp{{ d.name }}</lable></div>
{{#  } else if(d.type === 'mp4') { }}
<!-- mp4 -->
<i class="iconfont" style="float:left; font-size: 32px; color: #6c70ed;">&#xe8b8;</i>
<div style="float:left"><lable>&nbsp&nbsp{{ d.name }}</lable></div>
{{#  } else if(d.type === 'mp3') { }}
<!-- mp3 -->
<i class="iconfont" style="float:left; font-size: 32px; color: #ed000d;">&#xe8a5;</i>
<div style="float:left"><lable>&nbsp&nbsp{{ d.name }}</lable></div>
{{#  } else { }}
<i class="iconfont" style="float:left; font-size: 32px; color: #e1e1e1;">&#xe8ba;</i>
<div style="float:left"><lable>&nbsp&nbsp{{ d.name }}</lable></div>
{{#  } }}
</script>
<script>
var nowGroup = "";
var nowFile = "";
var nowDirectory = "";
// 获取当前目录的id
var parent = "";
layui.use(['table','element'], function() {
	var table = layui.table;
	var element = layui.element;

	table.init('groupEvent', {
		id: 'group',
		url: '${pageContext.request.contextPath }/list-group-share.do',
		height: 660,
		limit: 10, //注意：请务必确保 limit 参数（默认：10）是与你服务端限定的数据条数一致
		size: 'lg',
		cols: [[
			{field:'name', title:'我的群组', event: 'enter'}
		]]
	});
	element.on('tab(test)', function(data){
		if(data.index == 0) { // 点击了文件库
			$("#file-operator").removeClass("layui-hide");
			$("#friend-operator").addClass("layui-hide");
		} else { // 点击了成员列表
			$("#file-operator").addClass("layui-hide");
			$("#friend-operator").removeClass("layui-hide");
		}
	});
	var h = 0; // 目录深度
	table.on('checkbox(filesEvent)', function(obj){
		var checkStatus = table.checkStatus('files');
		if(checkStatus.data.length != 0) {
			$("#file-share").addClass("layui-hide");
			$("#file-store").removeClass("layui-hide");
		} else {
			$("#file-share").removeClass("layui-hide");
			$("#file-store").addClass("layui-hide");
		}
	});
	table.on('checkbox(usersEvent)', function(obj){
		var checkStatus = table.checkStatus('users');
		if(checkStatus.data.length != 0) {
			$("#friend-invite").addClass("layui-hide");
			$("#friend-setting").removeClass("layui-hide");
		} else {
			$("#friend-invite").removeClass("layui-hide");
			$("#friend-setting").addClass("layui-hide");
		}
	});
	/** 创建共享组 */
	$("#add-group").click(function() {
		layer.prompt({title: '要创建共享组的名称', formType: 0}, function(name, index){
			layer.load();
			$.ajax({
				type : "post",
				url : "${pageContext.request.contextPath }/add-group-share.do",
				data : {
					name : name
				},
				success : function(data) {
					layer.close(index);
					if(data.status == 200) {
						layer.msg('创建群组'+name+'"成功');
					}
					table.reload('group', {});
					setTimeout(function(){
						layer.closeAll('loading');
					}, 500);
					<%-- 这里可以弹出另一个窗口 --%>
				},
				error : function() {
				}
			});
		});
	});
	/** 资料组监听事件 */
	table.on('tool(groupEvent)', function(obj) { //注：tool是工具条事件名，demoEvent是table原始容器的属性 lay-filter="对应的值"
		var data = obj.data; // 当前行数据
		var event = obj.event; //获得 lay-event 对应的值
		var tr = obj.tr; //获得当前行 tr 的DOM对象
		if (event === 'enter') {
			layer.load();
			nowGroup = data.id;
			$("#group-name").text(data.name);
			// 加载资料组内的文件
			table.render({
				id: 'files',
				elem: '#files',
				height: 640,
				skin: 'line',
				size: 'lg',
				url: '${pageContext.request.contextPath }/file-group-share.do', //数据接口
				where: {
					group : data.id
				},
				cols: [[
					{field:'id', checkbox: true},
					{field:'name', title: '文件', width:400, event: 'enter', style:'cursor: pointer;', sort: true, templet: '#usernameTpl'},
					{field:'size', title: '大小', width:100},
					{field:'teacher', title: '分享人', width:120, sort: true},
					{field:'time', title: '分享时间', width:200, sort: true}
				]]
			});
			table.render({
				id: 'users',
				elem: '#users',
				height: 640,
				skin: 'line',
				size: 'lg',
				url: '${pageContext.request.contextPath }/user-group-share.do', //数据接口
				where: {
					group : data.id
				},
				cols: [[
					{field:'id', checkbox: true},
					{field:'name', title: '成员', width:150, event: 'enter', style:'cursor: pointer;', sort: true, templet: '#'},
					{field:'username', title: '用户名', width:500},
					{field:'rank', title: '地位', width:200}
				]]
			});
			setTimeout(function(){
				layer.closeAll('loading');
			}, 300);
			$("#share-index").addClass("layui-hide");
			$("#share-content").removeClass("layui-hide");
		}
	});
	/** 返回到文件库列表 */
	$("#file-return").click(function() {
		$("#file-return").addClass("layui-hide");
		$("#file-operator").removeClass("layui-hide");
		$("#group-tab").removeClass("layui-hide");
		h = 0; parent = "";
		// 移除目录路径
		$("#path").children("a").each(function(){
			$(this).remove();
		});
		$("#file-path").addClass("layui-hide");
		$("#group-name").removeClass("layui-hide");
		// 获取根目录的文件信息，并刷新表格
		table.render({
			id: 'files',
			elem: '#files',
			height: 640,
			skin: 'line',
			size: 'lg',
			url: '${pageContext.request.contextPath }/file-group-share.do', //数据接口
			where: {
				group : nowGroup
			},
			cols: [[
				{field:'id', checkbox: true},
				{field:'name', title: '文件', width:400, event: 'enter', style:'cursor: pointer;', sort: true, templet: '#usernameTpl'},
				{field:'size', title: '大小', width:100},
				{field:'teacher', title: '分享人', width:120, sort: true},
				{field:'time', title: '分享时间', width:200, sort: true}
			]]
		});
	});
	/** 点击文件导航（后退） */
	function directoryBack(click, id, name) {
		// 如果点击的就是当前目录，则不需要处理
		if(click == h) return;
		h = click; parent = id;
		// 刷新文件表格
		table.reload('files', {where: {directory : id}});
		// 移除第h层之后其他目录路径
		$("#path").children("a").each(function(){
		var n = parseInt($(this).attr("id"));
			if(n > click) {
				$(this).remove();
			} else if (n == click) {
				$(this).addClass('active');
				$(this).html("<cite>"+name+"</cite>");
			}
		});
	}
	/** 点击文件目录（前进） */
	function directoryEnter(id, name) {
		h++; parent = id;
		// 刷新文件表格
		table.render({
			id: 'files',
			elem: '#files',
			height: 640,
			skin: 'line',
			size: 'lg',
			url: '${pageContext.request.contextPath }/look-directory.do', //数据接口
			where: {
				directory : id
			},
			cols: [[
				{field:'id', checkbox: true},
				{field:'name', title: '文件', width:400, event: 'enter', style:'cursor: pointer;', sort: true, templet: '#usernameTpl'},
				{field:'size', title: '大小', width:220},
				{field:'time', title: '修改日期', width:200, sort: true}
			]]
		});
		// 让上层目录的路径可点击
		$("#path").children("a").each(function(){
			if($(this).attr("class").indexOf("active") != -1) {
				$(this).removeClass('active');
				$(this).html($(this).text()+"<span class='layui-box'>&gt;</span>");
			}
		});
		// 添加当前所在目录（第h层）的路径
		$("#path").append("<a id='"+h+"' href='#' class='path active'><cite>"+name+"</cite></a>");
		// 添加当前所在目录（第h层）路径的点击事件
		$('#'+h).click(function() {
			directoryBack($(this).attr("id"), id, name);
		});
	}
	/** 监听文件库单元格事件 */
	table.on('tool(filesEvent)', function(obj) { //注：tool是工具条事件名，demoEvent是table原始容器的属性 lay-filter="对应的值"
		var data = obj.data; // 当前行数据
		var event = obj.event; //获得 lay-event 对应的值
		var tr = obj.tr; //获得当前行 tr 的DOM对象
		if (event === 'enter') {
			if(data.type === '-') { // 如果是文件夹
				h++;
				$("#group-tab").addClass("layui-hide");
				$("#file-return").removeClass("layui-hide");
				$("#file-operator").addClass("layui-hide");
				$("#file-path").removeClass("layui-hide");
				$("#group-name").addClass("layui-hide");
				directoryEnter(data.id, data.name);
			} else { // 如果是文件
				if(data.type === 'doc' || data.type === 'docx'
				|| data.type === 'ppt' || data.type === 'pptx'
				|| data.type === 'xls' || data.type === 'xlsx'
				|| data.type === 'pdf') { // 可以预览
					layer.msg(data.name, {
						time: 10000, //10s后自动关闭
						btn: ['下载', '预览', '关闭'],
						yes: function(index){
						layer.close(index);
							fileDownload(data.id);
						},
						btn2: function(){
							$.getJSON('file-preview.do?file='+data.id, function(json){
								layer.photos({
									photos: json,
									anim: 5 //0-6的选择，指定弹出图片动画类型，默认随机
								});
							});
						}
					});
				} else {
					layer.msg(data.name, {
						time: 10000, //10s后自动关闭
						btn: ['下载', '关闭'],
						yes: function(index){
						layer.close(index);
							fileDownload(data.id);
						}
					});
				}
			}
		}
	});
	/** 监听成员列表单元格事件 */
	table.on('tool(usersEvent)', function(obj) { //注：tool是工具条事件名，demoEvent是table原始容器的属性 lay-filter="对应的值"
		var data = obj.data; // 当前行数据
		var event = obj.event; //获得 lay-event 对应的值
		var tr = obj.tr; //获得当前行 tr 的DOM对象
		if (event === 'enter') {
			alert("测试");
		}
	});
	/** 邀请好友加入资料组 */
	$("#friend-invite").click(function(){
		layer.open({
			type: 0,
			title:"<div><input type='hidden' id='chooseParent' /><div id='choose'>文件分享</div></div>",
			area: ['640px', '480px'], //宽高
			content: '<table id="demo-table" lay-filter="friends"></table>',
			yes: function(index, layero){
				layer.load();
				var checkStatus = layui.table.checkStatus('friend-id');
				var users = new Array()
				for (var i = 0;i < checkStatus.data.length; i++) {
					users[i] = checkStatus.data[i].id;
				}
				// 邀请好友到资料组内
				$.ajax({
					type : "post",
					url : "${pageContext.request.contextPath }/invite-group-share.do",
					data : {
						users : users,
						group : nowGroup
					},
					success : function(data) {
						table.reload('users', {});
						layer.closeAll('loading');
					},
					error : function() { alert("失败"); }
				});
				layer.close(index); //如果设定了yes回调，需进行手工关闭
			}
		});
		table.render({
			elem: '#demo-table', //指定原始表格元素选择器（推荐id选择器）
			id: 'friend-id',
			url: '${pageContext.request.contextPath }/list-friend.do',
			height: 320, //容器高度
			width: 350,
			size: 'lg',
			cols: [[ //标题栏
				{field: 'id', checkbox: true},
				{field: 'name', title: '我的好友', width: 300}
			]] //设置表头
			//,…… //更多参数参考右侧目录：基本参数选项
		});
	});
	/** 将文件分享到资料组 */
	$("#file-share").click(function(){
		layer.open({
			type: 0,
			title:"<div><input type='hidden' id='chooseParent' /><div id='choose'>文件分享</div></div>",
			skin: 'layui-layer-rim', //加上边框
			area: ['480px', '320px'], //宽高
			content: '<ul id="demo"></ul>',
			yes: function(index, layero){
				layer.load();
				$.ajax({
					type : "post",
					url : "${pageContext.request.contextPath }/share-group-share.do",
					data : { file : nowFile, group : nowGroup },
					success : function(data) {
						table.reload('files', {
							url: '${pageContext.request.contextPath }/file-group-share.do',
							where: { group : nowGroup },
							done: function(){ layer.closeAll('loading'); }
						});
					},
					error : function() { alert("失败"); }
				});
				layer.close(index); //如果设定了yes回调，需进行手工关闭
			}
		});
		$.ajax({
			type : "post",
			url : "${pageContext.request.contextPath }/tree-file.do",
			success : function(data) {
				layui.tree({
					elem: '#demo', //指定元素
					skin: 'shihuang',
					nodes: data.data,
					click: function(item){ //点击节点回调
						$("#choose").text("分享："+item.name);
						nowFile = item.id;
					}
				});
			},
			error : function() { alert("失败"); }
		});
	});
	/** 转储资料组内文件 */
	$("#file-store").click(function(){
		layer.open({
			type: 0,
			title:"<div><input type='hidden' id='chooseParent' /><div id='choose'>文件转存</div></div>",
			skin: 'layui-layer-rim', //加上边框
			area: ['480px', '320px'], //宽高
			content: '<ul id="demo"></ul>',
			yes: function(index, layero){
				layer.load();
				// 获取选中数据
				var checkStatus = table.checkStatus('files');
				var files=new Array()
				for(var i = 0; i < checkStatus.data.length; i++) {
					files[i] = checkStatus.data[i].id;
				}
				$.ajax({
					type : "post",
					url : "${pageContext.request.contextPath }/store-file.do",
					data : { files : files, directory : nowDirectory },
					success : function(data) {
						table.reload('files', {
							url: '${pageContext.request.contextPath }/file-group-share.do',
							where: { group : nowGroup },
							done: function(){ layer.closeAll('loading'); }
						});
					},
					error : function() { alert("失败"); }
				});
				layer.close(index); //如果设定了yes回调，需进行手工关闭
			}
		});
		$.ajax({
			type : "post",
			url : "${pageContext.request.contextPath }/tree-directory.do",
			success : function(data) {
				layui.tree({
					elem: '#demo', //指定元素
					skin: 'shihuang',
					nodes: data.data,
					click: function(item){ //点击节点回调
						$("#choose").text("转存："+item.name);
						nowDirectory = item.id;
					}
				});
			},
			error : function() { alert("失败"); }
		});
	});
	/** 下载文件 */
	function fileDownload(fileId) {
		//定义一个form表单
		var form=$("<form>");
		form.attr("style","display:none");
		form.attr("method","post");
		form.attr("action","${pageContext.request.contextPath }/file-download.do");
		//设置参数
		var input=$("<input>");
		input.attr("type","hidden");
		input.attr("name","fileId");
		input.attr("value",fileId);
		$("body").append(form);//将表单放置在web中
		form.append(input);
		form.submit();//表单提交
	}
});
$(window).resize(function(){
	var height = $(window).height();
	var width = $(window).width();
	if(width < 1200) {
		alert(width);
	}
})
</script>