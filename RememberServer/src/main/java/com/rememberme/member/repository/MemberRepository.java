package com.rememberme.member.repository;

import com.rememberme.member.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, Long> {

    Optional<Member> findByUsername(String username);

    Optional<Member> findByPhone(String phone);

    List<Member> findByUsernameContaining (String keyword);

    List<Member> findByNicknameContaining(String nickname);
}