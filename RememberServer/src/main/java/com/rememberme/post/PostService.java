package com.rememberme.post;

import com.rememberme.member.entity.Member;
import com.rememberme.member.repository.MemberRepository;
import com.rememberme.post.dto.PostAllResponseDto;
import com.rememberme.post.dto.PostOneResponseDto;
import com.rememberme.post.dto.PostSaveRequestDto;
import com.rememberme.post.dto.PostUpdateRequestDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class PostService {

    private final PostRepository postRepository;
    private final MemberRepository memberRepository;

    @Transactional
    public Long createPost(Long memberId, PostSaveRequestDto postSaveRequestDto) {
        Member member = memberRepository.getReferenceById(memberId);

        Post post = Post.builder()
                .createdAt(LocalDate.now())
                .title(postSaveRequestDto.getTitle())
                .contents(postSaveRequestDto.getContents())
                .member(member)
                .build();

        return postRepository.save(post).getId();
    }

    @Transactional
    public void updatePost(Long memberId, PostUpdateRequestDto postUpdateRequestDto) {
        Long postId = postUpdateRequestDto.getPostId();
        String newContents = postUpdateRequestDto.getContents();
        String newTitle = postUpdateRequestDto.getTitle();

        Post post = postRepository.getReferenceById(postId);
        Long postMemberId = post.getMember().getId();
        if (!postMemberId.equals(memberId)) {
            throw new RuntimeException("게시글 작성자만 수정할 수 있습니다.");
        }

        if (newTitle != null) {
            post.updateTitle(newTitle);
        }
        if (newContents != null) {
            post.updateContents(newContents);
        }
    }

    public List<PostAllResponseDto> getPostAll() {
        List<Post> posts = postRepository.findAllByJPQL();
        return posts.stream().map(PostAllResponseDto::new).collect(Collectors.toUnmodifiableList());
    }

    public PostOneResponseDto getPostOneByPostId(Long postId) {
        Post post = postRepository.getReferenceById(postId);
        return new PostOneResponseDto(post);
    }
}
