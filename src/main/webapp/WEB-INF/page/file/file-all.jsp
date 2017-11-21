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
<link rel="stylesheet" href="res/css/modules/code.css" id="layuicss-skincodecss" media="all">
<link rel="stylesheet" href="res/css/modules/layer/default/layer.css" id="layuicss-layer" media="all">
<style type="text/css">
.layui-table-hover {
	
}
</style>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">

		<%@include file="../../module/header.jsp"%>
		<%@include file="../../module/navigation.jsp"%>

		<div class="layui-body" style="margin: 10px;">
			<div class="layui-row">
				<!-- 移动：6/12 | 平板：6/12 | 桌面：4/12 -->
				<div class="layui-col-xs12 layui-col-sm12 layui-col-md12">
					<button id="upload-file" class="layui-btn layui-btn-normal">文件上传</button>
					<button id="add-directory" class="layui-btn layui-btn-primary">新建文件夹</button>
				</div>
			</div>
			<div class="layui-row">
				<div class="layui-col-xs12 layui-col-sm12 layui-col-md12" style="margin: 8px 3px;">		
					<span class="layui-breadcrumb" id="path">
						<a id="0" href="#" class="path active"><cite>全部文件</cite></a>
					</span>
				</div>
				<div>
					<!-- 内容主体区域 -->
					<table class="layui-table" lay-data="{id: 'idTest', width:1200, skin:'line', size:'lg', height:680, url:'${pageContext.request.contextPath }/look-directory.do'}" lay-filter="demoEvent">
						<thead>
							<tr>
								<!-- <th lay-data="{field:'id', checkbox: true}"></th> -->
								<th lay-data="{field:'name', width:500, event: 'enter', style:'cursor: pointer;', sort: true, templet: '#usernameTpl'}">文件</th>
								<th lay-data="{field:'type', width:200}">类型</th>
								<th lay-data="{field:'time', width:250, sort: true}">修改日期</th>
								<th lay-data="{field:'operator', width:250, toolbar: '#barDemo'}">操作</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
		<script type="text/html" id="usernameTpl">
			{{#  if(d.type === '-'){ }}
			<i class="layui-icon" style="float:left; font-size: 26px; color: #EDCA50;">&#xe622;</i>
			<div style="float:left"><lable>&nbsp&nbsp{{ d.name }}</lable></div>
			{{#  } else { }}
			<i class="layui-icon" style="float:left; font-size: 28px; color: #EDCA50;">&#xe621;</i>
			<div style="float:left"><lable>&nbsp&nbsp{{ d.name }}</lable></div>
			{{#  } }}
		</script>
		<script type="text/html" id="barDemo">
			<div class="layui-btn-group">
				<button class="layui-btn layui-btn-small layui-btn-primary" lay-event="edit"><i class="layui-icon">&#xe642;</i></button>
				<button class="layui-btn layui-btn-small layui-btn-primary" lay-event="remove"><i class="layui-icon">&#xe621;</i></button>
				<button class="layui-btn layui-btn-small layui-btn-primary" lay-event="del"><i class="layui-icon">&#xe640;</i></button>
			</div>
		</script>
		<div class="layui-footer">
			<!-- 底部固定区域 -->
			© layui.com - 底部固定区域
		</div>
	</div>
	<script src="res/jquery.min.js"/></script>
	<script src="res/layui.js"></script>
	<script src="res/lay/modules/table.js"></script>
	<script src="res/lay/modules/laytpl.js"></script>
	<script src="res/lay/modules/tree.js"></script>
	<script src="res/lay/modules/element.js"></script>
	
	<script>
	//JavaScript代码区域
	$('#nav-file').addClass("layui-nav-itemed");
	$('#nav-file-all').addClass("layui-this");

	// 获取当前目录的id
	var parent = "";
	layui.use('table', function() {
		var table = layui.table;
		var h = 0; // 目录深度
		// 点击根目录路径的绑定事件
		$("#0").click(function() {
			if(h == 0) {
				return;
			}
			h = 0;
			parent = "";
			// 回到根目录后，移除其他目录路径
			$("#path").children("a").each(function(){
				if($(this).attr("id") != '0') {
					$(this).remove();
				} else {
					$(this).addClass('active');
					$(this).html("<cite>全部文件</cite>");
				}
			});
			// 获取根目录的文件信息，并刷新表格
			table.reload('idTest', {
				url: '${pageContext.request.contextPath }/look-directory.do',
				where: {
					parent : ""
				}
			});
		});
		//监听单元格事件
		table.on('tool(demoEvent)', function(obj) { //注：tool是工具条事件名，demoEvent是table原始容器的属性 lay-filter="对应的值"
			var data = obj.data; // 当前行数据
			var event = obj.event; //获得 lay-event 对应的值
			var tr = obj.tr; //获得当前行 tr 的DOM对象
			if (event === 'enter') {
				h++;
				parent = data.id;
				table.reload('idTest', {
					url: '${pageContext.request.contextPath }/look-directory.do',
					where: {
						directory : data.id
					}
				});
				// 让上层目录的路径可点击
				$("#path").children("a").each(function(){
					if($(this).attr("class").indexOf("active") != -1) {
						$(this).removeClass('active');
						$(this).html($(this).text()+"<span class='layui-box'>&gt;</span>");
					}
				});
				// 添加第h层目录路径，但不可点击
				$("#path").append("<a id='"+h+"' href='#' class='path active'><cite>"+data.name+"</cite></a>");
				// 点击第h层目录路径时的绑定事件
				$('#'+h).click(function() {
					if($(this).attr("id") == h) {
						return;
					}
					// 获取当前点击的是第几层
					h = $(this).attr("id");
					// 移除第h层之后其他目录路径
					$("#path").children("a").each(function(){
						var n = parseInt($(this).attr("id"));
						if(n > h) {
							$(this).remove();
						} else if (n == h) {
							$(this).addClass('active');
							$(this).html("<cite>"+data.name+"</cite>");
						}
					});
					parent = data.id;
					// 获取第h层目录信息，刷新表格
					table.reload('idTest', {
						url: '${pageContext.request.contextPath }/look-directory.do',
						where: {
							directory : data.id
						}
					});
				});
				//同步更新缓存对应的值
				obj.update({
					username : '123',
					title : 'xxx'
				});
			}
			if (event === 'remove') { //移动
				layer.open({
					type: 0,
					title:"<div><input type='hidden' id='chooseParent' /><div id='choose'>文件移动到</div></div>",
					skin: 'layui-layer-rim', //加上边框
					area: ['480px', '320px'], //宽高
					content: '<ul id="demo"></ul>',
					yes: function(index, layero){
						layer.load();
						$.ajax({
							type : "post",
							url : "${pageContext.request.contextPath }/remove-directory.do",
							data : {
								id : data.id,
								parent : $("#chooseParent").val()
							},
							success : function(data) {
								table.reload('idTest', {
									url: '${pageContext.request.contextPath }/look-directory.do',
									where: {
										directory : parent
									}
								});
								layer.closeAll('loading');
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
								$("#choose").text("文件移动到："+item.name);
								$("#chooseParent").val(item.id);
						    }
						});
					},
					error : function() { alert("失败"); }
				});
			} else if (event === 'del') { //删除
				layer.confirm('真的删除行么', function(index) {
					obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
					layer.close(index);
					//向服务端发送删除指令
				});
			} else if (event === 'edit') { //编辑

				layer.prompt({
					formType : 0,
					title : '修改文件名称',
					value : data.name
				}, function(value, index) {
					layer.close(index);
					layer.load();
					$.ajax({
						type : "post",
						url : "${pageContext.request.contextPath }/update-directory.do",
						data : {
							id : data.id,
							name : value
						},
						success : function(data) {
							//同步更新表格和缓存对应的值
							obj.update({
								name : value
							});
							layer.closeAll('loading');
						},
						error : function() {
							alert("失败");
						}

					});
				});
			}
		});
	});
	$("#add-directory").click(function() {
		layer.load();
		$.ajax({
			type : "post",
			url : "${pageContext.request.contextPath }/add-directory.do",
			data : {
				name : '新建文件夹',
				parent : parent
			},
			success : function(data) {
				layui.use('table', function() {
					var table = layui.table;
					table.reload('idTest', {});
				});
				setTimeout(function(){
					layer.closeAll('loading');
				}, 500);
			},
			error : function() {
			}

		});
	});
	$("#upload-file").click(function() {
		layer.open({
			  type: 1,
			  skin: 'layui-layer-rim', //加上边框
			  area: ['640px', '480px'], //宽高
			  content: 'html内容'
		});
	});
	</script>
</body>
</html>