package com.rememberme.post.dto;

import lombok.*;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class PostUpdateRequestDto {

    private Long postId;

    private String title;

    private String contents;
}
