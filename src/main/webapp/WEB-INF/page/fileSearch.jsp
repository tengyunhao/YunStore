<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">
.layui-row {
    margin:15px
}
.layui-elem-field {
    margin-bottom: 10px;
    padding: 0;
    border: 0;
}
.layui-elem-field legend {
    margin-left: 0px;
    padding: 0 0px;
    font-size: 16px;
    font-weight: 300;
    height: 35px
}
.layui-field-box {
    padding: 5px 0px
}
</style>
<div id="index" class="layui-container">
    <div style="margin:0 auto;" class="layui-row">
        <form class="layui-form layui-form-pane" style="margin-top:75px" action="">
            <div class="layui-col-md-offset1 layui-col-xs7 layui-col-sm7 layui-col-md7">
                <div class="layui-input-block">
                    <input type="text" name="name" placeholder="" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-col-xs1 layui-col-sm1 layui-col-md1">
                <button class="layui-btn layui-btn-normal" lay-submit lay-filter="search-index">搜索一下</button>
            </div>
        </form>
    </div>
</div>
<div id="result" class="layui-hide layui-container">
    <form class="layui-form layui-form-pane" style="margin-top:10px" action="">
        <div class="layui-col-xs4 layui-col-sm4 layui-col-md4">
            <label class="layui-form-label">查找文件</label>
            <div class="layui-input-block">
                <input type="text" id="name" name="name" placeholder="请输入文件名称" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-col-xs2 layui-col-sm1 layui-col-md1">
            <select id="typeList" name="type">
                <option value="">类型</option>
            </select>
        </div>
        <div class="layui-col-xs2 layui-col-sm1 layui-col-md1">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="search">搜索一下</button>
        </div>
    </form>
    <div class="layui-row">
        <div style="margin:10px 0 0 -10px;" class="layui-col-xs12 layui-col-sm12 layui-col-md12">
            <lable id="length" style="color:#9b9b9b; font-size:13px"></lable>
        </div>
    </div>
	<div class="flow-default" id="LAY_demo1"></div>
</div>

<script src="res/js/Chart.js"></script>
<script type="text/javascript">
    var preview,lookDirectory;
	layui.use(['form','flow'], function() {
        var form = layui.form;
		var flow = layui.flow;
        var searchName = '简历',searchType;
        form.render();
        preview = function(id) {
            $.getJSON('file-preview.do?file='+id, function(json){
                layer.photos({
                    photos: json,
                    anim: 5 //0-6的选择，指定弹出图片动画类型，默认随机
                });
            });
        };
        $.ajax({
            type : "post",
            url : "${pageContext.request.contextPath }/file/storage/show.do",
            success : function(data) {
                for(var i = 0; i < data.length; i++) {
                    if(data[i].show === 'yes') {
                        $("#typeList").append('<option value="'+data[i].id+'">'+data[i].type+'</option>');
                    }
                }
                form.render();
            },
            error : function() { alert("${pageContext.request.contextPath }/file/storage/show.do"); }
        });

        function flowLoad() {
            flow.load({
                elem: '#LAY_demo1', //流加载容器
                scrollElem: '#LAY_demo1', //滚动条所在元素，一般不用填，此处只是演示需要。
                done: function(page, next) { //执行下一页的回调
                $.post("${pageContext.request.contextPath }/file/search/show.do",{
                    name : searchName,
                    type : searchType,
                    page : page
                },function(data){
                    $("#length").text("为您找到相关结果约 "+data.length+" 个");
                    var lis = [];
                    for(var i = 0; i < data.list.length; i++) {
                        var line = data.list[i];
                        var typeicon = '&#xe8bb;',typecolor = '#00aded;';
                        var filetype = line.name.substring(line.name.lastIndexOf('.')+1);
                        if(filetype === 'doc' || filetype === 'docx') {
                            typeicon = "&#xe8bb;";
                            typecolor = "#00aded;";
                        } else if(filetype === 'ppt' || filetype === 'pptx') {
                            typeicon = "&#xe8b4;";
                            typecolor = "#ed5252;";
                        } else if(filetype === 'xls' || filetype === 'xlsx') {
                            typeicon = "&#xe8a8;";
                            typecolor = "#05c319;";
                        } else if(filetype === 'pdf') {
                            typeicon = "&#xe8b3;";
                            typecolor = "#e1716b;";
                        } else if(filetype === 'mp3') {
                            typeicon = "&#xe8a5;";
                            typecolor = "#ed000d;";
                        }
                        lis.push('<br>'
                                +'<fieldset class="layui-elem-field">'
                                    +'<legend>'
                                        +'<a href="#">'
                                            +'<i class="iconfont" style="float:left; font-size: 28px; color: '+typecolor+'">'+typeicon+'</i>'
                                            +'<div style="float:left; padding-top:5px">'
                                                +'<lable onclick="preview(\''+line.id+'\')">&nbsp;'+line.name+'</lable>'
                                            +'</div>'
                                        +'</a>'
                                    +'</legend>'
                                    +'<div class="layui-field-box">'
                                        +'<p style="color: #696969">目录：<a href="#file/list.do#'+line.directory+'" onclick="location.reload()">'+line.path+'</a></p>'
                                        +'<p style="color: #4b4b4b">[文件名称]：'+line.name+'&nbsp;，[文件类型]：'+line.type+'&nbsp;，[大小]：'+line.size+'&nbsp;，[修改日期]：'+line.time+'</p>'
                                    +'</div>'
                                +'</fieldset>');
                    }
                    next(lis.join(''), page < 10);
                });
                }
            });

        }

        form.on('submit(search)', function(data){
            searchName = data.field.name;
            searchType = data.field.type;
            $("#LAY_demo1").html("");
            flowLoad();
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

        form.on('submit(search-index)', function(data){
            $("#index").addClass("layui-hide");
            $("#result").removeClass("layui-hide");
            searchName = data.field.name;
            searchType = data.field.type;
            $("#name").val(searchName);
            $("#LAY_demo1").html("");
            flowLoad();
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });
    });
	</script>

