package com.yunstore.service;

import com.yunstore.entity.GroupMaterial;
import com.yunstore.entity.GroupShare;
import com.yunstore.model.*;

import java.util.List;

public interface GroupService {

    /**
     * 创建"资料组"
     * @param name
     * @param user
     */
    public void createGroupMaterial(String name, String user);

    /**
     * 创建"分享组"
     * @param name
     * @param user
     */
    public void createGroupShare(String name, String user);

    /**
     * 该用户所在的所有"资料组"
     * @param user
     * @return
     */
    public List<GroupMaterial> listGroupMaterial(String user);

    /**
     * 该用户所在的所有"共享组"
     * @param user
     * @return
     */
    public List<GroupShare> listGroupShare(String user);

    /**
     * "资料组"内的所有文件
     * @param group
     * @return
     */
    public List<GroupMaterialFileModel> fileGroupMaterial(String group);

    /**
     * "共享组"内的所有文件
     * @param group
     * @return
     */
    public List<GroupShareFileModel> fileGroupShare(String group);

    /**
     * 分享文件到"资料组"
     * @param file
     * @param group
     * @param user
     */
    public void shareGroupMaterial(String file, String group, String user);

    /**
     * 分享文件到"分享组"
     * @param file
     * @param group
     * @param user
     */
    public void shareGroupShare(String file, String group, String user);

    /**
     * "资料组"内的所有成员
     * @param group
     * @return
     */
    public List<GroupMaterialUserModel> userGroupMaterial(String group);

    /**
     * "共享组"内的所有成员
     * @param group
     * @return
     */
    public List<GroupShareUserModel> userGroupShare(String group);


    /**
     * 不在资料内的好友
     * @param group
     * @return
     */
    public List<FriendModel> friendGroupMaterial(String group);

    /**
     * 邀请好友到资料组内
     * @param group
     * @param users
     */
    public void inviteGroupMaterial(String group, String[] users);

}
