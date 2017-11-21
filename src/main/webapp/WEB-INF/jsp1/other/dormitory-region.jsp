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
                <li><a href="#">宿舍</a></li>
                <li class="am-active">区域划分</li>
            </ol>
            <div class="tpl-portlet-components">
                <div class="portlet-title">
                    <div class="caption font-green bold">
                        <span class="am-icon-code"></span> 区域划分
                    </div>
                </div>
                <div class="tpl-block ">
                    <div class="am-g tpl-amazeui-form">
                        <div class="am-u-sm-12 am-u-md-9">
                            <form class="am-form am-form-horizontal">
                                <div class="am-form-group">
                                    <label for="user-intro" class="am-u-sm-3 am-form-label">类型</label>
                                    <div class="am-u-sm-9">
                                        <select id="dormitory-type">
                                        	<option>选择宿舍类型</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="am-form-group">
                                    <label for="user-name" class="am-u-sm-3 am-form-label">区域</label>
                                    <div class="am-u-sm-1">
                                    	<button type="button" id="doc-prompt-toggle" class='am-btn am-btn-default am-btn-xs'>添加</button>
                                    </div>
                                    <div class="am-u-sm-8" id="dormitory-region">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="tpl-alert"></div>
            </div>

        </div>
        
	</div>

	<div class="am-modal am-modal-prompt" tabindex="-1" id="my-prompt">
		<div class="am-modal-dialog">
			<div class="am-modal-bd">
				添加宿舍区域 <input type="text" class="am-modal-prompt-input">
			</div>
			<div class="am-modal-footer">
				<span class="am-modal-btn" data-am-modal-cancel>取消</span> <span
					class="am-modal-btn" data-am-modal-confirm>提交</span>
			</div>
		</div>
	</div>

	<div class="am-modal am-modal-alert" tabindex="-1" id="my-alert">
		<div class="am-modal-dialog">
			<div class="am-modal-hd">提示</div>
			<div class="am-modal-bd">区域使用中，无法移除！</div>
			<div class="am-modal-footer">
				<span class="am-modal-btn">确定</span>
			</div>
		</div>
	</div>

	<script src="../../assets/js/jquery.min.js"/></script>
    <script src="../../assets/js/amazeui.min.js"/></script>
    <script src="../../assets/js/iscroll.js"/></script>
    <script src="../../assets/js/app.js"/></script>
    <script type="text/javascript">

	$('#nav-dormitory').addClass("active");
	$('#nav-dormitory-ul').css('display','block');
	$('#nav-dormitory-region').addClass("active");
    
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
    			$("#dormitory-type").append($row);
    		}
    	},
    	error:function(){
    	}

    });
    function loadRegionList() {
    	$.ajax({
	    	type:"post",
	    	url:"${pageContext.request.contextPath }/dormitory_region.action",
	    	data:{
	    		typeId:$('#dormitory-type').val()
	    	},
	    	success:function(data){
	    		$("#dormitory-region").html("");
	    		var rows = data.rows;
	    		for (var i = 0; i < rows.length; i++) {
	    			var row = rows[i];
	    			var $row = $("<button type='button' id="+row.id+" onclick='remove("+row.id+")' class='am-btn am-btn-default am-btn-xs'> "+row.name+"</button> ");
	    			$("#dormitory-region").append($row);
	    		}
	    	},
	    	error:function(){
	    	}

	    });
    }
	$("#dormitory-type").change(function(){
		loadRegionList();	
	});
	// 新增区域
	$('#doc-prompt-toggle').on('click', function() {
	    $('#my-prompt').modal({
			relatedTarget: this,
		    onConfirm: function(e) {
		    	$.ajax({
			    	type:"post",
			    	url:"${pageContext.request.contextPath }/dormitory_addRegion.action",
			    	data:{
			    		typeId:$('#dormitory-type').val(),
			    		name:e.data
			    	},
			    	success:function(data){
				    	loadRegionList();
			    	},
			    	error:function(){
			    	}
			    });
		    },
		    onCancel: function(e) {
		    }
		});
	});
	// 移除区域
	function remove(region) {
		$.ajax({
	    	type:"post",
	    	url:"${pageContext.request.contextPath }/dormitory_removeRegion.action",
	    	data:{
	    		regionId:region
	    	},
	    	success:function(data){
		    	loadRegionList();
	    	},
	    	error:function(){
	    		$('#my-alert').modal({
	    			relatedTarget: this
	    		});
	    	}
	    });
    }
    </script>
</body>
    
</html>