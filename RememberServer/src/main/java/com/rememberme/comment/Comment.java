package com.rememberme.comment;

import com.rememberme.member.entity.Member;
import com.rememberme.post.Post;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDate;

@Table(name = "comment")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Getter
@Entity
public class Comment {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "comment_id")
    private Long id;

    private String contents;

    private LocalDate createdAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "post_id")
    private Post post;

    public void updateContents(String newContents) {
        this.contents = newContents;
    }

}