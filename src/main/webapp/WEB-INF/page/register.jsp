    <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>云盘</title>
	<link rel="stylesheet" type="text/css" href="res/css/login-normalize.css" />
	<link rel="stylesheet" type="text/css" href="res/css/login-demo.css" />
	<!--必要样式-->
	<link rel="stylesheet" type="text/css" href="res/css/login-component.css" />
	<!--[if IE]>
	<script src="res/js/html5.js"></script>
	<![endif]-->
	<link rel="stylesheet" href="res/css/layui.css">
</head>
<body>
	<div class="container demo-1">
		<div class="content">
			<div id="large-header" class="large-header">
				<canvas id="demo-canvas"></canvas>
				<div class="logo_box" style="padding:50px;border-radius:20px;background-color:#ecfdff">
					<h3 style="margin-bottom:35px">欢迎你</h3>
					<form class="layui-form" id="form" action="register-check.do" name="f" method="post">
						<div class="layui-form-item">
						<input type="text" id="username" name="username" lay-verify="required" autocomplete="off" placeholder="输入手机号" class="layui-input">
						</div>
						<div class="layui-form-item">
						<input type="password" id="password" name="password" lay-verify="required" placeholder="输入密码" autocomplete="off" class="layui-input">
						</div>
                        <div class="layui-form-item">
                            <input type="text" style="float:left;width:180px" name="code" lay-verify="required" placeholder="输入验证码" autocomplete="off" class="layui-input">
                            <button id="code" style="float:right;width:110px" class="layui-btn layui-btn-primary">获取验证码</button>
                        </div>
                        <div class="layui-form-item">
                            <button id="register" style="width:300px;margin-top:35px" class="layui-btn">注册</button>
                        </div>
						<div class="layui-form-item">
							<a href="${pageContext.request.contextPath }/login.do" style="color:#9b9b9b">已经注册？点击前往登陆</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div><!-- /container -->
	<script src="res/js/TweenLite.min.js"></script>
	<script src="res/js/EasePack.min.js"></script>
	<script src="res/js/rAF.js"></script>
	<script src="res/js/demo-1.js"></script>
	<script src="res/jquery.min.js"></script>
	<script src="res/layui.js"></script>
	<script>
	$("#login").click(function () {
		$("#form").submit();
	})
	layui.use('form', function(){
		var form = layui.form;
        $("#code").click(function(){
            // 发送短信
            $.post("${pageContext.request.contextPath }/register/code.do",{
                username : $("#username").val()
            },function(data){
            });
            var i = 60;
            $("#code").text(i+"s");
            $(this).addClass("layui-btn-disabled");
            var interval = setInterval(function(){
                $("#code").text(--i+"s");
                if(i == 0) {
                    clearInterval(interval);
                    $("#code").text("获取验证码");
                    $("#code").removeClass("layui-btn-disabled");
                }
            }, 1000);
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });
    });
	</script>
</body>
</html>