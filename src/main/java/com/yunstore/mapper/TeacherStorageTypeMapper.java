package com.yunstore.mapper;

import com.yunstore.entity.TeacherStorageType;
import com.yunstore.entity.TeacherStorageTypeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TeacherStorageTypeMapper {
    int countByExample(TeacherStorageTypeExample example);

    int deleteByExample(TeacherStorageTypeExample example);

    int deleteByPrimaryKey(String id);

    int insert(TeacherStorageType record);

    int insertSelective(TeacherStorageType record);

    List<TeacherStorageType> selectByExample(TeacherStorageTypeExample example);

    TeacherStorageType selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") TeacherStorageType record, @Param("example") TeacherStorageTypeExample example);

    int updateByExample(@Param("record") TeacherStorageType record, @Param("example") TeacherStorageTypeExample example);

    int updateByPrimaryKeySelective(TeacherStorageType record);

    int updateByPrimaryKey(TeacherStorageType record);
}