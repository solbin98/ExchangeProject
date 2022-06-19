package com.project.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.Dao.MemberDao;
import com.project.Dto.MemberDto;

 
@Service
public class MemberServiceImp implements MemberService {
    @Autowired
    MemberDao memberDao;
    
	@Override
	public MemberDto getUser() {
		return memberDao.getUser();
	}

	@Override
	public MemberDto checkLoginInfo(MemberDto member) {
		return memberDao.checkLoginInfo(member);
	}
}

