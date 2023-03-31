package com.rememberme.dementiaquiz.repository;

import com.rememberme.dementiaquiz.entity.NostalgiaItemCatalog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface NostalgiaItemCatalogRepository extends JpaRepository<NostalgiaItemCatalog, Long> {

    List<NostalgiaItemCatalog> findByFamilyId(Long familyId);

    @Query("SELECT n from NostalgiaItemCatalog n WHERE n.family.id = :familyId AND n.nostalgiaItemId = :nostalgiaItemId")
    Optional<NostalgiaItemCatalog> findByFamilyIdAndNostalgiaItemId(@Param("familyId") Long familyId, @Param("nostalgiaItemId") Long nostalgiaItemId);
}