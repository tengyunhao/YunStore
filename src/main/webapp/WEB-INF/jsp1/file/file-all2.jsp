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
    <link rel="icon" type="image/png" href="assets/i/favicon.png">
    <link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">
	<link rel="stylesheet" href="assets/plugins/dropzone/css/dropzone.css" />
    <link rel="stylesheet" href="assets/css/amazeui.min.css" />
    <link rel="stylesheet" href="assets/css/admin.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="stylesheet" href="assets/plugins/tree/amazeui.tree.min.css">
</head>
<body data-type="index">
    
	<%@include file="../common/header.jsp" %>

    <div class="tpl-page-container tpl-page-header-fixed">
        <%@include file="../common/menu.jsp" %>

        <div class="tpl-content-wrapper">
            <div class="tpl-portlet-components">
                <div class="portlet-title">
                    <div class="caption font-green bold">
                        <span class="am-icon-code"> 我的文件 </span>
                    </div>
                    <div class="tpl-portlet-input tpl-fz-ml">
                        <div class="portlet-input input-small input-inline">
                            <div class="am-input-group am-input-group-sm">
                                <input type="text" class="am-form-field">
                                <span class="am-input-group-btn">
            							<button class="am-btn  am-btn-default am-btn-success tpl-am-btn-success am-icon-search" type="button"></button>
          						</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tpl-block">
                    <div class="am-g">
                        <div class="am-u-sm-12 am-u-md-6">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <button class="am-btn am-btn-default am-btn-secondary am-round" data-am-modal="{target: '#modal-model-update', closeViaDimmer: 0, width: 780, height: 480}"><span class="am-icon-plus"></span> 上传文件 </button>
                                </div>
                                <div class="am-btn-group am-btn-group-xs">
                                    <button class="am-btn am-btn-default am-round" data-am-modal="{target: '#modal-add-directory', closeViaDimmer: 0, width: 570, height: 420}"><span class="am-icon-copy"></span> 新建文件夹 </button>
                                </div>
                            </div>
                        </div>
                        <div class="am-u-sm-12 am-u-md-3">
                            <div class="am-form-group">
                                <select data-am-selected="{btnSize: 'sm'}">
					              <option value="option1">所有类别</option>
					              <option value="option2">IT业界</option>
					              <option value="option3">数码产品</option>
					              <option value="option3">笔记本电脑</option>
					              <option value="option3">平板电脑</option>
					              <option value="option3">只能手机</option>
					              <option value="option3">超极本</option>
					            </select>
                            </div>
                        </div>
                    </div>
                    <div class="am-g">
                        <div class="am-u-sm-12">
                            <form class="am-form">
                                <table class="am-table am-table-striped am-table-hover table-main">
                                    <thead>
                                        <tr>
                                            <th class="table-check"><input type="checkbox" class="tpl-table-fz-check"></th>
                                            <th class="table-id">ID</th>
                                            <th class="table-title">文件名</th>
                                            <th class="table-type">类别</th>
                                            <th class="table-date am-hide-sm-only">修改日期</th>
                                            <th class="table-set">操作</th>
                                        </tr>
                                    </thead>
                                    <tbody id="file-list"></tbody>
                                </table>
                                <div class="am-cf">

                                    <div class="am-fr">
                                        <ul class="am-pagination tpl-pagination">
                                            <li class="am-disabled"><a href="#">«</a></li>
                                            <li class="am-active"><a href="#">1</a></li>
                                            <li><a href="#">2</a></li>
                                            <li><a href="#">3</a></li>
                                            <li><a href="#">4</a></li>
                                            <li><a href="#">5</a></li>
                                            <li><a href="#">»</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <hr>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="tpl-alert"></div>
            </div>
        </div>
    </div>

	<div class="am-modal am-modal-no-btn" tabindex="-1" id="modal-model-update">
		<div class="am-modal-dialog">
			<div class="am-modal-hd">上传文件<a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a></div>
			<div class="am-modal-bd">
			
			    <div class="am-u-sm-6">
				    <div id="dropzone">
					<form method="post" enctype="multipart/form-data" class="dropzone" id="usecase">
						<div class="fallback">
							<input name="file" type="file" multiple="" />
						</div>
					</form>
					</div>
	            </div>
			    <div class="am-u-sm-6">
		            <form class="am-form am-form-horizontal">
		                <div class="am-form-group">
		                    <label for="user-intro" class="am-u-sm-4 am-form-label">文件类型</label>
		                    <div class="am-u-sm-8">
		                        <select id="update-type">
		                        </select>
		                    </div>
		                </div>
		            </form>
	            </div>
		       	<div class="am-u-sm-12">
		        		<button id="model-update" type="button" class="am-btn am-btn-primary">确认上传</button>
		        		<button type="button" class="am-btn am-btn-default" data-dismiss="modal">关闭窗口</button>
		     	</div>
			</div>
		</div>
	</div>
	<div class="am-popup" id="modal-add-directory1">
	  <div class="am-popup-inner">
	    <div class="am-popup-hd">
	      <h4 class="am-popup-title">新建文件夹</h4>
	      <span data-am-modal-close class="am-close">&times;</span>
	    </div>
	    <div class="am-popup-bd">
	    
	    </div>
	  </div>
	</div>
	<div class="am-modal am-modal-no-btn" tabindex="-1" id="modal-add-directory">
		<div class="am-modal-dialog">
			<div class="am-modal-hd">新建文件夹<a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a></div>
			<div class="am-modal-bd">
				<div class="am-u-sm-4" style="height: 300px;">
					<div class="am-pre-scrollable">
		  				<ul class="am-tree" id="myTree" >
						  <!-- 包含子级的条目模板 -->
						  <li class="am-tree-branch am-hide" data-template="treebranch">
						    <div class="am-tree-branch-header">
						      <button class="am-tree-branch-name">
						        <span class="am-tree-icon am-tree-icon-folder"></span>
						        <span class="am-tree-label"></span>
						      </button>
						    </div>
						    <ul class="am-tree-branch-children"></ul>
						    <div class="am-tree-loader">Loading...</div>
						  </li>
						
						  <!-- 不包含子级的条目模板 -->
						  <li class="am-tree-item am-hide" data-template="treeitem">
						    <button class="am-tree-item-name">
						      <span class="am-tree-icon am-tree-icon-item"></span>
						      <span class="am-tree-label"></span>
						    </button>
						  </li>
						</ul>
					</div>
				</div>
				<div class="am-u-sm-8">
					<form class="am-form am-form-horizontal">
						<div class="am-form-group">
							<div class="am-u-sm-12">
								<input type="text" id="name" name="name" class="form-control" placeholder="名称">
							</div>
						</div>
						<div class="am-form-group">
							<div class="am-u-sm-12">
								<select id="parent">
								</select>
							</div>
						</div>
					</form>
				</div>
		       	<div class="am-u-sm-12">
		        		<button id="add-directory" type="button" class="am-btn am-btn-primary">确认添加</button>
		        		<button type="button" class="am-btn am-btn-default" data-dismiss="modal">关闭窗口</button>
		     	</div>
			</div>
		</div>
	</div>
	
    <script src="assets/js/jquery.min.js"/></script>
    <script src="//s.amazeui.org/assets/2.x/js/handlebars.min.js"></script>
	<script src="assets/plugins/dropzone/js/dropzone.min.js"></script>
	<script src="assets/js/pages/form-dropzone.js"></script>
    <script src="assets/js/amazeui.min.js"/></script>
    <script src="assets/plugins/tree/amazeui.tree.min.js"/></script>
    <script src="assets/js/iscroll.js"/></script>
    <script src="assets/js/app.js"/></script>
    <script type="text/javascript">
    
	$('#nav-file').addClass("active");
	$('#nav-file-ul').css('display','block');
	// demo 1
	  var data = [
	    {
	      title: '苹果公司',
	      type: 'folder',
	      products: [
	        {
	          title: 'iPhone',
	          type: 'item'
	        },
	        {
	          title: 'iMac',
	          type: 'item'
	        },
	        {
	          title: 'MacBook Pro',
	          type: 'item'
	        }
	      ]
	    },
	    {
	      title: '微软公司',
	      type: 'item'
	    },
	    {
	      title: 'GitHub',
	      type: 'item',
	      attr: {
	        icon: 'am-icon-github'
	      }
	    }
	  ];
	  $('#myTree').tree({
		    dataSource: function(options, callback) {
			      // 模拟异步加载
			      setTimeout(function() {
			        callback({data: options.products || data});
			      }, 400);
			    },
			    multiSelect: false,
			    cacheItems: true,
			    folderSelect: false
			  });
	Dropzone.options.usecase = {
		url: "http://localhost:8080/YunStore/file-upload.do",
        addRemoveLinks: true,
        dictRemoveLinks: "x",
        dictCancelUpload: "x",
        maxFiles: 1,
        maxFilesize: 5,
        acceptedFiles: ".java",
        dictInvalidFileType: "仅支持 .java .class 类型的文件上传",
        dictMaxFilesExceeded: "仅支持一个用例文件上传",
        init: function() {
        		var fileId;
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
	
	$.ajax({
	    	type:"post",
	    	url:"${pageContext.request.contextPath }/find-directory.do",
	    	data:{
	    	},
	    	success:function(data){
	    		var rows = data;
	    		$("#file-list").html("");
	    		for (var i = 0; i < rows.length; i++) {
	    			var row = rows[i];
	    			var $row = $("<tr>"
	    							+ "<td><input type='checkbox'></td>"
	    							+ "<td>2</td>"
	    							+ "<td><a href='#'>"+ row.name +"</a></td>"
	    							+ "<td>default</td>"
	    							+ "<td class='am-hide-sm-only'>2014年9月4日 7:28:47</td>"
	    							+ "<td>"
	    								 + "<div class='am-btn-toolbar'>"
	    								 + "<div class='am-btn-group am-btn-group-xs'>"
	    								 	 + "<button class='am-btn am-btn-default am-btn-xs am-text-secondary'><span class='am-icon-pencil-square-o'></span> 编辑</button>"
	    								 	 + "<button class='am-btn am-btn-default am-btn-xs am-hide-sm-only'><span class='am-icon-copy'></span> 复制</button>"
	    								 	 + "<button class='am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only'><span class='am-icon-trash-o'></span> 删除</button>"
	    								 + "</div>"
	    							+ "</div>"
	    					   + "</td>");
	    			$("#file-list").append($row);
	    		}
	    	},
	    	error:function(){
	    	}

    });
	
	$("#add-directory").click(function() {
		$.ajax({
		    	type:"post",
		    	url:"${pageContext.request.contextPath }/add-directory.do",
		    	data:{
		    		name : $("#name").val(),
		    		parent : $("#parent").val()
		    	},
		    	success:function(data){
		    		$('#modal-model-create').modal('close')
		    		var rows = data;
		    		$("#file-list").html("");
		    		for (var i = 0; i < rows.length; i++) {
		    			var row = rows[i];
		    			var $row = $("<tr>"
		    							+ "<td><input type='checkbox'></td>"
		    							+ "<td>2</td>"
		    							+ "<td><a href='#'>"+ row.name +"</a></td>"
		    							+ "<td>default</td>"
		    							+ "<td class='am-hide-sm-only'>2014年9月4日 7:28:47</td>"
		    							+ "<td>"
		    								 + "<div class='am-btn-toolbar'>"
		    								 + "<div class='am-btn-group am-btn-group-xs'>"
		    								 	 + "<button class='am-btn am-btn-default am-btn-xs am-text-secondary'><span class='am-icon-pencil-square-o'></span> 编辑</button>"
		    								 	 + "<button class='am-btn am-btn-default am-btn-xs am-hide-sm-only'><span class='am-icon-copy'></span> 复制</button>"
		    								 	 + "<button class='am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only'><span class='am-icon-trash-o'></span> 删除</button>"
		    								 + "</div>"
		    							+ "</div>"
		    					   + "</td>");
		    			$("#file-list").append($row);
		    		}
		    	},
		    	error:function(){
		    	}
	
	    });
	});
	
    </script>                                 
                                        
</body>
    
</html>