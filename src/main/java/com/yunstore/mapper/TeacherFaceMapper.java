package com.yunstore.mapper;

import com.yunstore.entity.TeacherFace;
import com.yunstore.entity.TeacherFaceExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TeacherFaceMapper {
    int countByExample(TeacherFaceExample example);

    int deleteByExample(TeacherFaceExample example);

    int deleteByPrimaryKey(String teacher);

    int insert(TeacherFace record);

    int insertSelective(TeacherFace record);

    List<TeacherFace> selectByExample(TeacherFaceExample example);

    TeacherFace selectByPrimaryKey(String teacher);

    int updateByExampleSelective(@Param("record") TeacherFace record, @Param("example") TeacherFaceExample example);

    int updateByExample(@Param("record") TeacherFace record, @Param("example") TeacherFaceExample example);

    int updateByPrimaryKeySelective(TeacherFace record);

    int updateByPrimaryKey(TeacherFace record);
}