    <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="login.css" type="text/css" />
<link rel="stylesheet" href="res/css/layui.css">

<!-- <script src="./js/jquery-1.7.2.js"></script> -->
<style>
body { background: url(res/css/006.jpg) }
.register {
    background-color: #FFFFFF;
    height: 420px;
}
</style>
</head>
<body>
    <div class="wrap">
        <div class="logo">
            <a href="#">
            <!--<img src="#" alt="该链接已失效">-->
            </a>
        </div>
        <div class="register-wrap" id="register-wrap">
            <div class="pic">
            <!--<img src="./images/zhuce_400x300.jpg" alt="该链接已失效"/>-->
            </div>
            <div class="register"id="register" style="border-radius:20px;">
                <div class="register-top" id="reg-top">
                    <h2 class="normal"id="normal">普通登录</h2>
                    <h2 class="nopassword"id="nopw">短信验证登录</h2>
                    <a  id="qrcode"href="#"></a>
                </div>
                <!--普通登录-->
                <div class="register-con" id="rc">
                    <form action="#">
                        <ul>
                            <li id="rc-inner-num">
                                <i></i>
                                <span>请输入正确的手机号码</span>
                            </li>
                            <li id="rc-inner-virity">
                                <i></i>
                                <span>请输入密码</span>
                            </li>
                            <li id="rc-innerError" style="width:300px; height:32px;padding:0 6px; color:#ff0011; border:1px solid #ffd797;display:none;">
                                <i style="display:inline-block;float:left;width:20px;height:20px;margin:6px 10px;border:none;background:url(./images/bz_16x16.png) no-repeat 0 0;"></i>
                                <span style="color:#ff1877;display:inline-block;float:left;line-height:26px;">您输入的用户名或密码不正确</span>
                            </li>
                            <li class="form-group">
                                <input type="text" name="phone-num" id="username" class="form-control" placeholder="手机号码"/>
                                <span class="fa fa-check success" style="display:none;color:green;position:relative;left:-25px;top:5px;"></span>
                            </li>
                            <li class="form-group">
                                <input type="password"name="password" id="password"class="form-control"placeholder="密码"/>
                            </li>
                            <li class="read">
                                <a href="#">忘记密码？</a>
                            </li>
                            <li>
                                <button type="button" id="login-btn"style="border-radius:5px;">立即登录</button>
                            </li>
                            <li>
                                <a href="#" id="face-verify" class="haiwai">人脸识别登陆</a>
                                <a href="${pageContext.request.contextPath }/register.do"class="zhuce">新用户注册</a>
                            </li>
                        </ul>
                    </form>
                </div>
                <!--手机无密码登录-->
                <div class="login-con" id="lc">
                    <form action="#">
                        <ul>
                            <li id="inner-num">
                                <i></i>
                                <span>请输入手机号码</span>
                            </li>
                            <li id="inner-virity1">
                                <i></i>
                                <span>请输入验证码</span>
                            </li>
                            <li class="lg-num  form-group">
                                <select name="country" id="country"class="info-select"style="border-radius:5px;">
                                    <option value="中国">中国</option>
                                </select>
                                <input type="text" name="phone-num" id="sms-username" class="form-control" placeholder="手机号码"/>
                                <span class="fa fa-check success" style="display:none;color:green;position:relative;left:-25px;top:5px;"></span>
                            </li>
                            <li class="password form-group">
                                <input name="password" id="sms-password" class="form-control" placeholder="动态密码"/>
                            </li>
                            <li>
                                <button class="getcode" id="sms-verify" style="border-radius:5px;">获取手机动态密码</button>
                            </li>
                            <li class="read">
                                <a href="#">忘记密码？</a>
                            </li>
                            <li>
                                <button type="button" id="sms-login" style="border-radius:5px;">登录</button>
                            </li>
                            <li>
                                <a href="#" class="haiwai">人脸识别登陆</a>
                                <a href="${pageContext.request.contextPath }/register.do"class="zhuce">新用户注册</a>
                            </li>
                        </ul>
                    </form>

                </div>
                <!-- 扫码登录 -->
                <div class="saoma" id="sm">
                    <div class="screen-tu"id="screen"></div>
                    <div class="saoyisao"></div>
                    <div class="qr-code">
                        <img src="./images/ereima_202x202.png" alt="">
                    </div>
                    <div class="link">
                        <a href="#">点击下载蘑菇街APP</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="res/jquery.min.js"></script>
    <script src="res/layui.js"></script>
    <script src="login.js"></script>
    <script>
    $("#login-btn").click(function() {
        $.post("${pageContext.request.contextPath }/login-check.do",{
            username : $("#username").val(),
            password : $("#password").val()
        },function(data){
            if(data.status == 200) {
                location.href='${pageContext.request.contextPath }/index.do';
            } else {
                $('#rc-inner-num').show().text();
                $('#rc-inner-virity').hide();
                $('#rc-inner-num > span').text('手机号码不存在,请重新输入！');
            }
        });
    });
    $("#sms-login").click(function() {
        $.post("login-sms-check.do",{
            username : $("#sms-username").val(),
            verify : $("#sms-password").val()
        },function(data){
            if(data.status == 200) {
                location.href='${pageContext.request.contextPath }/index.do';
            } else {
                $('#rc-inner-num').show().text();
                $('#rc-inner-virity').hide();
                $('#rc-inner-num > span').text('手机号码不存在,请重新输入！');
            }
        });
    });
    $("#sms-verify").click(function() {
        // 发送短信
        $.post("${pageContext.request.contextPath }/login-sms-verify.do",{
            username : $("#sms-username").val()
        },function(data){

        });
        var i = 60;
        $("#sms-verify").css("color","lightgrey");
        $("#sms-verify").attr('disabled',"true");
        $("#sms-verify").text(i+"s");
        var interval = setInterval(function(){
            $("#sms-verify").text(--i+"s");
            if(i == 0) {
                clearInterval(interval);
                $("#sms-verify").text("获取验证码");
                $("#sms-verify").removeAttr("disabled");
                $("#sms-verify").css("color","");
            }
        }, 1000);
        return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
    });
    layui.use(['layer','form','element'], function() {
        var form = layui.form;
        var element = layui.element;
        var layer = layui.layer;
        <%--layer.msg('hello');--%>
        $("#face-verify").click(function(){
            layer.prompt({title: '输入用户名', formType: 0}, function(value, index){
                layer.close(index);
                layer.open({
                    type: 2,
                    title: '人脸识别',
                    shadeClose: true,
                    shade: 0.8,
                    area: ['480px', '425'],
                    content: '${pageContext.request.contextPath }/loginface.do?face='+value //iframe的url
                });
            });
        });
    });
    </script>
</body>
</html>