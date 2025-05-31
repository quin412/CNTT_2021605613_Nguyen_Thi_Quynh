package com.example.laptopaz.repository;

import com.example.laptopaz.domain.entity.Customer;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Long> {

    @Query("SELECT COUNT(c) FROM Customer c")
    int countCustomers();

    boolean existsByEmail(String email);

    boolean existsByPhone(String phone);

    Customer findByEmail(String email);

    Customer findByCustomerId(long customerId);

    Customer findByName(String name);

    Page<Customer> findByNameContaining(String name, Pageable pageable);

    @Query(value = "SELECT c.* FROM users c WHERE c.role_id = ?1 and c.is_deleted = false", countQuery = "SELECT COUNT(*) FROM users c WHERE c.role_id = ?1 and c.is_deleted = false", nativeQuery = true)
    Page<Customer> findCustomerByRoleRoleId(Long roleId, Pageable pageable);

    Page<Customer> findByNameAndRoleRoleId(@Param("name") String name, @Param("roleId") Long roleId, Pageable pageable);

    @Query("SELECT COUNT(c) FROM Customer c WHERE MONTH(c.createdDate) = :month AND YEAR(c.createdDate) = :year")
    int countCustomersByMonthAndYear(@Param("month") int month, @Param("year") int year);

    @Query("SELECT COUNT(c) FROM Customer c WHERE DATE(c.createdDate) = :date")
    int countCustomersByDate(LocalDate date);

    @Query(value = "SELECT COUNT(*) FROM users c WHERE c.role_id = :roleId AND c.is_deleted = false", nativeQuery = true)
    int countCustomersByRoleId(@Param("roleId") Long roleId);

}
