package com.example.laptopaz.domain.dto.request;

import com.example.laptopaz.domain.BillStatus;
import com.example.laptopaz.domain.entity.BillDetail;
import com.example.laptopaz.domain.entity.Customer;
import lombok.Data;

import java.util.List;

@Data
public class BillInfo {
    private long billId;

    private BillStatus status;

    private String paymentMethod;

    private long feeShip;

    private long total;

    List<BillDetail> billDetails;

    private Customer customer;

    private String receiverName;

    private String receiverAddress;

    private String receiverPhone;

    private String createdDate;
}
