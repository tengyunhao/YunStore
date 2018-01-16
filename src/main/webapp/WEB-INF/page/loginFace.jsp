    <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
</head>
<body>
    <video id="video" width="465" autoplay></video>
    <lable style="display:none;" id="face-check" style="color:#3F3F3F">人脸识别中……为保证识别率，请勿遮挡脸部</lable>
    <canvas style="display:none;" id="canvas" width="320" height="240"></canvas>
	<script src="res/jquery.min.js"></script>
	<script>
    <%--$("#face-verify").click(function() {--%>

        <%--$("#face-form").addClass("layui-hide");--%>
        <%--$("#face-check").removeClass("layui-hide");--%>
        <%--$("#video").removeClass("layui-hide");--%>
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
                setTimeout(function(){
                    $("#face-check").css("display","");
                }, 1500);
            }).catch(function(err) {
                alert(err);
            })
        }
        var faceCheck = function(){
            ctx.drawImage(aVideo, 0, 0, 320, 240);//将获取视频绘制在画布上
            var canvas = document.getElementById('canvas');
            var url = location.href;
            var username = url.substring(url.indexOf('face=')+5);
            $.post("${pageContext.request.contextPath }/login-face.do",{
                username: username,
                img : canvas.toDataURL('image/png')
            },function(result){
                if(result.msg === 'OK') {
                    $("#face-check").text("验证成功，登录中....");
                    clearInterval(interval);
                    setTimeout("javascript:window.parent.location.href='${pageContext.request.contextPath }/index.do'", 1500);
                } else {
                 $("#face-check").text("请重试，切勿勿遮挡脸部");
                }
            });

        }
        var interval = setInterval(faceCheck, 3000);
        <%--return false;--%>
    <%--});--%>
	</script>
        <%--mediaStreamTrack && mediaStreamTrack.stop();--%>
</body>
</html>