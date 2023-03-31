package com.rememberme.family.dto;

import com.rememberme.member.entity.Member;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FamilySearchResponseDto {

    private Long familyId;

    private Long memberId; // 환자 id

    private String username;

    private String nickname;

    private String profileImg;

    public FamilySearchResponseDto of(Member member) {
        this.familyId = member.getFamily().getId();
        this.memberId = member.getId();
        this.username = member.getUsername();
        this.nickname = member.getNickname();
        this.profileImg = member.getProfileImg();
        return this;
    }
}