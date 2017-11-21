<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<div class="tpl-left-nav tpl-left-nav-hover">
            <div class="tpl-left-nav-title"> 功能导航</div>
            <div class="tpl-left-nav-list">
                <ul class="tpl-left-nav-menu">
                    <li class="tpl-left-nav-item">
                        <a id="nav-index" href="home.do" class="nav-link">
                            <i class="am-icon-home"></i>
                            <span>首页</span>
                        </a>
                    </li>
                    <li class="tpl-left-nav-item">
                        <a id="nav-file" href="file-all.do" class="nav-link tpl-left-nav-link-list">
                            <i class="am-icon-folder"></i>
                            <span>全部文件</span>
                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                        </a>
                        <ul id="nav-file-ul" class="tpl-left-nav-sub-menu">
                            <li>
                                <a id="nav-student-add" href="../other/student-add.jsp">
                                    <i class="am-icon-file-image-o"></i>
                                    <span>图片</span>
                                </a>
                            </li>
                            <li>
                                <a id="nav-student-add2" href="../other/student-add2.jsp">
                                    <i class="am-icon-file-zip-o"></i>
                                    <span>文档</span>
                                </a>
                            </li>
                            <li>
                                <a id="nav-student-list" href="../other/student-list.jsp">
                                    <i class="am-icon-file-video-o"></i>
                                    <span>视频</span>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="tpl-left-nav-item">
                        <a id="nav-dormitory" href="javascript:;" class="nav-link tpl-left-nav-link-list">
                            <i class="am-icon-wpforms"></i>
                            <span>资料组</span>
                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                        </a>
                        <ul id="nav-dormitory-ul" class="tpl-left-nav-sub-menu">
                            <li>
                                <a id="nav-dormitory-add" href="../other/dormitory-add.jsp">
                                    <i class="am-icon-angle-right"></i>
                                    <span>添加宿舍</span>
                                </a>
                            </li>
                            <li>
                                <a id="nav-dormitory-list" href="../other/dormitory-list.jsp">
                                    <i class="am-icon-angle-right"></i>
                                    <span>宿舍列表</span>
                                </a>
                            </li>
                            <li>
                                <a id="nav-dormitory-region" href="../other/dormitory-region.jsp">
                                    <i class="am-icon-angle-right"></i>
                                    <span>区域划分</span>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="tpl-left-nav-item">
                        <a id="nav-model" href="javascript:;" class="nav-link tpl-left-nav-link-list">
                            <i class="am-icon-suitcase"></i>
                            <span>分享组</span>
                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                        </a>
                        <ul id="nav-model-ul" class="tpl-left-nav-sub-menu">
                            <li>
                                <a id="nav-model-add" href="../other/model-add.jsp">
                                    <i class="am-icon-angle-right"></i>
                                    <span>添加模板</span>
                                </a>
                            </li>
                            <li>
                                <a id="nav-model-list" href="../other/model-list.jsp">
                                    <i class="am-icon-angle-right"></i>
                                    <span>模板列表</span>
                                </a>
                            </li>
                        </ul>
                    </li>

                    <li class="tpl-left-nav-item">
                        <a id="nav-grade" href="javascript:;" class="nav-link tpl-left-nav-link-list">
                            <i class="am-icon-table"></i>
                            <span>任务组</span>
                            <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
                        </a>
                        <ul id="nav-grade-ul" class="tpl-left-nav-sub-menu">
                            <li>
                                <a id="nav-grade-list" href="../other/grade-list.jsp">
                                    <i class="am-icon-angle-right"></i>
                                    <span>成绩查询</span>
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>