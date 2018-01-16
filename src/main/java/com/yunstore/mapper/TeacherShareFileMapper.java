package com.yunstore.mapper;

import com.yunstore.entity.TeacherShareFile;
import com.yunstore.entity.TeacherShareFileExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TeacherShareFileMapper {
    int countByExample(TeacherShareFileExample example);

    int deleteByExample(TeacherShareFileExample example);

    int deleteByPrimaryKey(String id);

    int insert(TeacherShareFile record);

    int insertSelective(TeacherShareFile record);

    List<TeacherShareFile> selectByExample(TeacherShareFileExample example);

    TeacherShareFile selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") TeacherShareFile record, @Param("example") TeacherShareFileExample example);

    int updateByExample(@Param("record") TeacherShareFile record, @Param("example") TeacherShareFileExample example);

    int updateByPrimaryKeySelective(TeacherShareFile record);

    int updateByPrimaryKey(TeacherShareFile record);
}