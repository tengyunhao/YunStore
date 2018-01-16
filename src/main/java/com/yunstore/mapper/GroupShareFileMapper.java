package com.yunstore.mapper;

import com.yunstore.entity.GroupShareFile;
import com.yunstore.entity.GroupShareFileExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface GroupShareFileMapper {
    int countByExample(GroupShareFileExample example);

    int deleteByExample(GroupShareFileExample example);

    int insert(GroupShareFile record);

    int insertSelective(GroupShareFile record);

    List<GroupShareFile> selectByExample(GroupShareFileExample example);

    int updateByExampleSelective(@Param("record") GroupShareFile record, @Param("example") GroupShareFileExample example);

    int updateByExample(@Param("record") GroupShareFile record, @Param("example") GroupShareFileExample example);
}