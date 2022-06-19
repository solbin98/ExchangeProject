package com.project.Service;
import com.project.Dto.MemberDto;

public interface MemberService {
    public MemberDto getUser();
    public MemberDto checkLoginInfo(MemberDto member);
}

