<%@page import="com.yunstore.model.ProgressBar"%>
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
<link rel="stylesheet" href="../res/css/layui.css">
<link rel="stylesheet" href="../res/css/layui.my.css">
<link rel="stylesheet" href="../res/css/modules/code.css" id="layuicss-skincodecss" media="all">
<link rel="stylesheet" href="../res/css/modules/layer/default/layer.css" id="layuicss-layer" media="all">
</head>
<body style="margin: 10px;">
	<div class="layui-row">
		<div class="layui-upload">
			<button type="button" class="layui-btn layui-btn-normal" id="testList">选择文件</button>
			<button type="button" class="layui-btn" id="testListAction">开始上传</button>
			<input class="layui-upload-file" type="file" name="file" multiple="">
			<div class="layui-upload-list">
				<table class="layui-table">
					<thead>
						<tr>
							<th style="width: 150px">文件名</th>
							<th style="width: 200px">上传位置</th>
							<th style="width: 100px">大小</th>
							<th style="width: 100px">状态</th>
							<th style="width: 150px">操作</th>
						</tr>
					</thead>
					<tbody id="demoList"></tbody>
				</table>
			</div>
		</div>
	</div>

	<script src="../res/jquery.min.js"></script>
	<script src="../res/layui.js"></script>
	<script src="../res/lay/modules/table.js"></script>
	<script src="../res/lay/modules/laytpl.js"></script>
	<script src="../res/lay/modules/tree.js"></script>
	<script src="../res/lay/modules/element.js"></script>
	<script src="../res/lay/modules/upload.js"></script>

	<script>
	//JavaScript代码区域
	$('#nav-file').addClass("layui-nav-itemed");
	$('#nav-file-upload').addClass("layui-this");
	</script>
	<script>
	layui.use(['upload','table'], function(){
	  var $ = layui.jquery;
	  var upload = layui.upload;
	  var table = layui.table;
	  //定时器
	  var timer;
        var files;
	  //多文件列表示例
	  var demoListView = $('#demoList'),
	  uploadListIns = upload.render({
		elem: '#testList',
		url: '${pageContext.request.contextPath }/file-upload.do',
		accept: 'file',
		multiple: true,
		auto: false,
		bindAction: '#testListAction',
		choose: function(obj){
          files = obj.pushFile(); //将每次选择的文件追加到文件队列
		  //读取本地文件
		  obj.preview(function(index, file, result){
			var tr = $(['<tr id="upload-'+ index +'">'
			  ,'<td>'+ file.name +'</td>'
			  ,'<td class="directory"><input type="hidden" id="directory-'+index+'"><label id="directory-name-'+index+'">/<label></td>'
			  ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
			  ,'<td><progress id="progressBar-'+ index +'" value="0" max="100" style="width: 100%;height: 20px; "></progress></td>'
			  ,'<td>'
				,'<button class="layui-btn layui-btn-mini reload layui-hide">重传</button>'
				,'<button class="layui-btn layui-btn-mini layui-btn-danger delete">删除</button>'
			  ,'</td>'
			,'</tr>'].join(''));

			//选择目录
			tr.find('.directory').on('click', function(){
				layer.open({
					type: 0,
					title:"<div><input type='hidden' id='directory-choose' /><input type='hidden' id='directory-name'><div id='choose'>选择上传目录</div></div>",
					skin: 'layui-layer-rim', //加上边框
					area: ['480px', '320px'], //宽高
					content: '<ul id="demo"></ul>',
					yes: function(directory, layero){
						$("#directory-name-"+index).text($("#directory-name").val());
						$("#directory-"+index).val($("#directory-choose").val());
						layer.close(directory); //如果设定了yes回调，需进行手工关闭
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
								$("#choose").text("已选择目录："+item.name);
								$("#directory-choose").val(item.id);
								$("#directory-name").val(item.name);
							}
						});
					},
					error : function() { alert("失败"); }
				});
			});

			//单个重传
			tr.find('.reload').on('click', function(){
			  obj.upload(index, file);
			});

			//删除
			tr.find('.delete').on('click', function(){
			  delete files[index]; //删除对应的文件
			  tr.remove();
			});

			demoListView.append(tr);
			$("#directory-name-"+index).text(getName());
			$("#directory-"+index).val(getId());
		  });
		},
		before: function(obj){ //obj参数包含的信息，跟 choose回调完全一致，可参见上文。
		},
		done: function(res, index, upload){
			  /* window.clearTimeout(timer); */
		  if(res.status == 200){ //上传成功
            delete files[index]; //删除对应的文件
			parent.reloadTable(); // 刷新表格
			var tds = demoListView.find('tr#upload-'+ index).children(); // 获取进度条
            tds.eq(3).html('<span style="color: #5FB878;">已上传，解析中</span>');
            tds.eq(4).html(''); //清空操作
            $.get("${pageContext.request.contextPath }/file/analysis.do", {
                file : res.data
            }, function(data){
				if(data.status == 200) {
					tds.eq(3).html('<span style="color: #5FB878;">文件解析成功</span>');
				} else {
					tds.eq(3).html('<span style="color: #5FB878;">文件解析失败</span>');
				}
                <%--delete files[index]; //删除文件队列已经上传成功的文件--%>
            });
		  }
		  this.error(fileIndex, upload);
		}
		,error: function(index, upload){
		  var tr = demoListView.find('tr#upload-'+ index)
		  ,tds = tr.children();
		  tds.eq(3).html('<span style="color: #FF5722;">上传失败</span>');
		  tds.eq(4).find('.reload').removeClass('layui-hide'); //显示重传
		}
	  });
	});
	// 获取参数
	function getName() {
		<%--var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");--%>
		<%--var r = window.location.search.substr(1).match(reg);--%>
		<%--if(r!=null)return  unescape(r[2]); return null;--%>
		var urlinfo = window.location.href;//获取url
		var param = urlinfo.split("?")[1].split("&")[0].split("=")[1];//拆分url得到”=”后面的参数
		return decodeURI(param);
	}
	function getId() {
		var urlinfo = window.location.href;//获取url
		var param = urlinfo.split("?")[1].split("&")[1].split("=")[1];//拆分url得到”=”后面的参数
		return decodeURI(param);
	}
	</script>
</body>
</html>