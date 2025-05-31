package com.example.laptopaz.domain.entity;

import com.example.laptopaz.domain.BillStatus;
import com.example.laptopaz.domain.entity.common.DateAuditing;
import com.example.laptopaz.utils.DateUtils;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "bills")
public class Bill extends DateAuditing implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "bill_id")
    private long billId;

    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private BillStatus status;

    private String paymentMethod;

    private long feeShip;

    private long total;

    @OneToMany(mappedBy = "bill")
    List<BillDetail> billDetails = new ArrayList<>();

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;

    private String receiverName;

    private String receiverAddress;

    private String receiverPhone;

    public Date getCreatedAt() {
        return DateUtils.toDate(this.getCreatedDate());
    }
}
