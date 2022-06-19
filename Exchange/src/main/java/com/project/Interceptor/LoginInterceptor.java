package com.project.Interceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
 
@SuppressWarnings("deprecation")
public class LoginInterceptor extends HandlerInterceptorAdapter{
 
    private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        
        logger.info("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ");
        logger.info("LoginInterceptor 진입");
        logger.info("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ");
        System.out.println(request.getSession().getAttribute("id"));
        if(request.getSession().getAttribute("id") == null) {
            response.sendRedirect("login");
            return false;
        }
        return true;
    }
}

