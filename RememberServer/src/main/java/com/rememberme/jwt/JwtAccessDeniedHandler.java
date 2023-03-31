package com.rememberme.jwt;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class JwtAccessDeniedHandler implements AccessDeniedHandler {

    /**
     * 인가되지 않은,
     * 접근 권한이 없는 사용자의 요청일 경우, 403 에러 발생
     * */
    @Override
    public void handle(HttpServletRequest request,
                       HttpServletResponse response,
                       AccessDeniedException accessDeniedException) throws IOException, ServletException {

        response.sendError(HttpServletResponse.SC_FORBIDDEN, accessDeniedException.getMessage());
    }
}