package com.rememberme.member.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class LoginRequestDto {

    @NotBlank
    private String username;

    @NotBlank
    private String password;
}