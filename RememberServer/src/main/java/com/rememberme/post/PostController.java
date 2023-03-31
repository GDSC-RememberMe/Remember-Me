package com.rememberme.post;

import com.rememberme.hashtag.service.HashtagService;
import com.rememberme.post.dto.PostAllResponseDto;
import com.rememberme.post.dto.PostOneResponseDto;
import com.rememberme.post.dto.PostSaveRequestDto;
import com.rememberme.post.dto.PostUpdateRequestDto;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/post")
public class PostController {

    private final PostService postService;
    private final HashtagService hashtagService;

    @ApiOperation(value = "게시글 저장")
    @PostMapping
    public ResponseEntity createPost(
            Authentication authentication,
            @RequestBody PostSaveRequestDto postSaveRequestDto) {
        Long memberId = Long.parseLong(authentication.getName());
        Long postId = postService.createPost(memberId, postSaveRequestDto);
        String hashtagList = postSaveRequestDto.getHashtagList();

        // 해시 태그 저장하기
        hashtagService.setHashtagList(postId, hashtagList);
        return new ResponseEntity(HttpStatus.OK);
    }

    @ApiOperation(value = "게시글 수정")
    @PatchMapping
    public ResponseEntity updatePost(
            Authentication authentication,
            @RequestBody PostUpdateRequestDto postUpdateRequestDto) {
        Long memberId = Long.parseLong(authentication.getName());
        postService.updatePost(memberId, postUpdateRequestDto);
        return new ResponseEntity(HttpStatus.OK);
    }

    @ApiOperation(value = "게시글 전체 조회")
    @GetMapping
    public ResponseEntity<List<PostAllResponseDto>> getPostAll() {
        List<PostAllResponseDto> posts = postService.getPostAll();
        return ResponseEntity.ok(posts);
    }

    @ApiOperation(value = "게시글 개별 조회")
    @GetMapping("/{postId}")
    public ResponseEntity<PostOneResponseDto> getPostOneByPostId(@PathVariable Long postId) {
        PostOneResponseDto postOneResponseDto = postService.getPostOneByPostId(postId);
        return ResponseEntity.ok(postOneResponseDto);
    }
}