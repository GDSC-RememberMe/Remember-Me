package com.rememberme.family;

import com.rememberme.family.dto.PatientInfoResponseDto;
import com.rememberme.family.dto.FamilyRequestDto;
import com.rememberme.family.dto.FamilySearchResponseDto;
import com.rememberme.member.service.MemberService;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class FamilyController {

    private final FamilyService familyService;
    private final MemberService memberService;

    @ApiOperation(value = "환자 검색", notes = "이름으로 환자 검색")
    @GetMapping("/search")
    public ResponseEntity<List<FamilySearchResponseDto>> searchFamily(
            @RequestParam("patient") String keyword) {
        List<FamilySearchResponseDto> familySearchResponseDtoList = familyService.searchFamilyByKeyword(keyword);
        return ResponseEntity.ok(familySearchResponseDtoList);
    }

    @ApiOperation(value = "가족 관계 설정", notes = "보호자가 환자와 가족 관계 설정")
    @PostMapping("/family")
    public ResponseEntity saveFamily(
            Authentication authentication,
            @RequestBody FamilyRequestDto familyRequestDto) {
        Long userId = Long.parseLong(authentication.getName());
        Long familyId = familyRequestDto.getFamilyId();

        familyService.setFamilyOfCaregiverUser(userId, familyId);
        return new ResponseEntity(HttpStatus.OK);
    }

    @ApiOperation(value = "(보호자의) 환자 정보 조회")
    @GetMapping("/family/info")
    public ResponseEntity getPatientInfo (
            Authentication authentication) {
        Long memberId = Long.parseLong(authentication.getName());
        Long patientId = familyService.getPatientIdByMemberId(memberId);
        PatientInfoResponseDto result = memberService.getPatientInfoByMemberId(patientId);
        return ResponseEntity.ok(result);
    }
}