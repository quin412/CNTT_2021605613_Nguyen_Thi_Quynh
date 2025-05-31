package com.example.laptopaz.controller.client;

import com.example.laptopaz.domain.entity.Category;
import com.example.laptopaz.service.impl.CategoryServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
public class CategoryPageController {
    private final CategoryServiceImpl categoryService;

    @GetMapping("/admin/category")
    public String CategoryPage(Model model, @RequestParam("page") Optional<String> page) {
        int pageNum = 1;
        try {
            if (page.isPresent()) {
                pageNum = Integer.parseInt(page.get());
            }
        } catch (Exception e) {
        }

        Pageable pageable = PageRequest.of(pageNum - 1, 4);
        Page<Category> categoryPage = this.categoryService.findAll(pageable);
        List<Category> categories = categoryPage.getContent();

        model.addAttribute("cates", categories);
        model.addAttribute("currentPage", pageNum);
        int totalPages = categoryPage.getTotalPages() > 0 ? categoryPage.getTotalPages() : 1;
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("newCategory", new Category());
        return "admin/category/show";
    }

    @PostMapping("/admin/category")
    public String searchCategoryPage(Model model, @ModelAttribute("newCategory") Category category
            , @RequestParam("page") Optional<String> page) {

        Category category1 = this.categoryService.getCategoryByName(category.getName());
        Page<Category> categoryPage;

        int pageNum = 1;
        try {
            if (page.isPresent()) {
                pageNum = Integer.parseInt(page.get());
            }
        } catch (Exception e) {
        }
        Pageable pageable = PageRequest.of(pageNum - 1, 4);
        if (category1 != null) {
            categoryPage = this.categoryService.findBynameContaining(category1.getName(), pageable);
        } else {
            categoryPage = this.categoryService.findAll(pageable);
        }

        List<Category> categories = categoryPage.getContent();

        model.addAttribute("cates", categories);
        model.addAttribute("currentPage", pageNum);
        int totalPages = categoryPage.getTotalPages() > 0 ? categoryPage.getTotalPages() : 1;
        model.addAttribute("totalPages", totalPages);
        return "admin/category/show";
    }

    @GetMapping("/admin/category/create")
    public String getcreateCategoryPage(Model model) {
        model.addAttribute("newCate", new Category());
        return "admin/category/create";
    }

    @PostMapping("/admin/category/create")
    public String createCategoryPage(Model model, @ModelAttribute("newCate") Category category) {
        Category newCate = this.categoryService.getCategoryByName(category.getName());
        if (newCate == null) {
            if (this.categoryService.countCategories() == 0) {
                this.categoryService.resetAutoIncrement();
            }

            category.setCreatedDate(LocalDateTime.ofInstant(new Date().toInstant(), ZoneId.systemDefault()));
            category.setLastModifiedDate(LocalDateTime.ofInstant(new Date().toInstant(), ZoneId.systemDefault()));
            this.categoryService.saveCategory(category);
            return "redirect:/admin/category";
        } else {
            model.addAttribute("error", "Danh mục đã tồn tại");
            return "admin/category/create";
        }
    }


    @GetMapping("/admin/category/update/{Id}")
    public String getupdateCategoryPage(Model model, @PathVariable long Id) {
        Category category = new Category();
        model.addAttribute("newCate", category);
        Category category1 = this.categoryService.getCategoryById(Id);
        model.addAttribute("category1", category1);
        return "admin/category/update";
    }

    @PostMapping("/admin/category/update/{Id}")
    public String updateCategoryPage(Model model, @PathVariable("Id") long id, @ModelAttribute Category category) {

        List<Category> categories = this.categoryService.getCategories();
        for (Category c : categories) {
            if (Objects.equals(c.getName(), category.getName())) {
                model.addAttribute("error", "Danh mục đã tồn tại");
                Category category1 = this.categoryService.getCategoryById(id);
                model.addAttribute("category1", category1);
                model.addAttribute("newCate", new Category());
                return "admin/category/update";
            }
        }
        Category cate = this.categoryService.getCategoryById(id);
        cate.setName(category.getName());
        cate.setLastModifiedDate(LocalDateTime.ofInstant(new Date().toInstant(), ZoneId.systemDefault()));
        this.categoryService.saveCategory(cate);
        return "redirect:/admin/category";

    }

    @GetMapping("/admin/category/delete/{Id}")
    public String getdeleteCategoryPage(Model model, @PathVariable long Id) {
        Category category = this.categoryService.getCategoryById(Id);
        if (category == null) {
            return "redirect:/admin/category?error=notfound";
        }
        model.addAttribute("cate", category);
        model.addAttribute("newCate", new Category());
        return "admin/category/delete";
    }

    @PostMapping("/admin/category/delete")
    @Transactional
    public String deleteCategoryPage(Model model, @ModelAttribute("newCate") Category category) {
        this.categoryService.deleteCategory(category.getCategoryId());
        return "redirect:/admin/category";
    }

}
