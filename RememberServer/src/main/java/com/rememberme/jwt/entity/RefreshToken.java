package com.rememberme.jwt.entity;

import lombok.*;

import javax.persistence.*;

@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@Builder
@AllArgsConstructor
public class RefreshToken {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "refresh_token_id")
    private Long id;

    private String memberId;

    private String token;

    public void updateToken(String updateToken) {
        this.token = updateToken;
    }
}