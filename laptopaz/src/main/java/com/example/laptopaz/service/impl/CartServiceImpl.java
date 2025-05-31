package com.example.laptopaz.service.impl;

import com.example.laptopaz.domain.entity.Cart;
import com.example.laptopaz.domain.entity.CartDetail;
import com.example.laptopaz.domain.entity.Customer;
import com.example.laptopaz.domain.entity.Product;
import com.example.laptopaz.repository.CartDetailRepository;
import com.example.laptopaz.repository.CartRepository;
import com.example.laptopaz.repository.CustomerRepository;
import com.example.laptopaz.repository.ProductRepository;
import com.example.laptopaz.service.CartService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CartServiceImpl implements CartService {
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final CustomerRepository customerRepository;
    private final ProductRepository productRepository;

    public void handleAddProductToCart(String email, long productId, HttpSession session, long quantity) {

        Customer user = customerRepository.findByEmail(email);
        if (user == null) {
            throw new RuntimeException("USER_NOT_FOUND");
        }

        Cart cart = cartRepository.findByCustomer(user);
        if (cart == null) {
            cart = cartRepository.save(Cart.builder()
                    .customer(user)
                    .sum(0)
                    .build());
        }

        Optional<Product> productOptional = productRepository.findById(productId);
        if (productOptional.isEmpty()) {
            throw new RuntimeException("PRODUCT_NOT_FOUND");
        }

        Product realProduct = productOptional.get();

        if (quantity <= 0 || quantity > realProduct.getQuantity()) {
            throw new RuntimeException("INVALID_QUANTITY");
        }

        CartDetail oldDetail = cartDetailRepository.findByCartAndProduct(cart, realProduct);

        if (oldDetail == null) {
            CartDetail cd = CartDetail.builder()
                    .cart(cart)
                    .product(realProduct)
                    .quantity(quantity)
                    .build();

            cd.setCreatedDate(LocalDateTime.now());
            cd.setLastModifiedDate(LocalDateTime.now());
            cartDetailRepository.save(cd);

            long newSum = cart.getSum() + quantity;
            cart.setSum((int) newSum);
            cartRepository.save(cart);
            session.setAttribute("sum", newSum);

        } else {
            long totalQuantity = oldDetail.getQuantity() + quantity;
            if (totalQuantity > realProduct.getQuantity()) {
                throw new RuntimeException("EXCEED_PRODUCT_QUANTITY");
            }

            oldDetail.setQuantity(totalQuantity);
            oldDetail.setLastModifiedDate(LocalDateTime.now());
            cartDetailRepository.save(oldDetail);

            int newSum = cart.getSum() + (int) quantity;
            cart.setSum(newSum);
            cartRepository.save(cart);
            session.setAttribute("sum", newSum);
        }
    }

    public Cart fetchByUser(Customer user, HttpSession session) {
        Cart cart = cartRepository.findByCustomer(user);
        session.setAttribute("sum", cart.getCartDetails().size());
        return cart;
    }

    public void handleRemoveCartDetail(long cartDetailId, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = cartDetailRepository.findById(cartDetailId);
        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();

            Cart currentCart = cartDetail.getCart();
            // delete cart-detail
            cartDetailRepository.deleteById(cartDetailId);

            // update cart
            if (currentCart.getSum() > 1) {
                // update current cart
                int s = currentCart.getSum() - 1;
                currentCart.setSum(s);
                session.setAttribute("sum", s);
                cartRepository.save(currentCart);
            } else {
                // delete cart (sum = 1)
                cartRepository.deleteById(currentCart.getCartId());
                session.setAttribute("sum", 0);
            }
        }
    }

    @Override
    public int getCartSum(String email, HttpSession session) {
        Customer user = customerRepository.findByEmail(email);
        Cart cart = cartRepository.findByCustomer(user);
        session.setAttribute("sum", cart.getCartDetails().size());
        return cart.getCartDetails().size();
    }
}
