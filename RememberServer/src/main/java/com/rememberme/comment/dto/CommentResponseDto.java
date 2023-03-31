package com.rememberme.comment.dto;

import com.rememberme.comment.Comment;
import lombok.*;

import java.time.LocalDate;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CommentResponseDto {

    private String contents;

    private LocalDate createdAt;

    public CommentResponseDto(Comment comment) {
        this.contents = comment.getContents();
        this.createdAt = comment.getCreatedAt();
    }
}
