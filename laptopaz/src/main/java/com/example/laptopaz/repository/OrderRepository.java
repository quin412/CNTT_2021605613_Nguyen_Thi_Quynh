package com.example.laptopaz.repository;

import com.example.laptopaz.domain.entity.Bill;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Bill, Long>, JpaSpecificationExecutor<Bill> {

    List<Bill> findAll();

    void deleteBillByBillId(long billId);

    Bill findBillByBillId(long billId);

    @Query(value = "SELECT b.* FROM bills b WHERE b.status =?1", countQuery = "SELECT COUNT(*) FROM bills b WHERE b.status =?1", nativeQuery = true)
    Page<Bill> findAllBillByStatus(String status, Pageable pageable);

    @Transactional
    @Modifying
    @Query(value = "UPDATE bills b SET b.status =?1 WHERE b.bill_id =?2", nativeQuery = true)
    void updateBillStatus(String status, long billId);
}
