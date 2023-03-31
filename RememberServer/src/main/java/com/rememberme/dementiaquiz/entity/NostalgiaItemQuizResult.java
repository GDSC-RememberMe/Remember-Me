package com.rememberme.dementiaquiz.entity;

import com.rememberme.family.entity.Family;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDate;

@Table(name = "nostalgia_item_quiz_result")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Getter
@Entity
@EntityListeners(AuditingEntityListener.class)
public class NostalgiaItemQuizResult {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "nostalgia_item_quiz_result_id")
    private Long id;

    @Column(name = "is_correct")
    private boolean isCorrect;

    @Column(name = "nostalgia_item_id")
    private Long nostalgiaItemId;

    @Column(name = "created_at")
    @CreatedDate
    private LocalDate createdAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "family_id")
    private Family family;

    public void updateQuizResult(Long nostalgiaItemId, boolean isCorrect) {
        this.createdAt = LocalDate.now();
        this.isCorrect = isCorrect;
        this.nostalgiaItemId = nostalgiaItemId;
    }
}