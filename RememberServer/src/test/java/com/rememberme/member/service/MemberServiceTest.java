package com.rememberme.member.service;

import com.rememberme.member.entity.Member;
import com.rememberme.member.repository.MemberRepository;
import com.rememberme.post.Post;
import com.rememberme.post.PostRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@ExtendWith(SpringExtension.class)
@SpringBootTest(webEnvironment= SpringBootTest.WebEnvironment.MOCK)
class MemberServiceTest {

    // Optional<Member> member = memberRepository.findByUsername("회원아이디1");
    // List<Post> postList = postRepository.findAllByMemberId(1L);

    // 2. 지연 + 페치 조인
    // List<Post> postListByJPQL = postRepository.findAllByJPQL();


    @Autowired private MemberRepository memberRepository;
    @Autowired private PostRepository postRepository;
    // 1. 지연로딩이지만 하위 엔티티 조회 시 - LazyInitializationException 때문에 @Transaction


    @Transactional
    @Test
    void Post_Comment_조회() {
        List<Post> postListByJPQL = postRepository.findAllByJPQL();
//        Optional<Post> post = postRepository.findById(1L);
//        int postSize = post.get().getComments().size();

        for (int i = 0; i < postListByJPQL.size(); i++) {
            int commentSize = postListByJPQL.get(i).getComments().size();
            for (int j = 0; j <commentSize; j++) {
                System.out.println(postListByJPQL.get(i).getComments().get(j).getContents());
            }

        }
    }

    @Transactional
    @Test
    void 낙관락 () {
        // when

//        IntStream.range(0, threadCount).forEach(e -> executorService.submit(() -> {
//                    try {
//                        stockService.decrease(productId, quantity);
//                    } finally {
//                        countDownLatch.countDown();
//                    }
//                }
//        ));
//        countDownLatch.await();
//
//
//        // then
//        final Long afterQuantity = stockRepository.getByProductId(productId).getQuantity();
//
//        assertThat(afterQuantity).isZero();
    }
}