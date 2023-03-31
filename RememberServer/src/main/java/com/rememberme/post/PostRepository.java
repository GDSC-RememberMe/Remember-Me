package com.rememberme.post;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface PostRepository extends JpaRepository<Post, Long> {

    @Query("select DISTINCT p from Post p join fetch p.comments")
    List<Post> findAllByJPQL();
}
