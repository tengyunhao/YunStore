package com.yunstore.mapper;

import com.yunstore.entity.GroupShareUser;
import com.yunstore.entity.GroupShareUserExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface GroupShareUserMapper {
    int countByExample(GroupShareUserExample example);

    int deleteByExample(GroupShareUserExample example);

    int deleteByPrimaryKey(String id);

    int insert(GroupShareUser record);

    int insertSelective(GroupShareUser record);

    List<GroupShareUser> selectByExample(GroupShareUserExample example);

    GroupShareUser selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") GroupShareUser record, @Param("example") GroupShareUserExample example);

    int updateByExample(@Param("record") GroupShareUser record, @Param("example") GroupShareUserExample example);

    int updateByPrimaryKeySelective(GroupShareUser record);

    int updateByPrimaryKey(GroupShareUser record);
}