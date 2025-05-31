package com.example.laptopaz.domain.dto.request;

import lombok.Data;

@Data
public class CartRequestDto {
    private long quantity;
    private long productId;
}
