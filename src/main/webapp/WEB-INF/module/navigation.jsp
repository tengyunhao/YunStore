<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>   
  <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <div class="kit-side-fold">
        <i class="fa fa-navicon" aria-hidden="true"></i>
      </div>
      <!-- 参数 lay-filter 用于局部更新
      <ul class="layui-nav layui-nav-tree"  lay-filter="test"> -->
      <ul class="layui-nav layui-nav-tree">
        <li class="layui-nav-item" id="nav-file">
          <a href="javascript:;">我的硬盘</a>
          <dl class="layui-nav-child">
            <dd id="nav-file-all"><a href="path-file-all.do">全部文件</a></dd>
            <dd id="nav-file-upload"><a href="path-file-upload.do">文件上传</a></dd>
            <dd><a href="javascript:;">空间管理</a></dd>
          </dl>
        </li>
        <li class="layui-nav-item" id="nav-share">
          <a href="javascript:;">我的群组</a>
          <dl class="layui-nav-child">
            <dd id="nav-share-1"><a href="home.do">办公资料</a></dd>
            <dd id="nav-share-2"><a href="javascript:;">文件共享</a></dd>
            <dd id="nav-share-3"><a href="javascript:;">任务发布</a></dd>
          </dl>
        </li>
        <li class="layui-nav-item"><a href="">我的好友</a></li>
        <li class="layui-nav-item"><a href="">我的日程</a></li>
        <li class="layui-nav-item"><a href="">回收站</a></li>
      </ul>
    </div>
  </div>