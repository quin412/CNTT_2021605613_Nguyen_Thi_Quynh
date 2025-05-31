package com.example.laptopaz.service;

import com.example.laptopaz.domain.dto.request.CategoryMarketShareDto;
import com.example.laptopaz.domain.dto.request.ProductDto;

import java.util.List;

public interface MonthReportService {
    int getTotalProductByMonth(int month, int year);

    int getTotalBillByMonth(int month, int year);

    int getTotalCustomerByMonth(int month, int year);

    Long getTotalRevenueByMonth(int month, int year);

    List<CategoryMarketShareDto> getPieChartDataMonth(int month, int year);

    List<ProductDto> getProductsWithSalesByMonth(int month, int year, String orderBy);
}
