package com.yunstore.controller;

import com.yunstore.common.ResponseData;
import com.yunstore.service.FriendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class FriendController {

    @Autowired
    private FriendService friendService;

    @RequestMapping(value = "/add-friend")
    public @ResponseBody ResponseData addFriend(String friend, HttpSession session) {

        String user = (String) session.getAttribute("user");

        if(friendService.addFriend(friend, user)) {

            return ResponseData.ok();
        } else {
            return ResponseData.build(400, "无此用户");
        }
    }

    @RequestMapping(value = "/list-friend")
    public @ResponseBody ResponseData listFriend(HttpSession session) {

        String user = (String) session.getAttribute("user");

        return ResponseData.ok(friendService.listFriend(user));
    }

    /**
     * 向朋友分享文件
     * @param file
     * @param friend
     * @param session
     * @return
     */
    @RequestMapping(value = "/share-file")
    public @ResponseBody ResponseData shareFile(String file, String friend, HttpSession session) {
        friendService.shareFile(file, (String) session.getAttribute("user"), friend);
        return ResponseData.ok();
    }

    /**
     * 朋友给自己和自己给朋友分享的文件
     * @param friend
     * @param session
     * @return
     */
    @RequestMapping(value = "/share-file-list")
    public @ResponseBody ResponseData shareFileList(String friend, HttpSession session) {
        System.out.println(friend);
        return ResponseData.ok(friendService.shareFileList(friend, (String) session.getAttribute("user")));
    }

}
