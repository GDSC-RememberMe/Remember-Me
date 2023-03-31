package com.rememberme.family;

import com.rememberme.family.dto.FamilySearchResponseDto;
import com.rememberme.family.entity.Family;
import com.rememberme.member.entity.Member;
import com.rememberme.member.entity.enumType.Role;
import com.rememberme.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class FamilyService {

    private final FamilyRepository familyRepository;
    private final MemberRepository memberRepository;

    public List<FamilySearchResponseDto> searchFamilyByKeyword(String keyword) {
        List<Member> memberList = memberRepository.findByUsernameContaining(keyword);

        return memberList.stream()
                .filter(user -> user.getRole().equals(Role.PATIENT))
                .map(user -> new FamilySearchResponseDto().of(user))
                .collect(Collectors.toUnmodifiableList());
    }

    public void setFamilyOfCaregiverUser(Long userId, Long familyId) {
        Member member = memberRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("해당 보호자 회원이 존재하지 않습니다."));
        Family family = familyRepository.findById(familyId)
                .orElseThrow(() -> new RuntimeException("해당 환자 회원이 존재하지 않습니다."));

        member.saveFamily(family);
    }

    public Long getFamilyIdByMemberId(Long memberId) {
        Member member = memberRepository.findById(memberId)
                .orElseThrow(() -> new RuntimeException("사용자가 존재하지 않습니다."));
        Family family = member.getFamily();
        if (family == null) {
            throw new RuntimeException("사용자의 가족이 설정되지 않았습니다.");
        }
        return family.getId();
    }

    public Long getPatientIdByMemberId(Long memberId) {
        Member member = memberRepository.findById(memberId)
                .orElseThrow(() -> new RuntimeException("사용자가 존재하지 않습니다."));
        Family family = member.getFamily();
        if (family == null) {
            throw new RuntimeException("사용자의 가족이 설정되지 않았습니다.");
        }
        return family.getPatientId();
    }
}