<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>表单集合演示</legend>
</fieldset>
<div class="layui-form-item">
    <label class="layui-form-label">名称修改</label>
    <div class="layui-input-inline">
        <input type="text" name="identity" value="${name}" class="layui-input">
        <button id="update-name" class="layui-btn layui-btn-sm">确认修改</button>
    </div>
</div>
<div class="layui-form-item">
    <label class="layui-form-label">密码修改</label>
    <div class="layui-input-inline">
        <input type="password" name="password" lay-verify="pass" placeholder="输入旧密码" class="layui-input">
        <input type="password" name="password" lay-verify="pass" placeholder="输入新密码" class="layui-input">
        <input type="password" name="password" lay-verify="pass" placeholder="确认新密码" class="layui-input">
        <button id="update-password" class="layui-btn layui-btn-sm">确认修改</button>
    </div>
    <div class="layui-form-mid layui-word-aux">请填写6到12位密码</div>
</div>

<div class="layui-form-item">
    <label class="layui-form-label">更改识别图</label>
    <div class="layui-input-inline">
        <video id="video" width="320" height="240" autoplay></video>
        <canvas id="canvas" width="320" height="240"></canvas>
        <button id="snap">拍照</button>
        <button id="again">重拍</button>
        <button id="update-face" onClick="saveFile(filename);" type="button">确认更换</button>
    </div>
</div>

<script type="text/javascript">

layui.use(['form'], function() {
	var form = layui.form;
    var aVideo=document.getElementById('video');
    var aCanvas=document.getElementById('canvas');
    var ctx=aCanvas.getContext('2d');

    navigator.getUserMedia  = navigator.getUserMedia ||
    navigator.webkitGetUserMedia ||
    navigator.mozGetUserMedia ||
    navigator.msGetUserMedia;//获取媒体对象（这里指摄像头）
    navigator.getUserMedia({video:true}, gotStream, noStream);//参数1获取用户打开权限；参数二成功打开后调用，并传一个视频流对象，参数三打开失败后调用，传错误信息

    function gotStream(stream) {
    video.src = URL.createObjectURL(stream);
    video.onerror = function () {
    stream.stop();
    };
    stream.onended = noStream;
    video.onloadedmetadata = function () {
    //            alert('摄像头成功打开！');
    };
    }
    function noStream(err) {
    alert(err);
    }

    $("#canvas").addClass("layui-hide");
    $("#again").addClass("layui-hide");
    document.getElementById("snap").addEventListener("click", function() {
        ctx.drawImage(aVideo, 0, 0, 320, 240);//将获取视频绘制在画布上
        $("#video").addClass("layui-hide");
        $("#canvas").removeClass("layui-hide");
        $("#again").removeClass("layui-hide");
        $(this).addClass("layui-hide");
    });
    document.getElementById("again").addEventListener("click", function() {
        $("#canvas").addClass("layui-hide");
        $("#video").removeClass("layui-hide");
        $("#snap").removeClass("layui-hide");
        $(this).addClass("layui-hide");
    });

    $("#update-face").click(function(){

        $.post("${pageContext.request.contextPath }/update-face.do",{
        img : document.getElementById('canvas').toDataURL('image/png')
        },function(result){
            alert(result.msg);
        });

    });

});

</script>

