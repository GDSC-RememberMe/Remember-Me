package com.rememberme.hashtag.entity;

import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Table(name = "hashtag")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Getter
@Entity
public class Hashtag {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "hashtag_id")
    private Long id;

    @Column(name = "tag_name")
    private String tagName;

    @OneToMany(mappedBy = "hashtag")
    private List<HashtagPostLink> hashtagPostLinks = new ArrayList<>();
}