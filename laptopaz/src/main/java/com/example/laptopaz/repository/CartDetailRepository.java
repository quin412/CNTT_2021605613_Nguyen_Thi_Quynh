package com.example.laptopaz.repository;

import com.example.laptopaz.domain.entity.Cart;
import com.example.laptopaz.domain.entity.CartDetail;
import com.example.laptopaz.domain.entity.Product;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    boolean existsByCartAndProduct(Cart cart, Product product);

    @Modifying
    @Transactional
    @Query("DELETE FROM CartDetail cd WHERE cd.cart = :cart")
    void deleteAllByCart(@Param("cart") Cart cart);

    CartDetail findByCartAndProduct(Cart cart, Product product);

    List<CartDetail> findByProduct(Product product);
}
