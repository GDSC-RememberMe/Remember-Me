package com.rememberme.dementiaquiz;

import com.rememberme.dementiaquiz.dto.NostalgiaItemResponseDto;
import com.rememberme.dementiaquiz.service.NostalgiaItemService;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/nostalgiaItem")
@RequiredArgsConstructor
public class NostalgiaItemController {

    private final NostalgiaItemService nostalgiaItemService;

    @ApiOperation(value = "<추억의 물건> 게임 조회")
    @GetMapping
    public ResponseEntity<List<NostalgiaItemResponseDto>> getNostalgiaItems() {
        List<NostalgiaItemResponseDto> result = nostalgiaItemService.getNostalgiaItems();
        return ResponseEntity.ok(result);
    }
}