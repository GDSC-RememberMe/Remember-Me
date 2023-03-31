package com.rememberme.comment;

import com.rememberme.comment.dto.CommentResponseDto;
import com.rememberme.comment.dto.CommentSaveRequestDto;
import com.rememberme.comment.dto.CommentUpdateRequestDto;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/comment")
@RequiredArgsConstructor
public class CommentController {

    private final CommentService commentService;

    @ApiOperation(value = "게시물당 댓글 전체 조회")
    @GetMapping("/{postId}")
    public ResponseEntity<List<CommentResponseDto>> getCommentsByPostId(@PathVariable Long postId) {
        List<CommentResponseDto> comments = commentService.getCommentsByPostId(postId);
        return ResponseEntity.ok(comments);
    }

    @ApiOperation(value = "댓글 저장")
    @PostMapping
    public ResponseEntity createComment(
            Authentication authentication,
            @RequestBody CommentSaveRequestDto commentSaveRequestDto
    ) {
        Long memberId = Long.parseLong(authentication.getName());
        commentService.createComment(memberId, commentSaveRequestDto);
        return new ResponseEntity(HttpStatus.OK);
    }

    @ApiOperation(value = "댓글 수정")
    @PatchMapping
    public ResponseEntity updateComment(
            Authentication authentication,
            @RequestBody CommentUpdateRequestDto commentUpdateRequestDto
    ) {
        Long memberId = Long.parseLong(authentication.getName());
        commentService.updateComment(memberId, commentUpdateRequestDto);
        return new ResponseEntity(HttpStatus.OK);
    }

    @ApiOperation(value = "댓글 삭제")
    @DeleteMapping("/{commentId}")
    public ResponseEntity deleteComment(
            Authentication authentication,
            @PathVariable Long commentId) {
        Long memberId = Long.parseLong(authentication.getName());
        commentService.deleteComment(memberId, commentId);
        return new ResponseEntity(HttpStatus.OK);
    }
}
