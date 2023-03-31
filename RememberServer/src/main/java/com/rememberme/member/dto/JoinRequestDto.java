package com.rememberme.member.dto;

import com.rememberme.member.entity.Member;
import com.rememberme.member.entity.enumType.Gender;
import com.rememberme.member.entity.enumType.Role;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.ColumnDefault;
import org.springframework.security.crypto.password.PasswordEncoder;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class JoinRequestDto {

    @NotBlank
    private String username;

    @NotBlank
    private String password;

    @NotBlank
    private String phone;

    private String nickname;

    private int dementiaLevel;

    private String fcmToken;

    @NotBlank
    private String role;

    @NotBlank
    @Pattern(regexp = "^(19[0-9][0-9]|20\\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$", message = "생년월일이 yyyy-MM-dd의 형식이어야 합니다.")
    private String birth;

    @NotBlank
    private String gender;

    private String profileImg;

    private String address;

    @ColumnDefault("true")
    private boolean isPushAgree;

    @ColumnDefault("0")
    private int pushCnt;

    @ColumnDefault("true")
    private boolean activated;

    private LocalDate parseLocalDateByBirth (String birth) throws ParseException {
        LocalDate date = LocalDate.parse(birth, DateTimeFormatter.ISO_DATE);
        return date;
    }

    public Member toEntity(PasswordEncoder passwordEncoder) throws ParseException {

        return  Member.builder()
                    .username(username)
                    .password(passwordEncoder.encode(password))
                    .nickname(nickname)
                    .dementiaLevel(dementiaLevel)
                    .fcmToken(fcmToken)
                    .phone(phone)
                    .role(Role.valueOf(role))
                    .profileImg(profileImg)
                    .birth(parseLocalDateByBirth(birth))
                    .gender(Gender.valueOf(gender))
                    .address(address)
                    .isPushAgree(isPushAgree)
                    .pushCnt(pushCnt)
                    .activated(activated)
                    .build();
    }
}