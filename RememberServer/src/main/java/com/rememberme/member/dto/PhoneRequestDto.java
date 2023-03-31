package com.rememberme.member.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class PhoneRequestDto {

    @NotBlank
    @Pattern(regexp = "^\\d{9,11}$", message = "전화번호는 공백없이 9 ~ 11자리 숫자이어야 합니다.")
    private String phone;
}