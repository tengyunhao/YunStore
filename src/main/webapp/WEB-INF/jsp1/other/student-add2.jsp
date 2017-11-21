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
	<link rel="stylesheet" href="../../assets/plugins/dropzone/css/dropzone.css" />
    <link rel="stylesheet" href="../../assets/css/amazeui.min.css" />
    <link rel="stylesheet" href="../../assets/css/admin.css" />
    <link rel="stylesheet" href="../../assets/css/app.css" />
</head>
<body data-type="index">
    
	<%@include file="../common/header.jsp" %>

    <div class="tpl-page-container tpl-page-header-fixed">
        <%@include file="../common/menu.jsp" %>
        
        <div class="tpl-content-wrapper">
            <ol class="am-breadcrumb">
                <li><a href="#" class="am-icon-home">首页</a></li>
                <li><a href="#">学生</a></li>
                <li class="am-active">批量导入</li>
            </ol>
            <div class="tpl-portlet-components">
                <div class="portlet-title">
                    <div class="caption font-green bold">
                        <span class="am-icon-code"></span> 批量导入
                    </div>
                </div>
                <div class="tpl-block ">
                    <div class="am-g tpl-amazeui-form">
                        <div class="am-u-sm-12 am-u-md-10">        
							<form method="post" enctype="multipart/form-data" class="dropzone" id="usecase">
								<div class="fallback">
									<input name="file" type="file" multiple="" />
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
	<script src="../../assets/plugins/dropzone/js/dropzone.min.js"></script>
	<script src="../../assets/js/pages/form-dropzone.js"></script>
    <script src="../../assets/js/amazeui.min.js"/></script>
    <script src="../../assets/js/iscroll.js"/></script>
    <script src="../../assets/js/app.js"/></script>
    <script type="text/javascript">

	$('#nav-student').addClass("active");
	$('#nav-student-ul').css('display','block');
	$('#nav-student-add2').addClass("active");

	var fileId;
	Dropzone.options.usecase = {
		url: "${pageContext.request.contextPath }/case/uploadfile.do",
        addRemoveLinks: true,
        dictRemoveLinks: "x",
        dictCancelUpload: "x",
        maxFiles: 1,
        maxFilesize: 5,
        acceptedFiles: ".xls",
        dictInvalidFileType: "仅支持 .java .class 类型的文件上传",
        dictMaxFilesExceeded: "仅支持一个用例文件上传",
        init: function() {
            this.on("success", function(file, data) {	
            	if(data.status == 200) {
            		fileId = data.data;
            	}	
            });
            this.on("removedfile", function(file) {
            	$.ajax({
    				type:"post",
    				url:"${pageContext.request.contextPath }/case/removefile.do",
    				data:{
    					fileId : fileId 
    				},
    				success:function(data){
    					alert(data.msg);
    				},
    				error:function(){
    					
    				}
    		
    			});
            });
        }
    };
    </script>
</body>
    
</html>