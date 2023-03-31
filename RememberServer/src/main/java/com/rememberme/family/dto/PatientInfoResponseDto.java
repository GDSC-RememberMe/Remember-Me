package com.rememberme.family.dto;

import com.rememberme.member.entity.Member;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PatientInfoResponseDto {

    private Long memberId; // 환자 id

    private String nickname; // 사용자 설정 닉네임

    private String profileImg; // 사용자 설정 닉네임

    private int age;

    private String gender;

    private int dementiaLevel;

    public PatientInfoResponseDto(Member member) {
         // 만나이 계산
        LocalDate now = LocalDate.now();
        LocalDate birth = member.getBirth();
        int tmpAge = now.minusYears(birth.getYear()).getYear();
        if (birth.plusYears(tmpAge).isAfter(now)) {
            tmpAge -= 1;
        }

        this.memberId = member.getId();
        this.nickname = member.getNickname();
        this.age = tmpAge;
        this.profileImg = member.getProfileImg();
        this.gender = member.getGender().toString();
        this.dementiaLevel = member.getDementiaLevel();
    }
}