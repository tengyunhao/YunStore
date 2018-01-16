package com.yunstore.mapper;

import com.yunstore.entity.TeacherStorage;
import com.yunstore.entity.TeacherStorageExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TeacherStorageMapper {
    int countByExample(TeacherStorageExample example);

    int deleteByExample(TeacherStorageExample example);

    int deleteByPrimaryKey(String id);

    int insert(TeacherStorage record);

    int insertSelective(TeacherStorage record);

    List<TeacherStorage> selectByExample(TeacherStorageExample example);

    TeacherStorage selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") TeacherStorage record, @Param("example") TeacherStorageExample example);

    int updateByExample(@Param("record") TeacherStorage record, @Param("example") TeacherStorageExample example);

    int updateByPrimaryKeySelective(TeacherStorage record);

    int updateByPrimaryKey(TeacherStorage record);
}