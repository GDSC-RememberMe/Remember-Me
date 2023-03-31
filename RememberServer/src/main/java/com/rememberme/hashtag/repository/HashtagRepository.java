package com.rememberme.hashtag.repository;

import com.rememberme.hashtag.entity.Hashtag;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface HashtagRepository extends JpaRepository<Hashtag, Long> {

    Optional<Hashtag> findByTagName(String tagName);
}