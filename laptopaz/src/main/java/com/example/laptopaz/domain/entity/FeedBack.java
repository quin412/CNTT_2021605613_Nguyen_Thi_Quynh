package com.example.laptopaz.domain.entity;

import com.example.laptopaz.domain.entity.common.DateAuditing;
import jakarta.persistence.*;
import lombok.*;

import java.io.Serializable;
import java.time.ZoneId;
import java.util.Date;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "feedback")
public class FeedBack extends DateAuditing implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long feedbackId;

    private String content;

    private int rate;

    private String createBy;

    public Date getCreateDate() {
        return java.util.Date.from(super.getCreatedDate().atZone(ZoneId.systemDefault()).toInstant());
    }

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;
}