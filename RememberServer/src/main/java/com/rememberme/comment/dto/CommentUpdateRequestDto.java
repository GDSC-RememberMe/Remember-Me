package com.rememberme.comment.dto;

import lombok.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CommentUpdateRequestDto {

    private Long commentId;

    private String contents;
}