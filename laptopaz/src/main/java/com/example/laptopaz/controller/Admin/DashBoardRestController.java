package com.example.laptopaz.controller.Admin;

import com.example.laptopaz.domain.dto.request.ProductDto;
import com.example.laptopaz.domain.dto.request.RevenueDto;
import com.example.laptopaz.service.DashBoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/dashboard")
public class DashBoardRestController {
    @Autowired
    private DashBoardService dashBoardService;

    @GetMapping("/daily")
    public List<RevenueDto> getDailyRevenue(
            @RequestParam String startDate,
            @RequestParam String endDate) {
        return dashBoardService.getDailyRevenue(LocalDate.parse(startDate), LocalDate.parse(endDate));
    }

    @GetMapping("top-products")
    public ResponseEntity<List<ProductDto>> getProducts(
            @RequestParam String orderBy) {
        List<ProductDto> products = dashBoardService.getProductsWithSales(orderBy);
        return ResponseEntity.ok(products);
    }

    @GetMapping("/low-selling-products")
    public ResponseEntity<List<ProductDto>> getLowSellingProducts() {
        List<ProductDto> products = dashBoardService.getLowSellingProducts();
        return ResponseEntity.ok(products);
    }


}
