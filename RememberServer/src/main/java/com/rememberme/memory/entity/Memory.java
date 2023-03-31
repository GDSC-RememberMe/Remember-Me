package com.rememberme.memory.entity;

import com.rememberme.family.entity.Family;
import com.rememberme.memory.dto.MemoryRequestDto;
import lombok.*;

import javax.persistence.*;

@Table(name = "memory")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Getter
@Entity
public class Memory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "memory_id")
    private Long id;

    private String title;

    private String content;

    private String category;

    private String keyword;

    @Version
    private Long version; // 낙관적 락

    @Column(name = "img_url")
    private String imgUrl;

    @Column(name = "audio_url")
    private String audioUrl;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name ="family_id")
    private Family family;

    public void updateMemory(MemoryRequestDto memoryRequestDto) {
        if (memoryRequestDto.getTitle() != null) {
            this.title = memoryRequestDto.getTitle();
        }
        if (memoryRequestDto.getContent() != null) {
            this.content = memoryRequestDto.getContent();
        }
    }

    public void updateCategory(String category) {
        this.category = category;
    }

    public void updateKeyword(String keyword) {
        this.keyword = keyword;
    }

    public void addImageFile(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public void addAudioFile(String audioUrl) {
        this.audioUrl = audioUrl;
    }
}