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
                <li class="am-active">宿舍列表</li>
            </ol>
            <div class="tpl-portlet-components">
                <div class="portlet-title">
                    <div class="caption font-green bold">
                        <span class="am-icon-code"></span> 宿舍列表
                    </div>
                </div>
                <div class="tpl-block">
                    <div class="am-g">
                        <div class="am-u-sm-12 am-u-md-6">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <button onclick="window.location.href='dormitory-add.jsp'" type="button" class="am-btn am-btn-default am-btn-success"><span class="am-icon-plus"></span> 新增</button>    
                                    <button id="dormitory-delete" type="button" class="am-btn am-btn-default am-btn-secondary"><span class="am-icon-archive"></span> 删除</button>
                                </div>
                            </div>
                        </div>
                        <div class="am-u-sm-12 am-u-md-6">
                            <div class="am-form-group">
                                <select id="dormitory-type" data-am-selected="{btnWidth: '40%',btnSize: 'sm'}">
                                	<option value="0">选择类型</option>
            					</select>
                                <select id="dormitory" data-am-selected="{btnWidth: '40%',btnSize: 'sm',searchBox: 1}">
                                	<option value="0">选择宿舍</option>
            					</select>
            					<button onclick="loadDormitoryList()" style="width: 15%" class="am-btn am-btn-default am-btn-success tpl-am-btn-success am-icon-search" type="button"></button>
                            </div>
                        </div>
                    </div>
                    <div class="am-g">
                        <div class="am-u-sm-12">
	                    	<table class="am-table am-table-striped am-table-hover table-main">
	                         	<thead>
	                               	<tr>
	                                  	<th style="width: 4%; min-width: 20px"></th>
	                              		<th style="width: 5%; min-width: 30px" class="am-hide-sm-only">ID</th>
	                                    <th style="width: 12%; min-width: 80px">宿舍</th>
	                                 	<th style="width: 16%; min-width: 100px">类型</th>
	                                    <th style="width: 10%; min-width: 50px" class="am-hide-sm-only">人数</th>
	                              		<th style="width: 20%; min-width: 100px" class="table-set">操作</th>
	                        		</tr>
	                           	</thead>
	                            <tbody id="dormitory-list">
	                       		</tbody>
	                        </table>
                            <div class="am-cf">
                                <div class="am-fr">
                                    <ul class="am-pagination tpl-pagination">
                                        <li><a style="font-size: 14px" onclick="first()">首页</a></li>
                                        <li id="page-left" class="am-disabled"><a style="font-size: 14px" onclick="left()">上一页</a></li>
                                        <li id="page-now" class="am-active">
                                        	<select id="page" data-am-selected="{btnWidth: '50px',btnSize: 'sm',searchBox: 1,dropUp: 1,maxHeight: 30}">
	            							</select>
										</li>
                                        <li id="page-right"><a style="font-size: 14px" onclick="right()">下一页</a></li>
                                        <li><a style="font-size: 14px" onclick="end()">尾页</a></li>
                                    </ul>
                                </div>
                            </div>
                            <hr>
                        </div>
                    </div>
                </div>
                <div class="tpl-alert"></div>
            </div>
        </div>
	</div>	
	<div class="am-modal am-modal-no-btn" tabindex="-1" id="modal-dormitory-detail">
		<div class="am-modal-dialog">
			<div class="am-modal-hd">宿舍区域详情<a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a></div>
			<div class="am-modal-bd">
                <div class="am-u-sm-12">
					<div id="wrapper-item" class="wrapper">
						<div id="" class="scroller">
							<table class="am-table am-table-striped am-table-hover table-main">
								<thead>
									<tr>
										<th style="width: 14%; min-width: 75px">班级</th>
										<th style="width: 14%; min-width: 75px">姓名</th>
										<th style="width: 12%; min-width: 60px">床铺</th>
										<th style="width: 26%; min-width: 100px">备注</th>
										<th style="width: 34%; min-width: 120px">区域</th>
									</tr>
								</thead>
								<tbody id="student-list">
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
	<div class="am-modal am-modal-no-btn" tabindex="-1" id="modal-dormitory-update">
		<div class="am-modal-dialog">
			<div class="am-modal-hd">宿舍信息修改<a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a></div>
			<div class="am-modal-bd">
	            <form class="am-form am-form-horizontal">
	                <div class="am-form-group">
	                    <label for="user-name" class="am-u-sm-2 am-form-label">宿舍</label>
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
	                    <label for="user-weibo" class="am-u-sm-2 am-form-label">人数</label>
	                    <div class="am-u-sm-10">
	                        <input type="text" id="update-num">
	                    </div>
	                </div>
	                <div class="am-form-group">
	                    <div class="am-u-sm-6 am-u-sm-push-3">
	                        <button id="dormitory-update" type="button" class="am-btn am-btn-primary">保存修改</button>
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

	$('#nav-dormitory').addClass("active");
	$('#nav-dormitory-ul').css('display','block');
	$('#nav-dormitory-list').addClass("active");
	var pageCount = 0;
	var pageRows = 10;
	var pageNum = 0;
	$.ajax({
    	type:"post",
    	url:"${pageContext.request.contextPath }/dormitory_count.action",
    	success:function(data){
    		pageCount = parseInt(data.data/pageRows) + 1;
    		for (var i = 0; i < pageCount; i++) {
				$("#page").append($("<option value="+i+">"+(i+1)+"</option>"));
			}
    	},
    	error:function(){
    	}
    });
	function left() {
		pageNum -= 1;
		loadDormitoryList();
		if(pageNum == 0) {
			$('#page-left').addClass("am-disabled");
		}
		if($("#page-right").hasClass('am-disabled')) {
			$('#page-right').removeClass("am-disabled");
		}
	}
	function right() {
		pageNum += 1;
		loadDormitoryList();
		if(pageNum == pageCount-1) {
			$('#page-right').addClass("am-disabled");
		}
		if($("#page-left").hasClass('am-disabled')) {
			$('#page-left').removeClass("am-disabled");
		}
	}
	function first() {
		pageNum = 0;
		loadDormitoryList();
		$('#page-left').addClass("am-disabled");
		if($("#page-right").hasClass('am-disabled')) {
			$('#page-right').removeClass("am-disabled");
		}
	}
	function end() {
		pageNum = pageCount-1;
		loadDormitoryList();
		$('#page-right').addClass("am-disabled");
		if($("#page-left").hasClass('am-disabled')) {
			$('#page-left').removeClass("am-disabled");
		}
	}
	$("#page").change(function(){
		pageNum = $(this).val();
		loadDormitoryList();
	});
	loadDormitoryList();
    function loadDormitoryList() {
    	$.ajax({
    		url : "${pageContext.request.contextPath }/dormitory_query.action",
    		type : "post",
    		dataType : "json",
    		data:{
    			page : pageNum,
    			rows : pageRows,
    			typeId : $('#dormitory-type').val(),
    			dormitoryId : $('#dormitory').val()
    		},
    		success : function(data) {
    			var rows = data.rows;
				$("#dormitory-list").html("");
    			for (var i = 0; i < rows.length; i++) {
    				var row = rows[i];
    				var $row = $("<tr>"
    								+ "<td><input class='dormitory-select' type='checkbox' value=" + row.id + "></td>"
    								+ "<td class='am-hide-sm-only'>" + row.id + "</td>"
    								+ "<td><a href='#'>" + row.dormitoryName + "</a></td>"
    								+ "<td>" + row.typeName + "</td>"
    								+ "<td class='am-hide-sm-only'>" + row.studentNumber + "</td>"
    								+ "<td>"
    									+ "<div class='am-btn-toolbar'>"
    									 	 + "<div class='am-btn-group am-btn-group-xs'>"
    									 	 	 + "<button onclick='update("+row.id+",\""+row.dormitoryName+"\","+row.studentNumber+")' class='am-btn am-btn-default am-btn-xs am-text-secondary' data-am-modal=\"{target: '#modal-dormitory-update', closeViaDimmer: 0, width: 395, height: 300}\"><span class='am-icon-pencil-square-o'></span> 编辑</button>"
    									 	 	 + "<button onclick='detail("+row.id+","+row.typeId+")' type='button' class='am-btn am-btn-default am-btn-xs am-hide-sm-only' data-am-modal=\"{target: '#modal-dormitory-detail', closeViaDimmer: 0, width: 800, height: 520}\"><span class='am-icon-copy'></span> 区域</button>"
    										 + "</div>"
    									+ "</div>"
    								+ "</td>"
    						    + "</tr>");
    				$("#dormitory-list").append($row);
    			}
    		},
    		error : function() {
    			alert("error");
    		}
    	});
	}
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
    			$("#dormitory-type").append($row);
    		}
    	},
    	error:function(){
    	}
    });
    /*宿舍下拉框列表*/
    $.ajax({
    	type:"post",
    	url:"${pageContext.request.contextPath }/dormitory_query.action",
    	data:{
    		page:0,
    		rows:100
    	},
    	success:function(data){
    		var rows = data.rows;
    		for (var i = 0; i < rows.length; i++) {
    			var row = rows[i];
    			var $row = $("<option value="+ row.id +">"
    							+ row.dormitoryName
    					   + "</option>");
    			$("#dormitory").append($row);
    		}
    	},
    	error:function(){
    	}
    });
    var dormitoryId;
    function update(dormitory,name,num) {
        dormitoryId = dormitory;
        
		$('#update-name').val(name);
		$('#update-num').val(num);
		
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
        	error:function(){}
        });
    }
    function detail(dormitoryid,typeId) {
    	/*获取宿舍区域*/
	    $.ajax({
	    	type:"post",
	    	url:"${pageContext.request.contextPath }/dormitory_region.action",
	    	data:{
	    		typeId:typeId
	    	},
	    	success:function(data){
	        	var regions = data.rows;  	
	    		$.ajax({
	        		url : "${pageContext.request.contextPath }/student_query.action",
	        		type : "post",
	        		dataType : "json",
	        		data:{
	        			dormitoryId : dormitoryid
	        		},
	        		success : function(data) {
	        			$("#student-list").html("");
	        			var rows = data.rows;
	        			for (var i = 0; i < rows.length; i++) {
	        				var row = rows[i];
	        				var $row = $("<tr>"
	    									+ "<td>" + row.className + "</td>"
	        								+ "<td><a href='#'>" + row.name + "</a></td>"
	        								+ "<td class='am-hide-sm-only'>" + row.bedId + "</td>"
	        								+ "<td class='am-hide-md-down'>" + row.remark + "</td>"
	        								+ "<td>"
	        									+ "<span id='region"+row.id+"'>"
	        									+ "</span>"
	           									+ "<button id='student_"+row.id+"_show' onclick='show("+row.id+")' class='show am-btn am-btn-default am-btn-xs' style='display:;'> 修改</button>"
	           									+ "<button id='student_"+row.id+"_hide' onclick='hide("+row.id+")' class='hide am-btn am-btn-default am-btn-xs' style='display:none;'> 确认</button>"
	           								+ "</td>"
	           						    + "</tr>");
	        				$("#student-list").append($row);
	        				for (var j = 0; j < regions.length; j++) {
	                			var region = regions[j];
	                			if(row.regionIds.indexOf(region.id) == -1) {
		                			$("#region"+row.id).append($("<button id='"+row.id+"_"+region.id+"' onclick='region("+region.id+","+row.id+")' class='"+row.id+" am-btn am-btn-default am-btn-xs am-text-success' style='display:none;'> "+region.name+"</button>"));
	                			} else {
		                			$("#region"+row.id).append($("<button id='"+row.id+"_"+region.id+"' onclick='region("+region.id+","+row.id+")' class='"+row.id+" am-btn am-btn-default am-btn-xs am-text-danger' disabled=''> "+region.name+"</button>"));
	                			}
	                		}
	        			}
	        		},
	        		error : function() {
	        			alert("error");
	        		}
	        	});
	    		
	    		
	    	},
	    	error:function(){}
	    });
    	
    }
    function region(region,student) {
		if($("#"+student+"_"+region).hasClass('am-text-success')) {
        	$("#"+student+"_"+region).removeClass('am-text-success');
        	$("#"+student+"_"+region).addClass('am-text-danger');
    		
    	} else {
        	$("#"+student+"_"+region).removeClass('am-text-danger');
        	$("#"+student+"_"+region).addClass('am-text-success');
    	}
    }
    // 点击修改按钮
    function show(student) {
    	$("."+student).css('display','');
		$("."+student).attr('disabled',false);
    	$("#student_"+student+"_show").css('display','none');
    	$("#student_"+student+"_hide").css('display','');
    }
    // 点击确认按钮
    function hide(student) {
    	var regions = [];
    	$("."+student).each(function() {
			if ($(this).hasClass('am-text-danger')) {
				regions.push($(this).attr("id").split('_')[1]);
				$(this).attr('disabled',true);
			} else {
				$(this).css('display','none');
			}
		});
    	$.ajax({
        	type:"post",
        	url:"${pageContext.request.contextPath }/student_addRegion.action",
        	data:{
        		studentId:student,
        		regionIds:regions.toString()
        	},
        	success:function(data){},
        	error:function(){}
        });
    	$("#student_"+student+"_show").css('display','');
    	$("#student_"+student+"_hide").css('display','none');
    	
    }
 	// 修改宿舍
    $("#dormitory-update").click(function() {
    	$.ajax({
        	type:"post",
        	url:"${pageContext.request.contextPath }/dormitory_update.action",
        	data:{
        		dormitoryId:dormitoryId,
    			name:$('#update-name').val(),
    			studentNum:$('#update-num').val(),
    			typeId:$('#update-type').val()
        	},
        	success:function(data){
        		window.location.href="${pageContext.request.contextPath }/jsp/other/dormitory-list.jsp";
    		},
        	error:function(){}
        });
    });
    // 删除宿舍
    $("#dormitory-delete").click(function(){
    	$(".dormitory-select").each(function() {
    		if(this.checked) {
    			$.ajax({
    	        	type:"post",
    	        	url:"${pageContext.request.contextPath }/dormitory_delete.action",
    	        	data:{
    	        		dormitoryId:$(this).val()
    	        	},
    	        	success:function(data){
    	    			loadDormitoryList();
    	    		},
    	        	error:function(){}
    	        });
    		}
		});
	});
	</script>
</body>
</html>