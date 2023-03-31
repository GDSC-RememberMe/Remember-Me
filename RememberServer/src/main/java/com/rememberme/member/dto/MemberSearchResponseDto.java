package com.rememberme.member.dto;

import com.rememberme.member.entity.Member;
import lombok.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberSearchResponseDto {

    private String username;

    private String nickname;

    private String profileImg;

    public MemberSearchResponseDto(Member member) {
        this.username = member.getUsername();
        this.nickname = member.getNickname();
        this.profileImg = member.getProfileImg();
    }
}