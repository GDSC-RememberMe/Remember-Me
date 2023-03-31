package com.rememberme.config;

import com.rememberme.jwt.JwtAccessDeniedHandler;
import com.rememberme.jwt.JwtAuthenticationEntryPoint;
import com.rememberme.jwt.JwtTokenFilterConfigurer;
import com.rememberme.jwt.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
@RequiredArgsConstructor
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    private final JwtTokenProvider jwtTokenProvider;
    private final JwtAccessDeniedHandler jwtAccessDeniedHandler;
    private final JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;
    private final CorsConfig corsConfig;

     // 아래 설정은  SecurityFilterChain에서 제외
     public void configure(WebSecurity web) throws Exception {
         web.ignoring()
                 .antMatchers("/resources/**");
     }

    @Override
    protected void configure(HttpSecurity httpSecurity) throws Exception {
        httpSecurity
                    .csrf().disable()
                    .sessionManagement()
                    .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                    .exceptionHandling()
                    .authenticationEntryPoint(jwtAuthenticationEntryPoint)
                .and()
                    .exceptionHandling()
                    .accessDeniedHandler(jwtAccessDeniedHandler)
                .and()
                    .authorizeRequests()
                    .antMatchers("/auth/**").permitAll()                // 회원가입, 로그인하기 위한 접근, 인가X된 사용자도 접근 가능
                    .antMatchers("/user/**").authenticated()            // 회원의 개인정보 관련 접근, 인가된 사용자만 접근
                    .antMatchers("/patient/**").hasRole("PATIENT")      // 환자 사용자의 접근만 허용
                    .antMatchers("/caregiver/**").hasRole("CAREGIVER")  // 보호자 사용자의 접근만 허용
                    .anyRequest().authenticated();

        httpSecurity.apply(new JwtTokenFilterConfigurer(jwtTokenProvider));
    }

    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }
}
