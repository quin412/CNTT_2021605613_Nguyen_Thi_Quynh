package com.example.laptopaz.controller.Admin;

import com.example.laptopaz.domain.dto.request.ProductDto;
import com.example.laptopaz.service.DashBoardService;
import com.example.laptopaz.service.DayReportService;
import com.example.laptopaz.service.ExportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/day")
public class DayReportController {

    @Autowired
    private DayReportService dayReportService;

    @Autowired
    private DashBoardService dashBoardService;

    @Autowired
    private ExportService exportService;

    @GetMapping("/{date}")
    public String getDashBoardMonthPage(Model model, @PathVariable("date") String date) {
        model.addAttribute("totalProduct", dayReportService.getTotalProductByDate(date));
        model.addAttribute("totalBill", dayReportService.getTotalBillByDate(date));
        model.addAttribute("totalCustomer", dayReportService.getTotalCustomerByDate(date));
        Long totalRevenue = dayReportService.getTotalRevenueByDate(date);
        model.addAttribute("totalRevenue", totalRevenue != null ? totalRevenue : 0);
        model.addAttribute("pieChartData", dayReportService.getPieChartDataDate(date));
        model.addAttribute("date", date);
//        model.addAttribute("year", year);
//        System.out.println(model.getAttribute("pieChartData"));
        return "admin/dashboard/dayreport";
    }

    @GetMapping("/top-products")
    @ResponseBody
    public List<ProductDto> getTopProducts(@RequestParam String date, @RequestParam(defaultValue = "DESC") String orderBy) {
        if (!"ASC".equalsIgnoreCase(orderBy) && !"DESC".equalsIgnoreCase(orderBy)) {
            throw new IllegalArgumentException("Invalid orderBy value: " + orderBy);
        }
        return dayReportService.getProductsWithSalesByDates(date, orderBy);
    }

    @GetMapping("/export/{date}")
    @ResponseBody
    public byte[] exportDayReport(@PathVariable String date) throws Exception {
        return exportService.exportDayReport(date);
    }
}

