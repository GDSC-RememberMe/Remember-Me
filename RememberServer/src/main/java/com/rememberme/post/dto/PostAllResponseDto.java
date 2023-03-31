package com.rememberme.post.dto;

import com.rememberme.post.Post;
import lombok.*;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class PostAllResponseDto {

    private String title;

    private String contents;

    private int likeCnt;

    private int commentCnt;

    public PostAllResponseDto(Post post) {
        this.title = post.getTitle();
        this.contents = post.getContents();
        this.likeCnt = post.getLikeCnt();
        this.commentCnt = post.getComments().size();
    }
}
