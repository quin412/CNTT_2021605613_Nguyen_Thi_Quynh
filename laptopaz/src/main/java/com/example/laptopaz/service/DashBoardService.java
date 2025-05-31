package com.example.laptopaz.service;

import com.example.laptopaz.domain.dto.request.CategoryMarketShareDto;
import com.example.laptopaz.domain.dto.request.ProductDto;
import com.example.laptopaz.domain.dto.request.RevenueDto;

import java.time.LocalDate;
import java.util.List;

public interface DashBoardService {
    int getTotalProduct();

    int getTotalBill();

    int getTotalCustomer();

    Long getTotalRevenue();

    List<RevenueDto> getDailyRevenue(LocalDate startDate, LocalDate endDate);

    List<RevenueDto> getMonthlyRevenue(String year);

    List<CategoryMarketShareDto> getPieChartData();

    List<ProductDto> getProductsWithSales(String orderBy);

    List<ProductDto> getLowSellingProducts();

}
