package com.rememberme.jwt;

import com.rememberme.jwt.entity.EnumType.JwtStatus;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
public class JwtTokenFilter extends OncePerRequestFilter {

    public static final String AUTHORIZATION_HEADER = "Authorization";
    public static final String BEARER_HEADER = "Bearer-";

    private final JwtTokenProvider jwtTokenProvider;

    public JwtTokenFilter(JwtTokenProvider jwtTokenProvider) {
        this.jwtTokenProvider = jwtTokenProvider;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String accessToken = resolveToken(request, AUTHORIZATION_HEADER);
        JwtStatus accessTokenStatus = jwtTokenProvider.validateToken(accessToken);

        // accessToken이 유효한 토큰일 경우, SecurityContext에 Authentication으로 저장
        if (accessToken != null && accessTokenStatus == JwtStatus.ACCESS) {
            Authentication authentication = jwtTokenProvider.getAuthentication(accessToken);
            SecurityContextHolder.getContext().setAuthentication(authentication);
        }
        filterChain.doFilter(request, response);
    }

    private String resolveToken(HttpServletRequest request, String header) {
        String bearerToken = request.getHeader(header);
        if (bearerToken != null && bearerToken.startsWith(BEARER_HEADER)) {
            return bearerToken.substring(BEARER_HEADER.length());
        }
        return null;
    }
}
