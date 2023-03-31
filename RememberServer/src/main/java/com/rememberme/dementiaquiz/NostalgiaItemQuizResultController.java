package com.rememberme.dementiaquiz;

import com.rememberme.dementiaquiz.dto.*;
import com.rememberme.dementiaquiz.entity.NostalgiaItemCatalog;
import com.rememberme.dementiaquiz.service.NostalgiaItemQuizResultService;
import com.rememberme.dementiaquiz.service.NostalgiaItemService;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/nostalgiaItem")
@RequiredArgsConstructor
public class NostalgiaItemQuizResultController {

    private final NostalgiaItemService nostalgiaItemService;
    private final NostalgiaItemQuizResultService nostalgiaItemQuizResultService;


    @ApiOperation(value = "<추억의 물건> 게임 결과 전송")
    @PostMapping("/result")
    public ResponseEntity saveNostalgiaItemResult(
            Authentication authentication,
            @RequestBody NostalgiaItemRequestDtoList nostalgiaItemRequestDtoList) {
        Long memberId = Long.parseLong(authentication.getName());
        nostalgiaItemQuizResultService.saveNostalgiaItemResult(memberId, nostalgiaItemRequestDtoList);
        return new ResponseEntity(HttpStatus.OK);
    }

    @ApiOperation(value = "<추억의 물건> 게임 결과 월별 조회")
    @GetMapping("/result/{month}")
    public ResponseEntity<HashMap<String, List<NostalgiaItemQuizResultResponseDto>>> getNostalgiaItemResultByMonth(
            Authentication authentication,
            @PathVariable("month") int month
    ) {
        Long memberId = Long.parseLong(authentication.getName());
        HashMap<String, List<NostalgiaItemQuizResultResponseDto>> result = nostalgiaItemQuizResultService.getNostalgiaItemResultByMonth(memberId, month);
        return ResponseEntity.ok(result);
    }

    @ApiOperation(value = "<추억의 물건> 게임 도감 조회")
    @GetMapping("/all")
    public ResponseEntity<List<NostalgiaItemCatalogResponseDto>> getNostalgiaItemResultAll(Authentication authentication) {
        Long memberId = Long.parseLong(authentication.getName());
        List<NostalgiaItemCatalogResponseDto> result = nostalgiaItemQuizResultService.getNostalgiaItemResultCategoryAll(memberId);
        return ResponseEntity.ok(result);
    }
}