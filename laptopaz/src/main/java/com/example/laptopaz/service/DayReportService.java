package com.example.laptopaz.service;

import com.example.laptopaz.domain.dto.request.CategoryMarketShareDto;
import com.example.laptopaz.domain.dto.request.ProductDto;

import java.util.List;

public interface DayReportService {
    int getTotalProductByDate(String date);

    int getTotalBillByDate(String date);

    int getTotalCustomerByDate(String date);

    Long getTotalRevenueByDate(String date);

    List<CategoryMarketShareDto> getPieChartDataDate(String date);

    List<ProductDto> getProductsWithSalesByDates(String date, String orderBy);
}
