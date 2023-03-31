package com.rememberme.family.entity;

import com.rememberme.dementiaquiz.entity.NostalgiaItemCatalog;
import com.rememberme.dementiaquiz.entity.NostalgiaItemQuizResult;
import com.rememberme.memory.entity.Memory;
import com.rememberme.member.entity.Member;
import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Table(name = "family")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Getter
@Builder
@Entity
public class Family {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "family_id")
    private Long id;

    @Column(name = "patient_id")
    private Long patientId;

    @Builder.Default
    @OneToMany(mappedBy = "family")
    private List<Member> member = new ArrayList<>();

    @Builder.Default
    @OneToMany(mappedBy = "family")
    private List<Memory> memory = new ArrayList<>();

    @OneToMany(mappedBy = "family")
    private List<NostalgiaItemQuizResult> nostalgiaItemQuizResults = new ArrayList<>();

    @OneToMany(mappedBy = "family")
    private List<NostalgiaItemCatalog> nostalgiaItemCatalogs = new ArrayList<>();

}
