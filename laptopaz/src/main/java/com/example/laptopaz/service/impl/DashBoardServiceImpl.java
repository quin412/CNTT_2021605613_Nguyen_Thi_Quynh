package com.example.laptopaz.service.impl;

import com.example.laptopaz.domain.dto.request.CategoryMarketShareDto;
import com.example.laptopaz.domain.dto.request.ProductDto;
import com.example.laptopaz.domain.dto.request.RevenueDto;
import com.example.laptopaz.repository.BillRepository;
import com.example.laptopaz.repository.CategoryRepository;
import com.example.laptopaz.repository.CustomerRepository;
import com.example.laptopaz.repository.ProductRepository;
import com.example.laptopaz.service.DashBoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class DashBoardServiceImpl implements DashBoardService {

    @Autowired
    private BillRepository billRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    public int getTotalProduct() {
        return productRepository.countProducts();
    }

    @Override
    public int getTotalBill() {
        return billRepository.countBills();
    }

    @Override
    public int getTotalCustomer() { return customerRepository.countCustomersByRoleId(2L);}

    @Override
    public Long getTotalRevenue() {
        return billRepository.getTotalRevenue();
    }

    @Override
    public List<RevenueDto> getDailyRevenue(LocalDate startDate, LocalDate endDate) {
        List<Object[]> rawResults = billRepository.getDailyRevenue(startDate.toString(), endDate.toString());

        return rawResults.stream()
                .map(record -> new RevenueDto(
                        record[0].toString(),
                        ((Number) record[1]).longValue() // Ensure correct casting to Long
                ))
                .collect(Collectors.toList());
    }

    @Override
    public List<RevenueDto> getMonthlyRevenue(String year) {
        List<Object[]> results = billRepository.findMonthlyRevenue(year);
        return results.stream()
                .map(row -> new RevenueDto((String) row[0], ((Number) row[1]).longValue()))
                .toList();
    }

    @Override
    public List<CategoryMarketShareDto> getPieChartData() {
        List<Object[]> results = categoryRepository.getCategoryRevenueAndMarketShare();
        return results.stream()
                .map(row -> new CategoryMarketShareDto(
                        (String) row[0],  // name
                        ((Number) row[1]).longValue(),  // category_revenue
                        ((Number) row[2]).doubleValue()   // market_share
                ))
                .collect(Collectors.toList());
    }

    @Override
    public List<ProductDto> getProductsWithSales(String orderBy) {
        List<Object[]> results = productRepository.findAllProductsWithSales(orderBy);

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

    @Override
    public List<ProductDto> getLowSellingProducts() {
        List<Object[]> results = productRepository.findLowSellingProducts();

        return results.stream()
                .map(row -> new ProductDto(
                        ((Number) row[0]).longValue(),  // product_id
                        (String) row[1],                // name
                        (String) row[2],                // category_name
                        ((Number) row[3]).longValue(),  // price
                        ((Number) row[4]).intValue()    // total_sales
                ))
                .collect(Collectors.toList());
    }
}
