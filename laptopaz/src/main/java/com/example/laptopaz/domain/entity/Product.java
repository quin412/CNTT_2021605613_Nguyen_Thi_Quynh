package com.example.laptopaz.domain.entity;

import com.example.laptopaz.domain.entity.common.DateAuditing;
import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Table(name = "products")
public class Product extends DateAuditing implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private long productId;

    @NotNull(message = "Tên sản phẩm không được để trống")
    private String name;

    @Min(value = 0, message = "Số lượng phải lớn hơn 0")
    private long quantity;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Min(value = 0, message = "Giá phải lớn hơn 0")
    private long price;

    @Min(value = 0, message = "Giảm giá phải lớn hơn hoặc bằng 0")
    private double discount;

    private long finalPrice;

    private boolean isDeleted = false;

    @OneToMany(mappedBy = "product")
    List<CartDetail> cartDetails = new ArrayList<>();

    @OneToMany(mappedBy = "product")
    List<BillDetail> billDetails = new ArrayList<>();

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    List<Image> images = new ArrayList<>();

    @ManyToOne
    @JoinColumn(name = "category_id", nullable = true)
    private Category category;

    @OneToMany(mappedBy = "product")
    List<FeedBack> feedBacks = new ArrayList<>();
}
