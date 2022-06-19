package com.project.Controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.Dto.MemberDto;
import com.project.Service.MemberService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class LoginTestController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
    @Autowired
    MemberService memberService;
    
    @RequestMapping(value="/loginchk")
    public String login(
            @RequestParam(value="id") String id,
            @RequestParam(value="password") String password,
            HttpServletRequest request, Model model) {
        
        logger.info("id: "+id);
        logger.info("password: "+password);

        
        request.getSession().setAttribute("id", id); //세션에 아이디값 입력
        request.getSession().setAttribute("password", password); // 세션에 패스워드값 입력
        
        MemberDto userinfo = new MemberDto(id, password, "");
        if(memberService.checkLoginInfo(userinfo) == null) {
            model.addAttribute("user_id", id);
            model.addAttribute("password", password);
        	return "loginFail";
        }
       
        return "redirect:/home";
    }
}
