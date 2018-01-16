package com.yunstore.service.impl;

import com.yunstore.entity.*;
import com.yunstore.mapper.*;
import com.yunstore.model.FriendModel;
import com.yunstore.model.TeacherShareFileModel;
import com.yunstore.service.FriendService;
import com.yunstore.utils.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class FriendServiceImpl implements FriendService {

    @Autowired
    private TeacherInfoMapper teacherInfoMapper;
    @Autowired
    private TeacherFriendMapper teacherFriendMapper;
    @Autowired
    private TeacherShareFileMapper teacherShareFileMapper;
    @Autowired
    private FileInfoMapper fileInfoMapper;
    @Autowired
    private FileDirectoryMapper fileDirectoryMapper;
    @Autowired
    private FileTypeDicMapper fileTypeDicMapper;

    @Override
    public boolean addFriend(String friend, String user) {

        TeacherInfoExample example = new TeacherInfoExample();
        example.createCriteria().andUsernameEqualTo(friend);
        List<TeacherInfo> list = teacherInfoMapper.selectByExample(example);
        if(list.size() > 0) {
            TeacherFriend teacherFriend1 = new TeacherFriend();
            teacherFriend1.setTeacher(user);
            teacherFriend1.setFriend(list.get(0).getId());
            teacherFriendMapper.insert(teacherFriend1);

            TeacherFriend teacherFriend2 = new TeacherFriend();
            teacherFriend2.setTeacher(list.get(0).getId());
            teacherFriend2.setFriend(user);
            teacherFriendMapper.insert(teacherFriend2);
            return true;
        } else {
            return false;
        }

    }

    @Override
    public List<FriendModel> listFriend(String user) {

        TeacherFriendExample example = new TeacherFriendExample();
        example.createCriteria().andTeacherEqualTo(user);

        List<TeacherFriend> list = teacherFriendMapper.selectByExample(example);
        List<FriendModel> friends = new ArrayList<>();
        for(TeacherFriend teacherFriend : list) {
            FriendModel friendModel = new FriendModel();
            TeacherInfo friendInfo = teacherInfoMapper.selectByPrimaryKey(teacherFriend.getFriend());
            friendModel.setId(friendInfo.getId());
            friendModel.setName(friendInfo.getName());
            friendModel.setUsername(friendInfo.getUsername());
            friendModel.setRemark(teacherFriend.getRemark());
            friends.add(friendModel);
        }

        return friends;
    }

    @Override
    public void shareFile(String file, String user, String friend) {

        TeacherShareFile shareFile = new TeacherShareFile();
        shareFile.setFile(file);
        shareFile.setUser(user);
        shareFile.setFriend(friend);
        teacherShareFileMapper.insert(shareFile);
    }

    @Override
    public List<TeacherShareFileModel> shareFileList(String friend, String user) {

        List<TeacherShareFileModel> list = new ArrayList<>();

        TeacherShareFileExample example = new TeacherShareFileExample();
        example.createCriteria().andFriendEqualTo(friend).andUserEqualTo(user);
        List<TeacherShareFileModel> selfShareList = shareFileList(teacherShareFileMapper.selectByExample(example), true);

        example.clear();
        example.createCriteria().andFriendEqualTo(user).andUserEqualTo(friend);
        List<TeacherShareFileModel> friendShareList = shareFileList(teacherShareFileMapper.selectByExample(example), false);

        list.addAll(selfShareList);
        list.addAll(friendShareList);
        return list;
    }

    private List<TeacherShareFileModel> shareFileList(List<TeacherShareFile> list, boolean self) {
        List<TeacherShareFileModel> models = new ArrayList<>();
        for (TeacherShareFile shareFile : list) {
            FileInfo fileInfo = fileInfoMapper.selectByPrimaryKey(shareFile.getFile());
            if(fileInfo != null) {
                TeacherShareFileModel model = new TeacherShareFileModel();
                model.setId(fileInfo.getId());
                model.setName(fileInfo.getName());
                model.setTime(fileInfo.getTime());
                model.setType(fileInfo.getType() == null ? "" : fileTypeDicMapper.selectByPrimaryKey(fileInfo.getType()).getType());
                model.setSize(FileUtil.getSize(fileInfo.getUrl()));
                model.setUrl(fileInfo.getUrl());
                model.setSelf(self ? "true":"false");
                models.add(model);
            }
            FileDirectory fileDirectory = fileDirectoryMapper.selectByPrimaryKey(shareFile.getFile());
            if(fileDirectory != null) {
                TeacherShareFileModel model = new TeacherShareFileModel();
                model.setId(fileDirectory.getId());
                model.setName(fileDirectory.getName());
                model.setTime(fileDirectory.getTime());
                model.setType("-");
                model.setSize("-");
                model.setSelf(self ? "true":"false");
                models.add(model);
            }

        }
        return models;
    }

}
