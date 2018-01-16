package com.yunstore.mapper;

import com.yunstore.entity.GroupMaterialUser;
import com.yunstore.entity.GroupMaterialUserExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface GroupMaterialUserMapper {
    int countByExample(GroupMaterialUserExample example);

    int deleteByExample(GroupMaterialUserExample example);

    int deleteByPrimaryKey(String id);

    int insert(GroupMaterialUser record);

    int insertSelective(GroupMaterialUser record);

    List<GroupMaterialUser> selectByExample(GroupMaterialUserExample example);

    GroupMaterialUser selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") GroupMaterialUser record, @Param("example") GroupMaterialUserExample example);

    int updateByExample(@Param("record") GroupMaterialUser record, @Param("example") GroupMaterialUserExample example);

    int updateByPrimaryKeySelective(GroupMaterialUser record);

    int updateByPrimaryKey(GroupMaterialUser record);
}