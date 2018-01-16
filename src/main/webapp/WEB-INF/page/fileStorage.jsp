<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">
.layui-row {margin:15px}
</style>

	<div id="ces"></div>
<div class="layui-container">
	<div class="layui-row">
		<div class="layui-col-xs10 layui-col-sm10 layui-col-md10">
			<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
				<legend>硬盘空间管理</legend>
			</fieldset>
		</div>
		<div class="layui-col-xs2 layui-col-sm2 layui-col-md2">
			<div class="layui-btn-group"style="margin-left: 35px;">
				<button id="show-type" class="layui-btn layui-btn-sm layui-btn-primary"><i class="layui-icon" style="font-size: 22px;">&#xe629;</i></button>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-xs1 layui-col-sm1 layui-col-md1">
			<div class="layui-row">
				<div style="float:right">硬盘空间</div>
			</div>
		</div>
		<div class="layui-col-xs10 layui-col-sm10 layui-col-md10">
			<div class="layui-row">
				<div class="layui-progress layui-progress-big" lay-showPercent="true">
					<div class="layui-progress-bar layui-bg-blue" lay-percent="${storage.percent}%"></div>
				</div>
			</div>
			<div class="layui-row">
				<div>剩余 ${storage.surplus} 可用（共 ${storage.total}）</div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-xs6 layui-col-sm6 layui-col-md6">
			<c:forEach items="${storage.list}" var="line">
			<div class="layui-row">
				<div class="layui-col-xs2 layui-col-sm2 layui-col-md2">
					<div class="layui-row">
						<div style="float:right">${line.type}</div>
					</div>
				</div>
				<div class="layui-col-xs9 layui-col-sm9 layui-col-md9">
					<div class="layui-row">
						<div class="layui-progress" lay-showPercent="true">
							<div class="layui-progress-bar layui-bg-orange" lay-percent="${line.used}%"></div>
						</div>
					</div>
					<div class="layui-row">
						<div>已使用 ${line.size}</div>
					</div>
				</div>
			</div>
			</c:forEach>
		</div>
		<div class="layui-col-xs4 layui-col-sm4 layui-col-md4">
			<div class="layui-row">
				<canvas id="myChart" width="180px" height="180px"></canvas>
			</div>
			<div class="layui-row" style="text-align:center">
				<lable>文件使用情况</lable>
			</div>
		</div>
	</div>
</div>

<script src="res/js/Chart.js"></script>
<script type="text/javascript">
// 设置参数
var data = {
	labels: ${storage.pie.labels},
	datasets: ${storage.pie.datasets}
};
//Get context with jQuery - using jQuery's .get() method.
var ctx = $("#myChart").get(0).getContext("2d");
//This will get the first returned node in the jQuery collection.
var myBarChart = new Chart(ctx, {type: 'pie',data: data});

layui.use(['form'], function() {
	var form = layui.form;
	$("#show-type").click(function() {
		layer.open({
			type: 1,
			title:'选择你要显示的类型',
			area: ['300px', '500px'], //宽高
			content: '<form class="layui-form" action="">'
						+'<div class="layui-form-item">'
						+'<ul id="typeList" class="layui-input-block">'
						+'</ul>'
						+'</div>'
					+'</form>'
		});
		$.ajax({
			type : "post",
			url : "${pageContext.request.contextPath }/file/storage/show.do",
			success : function(data) {
				for(var i = 0; i < data.length; i++) {
					if(data[i].show === 'yes') {
						$("#typeList").append('<li><input type="checkbox" name="like[write]" title="'+data[i].type+'" checked=""></li>');
					} else {
						$("#typeList").append('<li><input type="checkbox" name="like[write]" title="'+data[i].type+'"></li>');
					}

				}
				form.render();
			},
			error : function() { alert("失败"); }
		});
	});
});

</script>

