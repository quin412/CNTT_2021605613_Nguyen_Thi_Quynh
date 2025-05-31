package com.example.laptopaz.service.impl;

import com.example.laptopaz.domain.dto.request.CategoryMarketShareDto;
import com.example.laptopaz.domain.dto.request.ProductDto;
import com.example.laptopaz.repository.BillRepository;
import com.example.laptopaz.repository.CategoryRepository;
import com.example.laptopaz.repository.CustomerRepository;
import com.example.laptopaz.repository.ProductRepository;
import com.example.laptopaz.service.MonthReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class MonthReportServiceImpl implements MonthReportService {
    @Autowired
    private BillRepository billRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    public int getTotalProductByMonth(int month, int year) {
        return productRepository.countProductsByMonthAndYear(month, year);
    }

    @Override
    public int getTotalBillByMonth(int month, int year) {
        return billRepository.countBillsByMonthAndYear(month, year);
    }

    @Override
    public int getTotalCustomerByMonth(int month, int year) {
        return customerRepository.countCustomersByMonthAndYear(month, year);
    }

    @Override
    public Long getTotalRevenueByMonth(int month, int year) {
        return billRepository.findTotalRevenue(month, year);
    }

    @Override
    public List<CategoryMarketShareDto> getPieChartDataMonth(int month, int year) {
        List<Object[]> results = categoryRepository.findCategoryMarketShares(month, year);
        return results.stream()
                .map(result -> new CategoryMarketShareDto(
                        (String) result[0],
                        ((Number) result[1]).longValue(),
                        ((Number) result[2]).doubleValue()))
                .toList();
    }

    @Override
    public List<ProductDto> getProductsWithSalesByMonth(int month, int year, String orderBy) {
        List<Object[]> results = productRepository.getProductSalesByMonth(month, year, orderBy);
        return results.stream()
                .map(row -> new ProductDto(
                        ((Number) row[0]).longValue(),  // product_id
                        (String) row[1],                  // name
                        (String) row[2],                  // category_name
                        ((Number) row[3]).longValue(),  // price
                        ((Number) row[4]).intValue()      // total_sales
                ))
                .collect(Collectors.toList());
    }
}

