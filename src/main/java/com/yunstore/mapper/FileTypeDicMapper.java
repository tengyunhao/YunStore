package com.yunstore.mapper;

import com.yunstore.entity.FileTypeDic;
import com.yunstore.entity.FileTypeDicExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface FileTypeDicMapper {
    int countByExample(FileTypeDicExample example);

    int deleteByExample(FileTypeDicExample example);

    int deleteByPrimaryKey(String id);

    int insert(FileTypeDic record);

    int insertSelective(FileTypeDic record);

    List<FileTypeDic> selectByExample(FileTypeDicExample example);

    FileTypeDic selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") FileTypeDic record, @Param("example") FileTypeDicExample example);

    int updateByExample(@Param("record") FileTypeDic record, @Param("example") FileTypeDicExample example);

    int updateByPrimaryKeySelective(FileTypeDic record);

    int updateByPrimaryKey(FileTypeDic record);
}