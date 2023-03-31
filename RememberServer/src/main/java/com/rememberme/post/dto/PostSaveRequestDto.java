package com.rememberme.post.dto;

import lombok.*;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class PostSaveRequestDto {

    private String title;

    private String contents;

    private String hashtagList;
}
