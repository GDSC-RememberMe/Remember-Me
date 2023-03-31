package com.rememberme.comment;

import com.rememberme.comment.dto.CommentResponseDto;
import com.rememberme.comment.dto.CommentSaveRequestDto;
import com.rememberme.comment.dto.CommentUpdateRequestDto;
import com.rememberme.member.entity.Member;
import com.rememberme.member.repository.MemberRepository;
import com.rememberme.post.Post;
import com.rememberme.post.PostRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CommentService {

    private final CommentRepository commentRepository;
    private final MemberRepository memberRepository;
    private final PostRepository postRepository;

    public List<CommentResponseDto> getCommentsByPostId(@PathVariable Long postId) {
        List<Comment> comments = commentRepository.findByPostId(postId);
        return comments.stream()
                .map(CommentResponseDto::new)
                .collect(Collectors.toUnmodifiableList());
    }

    @Transactional
    public void createComment(Long memberId, CommentSaveRequestDto commentSaveRequestDto) {
        Member member = memberRepository.getReferenceById(memberId);
        Post post = postRepository.getReferenceById(commentSaveRequestDto.getPostId());
        String newContents = commentSaveRequestDto.getContents();

        Comment comment = Comment.builder()
                .contents(newContents)
                .createdAt(LocalDate.now())
                .member(member)
                .post(post)
                .build();
        commentRepository.save(comment);
    }

    @Transactional
    public void updateComment(Long memberId, CommentUpdateRequestDto commentUpdateRequestDto) {
        Long commentId = commentUpdateRequestDto.getCommentId();
        Comment comment = commentRepository.getReferenceById(commentId);
        Long commentMemberId = comment.getMember().getId();

        if (!memberId.equals(commentMemberId)) {
            throw new RuntimeException("댓글 작성자만 수정할 수 있습니다.");
        }

        String newContents = commentUpdateRequestDto.getContents();
        comment.updateContents(newContents);
    }

    @Transactional
    public void deleteComment(Long memberId, Long commentId) {
        Comment comment = commentRepository.getReferenceById(commentId);
        Long commentMemberId = comment.getMember().getId();

        if (!memberId.equals(commentMemberId)) {
            throw new RuntimeException("댓글 작성자만 삭제할 수 있습니다.");
        }
        
        commentRepository.deleteById(commentId);
    }
}
