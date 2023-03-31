package com.rememberme.fastapi;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class FastApiService {

    public KeywordResponseDto post(ContentRequestDto contentRequestDto) {

        URI uri = UriComponentsBuilder
                .fromUriString("http://localhost:8000")
                .path("/keyword")
                .encode()
                .build()
                .toUri();

        log.info(String.valueOf(uri));

        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<KeywordResponseDto> responseEntity = restTemplate.postForEntity(uri, contentRequestDto, KeywordResponseDto.class);

        log.info("statusCode: {}", responseEntity.getStatusCode());
        log.info("getBody: {}", responseEntity.getBody());

        return responseEntity.getBody();
    }
}