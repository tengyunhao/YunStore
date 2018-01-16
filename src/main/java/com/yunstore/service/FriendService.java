package com.yunstore.service;

import com.yunstore.model.FriendModel;
import com.yunstore.model.TeacherShareFileModel;

import java.util.List;

public interface FriendService {

    public boolean addFriend(String friend, String user);

    public List<FriendModel> listFriend(String user);

    public void shareFile(String file, String user, String friend);

    public List<TeacherShareFileModel> shareFileList(String friend, String user);
    
}
