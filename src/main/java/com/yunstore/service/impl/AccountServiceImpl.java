package com.yunstore.service.impl;

import com.yunstore.entity.*;
import com.yunstore.mapper.StudentInfoMapper;
import com.yunstore.mapper.TeacherFaceMapper;
import com.yunstore.utils.CodeUtil;
import com.yunstore.utils.MD5Util;
import com.yunstore.mapper.TeacherInfoMapper;
import com.yunstore.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AccountServiceImpl implements AccountService {

    @Autowired
    private TeacherInfoMapper teacherInfoMapper;
    @Autowired
    private TeacherFaceMapper teacherFaceMapper;

    @Override
    public TeacherInfo login(String username, String password) {

        TeacherInfoExample example = new TeacherInfoExample();
        example.createCriteria()
                .andUsernameEqualTo(username)
                .andPasswordEqualTo(password);

        List<TeacherInfo> list = teacherInfoMapper.selectByExample(example);

        if(!list.isEmpty()) {
            return list.get(0);
        } else {
            return null;
        }
    }

    @Override
    public boolean register(String username, String password) {

        TeacherInfo teacherInfo = new TeacherInfo();
        teacherInfo.setUsername(username);
        teacherInfo.setPassword(MD5Util.getMD5(password));
        teacherInfo.setName("用户"+ CodeUtil.getVerifyCode());

        return teacherInfoMapper.insert(teacherInfo) != 0 ;
    }

    @Override
    public boolean addFace(String teacher, String img) {

        TeacherFace face = new TeacherFace();
        face.setTeacher(teacher);
        face.setFace(img);
        return teacherFaceMapper.insert(face) != 0;
    }

    @Override
    public boolean updateFace(String teacher, String img) {

        TeacherFace face = new TeacherFace();
        face.setTeacher(teacher);
        face.setFace(img);
        return teacherFaceMapper.updateByPrimaryKey(face) != 0;
    }

    @Override
    public String getFace(String teacher) {
        TeacherFace face = teacherFaceMapper.selectByPrimaryKey(teacher);
        return face.getFace();
    }

    @Override
    public TeacherInfo getId(String username) {

        TeacherInfoExample example = new TeacherInfoExample();
        example.createCriteria().andUsernameEqualTo(username);
        List<TeacherInfo> list = teacherInfoMapper.selectByExample(example);

        if(list.size() > 0) {
            return list.get(0);
        }

        return null;
    }
}
