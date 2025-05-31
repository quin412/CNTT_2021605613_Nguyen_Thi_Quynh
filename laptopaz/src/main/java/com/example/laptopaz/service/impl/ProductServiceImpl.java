package com.example.laptopaz.service.impl;

import com.example.laptopaz.domain.dto.request.ProductCriteriaDto;
import com.example.laptopaz.domain.entity.Product;
import com.example.laptopaz.repository.ProductRepository;
import jakarta.persistence.criteria.*;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl {

    private final ProductRepository productRepository;

    public Page<Product> findProduct(ProductCriteriaDto productCriteriaDto, Pageable pageable) {

        Page<Product> page = productRepository.findAll(new Specification<Product>() {
            @Override
            public Predicate toPredicate(Root<Product> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();

                if (productCriteriaDto.getName() != null && !productCriteriaDto.getName().trim().isEmpty()) {
                    predicates.add(criteriaBuilder.like(root.get("name"), "%" + productCriteriaDto.getName() + "%"));
                }

                long min = 0, max = 0;
                if (productCriteriaDto.getPrice() != null && !productCriteriaDto.getPrice().trim().isEmpty()) {
                    switch (productCriteriaDto.getPrice()) {
                        case "duoi-10-trieu":
                            min = 1;
                            max = 10000000;
                            break;
                        case "10-15-trieu":
                            min = 10000000;
                            max = 15000000;
                            break;
                        case "15-20-trieu":
                            min = 15000000;
                            max = 20000000;
                            break;
                        case "tren-20-trieu":
                            min = 20000000;
                            max = 200000000;
                            break;
                    }
                    predicates.add(criteriaBuilder.between(root.get("finalPrice"), min, max));
                }

                if (productCriteriaDto.getCategory() != null && !productCriteriaDto.getCategory().trim().isEmpty()) {

                    Join<Object, Object> joinCategory = root.join("category", JoinType.INNER);
                    predicates.add(criteriaBuilder.equal(joinCategory.get("name"), productCriteriaDto.getCategory()));
                }
                predicates.add(criteriaBuilder.equal(root.get("isDeleted"), Boolean.FALSE));
                return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
            }
        }, pageable);
        return page;
    }

    public Product findProductById(Long id) {
        return productRepository.findByProductId(id).orElse(null);
    }

    public List<Product> getProducts() {
        return productRepository.findAll();
    }

    public Product getProductById(long id) {
        return productRepository.findProductByProductId(id);
    }

    public void rqProduct(Product product, RedirectAttributes redirectAttributes) {

        if (product.getName() == null || product.getName().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorName", "Tên không được để trống");
        }
        if (product.getQuantity() <= 0) {
            redirectAttributes.addFlashAttribute("errorQuantity", "Số lượng sản phẩm phải lớn hơn không");
        }
        if (product.getPrice() <= 0) {
            redirectAttributes.addFlashAttribute("errorPrice", "Giá sản phẩm phải lớn hơn không");
        }
        if (product.getDiscount() <= 0) {
            redirectAttributes.addFlashAttribute("errorDiscount", "Giảm giá sản phẩm phải lớn hơn không");
        }

    }

    public boolean existsProductByName(String name) {
        return productRepository.existsByName(name);
    }

    public Product saveProduct(Product product) {
        return productRepository.save(product);
    }

    public void deleteProduct(long id) {
        productRepository.deleteProduct(id);
    }

    public Optional<Product> fetchProductById(long id) {
        return productRepository.findById(id);
    }

    // Phương thức để cập nhật sản phẩm
    @Transactional
    public void updateProduct(Product product) {
        Product existingProduct = productRepository.findById(product.getProductId()).orElseThrow(() -> new RuntimeException("Product not found"));

        // Cập nhật các trường thông tin
        existingProduct.setName(product.getName());
        existingProduct.setQuantity(product.getQuantity());
        existingProduct.setDescription(product.getDescription());
        existingProduct.setPrice(product.getPrice());
        existingProduct.setDiscount(product.getDiscount());
        existingProduct.setFinalPrice((long) (product.getPrice() - product.getPrice() * product.getDiscount() / 100));

        // Cập nhật các thông tin khác nếu cần
        productRepository.save(existingProduct);  // Lưu lại vào DB
    }

    public List<Product> findSimilarProducts(Long categoryId, double price, Long excludeProductId) {
        double minPrice = price * 0.8;
        double maxPrice = price * 1.2;
        return productRepository.findSimilar(categoryId, minPrice, maxPrice, excludeProductId);
    }


}


