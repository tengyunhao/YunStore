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
<body data-type="login">
	<div class="am-g myapp-login">
		<div class="myapp-login-logo-block  tpl-login-max">
			<div class="myapp-login-logo-text">
				<div class="myapp-login-logo-text"> 卫生后台管理</div>
			</div>
			<div class="login-font">
				<i>无法登录？</i>请联系 <span> 17862980822</span>
			</div>
			<div class="am-u-sm-10 login-am-center">
				<form class="am-form">
					<fieldset>
						<div class="am-form-group">
							<input type="text" class="" id="username" placeholder="输入用户名">
						</div>
						<div class="am-form-group">
							<input type="password" class="" id="password" placeholder="请输入密码">
						</div>
						<p><button id="login" type="button" class="am-btn am-btn-default">登录</button></p>
					</fieldset>
				</form>
			</div>
		</div>
	</div>

  <script src="../../assets/js/jquery.min.js"></script>
  <script src="../../assets/js/amazeui.min.js"></script>
  <script src="../../assets/js/app.js"></script>
  <script type="text/javascript">

	$('#login').click(function(){
		$.ajax({
			type:"post",
			url:"${pageContext.request.contextPath }/account_login.action",
			data:{
				username:$('#username').val(),
				password:$('#password').val()
			},
			success:function(data){
		    	window.location.href="${pageContext.request.contextPath }/jsp/other/index.jsp";
			},
			error:function(){
				alert("用户名或密码错误");
			}
			
		});
	});
	
	</script>
</body>

    
</html>