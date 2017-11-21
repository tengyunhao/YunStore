<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
    <title>卫生后台管理</title>
    <meta name="description" content="这是一个 index 页面">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="icon" type="image/png" href="../../assets/i/favicon.png">
    <link rel="apple-touch-icon-precomposed" href="../../assets/i/app-icon72x72@2x.png">
    <link rel="stylesheet" href="../../assets/css/amazeui.min.css" />
    <link rel="stylesheet" href="../../assets/css/admin.css">
    <link rel="stylesheet" href="../../assets/css/app.css">
</head>
<body data-type="index">
    
	<%@include file="../common/header.jsp" %>

    <div class="tpl-page-container tpl-page-header-fixed">
        <%@include file="../common/menu.jsp" %>
        
        <div class="tpl-content-wrapper">
            <ol class="am-breadcrumb">
                <li><a href="#" class="am-icon-home">首页</a></li>
                <li><a href="#">检查</a></li>
                <li class="am-active">模板列表</li>
            </ol>
            <div class="tpl-portlet-components">
                <div class="portlet-title">
                    <div class="caption font-green bold">
                        <span class="am-icon-code"></span> 模板列表
                    </div>
                </div>
                <div class="tpl-block">
                    <div class="am-g">
                        <div class="am-u-sm-12 am-u-md-6">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <button onclick="window.location.href='model-add.jsp'" type="button" class="am-btn am-btn-default am-btn-success"><span class="am-icon-plus"></span> 新增</button>  
                                    <button id="model-delete" type="button" class="am-btn am-btn-default am-btn-secondary"><span class="am-icon-archive"></span> 删除</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="am-g">
                        <div class="am-u-sm-12">
                            <form class="am-form">
                                <table class="am-table am-table-striped am-table-hover table-main">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; min-width: 20px"></th>
                                            <th style="width: 8%; min-width: 30px" class="am-hide-sm-only">ID</th>
                                            <th style="width: 26%; min-width: 150px">名称</th>
                                            <th style="width: 26%; min-width: 100px">宿舍类型</th>
                                            <th style="width: 10%; min-width: 30px" class="am-hide-sm-only">扣分项</th>
                                            <th style="width: 25%; min-width: 80px" class="table-set">操作</th>
                                        </tr>
                                    </thead>
                                    <tbody id="model-list">
                                    </tbody>
                                </table>
                                <hr>
                            </form>
                        </div>

                    </div>
                </div>
                <div class="tpl-alert"></div>
            </div>

        </div>
        
        
	</div>

	<div class="am-modal am-modal-no-btn" tabindex="-1" id="modal-model-detail">
		<div class="am-modal-dialog">
			<div class="am-modal-hd">
				区域扣分项 <a href="javascript: void(0)" class="am-close am-close-spin"
					data-am-modal-close>&times;</a>
			</div>
			<div class="am-modal-bd">
				<div id="wrapper-item" class="wrapper">
					<div id="" class="scroller">
						<table class="am-table am-table-striped am-table-hover table-main">
							<thead>
								<tr>
									<th style="width: 25%; min-width: 100px">所属区域</th>
									<th style="width: 25%; min-width: 100px">项目名称</th>
									<th style="width: 15%; min-width: 30px">分值</th>
									<th style="width: 15%; min-width: 30px">德育</th>
									<th style="width: 20%; min-width: 150px" class="table-set">操作</th>
								</tr>
							</thead>
							<tbody id="item-list">
							</tbody>
						</table>

					</div>
				</div>
				<br>
				<form class="am-form am-form-horizontal">
					<div class="am-form-group">
						<div class="am-u-sm-3">
							<input type="text" id="name" placeholder="输入扣分项名称">
						</div>
						<div class="am-u-sm-3">
							<select id="region">
							</select>
						</div>
						<div class="am-u-sm-2">
							<input type="text" id="grade" placeholder="分值">
						</div>
						<div class="am-u-sm-2">
							<input type="text" id="quality" placeholder="德育">
						</div>
						<div class="am-u-sm-2">
							<button id="model-item-add" type="button" class="am-btn am-btn-primary">添加扣分项</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="am-modal am-modal-no-btn" tabindex="-1" id="modal-model-update">
		<div class="am-modal-dialog">
			<div class="am-modal-hd">模版信息修改<a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a></div>
			<div class="am-modal-bd">
	            <form class="am-form am-form-horizontal">
	                <div class="am-form-group">
	                    <label for="user-name" class="am-u-sm-2 am-form-label">名称</label>
	                    <div class="am-u-sm-10">
	                        <input type="text" id="update-name">
	                    </div>
	                </div>
	                <div class="am-form-group">
	                    <label for="user-intro" class="am-u-sm-2 am-form-label">类型</label>
	                    <div class="am-u-sm-10">
	                        <select id="update-type">
	                        </select>
	                    </div>
	                </div>
	                <div class="am-form-group">
	                    <div class="am-u-sm-6 am-u-sm-push-3">
	                        <button id="model-update" type="button" class="am-btn am-btn-primary">保存修改</button>
	                    </div>
	                </div>
	            </form>
			</div>
		</div>
	</div>
	
	<script src="../../assets/js/jquery.min.js"/></script>
    <script src="../../assets/js/amazeui.min.js"/></script>
    <script src="../../assets/js/iscroll.js"/></script>
    <script src="../../assets/js/app.js"/></script>
    <script type="text/javascript">

	$('#nav-model').addClass("active");
	$('#nav-model-ul').css('display','block');
	$('#nav-model-list').addClass("active");

	var modelId;
	function update(model,name) {
		modelId = model;
		
		$('#update-name').val(name);
		
        /*类型下拉框列表*/
        $.ajax({
        	type:"post",
        	url:"${pageContext.request.contextPath }/dormitory_type.action",
        	success:function(data){
        		var rows = data.rows;
        		for (var i = 0; i < rows.length; i++) {
        			var row = rows[i];
        			var $row = $("<option value="+ row.id +">"
        							+ row.name
        					   + "</option>");
        			$("#update-type").append($row);
        		}
        	},
        	error:function(){
        	}

        });
    }
    function detail(model) {
    	modelId = model;
    	$.ajax({
    		type : "get",
    		url : "${pageContext.request.contextPath }/model_detail.action",
    		data : {
    			model : model
    		},
    		success : function(data) {
				$("#item-list").html("");
    			for (let row of data.regionItemModels) {
					var $row = $("<tr>"
									+ "<td><a href='#'>" + row.regionName + "</a></td>"
									+ "<td>" + row.name + "</td>"
									+ "<td class='am-hide-sm-only'>" + row.grade + "</td>"
									+ "<td class='am-hide-sm-only'>" + row.quality + "</td>"
									+ "<td>"
										+ "<div class=''>"
											+ "<div class='am-btn-group am-btn-group-xs'>"
												+ "<button onclick='itemDelete("+row.id+")' class='am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only'><span class='am-icon-trash-o'></span> 删除</button>"
											+ "</div>" 
										+ "</div>" 
									+ "</td>"
							   + "</tr>");
					$("#item-list").append($row);
    			}

    			for (var i = 0; i < data.dormitoryRegionModels.length; i++) {
    				var row = data.dormitoryRegionModels[i];
    				var $row = $("<option value="+ row.id +">"
    								+ row.name
    						   + "</option>");
    				$("#region").append($row);
    			}
    			new IScroll('#wrapper-item', {
    	            scrollbars: true,
    	            mouseWheel: true,
    	            interactiveScrollbars: true,
    	            shrinkScrollbars: 'scale',
    	            preventDefault: false,
    	            fadeScrollbars: true
    	        });
    		},
    		error : function() {
    			alert("error");
    		}

    	});
	}
    loadModelList();
    function loadModelList() {		
    	$.ajax({
    		url : "${pageContext.request.contextPath }/model_query.action",
    		type : "GET",
    		dataType : "json",
    		success : function(data) {
				$("#model-list").html("");
    			var rows = data.rows;
    			for (var i = 0; i < rows.length; i++) {
    				var row = rows[i];
    				var $row = $("<tr>"
    								+ "<td><input class='model-select' type='checkbox' value=" + row.id + "></td>"
    								+ "<td class='am-hide-sm-only'>" + row.id + "</td>"
    								+ "<td><a href='#'>" + row.name + "</a></td>"
    								+ "<td>" + row.dormitoryTypeName + "</td>"
    								+ "<td class='am-hide-sm-only'>"+ row.regionItemCount + "</td>"
    								+ "<td>"
    									+ "<div class=''>"
    										+ "<div class='am-btn-group am-btn-group-xs'>"
    											+ "<button onclick='update("+row.id+",\""+row.name+"\")' type='button' class='am-btn am-btn-default am-btn-xs am-text-secondary' data-am-modal=\"{target: '#modal-model-update', closeViaDimmer: 0, width: 395, height: 240}\"><span class='am-icon-pencil-square-o'></span> 编辑</button>"
    											+ "<button onclick='detail("+row.id+")' type='button' class='am-btn am-btn-default am-btn-xs am-hide-sm-only' data-am-modal=\"{target: '#modal-model-detail', closeViaDimmer: 0, width: 800, height: 520}\"><span class='am-icon-copy'></span> 扣分项</button>"
    										+ "</div>" 
    									+ "</div>" 
    								+ "</td>"
    							+ "</tr>");
    				$("#model-list").append($row);
    			}
    		},
    		error : function() {
    			alert("error");
    		}
    	}); 	
	}
 	// 修改模型
    $("#model-update").click(function() {
    	$.ajax({
        	type:"post",
        	url:"${pageContext.request.contextPath }/model_update.action",
        	data:{
        		model:modelId,
    			name:$('#update-name').val(),
    			type:$('#update-type').val()
        	},
        	success:function(data){
        		window.location.href="${pageContext.request.contextPath }/jsp/other/model-list.jsp";
    		},
        	error:function(){}
        });
    });
    // 删除模型
    $("#model-delete").click(function(){
    	$(".model-select").each(function() {
    		if(this.checked) {
    			$.ajax({
    	        	type:"post",
    	        	url:"${pageContext.request.contextPath }/model_delete.action",
    	        	data:{
    	        		model:$(this).val()
    	        	},
    	        	success:function(data){
    	        		loadModelList();
    	    		},
    	        	error:function(){}
    	        });
    		}
		});
	});
    // 添加扣分项
    $("#model-item-add").click(function(){
    	$.ajax({
        	type:"post",
        	url:"${pageContext.request.contextPath }/model_addItem.action",
        	data:{
        		name:$("#name").val(),
        		regionId:$("#region").val(),
        		grade:$("#grade").val(),
        		quality:$("#quality").val(),
        		model:modelId
        	},
        	success:function(data){
        		detail(modelId);
        	},
        	error:function(){}
        });
	});
    // 删除扣分项
    function itemDelete(itemId) {
    	$.ajax({
        	type:"post",
        	url:"${pageContext.request.contextPath }/model_deleteItem.action",
        	data:{
        		itemId:itemId
        	},
        	success:function(data){
        		detail(modelId);
        	},
        	error:function(){}
        });
	}
	</script>
</body>
    
</html>