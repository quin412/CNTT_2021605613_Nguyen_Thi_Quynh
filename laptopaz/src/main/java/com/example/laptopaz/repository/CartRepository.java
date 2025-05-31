package com.example.laptopaz.repository;

import com.example.laptopaz.domain.entity.Cart;
import com.example.laptopaz.domain.entity.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {
    @Modifying
    @Query("DELETE FROM Cart c WHERE c.customer.customerId = :customerId")
    void deleteByCustomerId(@Param("customerId") long customerId);

    Cart findByCustomer(Customer customer);
}

