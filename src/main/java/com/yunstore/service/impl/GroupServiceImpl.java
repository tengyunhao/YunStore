package com.yunstore.service.impl;

import com.yunstore.model.*;
import com.yunstore.utils.DateUtil;
import com.yunstore.entity.*;
import com.yunstore.mapper.*;
import com.yunstore.service.GroupService;
import com.yunstore.utils.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class GroupServiceImpl implements GroupService {

    @Autowired
    private GroupMaterialMapper groupMaterialMapper;
    @Autowired
    private GroupShareMapper groupShareMapper;
    @Autowired
    private GroupMaterialFileMapper groupMaterialFileMapper;
    @Autowired
    private GroupShareFileMapper groupShareFileMapper;
    @Autowired
    private GroupMaterialUserMapper groupMaterialUserMapper;
    @Autowired
    private GroupShareUserMapper groupShareUserMapper;
    @Autowired
    private FileInfoMapper fileInfoMapper;
    @Autowired
    private FileTypeDicMapper fileTypeDicMapper;
    @Autowired
    private FileDirectoryMapper fileDirectoryMapper;
    @Autowired
    private TeacherInfoMapper teacherInfoMapper;
    @Autowired
    private TeacherFriendMapper teacherFriendMapper;

    @Override
    public void createGroupMaterial(String name, String user) {

        GroupMaterial groupMaterial = new GroupMaterial();
        groupMaterial.setOwner(user);
        groupMaterial.setName(name);
        groupMaterial.setTime(DateUtil.dateToString(new Date()));
        groupMaterialMapper.insert(groupMaterial);
    }

    @Override
    public void createGroupShare(String name, String user) {

        GroupShare groupShare = new GroupShare();
        groupShare.setOwner(user);
        groupShare.setName(name);
        groupShare.setTime(DateUtil.dateToString(new Date()));
        groupShareMapper.insert(groupShare);
    }

    @Override
    public List<GroupMaterial> listGroupMaterial(String user) {
        // 自己是群主
        GroupMaterialExample example = new GroupMaterialExample();
        example.createCriteria().andOwnerEqualTo(user);
        List<GroupMaterial> list = groupMaterialMapper.selectByExample(example);
        // 自己是成员
        GroupMaterialUserExample userExample = new GroupMaterialUserExample();
        userExample.createCriteria().andUserEqualTo(user);
        List<GroupMaterialUser> groupMaterialUserList = groupMaterialUserMapper.selectByExample(userExample);
        for (GroupMaterialUser groupMaterialUser : groupMaterialUserList) {
            GroupMaterial groupMaterial = groupMaterialMapper.selectByPrimaryKey(groupMaterialUser.getGroup());
            list.add(groupMaterial);
        }
        return list;
    }

    @Override
    public List<GroupShare> listGroupShare(String user) {
        // 自己是群主
        GroupShareExample example = new GroupShareExample();
        example.createCriteria().andOwnerEqualTo(user);
        List<GroupShare> list = groupShareMapper.selectByExample(example);
        // 自己是成员
        GroupShareUserExample userExample = new GroupShareUserExample();
        userExample.createCriteria().andUserEqualTo(user);
        List<GroupShareUser> groupSharelUserList = groupShareUserMapper.selectByExample(userExample);
        for (GroupShareUser groupShareUser : groupSharelUserList) {
            GroupShare groupShare = groupShareMapper.selectByPrimaryKey(groupShareUser.getGroup());
            list.add(groupShare);
        }
        return list;
    }

    @Override
    public List<GroupMaterialFileModel> fileGroupMaterial(String group) {

        GroupMaterialFileExample example = new GroupMaterialFileExample();
        example.createCriteria().andGroupEqualTo(group);
        List<GroupMaterialFile> list = groupMaterialFileMapper.selectByExample(example);

        List<GroupMaterialFileModel> models = new ArrayList<>();
        for (GroupMaterialFile file : list) {
            TeacherInfo teacherInfo = teacherInfoMapper.selectByPrimaryKey(file.getUser());
            GroupMaterialFileModel model = new GroupMaterialFileModel();
            FileInfo fileInfo = fileInfoMapper.selectByPrimaryKey(file.getFile());
            // 如果fileinfo为空说明是一个文件夹
            if(fileInfo == null) {
                FileDirectory fileDirectory = fileDirectoryMapper.selectByPrimaryKey(file.getFile());
                model.setId(fileDirectory.getId());
                model.setName(fileDirectory.getName());
                model.setTime(file.getTime());
                model.setType("-");
                model.setTeacher(teacherInfo.getName());
                models.add(model);
            } else {
                model.setId(fileInfo.getId());
                model.setName(fileInfo.getName());
                model.setUrl(fileInfo.getUrl());
                model.setTime(file.getTime());
                model.setSize(FileUtil.getSize(fileInfo.getUrl()));
                model.setType(fileInfo.getType() == null ? "" : fileTypeDicMapper.selectByPrimaryKey(fileInfo.getType()).getType());
                model.setTeacher(teacherInfo.getName());
                models.add(model);
            }
        }

        return models;
    }

    @Override
    public List<GroupShareFileModel> fileGroupShare(String group) {
        GroupShareFileExample example = new GroupShareFileExample();
        example.createCriteria().andGroupEqualTo(group);
        List<GroupShareFile> list = groupShareFileMapper.selectByExample(example);
        List<GroupShareFileModel> models = new ArrayList<>();
        for (GroupShareFile file : list) {
            GroupShareFileModel model = new GroupShareFileModel();
            // 也可能是学生分享的。暂时先按老师的来
            TeacherInfo teacherInfo = teacherInfoMapper.selectByPrimaryKey(file.getUser());
            if(teacherInfo != null) {
                String name = teacherInfo.getName();
                FileInfo fileInfo = fileInfoMapper.selectByPrimaryKey(file.getFile());
                // 如果fileinfo为空说明是一个文件夹
                if(fileInfo == null) {
                    FileDirectory fileDirectory = fileDirectoryMapper.selectByPrimaryKey(file.getFile());
                    model.setId(fileDirectory.getId());
                    model.setName(fileDirectory.getName());
                    model.setTime(file.getTime());
                    model.setType("-");
                    model.setTeacher(name);
                    models.add(model);
                } else {
                    model.setId(fileInfo.getId());
                    model.setName(fileInfo.getName());
                    model.setUrl(fileInfo.getUrl());
                    model.setTime(file.getTime());
                    model.setSize(FileUtil.getSize(fileInfo.getUrl()));
                    model.setType(fileInfo.getType() == null ? "" : fileTypeDicMapper.selectByPrimaryKey(fileInfo.getType()).getType());
                    model.setTeacher(name);
                    models.add(model);
                }
            }
        }

        return models;
    }

    @Override
    public void shareGroupMaterial(String file, String group, String user) {

        GroupMaterialFile share = new GroupMaterialFile();
        share.setFile(file);
        share.setGroup(group);
        share.setUser(user);
        share.setTime(DateUtil.dateToString(new Date()));
        groupMaterialFileMapper.insert(share);
    }

    @Override
    public void shareGroupShare(String file, String group, String user) {

        GroupShareFile share = new GroupShareFile();
        share.setFile(file);
        share.setGroup(group);
        share.setUser(user);
        System.out.println("判断是学生还是老师");
        share.setTime(DateUtil.dateToString(new Date()));
        groupShareFileMapper.insert(share);
    }

    @Override
    public List<GroupMaterialUserModel> userGroupMaterial(String group) {

        GroupMaterialUserExample example = new GroupMaterialUserExample();
        example.createCriteria().andGroupEqualTo(group);
        List<GroupMaterialUser> list = groupMaterialUserMapper.selectByExample(example);
        List<GroupMaterialUserModel> models = new ArrayList<>();
        // 获取群主
        GroupMaterial groupMaterial = groupMaterialMapper.selectByPrimaryKey(group);
        TeacherInfo owner = teacherInfoMapper.selectByPrimaryKey(groupMaterial.getOwner());
        GroupMaterialUserModel ownerModel = new GroupMaterialUserModel();
        ownerModel.setId(owner.getId());
        ownerModel.setName(owner.getName());
        ownerModel.setUsername(owner.getUsername());
        ownerModel.setRank("群主");
        models.add(ownerModel);
        // 获取其他群成员
        for (GroupMaterialUser user : list) {
            TeacherInfo teacherInfo = teacherInfoMapper.selectByPrimaryKey(user.getUser());
            GroupMaterialUserModel model = new GroupMaterialUserModel();
            model.setId(user.getUser());
            model.setName(teacherInfo.getName());
            model.setUsername(teacherInfo.getUsername());
            switch (user.getRank()) {
                case 0 :
                    model.setRank("群众");
                    break;
                case 1 :
                    model.setRank("群官");
                    break;
            }
            models.add(model);
        }

        return models;
    }

    @Override
    public List<GroupShareUserModel> userGroupShare(String group) {
        GroupShareUserExample example = new GroupShareUserExample();
        example.createCriteria().andGroupEqualTo(group);
        List<GroupShareUser> list = groupShareUserMapper.selectByExample(example);
        List<GroupShareUserModel> models = new ArrayList<>();
        // 获取群主
        GroupShare groupShare = groupShareMapper.selectByPrimaryKey(group);
        TeacherInfo owner = teacherInfoMapper.selectByPrimaryKey(groupShare.getOwner());
        GroupShareUserModel ownerModel = new GroupShareUserModel();
        ownerModel.setId(owner.getId());
        ownerModel.setName(owner.getName());
        ownerModel.setUsername(owner.getUsername());
        ownerModel.setRank("群主");
        models.add(ownerModel);
        // 获取其他群成员
        for (GroupShareUser user : list) {
            // 也可能是学生，暂时按照老师来
            TeacherInfo teacherInfo = teacherInfoMapper.selectByPrimaryKey(user.getUser());
            GroupShareUserModel model = new GroupShareUserModel();
            model.setId(user.getUser());
            model.setName(teacherInfo.getName());
            model.setUsername(teacherInfo.getUsername());
            model.setRank("群众");
            models.add(model);
        }

        return models;
    }

    @Override
    public List<FriendModel> friendGroupMaterial(String group) {

//        TeacherFriendExample example = new TeacherFriendExample();
//        example.createCriteria().andTeacherEqualTo(user);
//
//        List<TeacherFriend> list = teacherFriendMapper.selectByExample(example);
//        List<FriendModel> friends = new ArrayList<>();
//        for(TeacherFriend teacherFriend : list) {
//            FriendModel friendModel = new FriendModel();
//            TeacherInfo friendInfo = teacherInfoMapper.selectByPrimaryKey(teacherFriend.getFriend());
//            friendModel.setId(friendInfo.getId());
//            friendModel.setName(friendInfo.getName());
//            friendModel.setUsername(friendInfo.getUsername());
//            friendModel.setRemark(teacherFriend.getRemark());
//
////            friends.add(friendModel);
//        }

        return null;
    }

    @Override
    public void inviteGroupMaterial(String group, String[] users) {

        for (String user : users) {
            GroupMaterialUser groupUser = new GroupMaterialUser();
            groupUser.setUser(user);
            groupUser.setGroup(group);
            groupUser.setRank(0);
            groupMaterialUserMapper.insert(groupUser);
        }

    }
}
