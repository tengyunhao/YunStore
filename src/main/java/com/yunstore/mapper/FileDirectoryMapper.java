package com.yunstore.mapper;

import com.yunstore.entity.FileDirectory;
import com.yunstore.entity.FileDirectoryExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface FileDirectoryMapper {
    int countByExample(FileDirectoryExample example);

    int deleteByExample(FileDirectoryExample example);

    int deleteByPrimaryKey(String id);

    int insert(FileDirectory record);

    int insertSelective(FileDirectory record);

    List<FileDirectory> selectByExample(FileDirectoryExample example);

    FileDirectory selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") FileDirectory record, @Param("example") FileDirectoryExample example);

    int updateByExample(@Param("record") FileDirectory record, @Param("example") FileDirectoryExample example);

    int updateByPrimaryKeySelective(FileDirectory record);

    int updateByPrimaryKey(FileDirectory record);
}