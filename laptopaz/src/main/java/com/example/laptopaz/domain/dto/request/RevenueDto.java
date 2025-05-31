package com.example.laptopaz.domain.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class RevenueDto {
    private String label;
    private Long totalRevenue;

    @Override
    public String toString() {
        return "DailyRevenueDTO{" +
                "day='" + label + '\'' +
                ", dailyRevenue=" + totalRevenue +
                '}';
    }
}
