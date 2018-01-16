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
	<style>
	body { background: url(res/css/006.jpg) }
	</style>
</head>
<body>
	<div class="container demo-1">
		<div class="content">
			<div id="large-header" class="large-header">
				<div class="logo_box" style="border-radius: 25px;position:relative;">
                    <div class="layui-tab">
                        <h3 style="margin-top:25px">欢迎你</h3>
                        <div class="layui-tab" lay-filter="test">
                            <ul class="layui-tab-title">
                                <li lay-id="1" class="layui-this">密码登陆</li>
                                <li lay-id="2">短信验证</li>
                                <li lay-id="3">人脸识别</li>
                            </ul>
                            <div class="layui-tab-content">
                                <div class="layui-tab-item layui-show">
                                    <form class="layui-form" action="login-check.do">
                                        <div class="layui-form-item" style="margin-top:15px">
                                            <input type="text" name="username" lay-verify="title" autocomplete="off" placeholder="请输入手机号" class="layui-input">
                                        </div>
                                        <div class="layui-form-item">
                                            <input type="text" name="password" lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
                                        </div>
                                        <div class="layui-form-item" style="margin-top:25px">
                                            <button id="login" style="width:370px" class="layui-btn">登陆</button>
                                        </div>
                                    </form>
                                </div>
                                <div class="layui-tab-item">
                                    <form id="sms-form" class="layui-form" action="login-sms-check.do">
                                        <div class="layui-form-item" style="margin-top:15px">
                                            <input id="sms-username" name="username" lay-verify="title" autocomplete="off" placeholder="请输入手机号" class="layui-input">
                                        </div>
                                        <div class="layui-form-item">
                                            <input style="float:left;width:240px" name="verify" lay-verify="required" placeholder="输入验证码" autocomplete="off" class="layui-input">
                                            <button id="sms-verify" style="float:right;width:120px" class="layui-btn layui-btn-primary">获取验证码</button>
                                        </div>
                                        <div class="layui-form-item" style="margin-top:25px">
                                            <button id="sms-login" style="width:370px" class="layui-btn">登陆</button>
                                        </div>
                                    </form>
                                </div>
                                <div class="layui-tab-item">
                                    <form id="face-form" class="layui-form" action="#">
                                        <div class="layui-form-item">
                                            <input style="float:left;width:240px" id="face-username" name="username" lay-verify="title" autocomplete="off" placeholder="请输入手机号" class="layui-input">
                                            <button style="float:right;width:120px" id="face-verify" class="layui-btn layui-btn-primary">进行人脸识别</button>
                                        </div>
                                    </form>
                                    <video class="layui-hide" id="video" width="370" height="280" autoplay></video>
                                    <lable class="layui-hide" id="face-check" style="color:#3F3F3F">人脸识别中……为保证识别成功，请勿遮挡脸部</lable>
                                    <canvas class="layui-hide" id="canvas" width="320" height="240"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <lable style="position:absolute;left:20px;bottom:15px;"><a style="color:#9b9b9b;" href="#">忘记密码？</a></lable>
                    <lable style="position:absolute;right:20px;bottom:15px;"><a style="color:#9b9b9b;" href="register.do">新用户注册</a></lable>
				</div>
			</div>
		</div>
	</div><!-- /container -->
	<script src="res/jquery.min.js"></script>
	<script src="res/layui.js"></script>
	<script>
	$("#login").click(function () {
	})
    $("#sms-login").click(function () {
    })
	</script>
	<script>
    var type = 'png';
    var filename = (new Date()).getTime() + '.' + type;
    var saveFile = function(filename) {
        //获取canvas标签里的图片内容
        var imgData = document.getElementById('canvas').toDataURL(type);
        imgData = imgData.replace(_fixType(type), 'image/octet-stream');
        var save_link = document.createElementNS('http://www.w3.org/1999/xhtml', 'a');
        save_link.href = imgData;
        save_link.download = filename;

        var event = document.createEvent('MouseEvents');
        event.initMouseEvent('click', true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
        save_link.dispatchEvent(event);
    };
    //下面的代码是保存canvas标签里的图片并且将其按一定的规则重命名
    var _fixType = function(type) {
        type = type.toLowerCase().replace(/jpg/i, 'jpeg');
        var r = type.match(/png|jpeg|bmp|gif/)[0];
        return 'image/' + r;
    };
	layui.use(['form','element'], function(){
	    var form = layui.form;
		var element = layui.element;

        var width = window.innerWidth;
        var height = window.innerHeight;
        var target = {x: width/2, y: height/2};

        var largeHeader = document.getElementById('large-header');
        largeHeader.style.height = height+'px';

        function resize() {
            width = window.innerWidth;
            height = window.innerHeight;
            largeHeader.style.height = height+'px';
            canvas.width = width;
            canvas.height = height;
        }
        // Event handling
        function addListeners() {
            if(!('ontouchstart' in window)) {
                window.addEventListener('mousemove', mouseMove);
            }
            window.addEventListener('scroll', scrollCheck);
            window.addEventListener('resize', resize);
        }

        $("#sms-verify").click(function(){
            // 发送短信
            $.post("${pageContext.request.contextPath }/login-sms-verify.do",{
                username : $("#sms-username").val()
            },function(data){

            });
            var i = 60;
            $("#sms-verify").text(i+"s");
            $(this).addClass("layui-btn-disabled");
            var interval = setInterval(function(){
                $("#sms-verify").text(--i+"s");
                if(i == 0) {
                    clearInterval(interval);
                    $("#sms-verify").text("获取验证码");
                    $("#sms-verify").removeClass("layui-btn-disabled");
                }
            }, 1000);
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

        $("#face-verify").click(function() {

            $("#face-form").addClass("layui-hide");
            $("#face-check").removeClass("layui-hide");
            $("#video").removeClass("layui-hide");
            var aVideo=document.getElementById('video');
            var aCanvas=document.getElementById('canvas');
            var ctx=aCanvas.getContext('2d');

            if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
                navigator.mediaDevices.getUserMedia({
                    video: true,
                    audio: true
                }).then(function(stream) {
                    mediaStreamTrack = typeof stream.stop === 'function' ? stream : stream.getTracks()[1];
                    video.src = (window.URL || window.webkitURL).createObjectURL(stream);
                    video.play();
                }).catch(function(err) {
                    alert(err);
                })
            }
            var faceCheck = function(){
                ctx.drawImage(aVideo, 0, 0, 320, 240);//将获取视频绘制在画布上
                var canvas = document.getElementById('canvas');
                $.post("${pageContext.request.contextPath }/login-face.do",{
                    username: $("#face-username").val(),
                    img : canvas.toDataURL('image/png')
                },function(result){
                    if(result.msg === 'OK') {
                        $("#face-check").text("验证成功，登录中....");
                        clearInterval(interval);
                        layer.confirm('身份验证成功，请问您要登录吗？', function(index) {
                            location.href='${pageContext.request.contextPath }/index.do';
                        });
                        <%--setTimeout("javascript:location.href='${pageContext.request.contextPath }/index.do'", 1500);--%>
                    } else {
                     $("#face-check").text("请重试，切勿勿遮挡脸部");
                    }
                });

            }
            var interval = setInterval(faceCheck, 3000);
            return false;
        });

        element.on('tab(test)', function(elem){
            var id = $(this).attr('lay-id');
            if(id == 3) {

            } else {
                mediaStreamTrack && mediaStreamTrack.stop();
            }
        });
	});
	</script>
</body>
</html>