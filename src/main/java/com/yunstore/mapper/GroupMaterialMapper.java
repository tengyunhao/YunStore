package com.yunstore.mapper;

import com.yunstore.entity.GroupMaterial;
import com.yunstore.entity.GroupMaterialExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface GroupMaterialMapper {
    int countByExample(GroupMaterialExample example);

    int deleteByExample(GroupMaterialExample example);

    int deleteByPrimaryKey(String id);

    int insert(GroupMaterial record);

    int insertSelective(GroupMaterial record);

    List<GroupMaterial> selectByExample(GroupMaterialExample example);

    GroupMaterial selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") GroupMaterial record, @Param("example") GroupMaterialExample example);

    int updateByExample(@Param("record") GroupMaterial record, @Param("example") GroupMaterialExample example);

    int updateByPrimaryKeySelective(GroupMaterial record);

    int updateByPrimaryKey(GroupMaterial record);
}