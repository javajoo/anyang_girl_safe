package com.danusys.security;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

/*
// 클래스  명 : CrossScriptingFilter
// 클래스설명 : CrossScriptingFilter 클래스
*/
public class CrossScriptingFilter implements Filter
{
    public FilterConfig filterConfig;
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException
    {
        this.filterConfig = filterConfig;
    }
    
    @Override
    public void destroy()
    {
        this.filterConfig = null;        
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException
    {
        chain.doFilter(new RequestWrapper((HttpServletRequest) request), response);
    }
}
