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
        <li class="layui-nav-item">
          <a href="javascript:;">资料分享</a>
          <dl class="layui-nav-child">
            <dd><a href="javascript:;">分享组</a></dd>
            <dd><a href="javascript:;">资料组</a></dd>
            <dd><a href="javascript:;">任务组</a></dd>
          </dl>
        </li>
        <li class="layui-nav-item"><a href="">我的日程</a></li>
        <li class="layui-nav-item"><a href="">回收站</a></li>
      </ul>
    </div>
  </div>