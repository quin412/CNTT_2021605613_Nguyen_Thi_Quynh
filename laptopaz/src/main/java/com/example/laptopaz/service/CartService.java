package com.example.laptopaz.service;

import com.example.laptopaz.domain.entity.Cart;
import com.example.laptopaz.domain.entity.Customer;
import jakarta.servlet.http.HttpSession;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface CartService {
    void handleAddProductToCart(String email, long productId, HttpSession session, long quantity);

    Cart fetchByUser(Customer currentUser, HttpSession session);

    void handleRemoveCartDetail(long cartDetailId, HttpSession session);

    int getCartSum(String email, HttpSession session);

}

