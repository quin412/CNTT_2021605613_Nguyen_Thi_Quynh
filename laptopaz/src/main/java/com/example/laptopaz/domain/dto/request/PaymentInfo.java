package com.example.laptopaz.domain.dto.request;

import lombok.Data;

@Data
public class PaymentInfo {
    private String bankId;
    private String accountNo;
    private String description;
    private String accountName;
}
