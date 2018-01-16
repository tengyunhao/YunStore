<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="layui-row">
	<div class="layui-col-xs12 layui-col-sm12 layui-col-md12">
		<button id="upload-file" class="layui-btn layui-btn-normal">文件上传</button>
		<button id="add-directory" class="layui-btn layui-btn-primary">新建文件夹</button>
		<button id="download-file" class="layui-btn layui-hide">文件下载</button>
	</div>
</div>
<div class="layui-row">
	<div class="layui-col-xs12 layui-col-sm12 layui-col-md12" style="margin: 8px 3px;">
        <a id="0" href="#" class="path active"><cite>全部文件</cite></a>
		<span class="layui-breadcrumb" id="path">
		</span>
	</div>
	<div>
		<table id="files" lay-filter="filesEvent"></table>
	</div>
	<form id="download-form" style="display:none" action="${pageContext.request.contextPath }/file-download.do">
		<input id="download-input" style="display:none" name="fileId"/>
	</form>
    <form id="download-form-multifile" style="display:none" action="${pageContext.request.contextPath }/multifile-download.do">
    </form>
</div>
<script type="text/html" id="fileType">
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
<script type="text/html" id="barDemo">
	<div class="layui-btn-group">
		<button class="layui-btn layui-btn-small layui-btn-primary" lay-event="edit"><i class="layui-icon">&#xe642;</i></button>
		<button class="layui-btn layui-btn-small layui-btn-primary" lay-event="remove"><i class="layui-icon">&#xe621;</i></button>
		<button class="layui-btn layui-btn-small layui-btn-primary" lay-event="del"><i class="layui-icon">&#xe640;</i></button>
	</div>
</script>
<%--<script src="res/lay/modules/element.js"></script>--%>
<script src="res/lay/modules/table.js"></script>
<script src="res/lay/modules/tree.js"></script>
<script src="res/lay/modules/laytpl.js"></script>
<script>
var reloadTable,backDirectory;
layui.use(['table','element'], function() {
	var table = layui.table;
    var element = layui.element;
	var url = window.location.href;
	<%--var parent = "";// 获取当前目录的id--%>
    var parent = url.substring(url.lastIndexOf("file/list.do")+"file/list.do#".length);
	var parentName = ""
	var h = 0; // 目录深度
	table.on('checkbox(filesEvent)', function(obj){
		var checkStatus = table.checkStatus('idTest');
		if(checkStatus.data.length != 0) {
			$("#download-file").removeClass("layui-hide");
		} else {
			$("#download-file").addClass("layui-hide");
		}
	});
	reloadTable = function() {
		table.reload('idTest', {where: {directory : parent},done: function(){ }});
	}
	/** 初始化文件列表 */
	table.render({
		id: 'idTest',
		elem: '#files',
		height: 640,
		width: 1250,
		skin: 'line',
		size:'lg',
		url: '${pageContext.request.contextPath }/look-directory.do', //数据接口
        where: {
            directory : parent
        },
		cols: [[
			{field:'id', checkbox: true},
			{field:'name', title: '文件', width:500, event: 'enter', style:'cursor: pointer;', sort: true, templet: '#fileType'},
			{field:'size', title: '大小', width:200},
			{field:'time', title: '修改日期', width:250, sort: true},
			{field:'operator', title: '操作', width:250, toolbar: '#barDemo'}
		]]
	});
	/** 回到根目录 */
	$("#0").click(function() {
		directoryBack(0, '', '全部文件');
	});
	/** 点击文件导航（后退） */
	function directoryBack(click, id, name) {
		$("#download-file").addClass("layui-hide"); // 移除下载文件按钮
		// 如果点击的就是当前目录，则不需要处理
		if(click == h) return;
		h = click; parent = id; parentName = name;
		// 刷新文件表格
		table.reload('idTest', {where: {directory : id},done: function(){ window.location.href = url + ('#'+id); }});
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
		$("#download-file").addClass("layui-hide"); // 移除下载文件按钮
		h++; parent = id; parentName = name;
		// 刷新文件表格
		table.reload('idTest', {where: {directory : id},done: function(){ window.location.href = url + ('#'+id); }});
		<%--// 让上层目录的路径可点击--%>
		<%--$("#path").children("a").each(function(){--%>
			<%--if($(this).attr("class").indexOf("active") != -1) {--%>
				<%--$(this).removeClass('active');--%>
				<%--$(this).html($(this).text()+"<span class='layui-box'>&gt;</span>");--%>
			<%--}--%>
		<%--});--%>
		<%--// 添加当前所在目录（第h层）的路径--%>
		<%--$("#path").append("<a id='"+h+"' href='#' class='path active'><cite>"+name+"</cite></a>");--%>
		<%--// 添加当前所在目录（第h层）路径的点击事件--%>
		<%--$('#'+h).click(function() {--%>
			<%--directoryBack($(this).attr("id"), id, name);--%>
		<%--});--%>

	}
    backDirectory = function(id) {
        generateDirectory(id);
        table.reload('idTest', {where: {directory : id},done: function(){ window.location.href = url + ('#'+id); }});
    }
    generateDirectory(parent);
    /** 生成文件目录 */
    function generateDirectory (id) {
        $.post("${pageContext.request.contextPath }/get-directory.do",{
            directory : id,
        },function(result){
            $("#path").html("");
            for(var i = result.data.length-1; i >= 0; i--) {
                var line = result.data[i];
                if(i == 0) {
                    $("#path").append("<a href='#' class='path active'><cite>"+line.name+"</cite></a>");
                } else {
                    $("#path").append("<a href='#file/list.do#"+line.id+"' onclick='backDirectory(\""+line.id+"\")' class='path'>"+line.name+"<span class='layui-box'>&gt;</span></a>");
                }
            }
            element.render('breadcrumb');
        });
        // 添加当前所在目录（第h层）的路径
    }
	/** 监听表格事件 */
	table.on('tool(filesEvent)', function(obj) { //注：tool是工具条事件名，filesEvent lay-filter="对应的值"
		var data = obj.data; // 当前行数据
		var event = obj.event; //获得 lay-event 对应的值
		var tr = obj.tr; //获得当前行 tr 的DOM对象
		if (event === 'enter') { // 点击文件
			if(data.type === '-') { // 如果是文件夹
				directoryEnter(data.id, data.name);
                generateDirectory(data.id);
			} else { // 如果是文件
				if(data.type === 'doc' || data.type === 'docx'
				|| data.type === 'ppt' || data.type === 'pptx'
				|| data.type === 'xls' || data.type === 'xlsx'
				|| data.type === 'pdf') { // 可以预览
					$.getJSON('file-preview.do?file='+data.id, function(json){
						layer.photos({
							photos: json,
							anim: 5 //0-6的选择，指定弹出图片动画类型，默认随机
						});
					});
				} else if (data.type === 'mp4') {
					window.open("${pageContext.request.contextPath }/video.do?video="+data.id);
				} else if (data.type === 'mp3') {
					window.open("${pageContext.request.contextPath }/music.do?music="+data.id);
				}
			}
		} else if (event === 'remove') { //移动
			// 加载目录树
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
			layer.open({
				type: 0,
				title:"<div><input type='hidden' id='chooseParent' /><div id='choose'>文件移动到</div></div>",
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
							table.reload('idTest', {// 刷新目录
								where: {directory : parent},
								done: function(){
									layer.closeAll('loading'); // 刷新完成关闭遮盖层
								}
							});
						},
						error : function() { alert("失败"); }
					});
					layer.close(index); //如果设定了yes回调，需进行手工关闭
				}
			});
		} else if (event === 'del') { //删除
			layer.confirm('真的要删除"'+data.name+'"吗？', function(index) {
				layer.load();
				$.ajax({
					type : "post",
					url : "${pageContext.request.contextPath }/file-delete.do",
					data : {
						id : data.id
					},
					success : function(data) {
						layer.close(index);
						table.reload('idTest', { done: function(){ layer.closeAll('loading'); } });
					},
					error : function() { alert("失败"); }
				});
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
					error : function() { alert("失败"); }

				});
			});
		}
	});
	/** 新建文件夹 */
	$("#add-directory").click(function() {
		layer.prompt({
			formType : 0,
			title : '新建文件夹',
			value : '未命名文件夹'
		}, function(value, index) {
			layer.close(index);
			layer.load();
			$.ajax({
				type : "post",
				url : "${pageContext.request.contextPath }/add-directory.do",
				data : {
					name : value,
					parent : parent
				},
				success : function(data) {
					table.reload('idTest', { done: function(){ layer.closeAll('loading'); } });
				},
				error : function() { alert("失败");}
			});
		});
	});
	/** 上传文件 */
	$("#upload-file").click(function() {
		layer.open({
			type: 2,//此处以iframe举例
			title: '文件上传',
			area: ['960px', '640px'],
			shade: 0,
			maxmin: true,
			offset: [100,240],
			content: '${pageContext.request.contextPath }/file/upload.do?name='+parentName+'&id='+parent
		});
		<%--layer.open({--%>
			<%--type: 2,--%>
			<%--title: false,--%>
			<%--area: ['630px', '360px'],--%>
			<%--shade: 0.8,--%>
			<%--closeBtn: 0,--%>
			<%--shadeClose: true,--%>
			<%--content: 'http://localhost:8080/YunStore/video.jsp'--%>
		<%--});--%>
	});
	/** 下载文件 */
	$("#download-file").click(function(){

		var data = table.checkStatus('idTest').data;

		if(data.length > 1) {
            var multifile = new Array();
            for(var i = 0; i < data.length; i++) {
                multifile[i] = data[i].id;
            }
            multifileDownload(multifile);
        } else {
            fileDownload(data[0].id);
        }

	});
	function fileDownload(fileId) {
		$("#download-input").val(fileId);
		$("#download-form").submit();
	}
    function multifileDownload(multifile) {
        for(var i = 0; i < multifile.length; i++) {
            $("#download-form-multifile").append("<input name='fileIds' value='"+multifile[i]+"'>");
        }
        $("#download-form-multifile").submit();
    }
});
</script>