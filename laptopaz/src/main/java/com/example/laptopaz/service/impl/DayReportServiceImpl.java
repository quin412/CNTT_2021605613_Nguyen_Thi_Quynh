package com.example.laptopaz.service.impl;

import com.example.laptopaz.domain.dto.request.CategoryMarketShareDto;
import com.example.laptopaz.domain.dto.request.ProductDto;
import com.example.laptopaz.repository.BillRepository;
import com.example.laptopaz.repository.CategoryRepository;
import com.example.laptopaz.repository.CustomerRepository;
import com.example.laptopaz.repository.ProductRepository;
import com.example.laptopaz.service.DayReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class DayReportServiceImpl implements DayReportService {

    @Autowired
    private BillRepository billRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    public int getTotalProductByDate(String date) {
        return productRepository.countProductsByDate(LocalDate.parse(date));
    }

    @Override
    public int getTotalBillByDate(String date) {
        return billRepository.countBillsByDate(LocalDate.parse(date));
    }

    @Override
    public int getTotalCustomerByDate(String date) {
        return customerRepository.countCustomersByDate(LocalDate.parse(date));
    }

    @Override
    public Long getTotalRevenueByDate(String date) {
        return billRepository.findTotalRevenueByCreatedDate(LocalDate.parse(date));
    }

    @Override
    public List<CategoryMarketShareDto> getPieChartDataDate(String date) {
        List<Object[]> results = categoryRepository.findCategoryRevenueAndMarketShareDate(LocalDate.parse(date));
        return results.stream()
                .map(result -> new CategoryMarketShareDto(
                        (String) result[0],
                        ((Number) result[1]).longValue(),
                        ((Number) result[2]).doubleValue()))
                .toList();
    }

    @Override
    public List<ProductDto> getProductsWithSalesByDates(String date, String orderBy) {
        List<Object[]> results = productRepository.findProductsByDate(LocalDate.parse(date), orderBy.toUpperCase());

        // Map Object[] to ProductDTO
        return results.stream()
                .map(row -> new ProductDto(
                        ((Number) row[0]).longValue(),  // productId
                        (String) row[1],               // productName
                        (String) row[2],               // categoryName
                        ((Number) row[3]).longValue(), // price
                        ((Number) row[4]).intValue()   // numberOfSales
                ))
                .collect(Collectors.toList());
    }
}
