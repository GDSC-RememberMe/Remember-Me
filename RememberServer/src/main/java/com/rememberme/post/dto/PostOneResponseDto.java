package com.rememberme.post.dto;

import com.rememberme.post.Post;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class PostOneResponseDto {

    private Long postId;

    private String title;

    private String contents;

    private int viewCnt;

    private int likeCnt;

    private LocalDate createdAt;

    private Long memberId;

    private String username;

    private String profileImg;

    public PostOneResponseDto(Post post) {
        this.postId = post.getId();
        this.title = post.getTitle();
        this.contents = post.getContents();
        this.viewCnt = post.getViewCnt();
        this.likeCnt = post.getLikeCnt();
        this.createdAt = post.getCreatedAt();
        this.memberId = post.getMember().getId();
        this.username = post.getMember().getUsername();
        this.profileImg = post.getMember().getProfileImg();
    }
}
