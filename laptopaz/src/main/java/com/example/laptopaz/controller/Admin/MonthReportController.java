package com.example.laptopaz.controller.Admin;

import com.example.laptopaz.domain.dto.request.ProductDto;
import com.example.laptopaz.service.DashBoardService;
import com.example.laptopaz.service.ExportService;
import com.example.laptopaz.service.MonthReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/admin/month")
public class MonthReportController {

    @Autowired
    private MonthReportService monthReportService;

    @Autowired
    private DashBoardService dashBoardService;

    @Autowired
    private ExportService exportService;

    @GetMapping("/{month}/{year}")
    public String getDashBoardMonthPage(Model model, @PathVariable("month") int month, @PathVariable("year") int year) {
        model.addAttribute("totalProduct", monthReportService.getTotalProductByMonth(month, year));
        model.addAttribute("totalBill", monthReportService.getTotalBillByMonth(month, year));
        model.addAttribute("totalCustomer", monthReportService.getTotalCustomerByMonth(month, year));
        Long totalRevenue = monthReportService.getTotalRevenueByMonth(month, year);
        model.addAttribute("totalRevenue", totalRevenue != null ? totalRevenue : 0);
        model.addAttribute("pieChartData", monthReportService.getPieChartDataMonth(month, year));
        model.addAttribute("month", month);
        model.addAttribute("year", year);
        model.addAttribute("date", LocalDate.of(year, month, 1));
        System.out.println(model.getAttribute("pieChartData"));
        return "admin/dashboard/monthreport";
    }

    @GetMapping("/top-products")
    @ResponseBody
    public List<ProductDto> getTopProducts(@RequestParam int month, @RequestParam int year, @RequestParam(defaultValue = "DESC") String orderBy) {
        if (!"ASC".equalsIgnoreCase(orderBy) && !"DESC".equalsIgnoreCase(orderBy)) {
            throw new IllegalArgumentException("Invalid orderBy value: " + orderBy);
        }
        return monthReportService.getProductsWithSalesByMonth(month, year, orderBy);
    }

    @GetMapping("/export/{month}/{year}")
    @ResponseBody
    public byte[] exportMonthReport(@PathVariable int month, @PathVariable int year) throws Exception {
        return exportService.exportMonthReport(month, year);
    }
}

