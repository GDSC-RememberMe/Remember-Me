package com.rememberme.memory.dto;

import com.rememberme.family.entity.Family;
import com.rememberme.memory.entity.Memory;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class MemoryRequestDto {

    private String title;

    private String content;


    public Memory saveMemoryQuizWithFamily(Family family) {

        return Memory.builder()
                .title(title)
                .content(content)
                .family(family)
                .build();
    }
}