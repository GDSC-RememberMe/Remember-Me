package com.rememberme.hashtag.service;

import com.rememberme.hashtag.entity.Hashtag;
import com.rememberme.hashtag.entity.HashtagPostLink;
import com.rememberme.hashtag.repository.HashtagPostLinkRepository;
import com.rememberme.hashtag.repository.HashtagRepository;
import com.rememberme.post.Post;
import com.rememberme.post.PostRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class HashtagPostLinkService {

    private final HashtagRepository hashtagRepository;
    private final HashtagPostLinkRepository hashtagPostLinkRepository;
    private final PostRepository postRepository;

    public void createHashtagPostLink(Long postId, Long hashtagId) {
        Hashtag hashtag = hashtagRepository.getReferenceById(hashtagId);
        Post post = postRepository.getReferenceById(postId);

        HashtagPostLink hashtagPostLink = HashtagPostLink.builder()
                .hashtag(hashtag)
                .post(post)
                .build();
        hashtagPostLinkRepository.save(hashtagPostLink);
    }
}