package com.rememberme.comment.dto;

import com.rememberme.comment.Comment;
import lombok.*;

import java.time.LocalDate;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CommentSaveRequestDto {

    private Long postId;

    private String contents;
}