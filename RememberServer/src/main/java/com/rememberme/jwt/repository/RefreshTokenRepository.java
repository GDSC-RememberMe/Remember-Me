package com.rememberme.jwt.repository;


import com.rememberme.jwt.entity.RefreshToken;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RefreshTokenRepository extends JpaRepository<RefreshToken, String> {

    Optional<RefreshToken> findByMemberId(String memberId);
}