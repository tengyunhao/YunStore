package com.yunstore.service;

import com.yunstore.entity.StudentInfo;
import com.yunstore.entity.TeacherInfo;

public interface AccountService {

    public TeacherInfo login(String username, String password);

    public boolean register(String username, String password);

    public boolean addFace(String teacher, String img);

    public boolean updateFace(String teacher, String img);

    public String getFace(String teacher);

    public TeacherInfo getId(String username);

}
