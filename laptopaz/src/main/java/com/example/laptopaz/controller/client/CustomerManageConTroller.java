package com.example.laptopaz.controller.client;

import com.example.laptopaz.domain.dto.request.ChangePassRequestDto;
import com.example.laptopaz.domain.entity.Customer;
import com.example.laptopaz.service.impl.CustomerServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.text.SimpleDateFormat;
import java.util.Objects;

@Controller
@RequiredArgsConstructor
public class CustomerManageConTroller {
    private final CustomerServiceImpl customerService;
    private final PasswordEncoder passwordEncoder;

    @GetMapping("/client/user")
    public String getUserManagePage(Model model) {
        Customer customer = customerService.getCurrentCustomer();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String date = "";
        if (customer.getDob() != null) {
            date = dateFormat.format(customer.getDob());
        }
        if (customer != null) {
            model.addAttribute("customer", customer);
            model.addAttribute("date", date);
            model.addAttribute("newCustomer", new Customer());
            return "client/usermanage/show";
        } else {
            return "redirect:/";
        }
    }

    @PostMapping("/client/user/update")
    public String updateUserManagePage(@ModelAttribute("newCustomer") Customer customer, Model model, RedirectAttributes redirectAttributes) {
        Customer customerToUpdate = customerService.getCurrentCustomer();
        if (customerToUpdate != null) {
            customerToUpdate.setName(customer.getName());
            customerToUpdate.setPhone(customer.getPhone());
            customerToUpdate.setAddress(customer.getAddress());
            customerToUpdate.setDob(customer.getDob());
            this.customerService.saveCustomer(customerToUpdate);

            redirectAttributes.addFlashAttribute("update", "Cập nhật thành công");

            return "redirect:/client/user";
        } else {
            return "redirect:/";
        }

    }


    @GetMapping("/client/user/changepassword")
    public String getChangePasswordPage(Model model) {
        model.addAttribute("newPass", new ChangePassRequestDto());
        return "client/usermanage/changepassword";
    }

    @PostMapping("/client/user/changepassword")
    public String ChangePasswordPage(Model model, @ModelAttribute("newPass") ChangePassRequestDto newPass, RedirectAttributes redirectAttributes) {
        Customer customer = customerService.getCurrentCustomer();
        if (!this.passwordEncoder.matches(newPass.getPassword(), String.valueOf(customer.getPassword()))) {
            model.addAttribute("errorOld", "Mật khẩu cũ không đúng");

            return "client/usermanage/changepassword";
        }
        if (newPass.getNewpassword().length() < 3) {
            model.addAttribute("errorNew", "Mật khẩu phải tối thiểu 3 ký tự");
            return "client/usermanage/changepassword";
        }
        if (!Objects.equals(newPass.getNewpassword(), newPass.getConfirmpassword())) {
            model.addAttribute("errorConfirm", "Mật khẩu mới không khớp");

            return "client/usermanage/changepassword";
        }
        customer.setPassword(passwordEncoder.encode(newPass.getNewpassword()));
        this.customerService.saveCustomer(customer);
        redirectAttributes.addFlashAttribute("update", "Đổi mật khẩu thành công thành công");
        return "redirect:/client/user";
    }
}

