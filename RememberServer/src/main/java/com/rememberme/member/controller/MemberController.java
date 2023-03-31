package com.rememberme.member.controller;

import com.rememberme.gcs.GcsService.GcsService;
import com.rememberme.member.dto.FcmTokenRequestDto;
import com.rememberme.member.dto.MemberResponseDto;
import com.rememberme.member.dto.MemberSearchResponseDto;
import com.rememberme.member.service.MemberService;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;
    private final GcsService GCSService;
    
    @ApiOperation(value = "사용자 프로필 이미지 저장")
    @PostMapping(consumes = {MediaType.MULTIPART_FORM_DATA_VALUE}, value = "/user/profile")
    public String addProfileImage(
            Authentication authentication,
            @RequestParam MultipartFile file){
        Long userId = Long.parseLong(authentication.getName());
        String fileUrl = GCSService.uploadFiles(file);
        memberService.addProfileImage(userId, fileUrl);
        return fileUrl;
    }

    @ApiOperation(value = "사용자 정보 조회")
    @GetMapping("/user/info")
    public ResponseEntity<MemberResponseDto> getUserInfo(Authentication authentication) {
        Long userId = Long.parseLong(authentication.getName());
        MemberResponseDto memberResponseDto = memberService.getUserInfoByUserId(userId);
        return ResponseEntity.ok(memberResponseDto);
    }

    @ApiOperation(value = "사용자 닉네임으로 검색")
    @GetMapping("/search/all")
    public ResponseEntity<List<MemberSearchResponseDto>> findMemberByNickname(
            @RequestParam("nickname") String nickname) {
        List<MemberSearchResponseDto> result = memberService.searchMember(nickname);
        return ResponseEntity.ok(result);
    }

    @ApiOperation(value = "fcm 토큰 업데이트")
    @PatchMapping("/fcm")
    public ResponseEntity updateFcmToken(
            Authentication authentication,
            @RequestBody FcmTokenRequestDto fcmTokenRequestDto) {
        Long memberId = Long.parseLong(authentication.getName());
        memberService.updateFcmToken(fcmTokenRequestDto, memberId);
        return new ResponseEntity(HttpStatus.OK);
    }
}