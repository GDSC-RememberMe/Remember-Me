package com.rememberme.member.service;

import com.rememberme.member.entity.Member;
import com.rememberme.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;

@Service
@RequiredArgsConstructor
public class CustomDetailsService implements UserDetailsService {

    private final MemberRepository memberRepository;

    // 로그인용 - username 으로 검색
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Member member = memberRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException(username + " 아이디의 사용자가 존재하지 않습니다."));

        return createUserDetails(member);
    }

    public UserDetails loadUserByUserId(String userId) throws UsernameNotFoundException {
        Long findUserId = Long.parseLong(userId);
        Member member = memberRepository.findById(findUserId)
                .orElseThrow(() -> new UsernameNotFoundException(userId + "해당 사용자가 존재하지 않습니다."));

        return createUserDetails(member);
    }

    private UserDetails createUserDetails(Member member) {

        Collection<GrantedAuthority> grantedAuthorities = new ArrayList<>();
        grantedAuthorities.add(new SimpleGrantedAuthority(member.getRole().toString()));

        return new org.springframework.security.core.userdetails.User(
                member.getId().toString(), // User 테이블 PK user_id
                member.getPassword(),
                grantedAuthorities);
    }
}