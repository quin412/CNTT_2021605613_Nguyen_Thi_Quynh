package com.example.laptopaz.domain.dto.request;

import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class RegisterRequestDto {
    @Pattern(message = "Email không hợp lệ", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
    private String email;

    @Size(min = 3, message = "Mật khẩu phải tối thiểu 3 ký tự")
    private String password;

    private String rePassword;
    @Size(min = 3, message = "Tên phải tối thiểu 3 ký tự")
    private String name;

    @Pattern(message = "Số điện thoại không hợp lệ", regexp = "^(0[3|5|7|8|9])+([0-9]{8})$")
    private String phone;

    private String confirmCode;
}
