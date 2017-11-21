<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
    <title>卫生后台管理</title>
    <meta name="description" content="这是一个 index 页面">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
    <style>
			
			table .detail {
				font-size: 12px;
				display: none;
			}
			
			table button:hover {
				background: ;
			}
			
			table button:hover .detail {
				padding: 3px;
				background: white;
				color: #555555;
				font-size: 10pt;
				text-align:left;
				border-width: 1px 1px 1px 1px;
				border-color: silver;
				border-style: solid;
				position: absolute;
				top: -75px;
				left: -420px;
				display: block;
			}
		</style>
</head>
<body data-type="index">
	<%@include file="../common/header.jsp" %>

    <div class="tpl-page-container tpl-page-header-fixed">
        <%@include file="../common/menu.jsp" %>
        
        <div class="tpl-content-wrapper">
            <ol class="am-breadcrumb">
                <li><a href="#" class="am-icon-home">首页</a></li>
                <li><a href="#">成绩</a></li>
                <li class="am-active">宿舍成绩</li>
            </ol>
            <div class="tpl-portlet-components">
                <div class="portlet-title">
                    <div class="caption font-green bold">
                        <span class="am-icon-code"></span> 宿舍成绩
                    </div>
                </div>
                <div class="tpl-block">
                    <div class="am-g">
                        <div class="am-u-sm-12 am-u-md-6">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <button type="button" class="am-btn am-btn-default am-btn-secondary"><span class="am-icon-save"></span> 保存</button>
                                </div>
                            </div>
                        </div>
                        <div class="am-u-sm-9 am-u-md-3">
                            <div class="am-form-group">
                                <select id="week" data-am-selected="{btnSize: 'sm'}">
									<option value="第十一周">第十一周</option>
									<option value="第十二周">第十二周</option>
									<option value="第十三周">第十三周</option>
									<option value="第十四周">第十四周</option>
									<option value="第十五周">第十五周</option>
									<option value="第十六周">第十六周</option>
            					</select>
                            </div>
                        </div>
                    </div>
                    <div class="am-g">
                        <div class="am-u-sm-12">
                            <form class="am-form" style="min-height: 300px">
                                <table class="am-table am-table-striped am-table-hover table-main">
                                    <thead>
                                        <tr style="font-size: 12px">
                                            <th style="width: 4%; min-width: 20px"></th>
                                            <th style="width: 8%; min-width: 75px">周数</th>
                                            <th style="width: 8%; min-width: 75px">宿舍</th>
                                            <th style="width: 12%; min-width: 100px">班级</th>
                                            <th style="width: 5%; min-width: 40px" class="am-hide-sm-down">周三</th>
                                            <th style="width: 20%; min-width: 150px" class="am-hide-sm-down">周三详情</th>
                                            <th style="width: 5%; min-width: 40px" class="am-hide-sm-down">抽查</th>
                                            <th style="width: 20%; min-width: 150px" class="am-hide-sm-down">抽查详情</th>
                                            <th style="width: 5%; min-width: 40px">平均</th>
                                            <th style="width: 5%; min-width: 40px" class="am-hide-md-down">排名</th>
                                            <th style="width: 8%; min-width: 75px" class="table-set">操作</th>
                                        </tr>
                                    </thead>
                                    <tbody id="grade-list">
                                    </tbody>
                                </table>
                            </form>
                            <hr>
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

	$('#nav-grade').addClass("active");
	$('#nav-grade-ul').css('display','block');
	$('#nav-grade-list').addClass("active");
	
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
    $("#week").change(function(){
        $.ajax({
    		url : "${pageContext.request.contextPath }/grade_search.action",
    		type : "post",
    		dataType : "json",
    		data:{
    			classesId:$('#class').val(),
    			dormitoryId:$('#dormitory').val(),
    			week:$('#week').val()
    		},
    		success : function(data) {
    			$("#grade-list").html("");
    			var rows = data.rows;
    			for (var i = 0; i < rows.length; i++) {
    				var row = rows[i];
    				var dormitoryName = row.dormitoryName;//要展示的字符串
    				if(dormitoryName.length>5){
    					dormitoryName=dormitoryName.substring(0,5)+"...";
    				}
    				var classesName = row.classesName;//要展示的字符串
    				if(classesName.length>7){
    					classesName=classesName.substring(0,7)+"...";
    				}
    				var inspectFixedDetails = row.inspectFixedDetails;//要展示的字符串
    				if(inspectFixedDetails.length>10){
    					inspectFixedDetails=inspectFixedDetails.substring(0,10)+"...";
    				}
    				var inspectRandomDetails = row.inspectRandomDetails;//要展示的字符串
    				if(inspectRandomDetails.length>10){
    					inspectRandomDetails=inspectRandomDetails.substring(0,10)+"...";
    				}
    				var $row = $("<tr style='font-size: 12px'>"
    								+ "<td><input type='checkbox' value=" + row.id + "></td>"
    								+ "<td>" + row.week + "</td>"
    								+ "<td><a href='#'>" + dormitoryName + "</a></td>"
    								+ "<td>" + classesName + "</td>"
    								+ "<td class='am-hide-sm-down'>" + row.inspectFixedGrade + "</td>"
    								+ "<td class='am-hide-sm-down'>" + inspectFixedDetails + "</td>"
    								+ "<td class='am-hide-sm-down'>" + row.inspectRandomGrade + "</td>"
    								+ "<td class='am-hide-sm-down'>" + inspectRandomDetails + "</td>"
    								+ "<td>" + row.gradeAverage + "</td>"
    								+ "<td class='am-hide-md-down'>" + row.gradeRanking + "</td>"
    								+ "<td>"
    									+ "<div class='am-btn-toolbar'>"
    									 	 + "<div class='am-btn-group am-btn-group-xs'>"
    									 	 	 + "<button class='am-btn am-btn-default am-btn-xs'>"
    									 	 	 	 + "<span class='am-icon-copy'></span> 详情"
    									 	 	 	 + "<div class='detail'>"
    									 	 	 	 	 + "<ul style='width: 420px'>"
    						 	 	 	 	 	 			 + "<li>宿舍："+ row.dormitoryName +"</li>"
    							 	 	 	 	 	 		 + "<li>班级："+ row.classesName +"</li>"
    								 	 	 	 	 	 	 + "<li>周三分数："+ row.inspectFixedGrade +"</li>"
    									 	 	 	 	 	 + "<li>周三详情："+ row.inspectFixedDetails +"</li>"
    								 	 	 	 	 	 	 + "<li>抽查分数："+ row.inspectRandomGrade +"</li>"
    									 	 	 	 	 	 + "<li>抽查详情："+ row.inspectRandomDetails +"</li>"
    									 	 	 	 	 + "</ul>"
    								 	 	 	 	 + "<div>"
    									 	 	 + "</button>"
    										 + "</div>"
    									+ "</div>"
    								+ "</td>"
    						    + "</tr>");
    				$("#grade-list").append($row);
    			}
    		},
    		error : function() {
    		}
    	});
	});
    </script>
</body>
    
</html>