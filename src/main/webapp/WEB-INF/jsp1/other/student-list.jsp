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
                <li><a href="#">学生</a></li>
                <li class="am-active">学生列表</li>
            </ol>
            <div class="tpl-portlet-components">
                <div class="portlet-title">
                    <div class="caption font-green bold">
                        <span class="am-icon-code"></span> 学生列表
                    </div>
                </div>
                <div class="tpl-block">
                    <div class="am-g">
                        <div class="am-u-sm-12 am-u-md-6">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <button onclick="window.location.href='student-add.jsp'" type="button" class="am-btn am-btn-default am-btn-success"><span class="am-icon-plus"></span>新增</button>
                                    <button id="student-delete" type="button" class="am-btn am-btn-default am-btn-secondary"><span class="am-icon-archive"></span> 删除</button>
                                </div>
                            </div>
                        </div>
                        <div class="am-u-sm-12 am-u-md-6">
                            <div class="am-form-group">
                                <select id="class" data-am-selected="{btnWidth: '40%',btnSize: 'sm'}">
                                	<option value="0">选择班级</option>
            					</select>
                                <select id="dormitory" data-am-selected="{btnWidth: '40%',btnSize: 'sm',searchBox: 1}">
                                	<option value="0">选择宿舍</option>
            					</select>
            					<button onclick="loadStudengList()" style="width: 15%" class="am-btn am-btn-default am-btn-success tpl-am-btn-success am-icon-search" type="button"></button>
                            </div>
                        </div>
                    </div>
                    <div class="am-g">
                        <div class="am-u-sm-12">
	                        <table class="am-table am-table-striped am-table-hover table-main">
	                            <thead>
	                                <tr>
	                                    <th style="width: 4%; min-width: 20px"></th>
	                                    <th style="width: 4%; min-width: 30px" class="am-hide-sm-only">ID</th>
	                                    <th style="width: 12%; min-width: 80px">姓名</th>
	                                    <th style="width: 16%; min-width: 100px">宿舍</th>
	                                    <th style="width: 10%; min-width: 50px" class="am-hide-sm-only">床铺</th>
	                                    <th style="width: 16%; min-width: 90px">班级</th>
	                                    <th style="width: 22%" class="am-hide-md-down">备注</th>
	                                    <th style="width: 18%; min-width: 100px" class="table-set">操作</th>
	                                </tr>
	                            </thead>
	                            <tbody id="student-list">
	                            </tbody>
	                        </table>
	                        <div class="am-cf">
	                            <div class="am-fr">
	                                <ul class="am-pagination tpl-pagination">
	                                    <li><a style="font-size: 14px" onclick="first()">首页</a></li>
	                                    <li id="page-left" class="am-disabled"><a style="font-size: 14px" onclick="left()">上一页</a></li>
	                                    <li id="page-now" class="am-active">
	                                    	<select id="page" data-am-selected="{btnWidth: '50px',btnSize: 'sm',searchBox: 1,dropUp: 1,maxHeight: 100}">
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
		
	<div class="am-modal am-modal-no-btn" tabindex="-1" id="modal-student-update">
		<div class="am-modal-dialog">
			<div class="am-modal-hd">
				学生信息修改 <a href="javascript: void(0)" class="am-close am-close-spin"
					data-am-modal-close>&times;</a>
			</div>
			<div class="am-modal-bd">
	            <form class="am-form am-form-horizontal">
	                <div class="am-form-group">
	                    <label for="user-name" class="am-u-sm-2 am-form-label">姓名</label>
	                    <div class="am-u-sm-10">
	                        <input type="text" id="detail-name">
	                    </div>
	                </div>
	                <div class="am-form-group">
	                    <label for="user-intro" class="am-u-sm-2 am-form-label">班级</label>
	                    <div class="am-u-sm-10">
	                        <select id="detail-class">
	                        </select>
	                    </div>
	                </div>
	                <div class="am-form-group">
	                    <label for="user-intro" class="am-u-sm-2 am-form-label">宿舍</label>
	                    <div class="am-u-sm-10">
	                        <select id="detail-dormitory">
	                        </select>
	                    </div>
	                </div>
	                <div class="am-form-group">
	                    <label for="user-intro" class="am-u-sm-2 am-form-label">床铺</label>
	                    <div class="am-u-sm-10">
	                        <select id="detail-bed">
	                        	<option value="1">1号床铺</option>
	                        	<option value="2">2号床铺</option>
	                        	<option value="3">3号床铺</option>
	                        	<option value="4">4号床铺</option>
	                        	<option value="5">5号床铺</option>
	                        	<option value="6">6号床铺</option>
	                        	<option value="7">7号床铺</option>
	                        	<option value="8">8号床铺</option>
	                        </select>
	                    </div>
	                </div>
	                <div class="am-form-group">
	                    <label for="user-weibo" class="am-u-sm-2 am-form-label">备注</label>
	                    <div class="am-u-sm-10">
	                        <input type="text" id="detail-remark">
	                    </div>
	                </div>
	                <div class="am-form-group">
	                    <div class="am-u-sm-6 am-u-sm-push-3">
	                        <button id="student-update" type="button" class="am-btn am-btn-primary">保存修改</button>
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

	$('#nav-student').addClass("active");
	$('#nav-student-ul').css('display','block');
	$('#nav-student-list').addClass("active");
	var pageCount = 0;
	var pageRows = 10;
	var pageNum = 0;
	$.ajax({
    	type:"post",
    	url:"${pageContext.request.contextPath }/student_count.action",
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
		loadStudengList();
		if(pageNum == 0) {
			$('#page-left').addClass("am-disabled");
		}
		if($("#page-right").hasClass('am-disabled')) {
			$('#page-right').removeClass("am-disabled");
		}
	}
	function right() {
		pageNum += 1;
		loadStudengList();
		if(pageNum == pageCount-1) {
			$('#page-right').addClass("am-disabled");
		}
		if($("#page-left").hasClass('am-disabled')) {
			$('#page-left').removeClass("am-disabled");
		}
	}
	function first() {
		pageNum = 0;
		loadStudengList();
		$('#page-left').addClass("am-disabled");
		if($("#page-right").hasClass('am-disabled')) {
			$('#page-right').removeClass("am-disabled");
		}
	}
	function end() {
		pageNum = pageCount-1;
		loadStudengList();
		$('#page-right').addClass("am-disabled");
		if($("#page-left").hasClass('am-disabled')) {
			$('#page-left').removeClass("am-disabled");
		}
	}
	$("#page").change(function(){
		pageNum = $(this).val();
		loadStudengList();
	});
	loadStudengList();
    function loadStudengList() {	
    	$.ajax({
    		url : "${pageContext.request.contextPath }/student_query.action",
    		type : "GET",
    		dataType : "json",
    		data:{
    			page : pageNum,
    			rows : pageRows,
    			dormitoryId : $('#dormitory').val(),
    			classId : $('#class').val(),
    		},
    		success : function(data) {
    			var rows = data.rows;
				$("#student-list").html("");
    			for (var i = 0; i < rows.length; i++) {
    				var row = rows[i];
    				var $row = $("<tr>"
    								+ "<td><input class='student-select' type='checkbox' value=" + row.id + "></td>"
    								+ "<td class='am-hide-sm-only'>" + row.id + "</td>"
    								+ "<td><a href='#'>" + row.name + "</a></td>"
    								+ "<td>" + row.dormitoryName + "</td>"
    								+ "<td class='am-hide-sm-only'>" + row.bedId + "</td>"
    								+ "<td>" + row.className + "</td>"
    								+ "<td class='am-hide-md-down'>" + row.remark + "</td>"
    								+ "<td>"
    									+ "<div class='am-btn-toolbar'>"
    									 	 + "<div class='am-btn-group am-btn-group-xs'>"
    									 	 	 + "<button onclick='detail("+row.id+",\""+row.name+"\",\""+row.className+"\",\""+row.dormitoryName+"\","+row.bedId+",\""+row.remark+"\")' type='button' class='am-btn am-btn-default am-btn-xs am-text-secondary' data-am-modal=\"{target: '#modal-student-update', closeViaDimmer: 0, width: 435, height: 380}\"><span class='am-icon-pencil-square-o'></span> 编辑</button>"
    										 + "</div>"
    									+ "</div>"
    								+ "</td>"
    						    + "</tr>");
    				$("#student-list").append($row);
    			}
    		},
    		error : function() {
    			alert("error");
    		}
    	});
	}
    /*班级下拉框列表*/
    $.ajax({
    	type:"post",
    	url:"${pageContext.request.contextPath }/class_list.action",
    	success:function(data){
    		var rows = data.rows;
    		for (var i = 0; i < rows.length; i++) {
    			var row = rows[i];
    			var $row = $("<option value="+ row.id +">"
    							+ row.className
    					   + "</option>");
    			$("#class").append($row);
    		}
    	},
    	error:function(){
    	}

    });
    /*宿舍下拉框列表*/
    $.ajax({
    	type:"post",
    	url:"${pageContext.request.contextPath }/dormitory_query.action",
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
    var studentId; 
    function detail(id, name, classe, dormitory, bed, remark) {
		studentId = id;
		$('#detail-name').val(name);
		$('#detail-remark').val(remark);
		$('#detail-dormitory').val(dormitory);
		
        /*班级下拉框列表*/
        $.ajax({
        	type:"post",
        	url:"${pageContext.request.contextPath }/class_list.action",
        	success:function(data){
        		var rows = data.rows;
        		for (var i = 0; i < rows.length; i++) {
        			var row = rows[i];
        			var $row = $("<option value="+ row.id +">"
        							+ row.className
        					   + "</option>");
        			$("#detail-class").append($row);
        		}
        	},
        	error:function(){
        	}
        });
        /*宿舍下拉框列表*/
        $.ajax({
        	type:"post",
        	url:"${pageContext.request.contextPath }/dormitory_query.action",
        	success:function(data){
        		var rows = data.rows;
        		for (var i = 0; i < rows.length; i++) {
        			var row = rows[i];
        			var $row = $("<option value="+ row.id +">"
        							+ row.dormitoryName
        					   + "</option>");
        			$("#detail-dormitory").append($row);
        		}
        	},
        	error:function(){
        	}
        });  	
    }
    // 修改学生
    $("#student-update").click(function() {
    	$.ajax({
        	type:"post",
        	url:"${pageContext.request.contextPath }/student_update.action",
        	data:{
        		studentId:studentId,
    			name:$('#detail-name').val(),
    			remark:$('#detail-remark').val(),
    			bedId:$('#detail-bed').val(),
    			classId:$('#detail-class').val(),
    			dormitoryId:$('#detail-dormitory').val()
        	},
        	success:function(data){
        		window.location.href="${pageContext.request.contextPath }/jsp/other/student-list.jsp";
    		},
        	error:function(){}
        });
    });
    // 删除学生
    $("#student-delete").click(function(){
    	$(".student-select").each(function() {
    		if(this.checked) {
    			$.ajax({
    	        	type:"post",
    	        	url:"${pageContext.request.contextPath }/student_delete.action",
    	        	data:{
    	        		studentId:$(this).val()
    	        	},
    	        	success:function(data){
    	    			loadStudengList();
    	    		},
    	        	error:function(){}
    	        });
    		}
		});
	});
    </script>
</body>
    
</html>