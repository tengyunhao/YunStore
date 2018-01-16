package com.yunstore.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AccountInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String user = (String) request.getSession().getAttribute("user");

		// 如果是登录请求则放行
    	if (request.getRequestURI().contains("login.do") ||
			request.getRequestURI().contains("login-check.do") ||
			request.getRequestURI().contains("login-sms-verify.do") ||
			request.getRequestURI().contains("login-sms-check.do") ||
			request.getRequestURI().contains("loginface.do") ||
			request.getRequestURI().contains("login-face.do") ||
			request.getRequestURI().contains("register.do") ||
			request.getRequestURI().contains("register/code.do") ||
			request.getRequestURI().contains("register-check.do")) {
    		return true;
    	}
        if(user == null){
    		response.sendRedirect("login.do");
            return false;
        } else {
        	return true;
        }
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		super.postHandle(request, response, handler, modelAndView);
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

		super.afterCompletion(request, response, handler, ex);
	}

}
