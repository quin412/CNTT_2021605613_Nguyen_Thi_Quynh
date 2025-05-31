package com.example.laptopaz.domain.dto.request;

import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ChangePassRequestDto {
    private String password;

    @Size(min = 3, message = "Mật khẩu phải tối thiểu 3 ký tự")
    private String newpassword;

    @Size(min = 3, message = "Mật khẩu phải tối thiểu 3 ký tự")
    private String confirmpassword;
}
