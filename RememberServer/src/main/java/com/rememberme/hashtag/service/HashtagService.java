package com.rememberme.hashtag.service;

import com.rememberme.hashtag.entity.Hashtag;
import com.rememberme.hashtag.repository.HashtagRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class HashtagService {

    private final HashtagRepository hashtagRepository;
    private final HashtagPostLinkService hashtagPostLinkService;

    // String으로 들어온 해시태그 리스트 전체 반환
    public void setHashtagList(Long postId, String tagList) {
        String[] hashtagList = tagList.split(",");
        for (String hashtag : hashtagList) {
            Long hashtagId = getHashtagId(hashtag);
            hashtagPostLinkService.createHashtagPostLink(postId, hashtagId);
        }
    }

    public Long getHashtagId(String tagName) {
        Optional<Hashtag> findHashtag = hashtagRepository.findByTagName(tagName);

        if (findHashtag.isPresent()) {
            return findHashtag.get().getId();
        }
        Hashtag hashtag = Hashtag.builder()
                    .tagName(tagName)
                    .build();
        return hashtagRepository.save(hashtag).getId();
    }
}