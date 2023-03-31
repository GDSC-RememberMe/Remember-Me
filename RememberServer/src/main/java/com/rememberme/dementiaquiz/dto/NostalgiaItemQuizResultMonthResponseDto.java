package com.rememberme.dementiaquiz.dto;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class NostalgiaItemQuizResultMonthResponseDto {

    private String createdDate;

    private List<NostalgiaItemQuizResultResponseDto> results;
}
