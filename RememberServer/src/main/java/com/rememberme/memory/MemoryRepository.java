package com.rememberme.memory;

import com.rememberme.memory.dto.MemoryRandomResponseDto;
import com.rememberme.memory.entity.Memory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface MemoryRepository extends JpaRepository<Memory, Long> {

     Optional<Memory> findById(Long memoryId);

     List<Memory> findAllByFamilyId(Long familyId);

     @Query(value = "SELECT * FROM memory WHERE family_id = :familyId AND category = :category", nativeQuery = true)
     List<Memory> findAllByCategoryAndFamilyId(@Param("familyId")Long familyId, @Param("category")String category);

     @Query(value = "SELECT * FROM memory WHERE family_id = :familyId order by RAND() limit 1",nativeQuery = true)
     Optional<Memory> findOneRandomMemoryIdByFamilyId(@Param("familyId")Long familyId);
}