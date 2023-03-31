package com.rememberme.dementiaquiz.dto;

import com.rememberme.dementiaquiz.entity.NostalgiaItem;
import lombok.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class NostalgiaItemQuizResultResponseDto {

    private long nostalgiaItemId;

    private String imgUrl;

    private boolean result;

    public NostalgiaItemQuizResultResponseDto(NostalgiaItem nostalgiaItem, boolean result) {
        this.nostalgiaItemId = nostalgiaItem.getId();
        this.imgUrl = nostalgiaItem.getImgUrl();
        this.result = result;
    }
}
