package com.rememberme.dementiaquiz.repository;

import com.rememberme.dementiaquiz.entity.NostalgiaItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface NostalgiaItemRepository extends JpaRepository<NostalgiaItem, Long>  {

    @Query(value = "SELECT * FROM nostalgia_item order by RAND() limit 10", nativeQuery = true)
    List<NostalgiaItem> findRandomLimit10();
}
