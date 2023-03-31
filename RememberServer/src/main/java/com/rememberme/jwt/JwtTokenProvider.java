package com.rememberme.jwt;

import com.rememberme.jwt.entity.EnumType.JwtStatus;
import com.rememberme.member.dto.TokenDto;
import com.rememberme.member.service.CustomDetailsService;
import io.jsonwebtoken.*;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Base64;
import java.util.Date;

@Component
@PropertySource("classpath:application.yml")
public class JwtTokenProvider implements InitializingBean {

    public static final String BEARER_HEADER = "Bearer-";

    private final CustomDetailsService customDetailsService;
    private final long accessTokenValidity;
    private final long refreshTokenValidity;
    private String key;

    public JwtTokenProvider(@Value("${jwt.secret-key}") String key,
                            @Value("${jwt.access-token-validity-in-ms}") long accessTokenValidity,
                            @Value("${jwt.refresh-token-validity-in-ms}") long refreshTokenValidity,
                            CustomDetailsService customDetailsService){
        this.key = key;
        this.accessTokenValidity = accessTokenValidity * 1000;
        this.refreshTokenValidity = refreshTokenValidity * 1000;
        this.customDetailsService = customDetailsService;
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        key = Base64.getEncoder().encodeToString(key.getBytes());
    }

    public Authentication getAuthentication(String token) {
        Claims claims = getClaims(token);

        UserDetails userDetails = customDetailsService.loadUserByUserId(claims.getSubject()); // 사용자 엔티티 찾기
        return new UsernamePasswordAuthenticationToken(userDetails, token, userDetails.getAuthorities());
    }

    public Claims getClaims(String token) {
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(key)
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        } catch (ExpiredJwtException e) {
            return e.getClaims();
        }
    }

    @Transactional
    public TokenDto createTokenDto(Authentication authentication) {
        Date now = new Date();

        String accessToken = Jwts.builder()
                .setSubject(authentication.getName())
                .setIssuedAt(now)
                .signWith(SignatureAlgorithm.HS512, key)
                .setExpiration(new Date(now.getTime() + accessTokenValidity))
                .compact();

        String refreshToken = Jwts.builder()
                .setSubject(authentication.getName())
                .signWith(SignatureAlgorithm.HS512, key)
                .setExpiration(new Date(now.getTime() + refreshTokenValidity))
                .compact();

        return TokenDto.builder()
                .accessToken(BEARER_HEADER + accessToken)
                .refreshToken(BEARER_HEADER + refreshToken)
                .build();
    }

    public JwtStatus validateToken(String token) {
        try { Jwts.parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(token);
            return JwtStatus.ACCESS;

        } catch (ExpiredJwtException e){
            return JwtStatus.EXPIRED;

        } catch (JwtException | IllegalArgumentException e) {
            return JwtStatus.DENIED;
        }
    }
}