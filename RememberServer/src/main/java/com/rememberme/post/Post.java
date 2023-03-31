package com.rememberme.post;

import com.rememberme.comment.Comment;
import com.rememberme.hashtag.entity.HashtagPostLink;
import com.rememberme.member.entity.Member;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Table(name = "post")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Getter
@Entity
public class Post {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "post_id")
    private Long id;

    private String title;

    private String contents;

    @Column(name = "view_cnt")
    private int viewCnt;

    @Column(name = "like_cnt")
    private int likeCnt;

    @Column(name = "created_at")
    private LocalDate createdAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @OneToMany(mappedBy = "post", fetch = FetchType.LAZY)
    private List<Comment> comments = new ArrayList<>();

    @OneToMany(mappedBy = "post")
    private List<HashtagPostLink> hashtagPostLinks = new ArrayList<>();

    public void updateContents(String newContents) {
        this.contents = newContents;
    }

    public void updateTitle(String newTitle) {
        this.title = newTitle;
    }
}