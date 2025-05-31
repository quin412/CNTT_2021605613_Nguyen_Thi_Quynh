package com.example.laptopaz.repository;

import com.example.laptopaz.domain.entity.Image;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface ImageRepository extends JpaRepository<Image, Long> {
    @Transactional
    @Modifying
    @Query(value = "DELETE FROM images i where i.product_id = ?1", nativeQuery = true)
    void deleteByProductId(Long imageId);
}