package com.yunstore.controller;

import com.yunstore.common.ResponseData;
import com.yunstore.service.GroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class GroupController {

    @Autowired
    private GroupService groupService;

    /**
     * 创建"资料组"
     * @param name 资料组名称
     * @param session
     * @return
     */
    @RequestMapping(value = "/add-group-material")
    public @ResponseBody ResponseData addGroupMaterial(String name, HttpSession session) {
        String user = (String) session.getAttribute("user");
        groupService.createGroupMaterial(name, user);
        return ResponseData.ok();
    }

    /**
     * 创建"分享组"
     * @param name 资料组名称
     * @param session
     * @return
     */
    @RequestMapping(value = "/add-group-share")
    public @ResponseBody ResponseData addGroupShare(String name, HttpSession session) {
        String user = (String) session.getAttribute("user");
        groupService.createGroupShare(name, user);
        return ResponseData.ok();
    }

    /**
     * 用户所参与的"资料组"
     * @param session
     * @return
     */
    @RequestMapping(value = "/list-group-material")
    public @ResponseBody ResponseData listGroupMaterial(HttpSession session) {
        String user = (String) session.getAttribute("user");
        return ResponseData.ok(groupService.listGroupMaterial(user));
    }

    /**
     * 用户所参与的"分享组"
     * @param session
     * @return
     */
    @RequestMapping(value = "/list-group-share")
    public @ResponseBody ResponseData listGroupShare(HttpSession session) {
        String user = (String) session.getAttribute("user");
        return ResponseData.ok(groupService.listGroupShare(user));
    }

    /**
     * "资料组"内的所有文件
     * @param group 资料组ID
     * @return
     */
    @RequestMapping(value = "/file-group-material")
    public @ResponseBody ResponseData fileGroupMaterial(String group) {

        return ResponseData.ok(groupService.fileGroupMaterial(group));
    }

    /**
     * "共享组"内的所有文件
     * @param group 资料组ID
     * @return
     */
    @RequestMapping(value = "/file-group-share")
    public @ResponseBody ResponseData fileGroupShare(String group) {

        return ResponseData.ok(groupService.fileGroupShare(group));
    }

    /**
     * 分享文件到"资料组"内
     * @param file
     * @param group
     * @param session
     * @return
     */
    @RequestMapping(value = "/share-group-material")
    public @ResponseBody ResponseData shareGroupMaterial(String file, String group, HttpSession session) {

        groupService.shareGroupMaterial(file, group, (String) session.getAttribute("user"));
        return ResponseData.ok();
    }

    /**
     * 分享文件到"共享组"内
     * @param file
     * @param group
     * @param session
     * @return
     */
    @RequestMapping(value = "/share-group-share")
    public @ResponseBody ResponseData shareGroupShare(String file, String group, HttpSession session) {

        groupService.shareGroupShare(file, group, (String) session.getAttribute("user"));
        return ResponseData.ok();
    }

    /**
     * "资料组"内的所有成员
     * @param group
     * @return
     */
    @RequestMapping(value = "/user-group-material")
    public @ResponseBody ResponseData userGroupMaterial(String group) {

        return ResponseData.ok(groupService.userGroupMaterial(group));
    }

    /**
     * "共享组"内的所有成员
     * @param group
     * @return
     */
    @RequestMapping(value = "/user-group-share")
    public @ResponseBody ResponseData userGroupShare(String group) {

        return ResponseData.ok(groupService.userGroupShare(group));
    }

    /**
     * 不在资料组内的好友
     * @param group
     * @return
     */
    @RequestMapping(value = "/friend-group-material")
    public @ResponseBody ResponseData friendGroupMaterial(String group) {

        return ResponseData.ok();
    }

    /**
     * 邀请好友到资料组内
     * @param group
     * @param users
     * @return
     */
    @RequestMapping(value = "/invite-group-material")
    public @ResponseBody ResponseData inviteGroupMaterial(String group, @RequestParam(value = "users[]") String[] users) {

        groupService.inviteGroupMaterial(group, users);
        return ResponseData.ok();
    }

}
