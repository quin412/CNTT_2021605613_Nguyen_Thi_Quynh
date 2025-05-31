package com.example.laptopaz.controller.Admin;

import com.example.laptopaz.domain.entity.Customer;
import com.example.laptopaz.service.impl.CustomerServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
public class AdminPageController {

    private final CustomerServiceImpl customerService;

    private static final long ROLE_USER_ID = 2L;

    @ModelAttribute("newUser")
    public Customer defaultCustomer() {
        return new Customer();
    }

    @GetMapping("/admin/user")
    public String getAdminUserPage(Model model, @RequestParam("page") Optional<String> page) {
        int pageNum = parsePageNumber(page);
        Pageable pageable = PageRequest.of(pageNum - 1, 4);
        Page<Customer> customerPage = customerService.findCustomersByRoleId(ROLE_USER_ID, pageable);

        List<Customer> users = customerPage != null ? customerPage.getContent() : new ArrayList<>();
        users.forEach(this::convertRoleName);

        int totalPages = (customerPage != null && customerPage.getTotalPages() > 0) ? customerPage.getTotalPages() : 1;

        model.addAttribute("users", users);
        model.addAttribute("currentPage", pageNum);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("newUser", new Customer());

        return "admin/user/show";
    }

    @PostMapping("/admin/user")
    public String searchCustomerPage(Model model,
                                     @ModelAttribute("newUser") Customer customer,
                                     @RequestParam("page") Optional<String> page) {
        int pageNum = parsePageNumber(page);
        Pageable pageable = PageRequest.of(pageNum - 1, 4);
        Page<Customer> customerPage;

        if (customer.getName() != null && !customer.getName().trim().isEmpty()) {
            customerPage = customerService.findCustomersByNameAndRoleId(customer.getName(), ROLE_USER_ID, pageable);
            if (customerPage == null || customerPage.isEmpty()) {
                customerPage = customerService.findCustomersByRoleId(ROLE_USER_ID, pageable);
            }
        } else {
            customerPage = customerService.findCustomersByRoleId(ROLE_USER_ID, pageable);
        }

        List<Customer> customers = customerPage != null ? customerPage.getContent() : new ArrayList<>();
        customers.forEach(this::convertRoleName);

        model.addAttribute("users", customers);
        model.addAttribute("currentPage", pageNum);
        model.addAttribute("totalPages", customerPage != null ? customerPage.getTotalPages() : 1);

        return "admin/user/show";
    }

    @GetMapping("/admin/user/{Id}")
    public String getAdminUserViewPage(Model model, @PathVariable("Id") Long id) {
        Customer customer = customerService.getCustomerById(id);
        if (customer == null) {
            return "redirect:/admin/user?error=notfound";
        }
        model.addAttribute("userview", customer);
        return "admin/user/detail";
    }

    @GetMapping("/admin/user/delete/{Id}")
    public String getDeleteAdminUserPage(Model model, @PathVariable("Id") Long id) {
        Customer customer = customerService.getCustomerById(id);
        if (customer == null) {
            return "redirect:/admin/user?error=notfound";
        }
        model.addAttribute("cus", customer);
        model.addAttribute("newUser", new Customer());
        return "admin/user/delete";
    }

    @PostMapping("/admin/user/delete")
    @Transactional
    public String deleteAdminUser(@RequestParam("customerId") Long id) {
        customerService.deleteCustomer(id);
        return "redirect:/admin/user";
    }

    // Utility methods
    private int parsePageNumber(Optional<String> page) {
        try {
            return page.map(Integer::parseInt).filter(p -> p > 0).orElse(1);
        } catch (Exception e) {
            return 1;
        }
    }

    private void convertRoleName(Customer customer) {
        if (customer.getRole() != null && "ROLE_USER".equals(customer.getRole().getRoleName())) {
            customer.getRole().setRoleName("Người dùng");
        }
    }
}
