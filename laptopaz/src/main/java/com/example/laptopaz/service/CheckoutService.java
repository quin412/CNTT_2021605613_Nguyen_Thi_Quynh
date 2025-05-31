package com.example.laptopaz.service;

import com.example.laptopaz.domain.dto.request.BillInfo;
import com.example.laptopaz.domain.dto.request.PaymentInfo;
import com.example.laptopaz.domain.entity.CartDetail;
import com.example.laptopaz.domain.entity.Customer;
import jakarta.servlet.http.HttpSession;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
public interface CheckoutService {
    void handlePlaceOrder(Customer currentUser, HttpSession session, String receiverName, String receiverAddress, String receiverPhone, String paymentMethod);

    void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails);

    List<BillInfo> fetchOrderByUser(Customer currentUser);

    void cancelBill(String email, long oderId, HttpSession session, int i);

    PaymentInfo getPaymentInfo();
}