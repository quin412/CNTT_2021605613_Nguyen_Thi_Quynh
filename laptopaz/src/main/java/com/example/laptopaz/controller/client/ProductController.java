package com.example.laptopaz.controller.client;

import com.example.laptopaz.domain.entity.Category;
import com.example.laptopaz.domain.entity.FeedBack;
import com.example.laptopaz.domain.entity.Product;
import com.example.laptopaz.service.impl.CategoryServiceImpl;
import com.example.laptopaz.service.impl.FeedBackServiceImpl;
import com.example.laptopaz.service.impl.ProductServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
public class ProductController {
    private final ProductServiceImpl productService;
    private final CategoryServiceImpl categoryService;
    private final FeedBackServiceImpl feedBackService;

    @GetMapping("/product/{id}")
    public String getProductPage(Model model, @PathVariable(name = "id") long id, @RequestParam(name = "pageNum") Optional<Integer> pageNum) {
        Product pr = this.productService.findProductById(id);
        List<Category> categories = categoryService.findAll();
        if (!pageNum.isPresent()) {
            pageNum = Optional.of(1);
        }
        PageRequest pageRequest = PageRequest.of(pageNum.get() - 1, 2);

        Page<FeedBack> page = feedBackService.findByProductId(id, pageRequest);
        float rate = feedBackService.getAvgRateByProductId(id).orElse(5.0f);
        model.addAttribute("rate", rate);
        model.addAttribute("categories", categories);
        model.addAttribute("feedbacks", page.getContent());
        model.addAttribute("product", pr);
        model.addAttribute("id", id);
        model.addAttribute("currentPage", page.getNumber() + 1);
        model.addAttribute("totalPages", page.getTotalPages());

        // Gợi ý sản phẩm tương tự
        List<Product> relatedProducts = productService.findSimilarProducts(pr.getCategory().getCategoryId(), pr.getPrice(), pr.getProductId());
        model.addAttribute("relatedProducts", relatedProducts);

        return "client/product/detail";
    }


}

