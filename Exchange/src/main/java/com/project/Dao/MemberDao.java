package com.project.Dao;

import org.apache.ibatis.annotations.Param;
import com.project.Dto.MemberDto;

public interface MemberDao {
    public MemberDto getUser();
    public MemberDto checkLoginInfo(@Param("member")MemberDto member);
}
 
