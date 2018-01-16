package com.yunstore.mapper;

import com.yunstore.entity.TeacherFriend;
import com.yunstore.entity.TeacherFriendExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TeacherFriendMapper {
    int countByExample(TeacherFriendExample example);

    int deleteByExample(TeacherFriendExample example);

    int deleteByPrimaryKey(String id);

    int insert(TeacherFriend record);

    int insertSelective(TeacherFriend record);

    List<TeacherFriend> selectByExample(TeacherFriendExample example);

    TeacherFriend selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") TeacherFriend record, @Param("example") TeacherFriendExample example);

    int updateByExample(@Param("record") TeacherFriend record, @Param("example") TeacherFriendExample example);

    int updateByPrimaryKeySelective(TeacherFriend record);

    int updateByPrimaryKey(TeacherFriend record);
}