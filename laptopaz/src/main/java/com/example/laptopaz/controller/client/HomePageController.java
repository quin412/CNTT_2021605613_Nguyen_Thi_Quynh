package com.example.laptopaz.controller.client;

import com.example.laptopaz.domain.dto.request.ProductCriteriaDto;
import com.example.laptopaz.domain.dto.request.RegisterRequestDto;
import com.example.laptopaz.domain.entity.Category;
import com.example.laptopaz.domain.entity.Customer;
import com.example.laptopaz.domain.entity.Product;
import com.example.laptopaz.repository.ProductRepository;
import com.example.laptopaz.service.impl.CategoryServiceImpl;
import com.example.laptopaz.service.impl.CustomerServiceImpl;
import com.example.laptopaz.service.impl.ProductServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.Random;

@Controller
@RequiredArgsConstructor
public class HomePageController {
    private final CustomerServiceImpl customerService;
    private final PasswordEncoder passwordEncoder;

    private final ProductServiceImpl productService;

    private final ProductRepository productRepository;

    private final CategoryServiceImpl categoryService;

    @GetMapping("/login")
    public String getLoginPage(Model model) {
        return "client/auth/login";
    }

    @GetMapping("/session-expired")
    public String getSessionExpiredPage(Model model) {
        return "client/error/session-expired";
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerUser", new RegisterRequestDto());
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String handleRegister(Model model, @ModelAttribute("registerUser") @Valid RegisterRequestDto registerRequestDto, BindingResult bindingResult) {
        if (!registerRequestDto.getPassword().equals(registerRequestDto.getRePassword())) {
            bindingResult.rejectValue("rePassword", "error.registerRequestDto", "Mật khẩu không khớp");
        } else if (customerService.existByEmail(registerRequestDto.getEmail())) {
            bindingResult.rejectValue("email", "error.registerRequestDto", "Email đã được sử dụng");
        } else if (customerService.existByEmail(registerRequestDto.getEmail())) {
            bindingResult.rejectValue("phone", "error.registerRequestDto", "Số điện thoại đã được sử dụng");
        }

        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }
        customerService.registerCustomer(registerRequestDto);
        return "redirect:/login";
    }

    @GetMapping(value = {"/", "/home"})
    public String getHomePage(Model model, @ModelAttribute ProductCriteriaDto productCriteriaDto,
                              @RequestParam(name = "pageNum") Optional<Integer> pageNum,
                              @RequestParam(name = "sortBy") Optional<String> sortBy,
                              HttpServletRequest request) {

        if (!pageNum.isPresent()) {
            pageNum = Optional.of(1);
        }

        String uri = request.getRequestURI();
        if (uri.equals("/")) {
            // Khi vào trang chủ ("/") thì xóa các filter cũ
            request.getSession().removeAttribute("name");
            request.getSession().removeAttribute("category");
            request.getSession().removeAttribute("finalPrice");
        } else {
            if (productCriteriaDto.getName() != null) {
                request.getSession().setAttribute("name", productCriteriaDto.getName());
            } else if (request.getSession().getAttribute("name") != null) {
                productCriteriaDto.setName((String) request.getSession().getAttribute("name"));
            }

            if (productCriteriaDto.getCategory() != null && !productCriteriaDto.getCategory().isEmpty()) {
                request.getSession().setAttribute("category", productCriteriaDto.getCategory());
            } else if (request.getSession().getAttribute("category") != null) {
                productCriteriaDto.setCategory((String) request.getSession().getAttribute("category"));
            }

            if (productCriteriaDto.getPrice() != null && !productCriteriaDto.getPrice().isEmpty()) {
                request.getSession().setAttribute("finalPrice", productCriteriaDto.getPrice());
            } else if (request.getSession().getAttribute("finalPrice") != null) {
                productCriteriaDto.setPrice((String) request.getSession().getAttribute("finalPrice"));
            }
        }


        String sort = "createdDate";
        boolean isAsc = false;

        if (sortBy.isPresent()) {
            switch (sortBy.get()) {
                case "desc":
                    sort = "price";
                    isAsc = false;
                    break;
                case "asc":
                    sort = "price";
                    isAsc = true;
                    break;
                default:
                    sort = "createdDate";
                    isAsc = false;
            }
        }
        PageRequest pageRequest = PageRequest.of(pageNum.get() - 1, 8,
                isAsc ? Sort.by(sort).ascending() : Sort.by(sort).descending());
        Page<Product> page = productService.findProduct(productCriteriaDto, pageRequest);
        model.addAttribute("products", page.getContent());

        Page<Product> products = productRepository.findTopSellingProducts(PageRequest.of(0, 5));
        model.addAttribute("recommend_products", products.getContent());

        model.addAttribute("currentPage", page.getNumber() + 1);
        model.addAttribute("totalPages", page.getTotalPages());
        List<Category> categories = categoryService.findAll();
        model.addAttribute("categories", categories);

        model.addAttribute("selectedCategory", productCriteriaDto.getCategory());
        model.addAttribute("selectedSortBy", sortBy.orElse(" "));
        model.addAttribute("selectedPrice", productCriteriaDto.getPrice());
        model.addAttribute("searchName", productCriteriaDto.getName());
        return "client/homepage/index";
    }

    @GetMapping("/forget")
    public String getForgetPassword(Model model) {
        model.addAttribute("registerUser", new RegisterRequestDto());
        return "client/auth/forget";
    }

    @PostMapping("/forget")
    public String handleForgetPassword(Model model, @ModelAttribute("registerUser") @Valid RegisterRequestDto registerRequestDto, BindingResult bindingResult
            , RedirectAttributes redirectAttributes, HttpServletRequest request) {

        if (!customerService.existByEmail(registerRequestDto.getEmail())) {
            bindingResult.rejectValue("email", "error.registerRequestDto", "Email không tồn tại");
        }
        if (bindingResult.hasErrors()) {
            return "client/auth/forget";
        }

        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
        String verificationCode = String.valueOf(code);

        customerService.sendEmailWithVerificationCode(registerRequestDto.getEmail(), verificationCode);

        request.getSession().setAttribute("verificationCode", verificationCode);
        request.getSession().setAttribute("email", registerRequestDto.getEmail());
        redirectAttributes.addFlashAttribute("registerUser", new RegisterRequestDto());
        return "redirect:/forget/confirmed";
    }

    @GetMapping("/forget/confirmed")
    public String getForgetPasswordConfirm(Model model) {
        model.addAttribute("registerUser", new RegisterRequestDto());

        return "client/auth/confirmed";
    }

    @PostMapping("/forget/confirmed")
    public String handleConfirmCode(Model model, @ModelAttribute("registerUser") @Valid RegisterRequestDto registerRequestDto,
                                    RedirectAttributes redirectAttributes, HttpServletRequest request) {
        String code = (String) request.getSession().getAttribute("verificationCode");
        if (registerRequestDto.getConfirmCode() != null && registerRequestDto.getConfirmCode().equals(code)) {
            return "redirect:/forget/confirmed/updatepass";
        }

        model.addAttribute("error", "Mã xác nhận không chính xác!");
        return "client/auth/confirmed";

    }

    @GetMapping("/forget/confirmed/updatepass")
    public String getForgetPasswordUpdate(Model model) {
        model.addAttribute("registerUser", new RegisterRequestDto());
        return "client/auth/updatepass";
    }

    @PostMapping("/forget/confirmed/updatepass")
    public String ForgetPasswordUpdate(Model model, @ModelAttribute("registerUser") @Valid RegisterRequestDto registerRequestDto,
                                       BindingResult bindingResult, HttpServletRequest request, RedirectAttributes redirectAttributes) {

        if (!Objects.equals(registerRequestDto.getPassword(), registerRequestDto.getRePassword())) {
            bindingResult.rejectValue("rePassword", "error.registerRequestDto", "Mật khẩu xác thực không khớp");
        }
        if (bindingResult.hasErrors()) {
            return "client/auth/updatepass";
        }
        String email = (String) request.getSession().getAttribute("email");
        Customer customer = this.customerService.getCustomerByEmail(email);
        customer.setPassword(this.passwordEncoder.encode(registerRequestDto.getPassword()));
        this.customerService.saveCustomer(customer);
        redirectAttributes.addFlashAttribute("success", "thanh cong");
        return "redirect:/login";
    }
}

