package com.yunstore.mapper;

import com.yunstore.entity.GroupMaterialFile;
import com.yunstore.entity.GroupMaterialFileExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface GroupMaterialFileMapper {
    int countByExample(GroupMaterialFileExample example);

    int deleteByExample(GroupMaterialFileExample example);

    int deleteByPrimaryKey(String id);

    int insert(GroupMaterialFile record);

    int insertSelective(GroupMaterialFile record);

    List<GroupMaterialFile> selectByExample(GroupMaterialFileExample example);

    GroupMaterialFile selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") GroupMaterialFile record, @Param("example") GroupMaterialFileExample example);

    int updateByExample(@Param("record") GroupMaterialFile record, @Param("example") GroupMaterialFileExample example);

    int updateByPrimaryKeySelective(GroupMaterialFile record);

    int updateByPrimaryKey(GroupMaterialFile record);
}