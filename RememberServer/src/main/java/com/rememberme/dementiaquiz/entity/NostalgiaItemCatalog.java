package com.rememberme.dementiaquiz.entity;

import com.rememberme.family.entity.Family;
import lombok.*;

import javax.persistence.*;

@Table(name = "nostalgia_item_catalogue")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Getter
@Entity
public class NostalgiaItemCatalog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "nostalgia_item_catalogue_id")
    private Long id;

    private Long nostalgiaItemId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "family_id")
    private Family family;
}