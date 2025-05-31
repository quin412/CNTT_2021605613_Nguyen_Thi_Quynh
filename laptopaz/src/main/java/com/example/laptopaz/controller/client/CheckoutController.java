package com.example.laptopaz.controller.client;

import com.example.laptopaz.domain.dto.request.BillInfo;
import com.example.laptopaz.domain.dto.request.FeedbackRequestDto;
import com.example.laptopaz.domain.dto.request.PaymentInfo;
import com.example.laptopaz.domain.entity.Cart;
import com.example.laptopaz.domain.entity.CartDetail;
import com.example.laptopaz.domain.entity.Customer;
import com.example.laptopaz.domain.entity.Product;
import com.example.laptopaz.repository.CustomerRepository;
import com.example.laptopaz.service.CartService;
import com.example.laptopaz.service.CheckoutService;
import com.example.laptopaz.service.impl.FeedBackServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class CheckoutController {
    private final CartService cartService;
    private final CheckoutService checkoutService;
    private final FeedBackServiceImpl feedBackService;
    private final CustomerRepository customerRepository;

    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        Customer currentUser = customerRepository.findById(id).orElse(null);

        Cart cart = cartService.fetchByUser(currentUser, session);

        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            Product product = cd.getProduct();
            totalPrice += product.getFinalPrice() * cd.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("currentUser", currentUser);

        return "client/cart/checkout";
    }

    @PostMapping("/confirm-checkout")
    public String getCheckOutPage(@ModelAttribute("cart") Cart cart) {
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        checkoutService.handleUpdateCartBeforeCheckout(cartDetails);
        return "redirect:/checkout";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(
            HttpServletRequest request,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone,
            @RequestParam("paymentMethod") String paymentMethod) {
        Customer currentUser = new Customer();// null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setCustomerId(id);

        checkoutService.handlePlaceOrder(currentUser, session, receiverName, receiverAddress, receiverPhone, paymentMethod);

        return "redirect:/thanks";
    }

    @GetMapping("/thanks")
    public String getThankYouPage(Model model) {

        return "client/cart/thanks";
    }

    @GetMapping("/order-history")
    public String getOrderHistoryPage(Model model, HttpServletRequest request) {
        Customer currentUser = new Customer();// null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setCustomerId(id);

        List<BillInfo> orders = checkoutService.fetchOrderByUser(currentUser);
        model.addAttribute("orders", orders);

        return "client/cart/order-history";
    }

    @PostMapping("/cancel-bill/{id}")
    public String cancelOrder(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        long oderId = id;
        String email = (String) session.getAttribute("email");

        checkoutService.cancelBill(email, oderId, session, 1);

        return "redirect:/order-history";
    }

    @GetMapping("checkout/payment-info")
    public ResponseEntity<PaymentInfo> getPaymentInfo() {
        PaymentInfo paymentInfo = checkoutService.getPaymentInfo();
        return ResponseEntity.ok(paymentInfo);
    }

    @PostMapping("/api/give-feedback")
    public ResponseEntity<?> giveFeedBack(@RequestBody FeedbackRequestDto requestDto) {
        feedBackService.giveFeedBack(requestDto);
        return ResponseEntity.ok("Đánh giá thành công!");
    }
}

