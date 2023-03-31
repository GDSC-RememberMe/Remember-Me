package com.rememberme.dementiaquiz.repository;

import com.rememberme.dementiaquiz.entity.NostalgiaItemQuizResult;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface NostalgiaItemQuizResultRepository extends JpaRepository<NostalgiaItemQuizResult, Long> {

    // 한 달동안만
    @Query("SELECT n from NostalgiaItemQuizResult n WHERE n.family.id = :familyId AND n.createdAt BETWEEN :startDate AND :endDate")
    List<NostalgiaItemQuizResult> findAllByFamilyIdAndCreatedAtBetween(@Param("familyId") Long familyId, @Param("startDate")LocalDate startDate, @Param("endDate")LocalDate endDate);


    // 오늘 하루
    @Query("SELECT n from NostalgiaItemQuizResult n WHERE n.family.id = :familyId AND n.createdAt = :date")
    List<NostalgiaItemQuizResult> findAllByFamilyIdAndCreatedAt(@Param("familyId") Long familyId, @Param("date")LocalDate date);

}
