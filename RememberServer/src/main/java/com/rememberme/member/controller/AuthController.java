package com.rememberme.member.controller;

import com.rememberme.member.dto.*;
import com.rememberme.member.service.MemberService;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.Authorization;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.text.ParseException;

@Slf4j
@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final MemberService memberService;

    @ApiOperation(value = "회원 가입")
    @PostMapping("/join")
    public ResponseEntity<TokenDto> join(@RequestBody JoinRequestDto joinRequestDto) throws ParseException {
        return ResponseEntity.ok(memberService.join(joinRequestDto));
    }
    
    @ApiOperation(value = "로그인")
    @PostMapping("/login")
    public ResponseEntity<TokenDto> login(@RequestBody LoginRequestDto loginRequestDto) {
        return ResponseEntity.ok(memberService.login(loginRequestDto));
    }

    @ApiOperation(value = "토큰 재발급", notes = "AccessToken 만료시, RefreshToken 검증 후 AccessToken와 RefreshToken 재발급")
    @PostMapping("/reissue")
    public ResponseEntity<TokenDto> reissueToken(
            Authentication authentication,
            @RequestBody TokenDto tokenDto
    ) {
        Long memberId = Long.parseLong(authentication.getName());
        return ResponseEntity.ok(memberService.reissue(memberId, tokenDto));
    }

    @ApiOperation(value = "아이디 중복 검사")
    @PostMapping("/validation/username")
    public void validateUsername(@RequestBody @Valid UsernameRequestDto usernameRequestDto) {
        memberService.validateUsername(usernameRequestDto);
    }

    @ApiOperation(value = "해당 핸드폰 번호로 이미 가입한 회원인지 확인")
    @PostMapping("/validation/phone")
    public void validatePhone(@RequestBody @Valid PhoneRequestDto phoneRequestDto) {
        memberService.validatePhone(phoneRequestDto);
    }
}