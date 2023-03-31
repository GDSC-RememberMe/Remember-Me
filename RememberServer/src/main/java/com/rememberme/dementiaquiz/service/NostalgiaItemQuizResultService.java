package com.rememberme.dementiaquiz.service;

import com.rememberme.dementiaquiz.dto.*;
import com.rememberme.dementiaquiz.entity.NostalgiaItem;
import com.rememberme.dementiaquiz.entity.NostalgiaItemCatalog;
import com.rememberme.dementiaquiz.entity.NostalgiaItemQuizResult;
import com.rememberme.dementiaquiz.repository.NostalgiaItemCatalogRepository;
import com.rememberme.dementiaquiz.repository.NostalgiaItemQuizResultRepository;
import com.rememberme.dementiaquiz.repository.NostalgiaItemRepository;
import com.rememberme.family.entity.Family;
import com.rememberme.member.entity.Member;
import com.rememberme.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class NostalgiaItemQuizResultService {

    private final NostalgiaItemRepository nostalgiaItemRepository;
    private final NostalgiaItemQuizResultRepository nostalgiaItemQuizResultRepository;
    private final NostalgiaItemCatalogRepository nostalgiaItemCatalogRepository;
    private final MemberRepository memberRepository;

    public void saveNostalgiaItemResult(Long memberId, NostalgiaItemRequestDtoList nostalgiaItemRequestDtoList) {

        Family family = getFamilyIdByMemberId(memberId);
        List<NostalgiaItemRequestDto> inputResults = nostalgiaItemRequestDtoList.getResultList();

        // 1. NostalgiaItemCatalog에는 정답 맞춘 것만 저장하기
        createNostalgiaItemCatalog(inputResults, family);

        // 2. 오늘 기록 저장
        LocalDate today = LocalDate.now();
        Long familyId = family.getId();
        List<NostalgiaItemQuizResult> savedResults = nostalgiaItemQuizResultRepository.findAllByFamilyIdAndCreatedAt(familyId, today);

        if (savedResults.size() == 0) {
            createNostalgiaItemQuizResult(inputResults, family);
            return;
        }
        updateNostalgiaItemQuizResult(inputResults, savedResults);
    }

    private void createNostalgiaItemCatalog(List<NostalgiaItemRequestDto> inputResults, Family family) {
        Long familyId = family.getId();
        for (NostalgiaItemRequestDto tmp : inputResults) {
            long id = tmp.getId();
            boolean result = tmp.getResult();
            if (!result) {
                continue;
            }

            Optional<NostalgiaItemCatalog> nostalgiaItemCatalog = nostalgiaItemCatalogRepository.findByFamilyIdAndNostalgiaItemId(familyId, id);
            if (nostalgiaItemCatalog.isEmpty()) {
                NostalgiaItemCatalog newNostalgiaItemCatalog = NostalgiaItemCatalog.builder()
                        .nostalgiaItemId(id)
                        .family(family)
                        .build();
                nostalgiaItemCatalogRepository.save(newNostalgiaItemCatalog);
            }
        }
    }

    private void createNostalgiaItemQuizResult(List<NostalgiaItemRequestDto> inputResults, Family family) {
        for (NostalgiaItemRequestDto inputTmp : inputResults) {
            long nostalgiaItemId = inputTmp.getId();
            boolean isCorrect = inputTmp.getResult();
            NostalgiaItemQuizResult newEntity = NostalgiaItemQuizResult.builder()
                    .family(family)
                    .nostalgiaItemId(nostalgiaItemId)
                    .isCorrect(isCorrect).build();
            nostalgiaItemQuizResultRepository.save(newEntity);
        }
    }

    private void updateNostalgiaItemQuizResult(List<NostalgiaItemRequestDto> inputResults, List<NostalgiaItemQuizResult> savedResults) {
        for (int i = 0; i < savedResults.size(); i++) {
            long nostalgiaItemId = inputResults.get(i).getId();
            boolean isCorrect = inputResults.get(i).getResult();

            NostalgiaItemQuizResult now = savedResults.get(i);
            now.updateQuizResult(nostalgiaItemId, isCorrect);
            nostalgiaItemQuizResultRepository.save(now);
        }
    }

    public HashMap<String, List<NostalgiaItemQuizResultResponseDto>> getNostalgiaItemResultByMonth(Long memberId, int month) {
        Family family = getFamilyIdByMemberId(memberId);
        Long familyId = family.getId();

        List<NostalgiaItemQuizResult> monthResults = getMonthResults(familyId, month);
        List<NostalgiaItemQuizResultResponseDto> dayResults = new ArrayList<>();

        HashMap<String, List<NostalgiaItemQuizResultResponseDto>> results = new HashMap<>();

        for (NostalgiaItemQuizResult tmp : monthResults) {
            Long nostalgiaItemId = tmp.getNostalgiaItemId();
            Optional<NostalgiaItem> nostalgiaItem = nostalgiaItemRepository.findById(nostalgiaItemId);
            if (nostalgiaItem.isEmpty()) {
                throw new RuntimeException("추억의 물건 id가 잘못되었습니다.");
            }
            NostalgiaItemQuizResultResponseDto newDto = new NostalgiaItemQuizResultResponseDto(nostalgiaItem.get(), tmp.isCorrect());
            dayResults.add(newDto);

            String date = tmp.getCreatedAt().toString();
            results.put(date, dayResults);
        }
        return results;
    }

    private List<NostalgiaItemQuizResult> getMonthResults(long familyId, int month) {
        LocalDate now = LocalDate.now();
        int year = now.getYear();
        LocalDate monthStart = LocalDate.of(year, month, 1);
        LocalDate monthEnd = monthStart.plusDays(monthStart.lengthOfMonth()-1);

        return nostalgiaItemQuizResultRepository.findAllByFamilyIdAndCreatedAtBetween(familyId, monthStart, monthEnd);
    }

    public List<NostalgiaItemCatalogResponseDto> getNostalgiaItemResultCategoryAll(Long memberId) {
        Family family = getFamilyIdByMemberId(memberId);
        Long familyId = family.getId();

        List<NostalgiaItemCatalog> nostalgiaItemCatalogs = nostalgiaItemCatalogRepository.findByFamilyId(familyId);
        List<NostalgiaItemCatalogResponseDto> result = new ArrayList<>();
        for (NostalgiaItemCatalog tmp : nostalgiaItemCatalogs) {
            long id = tmp.getNostalgiaItemId();
            String imgUrl = nostalgiaItemRepository.findById(id).get().getImgUrl();
            NostalgiaItemCatalogResponseDto newDto = new NostalgiaItemCatalogResponseDto(id, imgUrl);
            result.add(newDto);
        }
        return result;
    }

    private Family getFamilyIdByMemberId(Long memberId) {
        Member member = memberRepository.findById(memberId)
                .orElseThrow(() -> new RuntimeException("사용자가 존재하지 않습니다."));
        Family family = member.getFamily();
        if (family == null) {
            throw new RuntimeException("사용자의 가족이 설정되지 않았습니다.");
        }
        return family;
    }
}