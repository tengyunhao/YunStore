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
                <li class="am-active">新增学生</li>
            </ol>
            <div class="tpl-portlet-components">
                <div class="portlet-title">
                    <div class="caption font-green bold">
                        <span class="am-icon-code"></span> 新增学生
                    </div>
                </div>
                <div class="tpl-block ">
                    <div class="am-g tpl-amazeui-form">
                        <div class="am-u-sm-12 am-u-md-9">
                            <form class="am-form am-form-horizontal">
                                <div class="am-form-group">
                                    <label for="user-name" class="am-u-sm-3 am-form-label">姓名</label>
                                    <div class="am-u-sm-9">
                                        <input type="text" id="name">
                                    </div>
                                </div>
                                <div class="am-form-group">
                                    <label for="user-intro" class="am-u-sm-3 am-form-label">宿舍</label>
                                    <div class="am-u-sm-9">
                                        <select id="dormitory">
                                        </select>
                                    </div>
                                </div>
                                <div class="am-form-group">
                                    <label for="user-intro" class="am-u-sm-3 am-form-label">班级</label>
                                    <div class="am-u-sm-9">
                                        <select id="class">
                                        </select>
                                    </div>
                                </div>
                                <div class="am-form-group">
                                    <label for="user-weibo" class="am-u-sm-3 am-form-label">备注</label>
                                    <div class="am-u-sm-9">
                                        <input type="text" id="remark">
                                    </div>
                                </div>
                                <div class="am-form-group">
                                    <div class="am-u-sm-9 am-u-sm-push-3">
                                        <button id="student-add" type="button" class="am-btn am-btn-primary">保存</button>
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
    <script src="../../assets/js/jquery.min.js"/></script>
    <script src="../../assets/js/amazeui.min.js"/></script>
    <script src="../../assets/js/iscroll.js"/></script>
    <script src="../../assets/js/app.js"/></script>
    <script type="text/javascript">
	// 学生菜单阴影效果
	$('#nav-student').addClass("active");
	// 列表的打开和关闭
	$('#nav-student-ul').css('display','block');
	// 具体某个页面的阴影
	$('#nav-student-add').addClass("active");
    
    /*班级下拉框列表*/
    $.ajax({
    	type:"post",
    	url:"${pageContext.request.contextPath }/class_list.action",
    	success:function(data){
    		var rows = data.rows;
    		for (var i = 0; i < rows.length; i++) {
    			var row = rows[i];
    			var $row = $("<option value="+ row.id +">" + row.className + "</option>");
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
    			var $row = $("<option value="+ row.id +">" + row.dormitoryName + "</option>");
    			$("#dormitory").append($row);
    		}
    	},
    	error:function(){
    	}
    });
    $('#student-add').click(function(){
    	
    	$.ajax({
    		type:"post",
    		url:"${pageContext.request.contextPath }/student_add.action",
    		data:{
    			name:$('#name').val(),
    			remark:$('#remark').val(),
    			classId:$('#class').val(),
    			dormitoryId:$('#dormitory').val()
    		},
    		success:function(data){
    	    	window.location.href="${pageContext.request.contextPath }/jsp/other/student-list.jsp";
    		},
    		error:function(){
    		}
    		
    	});
    });
    </script>
</body>
    
</html>