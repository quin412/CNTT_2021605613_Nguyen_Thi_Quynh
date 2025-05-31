package com.example.laptopaz.service.impl;

import com.example.laptopaz.domain.BillStatus;
import com.example.laptopaz.domain.dto.request.BillInfo;
import com.example.laptopaz.domain.dto.request.PaymentInfo;
import com.example.laptopaz.domain.entity.*;
import com.example.laptopaz.repository.*;
import com.example.laptopaz.service.CheckoutService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CheckoutServiceImpl implements CheckoutService {
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final CustomerRepository customerRepository;
    private final ProductRepository productRepository;
    private final BillRepository billRepository;
    private final BillDetailRepository billDetailRepository;

    public void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails) {
        for (CartDetail cartDetail : cartDetails) {
            Optional<CartDetail> cdOptional = cartDetailRepository.findById(cartDetail.getId());
            if (cdOptional.isPresent()) {
                CartDetail currentCartDetail = cdOptional.get();
                Product product = currentCartDetail.getProduct();
                if (product.getQuantity() < cartDetail.getQuantity()) {
                    throw new RuntimeException("ERROR_CHECKOUT");
                }
                currentCartDetail.setQuantity(cartDetail.getQuantity());
                cartDetailRepository.save(currentCartDetail);
            }
        }
    }

    @Override
    public List<BillInfo> fetchOrderByUser(Customer currentUser) {
        List<Bill> bills = billRepository.findByCustomer(currentUser);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        List<BillInfo> billInfos = new ArrayList<>();
        bills.forEach(bill -> {
            BillInfo billInfo = new BillInfo();
            billInfo.setBillDetails(bill.getBillDetails());
            billInfo.setCreatedDate(bill.getCreatedDate().format(formatter));
            billInfo.setBillId(bill.getBillId());
            billInfo.setFeeShip(bill.getFeeShip());
            billInfo.setCustomer(bill.getCustomer());
            billInfo.setTotal(bill.getTotal());
            billInfo.setPaymentMethod(bill.getPaymentMethod());
            billInfo.setStatus(bill.getStatus());
            billInfo.setReceiverName(bill.getReceiverName());
            billInfo.setReceiverPhone(bill.getReceiverPhone());
            billInfo.setReceiverAddress(bill.getReceiverAddress());
            billInfos.add(billInfo);
        });
        Collections.reverse(billInfos);
        return billInfos;
    }

    @Override
    public void cancelBill(String email, long oderId, HttpSession session, int i) {
        Bill bill = billRepository.findById(oderId).orElseThrow(() -> new RuntimeException("Bill not found"));
        bill.setStatus(BillStatus.CANCELLED);
        billRepository.save(bill);
    }

    @Override
    public PaymentInfo getPaymentInfo() {
        PaymentInfo paymentInfo = new PaymentInfo();
        paymentInfo.setAccountName("NGUYEN THI QUYNH");
        paymentInfo.setBankId("VCB");
        paymentInfo.setAccountNo("1023095398");
        paymentInfo.setDescription("KHACH HANG LAPTOPAZ CHUYEN KHOAN");
        return paymentInfo;
    }

    public void handlePlaceOrder(
            Customer user, HttpSession session,
            String receiverName, String receiverAddress, String receiverPhone, String paymentMethod) {

        // step 1: get cart by user
        Cart cart = cartRepository.findByCustomer(user);
        if (cart != null) {
            List<CartDetail> cartDetails = cart.getCartDetails();

            if (cartDetails != null) {

                // create order
                Bill order = new Bill();
                order.setCustomer(user);
                order.setReceiverName(receiverName);
                order.setReceiverAddress(receiverAddress);
                order.setReceiverPhone(receiverPhone);
                order.setPaymentMethod(paymentMethod);
                order.setFeeShip(30000L);
                order.setCreatedDate(LocalDateTime.now());
                order.setLastModifiedDate(LocalDateTime.now());
                order.setStatus(BillStatus.WAITING);

                long sum = 30000;
                for (CartDetail cd : cartDetails) {
                    sum += cd.getProduct().getPrice() + cd.getQuantity();
                }
                order.setTotal(sum);
                order = billRepository.save(order);

                // create orderDetail

                for (CartDetail cd : cartDetails) {
                    BillDetail orderDetail = new BillDetail();
                    Product product = cd.getProduct();
                    orderDetail.setBill(order);
                    orderDetail.setProduct(cd.getProduct());
                    orderDetail.setPrice(cd.getProduct().getPrice());
                    orderDetail.setQuantity(cd.getQuantity());
                    product.setQuantity(product.getQuantity() - cd.getQuantity());
                    orderDetail.setCreatedDate(LocalDateTime.now());
                    orderDetail.setLastModifiedDate(LocalDateTime.now());
                    billDetailRepository.save(orderDetail);
                    productRepository.save(product);

                }

                // step 2: delete cart_detail and cart
                for (CartDetail cd : cartDetails) {
                    List<CartDetail> cartDetails1 = cartDetailRepository.findByProduct(cd.getProduct());
                    if (cd.getProduct().getQuantity() == 0) {
                        cartDetailRepository.deleteAllById(cartDetails1.stream().map(CartDetail::getId).collect(Collectors.toList()));
                    } else {
                        cartDetails1.forEach(cartDetail -> {
                            if (cartDetail.getQuantity() > cd.getProduct().getQuantity()) {
                                cartDetail.setQuantity(cd.getProduct().getQuantity());
                            }
                        });
                        cartDetailRepository.saveAll(cartDetails1);
                    }
                    cartDetailRepository.deleteById(cd.getId());
                }

                //     cartRepository.deleteById(cart.getCartId());

                // step 3 : update session
                session.setAttribute("sum", 0);
            }
        }

    }
}
