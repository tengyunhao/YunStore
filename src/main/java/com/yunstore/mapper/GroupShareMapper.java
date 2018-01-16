package com.yunstore.mapper;

import com.yunstore.entity.GroupShare;
import com.yunstore.entity.GroupShareExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface GroupShareMapper {
    int countByExample(GroupShareExample example);

    int deleteByExample(GroupShareExample example);

    int deleteByPrimaryKey(String id);

    int insert(GroupShare record);

    int insertSelective(GroupShare record);

    List<GroupShare> selectByExample(GroupShareExample example);

    GroupShare selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") GroupShare record, @Param("example") GroupShareExample example);

    int updateByExample(@Param("record") GroupShare record, @Param("example") GroupShareExample example);

    int updateByPrimaryKeySelective(GroupShare record);

    int updateByPrimaryKey(GroupShare record);
}