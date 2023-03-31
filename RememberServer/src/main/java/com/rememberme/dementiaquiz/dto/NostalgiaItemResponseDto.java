package com.rememberme.dementiaquiz.dto;

import lombok.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class NostalgiaItemResponseDto {

    private long rightNostalgiaItemId;

    private String imgUrl;

    private String rightAnswer;

    private String wrongAnswer;
}
