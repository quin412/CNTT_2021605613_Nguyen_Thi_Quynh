package com.example.laptopaz.controller.Admin;

import com.example.laptopaz.domain.entity.Category;
import com.example.laptopaz.domain.entity.Image;
import com.example.laptopaz.domain.entity.Product;
import com.example.laptopaz.service.impl.CategoryServiceImpl;
import com.example.laptopaz.service.impl.ImageServiceImpl;
import com.example.laptopaz.service.impl.ProductServiceImpl;
import com.example.laptopaz.service.impl.UploadServiceImpl;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
public class ProductPageController {
    private final ProductServiceImpl productService;
    private final CategoryServiceImpl categoryService;
    private final ImageServiceImpl imageService;
    private final UploadServiceImpl uploadService;

    @GetMapping("/admin/product")
    public String getProductPage(Model model) {
        List<Product> products = this.productService.getProducts();
        model.addAttribute("products", products);
        return "admin/product/show";
    }

    @GetMapping("/admin/product/{Id}")
    public String detailProductPage(@PathVariable("Id") long Id, Model model) {
        Product product = this.productService.getProductById(Id);
        model.addAttribute("product", product);
        return "admin/product/detail";
    }

    @GetMapping("/admin/product/create")
    public String getcreateProductPage(Model model) {
        Product product = new Product();

        List<Image> images = new ArrayList<>();

        List<Category> categories = this.categoryService.getCategories();
        model.addAttribute("categories", categories);
        model.addAttribute("newProduct", product);
        model.addAttribute("images", images);
        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String createProduct(Model model,
                                @ModelAttribute("newProduct") Product product,
                                @RequestParam("imageFiles") List<MultipartFile> imageFiles,
                                RedirectAttributes redirectAttributes) {
        log.info("Received product: {}", product);
        log.info("Received images: {}", imageFiles);

        Category categoryName = categoryService.getCategoryByName(product.getCategory().getName());
        List<Category> categories = this.categoryService.getCategories();
        model.addAttribute("categories", categories);

        boolean hasError = false; // Biến kiểm tra xem có lỗi hay không

        // Kiểm tra các lỗi và thêm vào RedirectAttributes
        if (product.getName() == null || product.getName().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorName", "Tên sản phẩm không được để trống");
            hasError = true;
        }
        if (product.getDescription() == null || product.getDescription().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorDescription", "Mô tả không được để trống");
            hasError = true;
        }
        if (product.getPrice() <= 0) {
            redirectAttributes.addFlashAttribute("errorPrice", "Giá sản phẩm phải lớn hơn 0");
            hasError = true;
        }
        if (product.getQuantity() <= 0) {
            redirectAttributes.addFlashAttribute("errorQuantity", "Số lượng sản phẩm phải lớn hơn 0");
            hasError = true;
        }
        if (product.getDiscount() < 0 || product.getDiscount() >= 100) {
            redirectAttributes.addFlashAttribute("errorDiscount", "Giảm giá nằm trong khoảng từ 0 đến 100");
            hasError = true;
        }

        // Kiểm tra các lỗi từ service, nếu có lỗi, thêm vào RedirectAttributes
        this.productService.rqProduct(product, redirectAttributes);

        // Kiểm tra số lượng ảnh, nếu không đủ 3 ảnh, thêm thông báo lỗi
        if (imageFiles.size() != 3) {
            redirectAttributes.addFlashAttribute("errorImage", "Vui lòng chọn đủ 3 ảnh cho sản phẩm");
            hasError = true;
        }

        // Nếu có lỗi, trả về trang tạo sản phẩm với thông báo lỗi
        if (hasError || redirectAttributes.containsAttribute("errorName") ||
                redirectAttributes.containsAttribute("errorDescription") ||
                redirectAttributes.containsAttribute("errorPrice") ||
                redirectAttributes.containsAttribute("errorQuantity") ||
                redirectAttributes.containsAttribute("errorDiscount") ||
                redirectAttributes.containsAttribute("errorImage")) {

            redirectAttributes.addFlashAttribute("savedProduct", product);

            return "redirect:/admin/product/create"; // Trả về lại trang tạo sản phẩm với các thông báo lỗi
        }

        // Nếu không có lỗi, tiếp tục lưu sản phẩm
        product.setCreatedDate(LocalDateTime.ofInstant(new Date().toInstant(), ZoneId.systemDefault()));
        product.setLastModifiedDate(LocalDateTime.ofInstant(new Date().toInstant(), ZoneId.systemDefault()));
        product.setCategory(categoryName);

        // Lưu sản phẩm vào cơ sở dữ liệu
        productService.saveProduct(product);

        // Lưu hình ảnh (nếu có)
        List<Image> images = new ArrayList<>();
        for (MultipartFile file : imageFiles) {
            if (!file.isEmpty()) {
                Image image = new Image();

                String url = this.uploadService.handleSaveUploadFile(file, "products");
                image.setUrl(url);
                image.setProduct(product);
                imageService.saveImage(image);

                images.add(image);
            }
        }

        // Cập nhật giá cuối cùng của sản phẩm
        product.setFinalPrice((long) (product.getPrice() - product.getPrice() * product.getDiscount() / 100));
        product.setImages(images);
        productService.saveProduct(product); // Lưu lại sản phẩm với hình ảnh

        return "redirect:/admin/product"; // Redirect đến trang danh sách sản phẩm
    }

    @GetMapping("/admin/product/delete/{id}")
    public String getdeleteProductPage(Model model, @PathVariable("id") long id) {
        model.addAttribute("id", id);
        model.addAttribute("newProduct", new Product());
        return "admin/product/delete";
    }

    @Transactional
    @PostMapping("/admin/product/delete")
    public String postdeleteProductPage(Model model, @ModelAttribute("newProduct") Product product) {
        this.productService.deleteProduct(product.getProductId());
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/update/{id}")
    public String getUpdateProductPage(Model model, @PathVariable long id) {
        Product currentProduct = this.productService.findProductById(id);
        model.addAttribute("newProduct", currentProduct);
        model.addAttribute("id", currentProduct.getProductId());
        List<Category> categories = this.categoryService.getCategories();
        model.addAttribute("categories", categories);
        return "admin/product/update";
    }

    @PostMapping("/admin/product/update/{id}")
    public String handleUpdateProduct(Model model, @ModelAttribute("newProduct") @Valid Product product, @PathVariable("id") long id,
                                      BindingResult newProductBindingResult,
                                      @RequestParam("imageFiles") List<MultipartFile> imageFiles,
                                      RedirectAttributes redirectAttributes) {
        boolean hasError = false;

        // Kiểm tra các trường dữ liệu
        if (product.getName() == null || product.getName().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorName", "Tên sản phẩm không được để trống");
            hasError = true;
        }
        if (product.getDescription() == null || product.getDescription().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorDescription", "Mô tả không được để trống");
            hasError = true;
        }
        if (product.getPrice() == 0) {
            redirectAttributes.addFlashAttribute("errorPrice", "Giá sản phẩm không được để trống");
            hasError = true;
        } else if (product.getPrice() <= 0) {
            redirectAttributes.addFlashAttribute("errorPrice", "Giá sản phẩm phải lớn hơn 0");
            hasError = true;
        } else {
            try {
                Long.parseLong(String.valueOf(product.getPrice()));
            } catch (NumberFormatException e) {
                redirectAttributes.addFlashAttribute("errorPrice", "Giá sản phẩm phải là số");
                hasError = true;
            }
        }

        if (product.getQuantity() == 0) {
            redirectAttributes.addFlashAttribute("errorQuantity", "Số lượng sản phẩm không được để trống");
            hasError = true;
        } else if (product.getQuantity() <= 0) {
            redirectAttributes.addFlashAttribute("errorQuantity", "Số lượng sản phẩm phải lớn hơn 0");
            hasError = true;
        } else {
            try {
                Long.parseLong(String.valueOf(product.getQuantity()));
            } catch (NumberFormatException e) {
                redirectAttributes.addFlashAttribute("errorQuantity", "Số lượng sản phẩm phải là số");
                hasError = true;
            }
        }

        if (product.getDiscount() < 0 || product.getDiscount() >= 100) {
            redirectAttributes.addFlashAttribute("errorDiscount", "Giảm giá phải lớn hơn hoặc bằng 0 và bé hơn 100");
            hasError = true;
        } else {
            try {
                Double.parseDouble(String.valueOf(product.getDiscount()));
            } catch (NumberFormatException e) {
                redirectAttributes.addFlashAttribute("errorDiscount", "Giảm giá phải là số");
                hasError = true;
            }
        }

        // Nếu có lỗi, trả về lại trang cập nhật với các thông báo lỗi
        if (hasError) {
            return "redirect:/admin/product/update/" + id;
        }

        Category categoryName = categoryService.getCategoryByName(product.getCategory().getName());

        List<Category> categories = this.categoryService.getCategories();
        model.addAttribute("categories", categories);
        if (newProductBindingResult.hasErrors()) {
            return "admin/product/update";
        }
        List<Image> images = new ArrayList<>();

        Product currentProduct = this.productService.findProductById(id);
        if (currentProduct != null) {
            // update new image

            currentProduct.setName(product.getName());
            currentProduct.setPrice(product.getPrice());
            currentProduct.setQuantity(product.getQuantity());
            currentProduct.setDiscount(product.getDiscount());
            currentProduct.setDescription(product.getDescription());
            currentProduct.setCategory(categoryName);
            currentProduct.setFinalPrice((long) (product.getPrice() - product.getPrice() * product.getDiscount() / 100));

            boolean isDelete = false;
            for (MultipartFile file : imageFiles) {
                if (!file.isEmpty()) {
                    isDelete = true;
                    break;
                }
            }
            if (isDelete) {
                for (Image tmp : currentProduct.getImages()) {
                    imageService.deleteImage(tmp.getProduct().getProductId());
                }
            }
            for (MultipartFile file : imageFiles) {
                if (!file.isEmpty()) {
                    Image image = new Image();
                    String url = this.uploadService.handleSaveUploadFile(file, "products");
                    image.setUrl(url);
                    image.setProduct(currentProduct);
                    imageService.saveImage(image);
                    images.add(image);
                }
            }

            currentProduct.setImages(images);
            this.productService.saveProduct(currentProduct);
        }

        return "redirect:/admin/product";
    }

}

