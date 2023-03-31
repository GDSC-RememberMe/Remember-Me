package com.rememberme.dementiaquiz.entity;

import lombok.*;

import javax.persistence.*;

@Table(name = "nostalgia_item")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Getter
@Entity
public class NostalgiaItem {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "nostalgia_item_id")
    private Long id;

    private String title;

    @Column(name = "img_url")
    private String imgUrl;
}