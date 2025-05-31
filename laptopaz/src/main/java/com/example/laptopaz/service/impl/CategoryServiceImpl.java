package com.example.laptopaz.service.impl;

import com.example.laptopaz.domain.entity.Category;
import com.example.laptopaz.repository.*;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CategoryServiceImpl {
    private final CustomerRepository customerRepository;
    private final PasswordEncoder passwordEncoder;
    private final CartRepository cartRepository;
    private final RoleRepository roleRepository;
    private final CategoryRepository categoryRepository;
    private final ProductRepository productRepository;

    public List<Category> findAll() {
        return categoryRepository.findAll();
    }

    public List<Category> getCategories() {
        return categoryRepository.findAll();
    }

    public Page<Category> findAll(Pageable pageable) {
        return categoryRepository.findAll(pageable);
    }

    public Category getCategoryByName(String categoryName) {
        return this.categoryRepository.findCategoryByName(categoryName);
    }

    public Category saveCategory(Category category) {
        return categoryRepository.save(category);
    }

    public Page<Category> findBynameContaining(String name, Pageable pageable) {
        return categoryRepository.findCategoriesByName(name, pageable);
    }

    public Category getCategoryById(long id) {
        return categoryRepository.findCategoryByCategoryId(id);
    }

    public void deleteCategory(long id) {
        this.productRepository.updateCategoryToNull(id);
        this.categoryRepository.deleteByCategoryId(id);
    }

    public int countCategories() {
        return categoryRepository.countCategories();
    }

    @Transactional
    public void resetAutoIncrement() {
        categoryRepository.resetAutoIncrement();
    }

}
