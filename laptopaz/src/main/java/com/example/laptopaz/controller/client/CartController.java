package com.example.laptopaz.controller.client;

import com.example.laptopaz.domain.dto.request.CartRequestDto;
import com.example.laptopaz.domain.entity.Cart;
import com.example.laptopaz.domain.entity.CartDetail;
import com.example.laptopaz.domain.entity.Customer;
import com.example.laptopaz.domain.entity.Product;
import com.example.laptopaz.service.CartService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class CartController {
    private final CartService cartService;

    @PostMapping("/api/add-product-to-cart")
    public ResponseEntity<?> addProductToCart(
            @RequestBody() CartRequestDto cartRequest,
            HttpServletRequest request) {

        try {
            HttpSession session = request.getSession(false);
            String email = (String) session.getAttribute("email");
            cartService.handleAddProductToCart(email, cartRequest.getProductId(), session,
                    cartRequest.getQuantity());

            int sum = (int) session.getAttribute("sum");

            return ResponseEntity.ok().body(sum);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        Customer currentUser = new Customer();// null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setCustomerId(id);

        Cart cart = cartService.fetchByUser(currentUser, session);

        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            Product product = cd.getProduct();
            totalPrice += product.getFinalPrice() * cd.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);

        model.addAttribute("cart", cart);

        return "client/cart/show";
    }

    @PostMapping("/delete-cart-product/{id}")
    public String deleteCartDetail(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long cartDetailId = id;
        cartService.handleRemoveCartDetail(cartDetailId, session);
        return "redirect:/cart";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        long productId = id;
        String email = (String) session.getAttribute("email");

        cartService.handleAddProductToCart(email, productId, session, 1);

        return "redirect:/cart";
    }

    @GetMapping("api/cart/sum")
    public ResponseEntity<Integer> getCartSum(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        int sum = cartService.getCartSum(email, session);
        return ResponseEntity.ok().body(sum);
    }
}

