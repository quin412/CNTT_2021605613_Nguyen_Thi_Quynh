package com.example.laptopaz.repository;

import com.example.laptopaz.domain.entity.Bill;
import com.example.laptopaz.domain.entity.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface BillRepository extends JpaRepository<Bill, Long> {

    @Query("SELECT COUNT(b) FROM Bill b")
    int countBills();

    @Query("SELECT SUM(b.total) FROM Bill b")
    Long getTotalRevenue();

    @Query(value = """
                WITH RECURSIVE calendar AS (
                    SELECT DATE(:startDate) AS day
                    UNION ALL
                    SELECT DATE_ADD(day, INTERVAL 1 DAY)
                    FROM calendar
                    WHERE day < DATE(:endDate)
                )
                SELECT 
                    c.day AS day, 
                    COALESCE(SUM(b.total), 0) AS daily_revenue
                FROM 
                    calendar c
                LEFT JOIN 
                    bills b
                ON 
                    DATE(b.created_date) = c.day
                GROUP BY 
                    c.day
                ORDER BY 
                    c.day;
            """, nativeQuery = true)
    List<Object[]> getDailyRevenue(@Param("startDate") String startDate, @Param("endDate") String endDate);

    @Query(value = """
                WITH RECURSIVE month_cte AS (
                    SELECT 1 AS month 
                    UNION ALL 
                    SELECT month + 1 FROM month_cte WHERE month < 12
                )
                SELECT DATE_FORMAT(CONCAT(:year, '-', LPAD(mc.month, 2, '0'), '-01'), '%Y-%m') AS month, 
                       COALESCE(SUM(bd.price * bd.quantity), 0) AS totalRevenue
                FROM month_cte mc 
                LEFT JOIN bills b ON DATE_FORMAT(b.created_date, '%Y-%m') = DATE_FORMAT(CONCAT(:year, '-', LPAD(mc.month, 2, '0'), '-01'), '%Y-%m') 
                LEFT JOIN bill_detail bd ON b.bill_id = bd.bill_id 
                GROUP BY month
            """, nativeQuery = true)
    List<Object[]> findMonthlyRevenue(@Param("year") String year);

    @Query(value = "SELECT SUM(bd.price * bd.quantity) AS total_revenue " +
            "FROM bill_detail bd " +
            "JOIN bills b ON bd.bill_id = b.bill_id " +
            "WHERE MONTH(b.created_date) = :month AND YEAR(b.created_date) = :year",
            nativeQuery = true)
    Long findTotalRevenue(@Param("month") int month, @Param("year") int year);

    @Query("SELECT COUNT(b) FROM Bill b WHERE MONTH(b.createdDate) = :month AND YEAR(b.createdDate) = :year")
    int countBillsByMonthAndYear(@Param("month") int month, @Param("year") int year);

    @Query(value = "SELECT SUM(bd.price * bd.quantity) AS total_revenue " +
            "FROM bills b " +
            "JOIN bill_detail bd ON b.bill_id = bd.bill_id " +
            "WHERE DATE(b.created_date) = :date",
            nativeQuery = true)
    Long findTotalRevenueByCreatedDate(LocalDate date);

    @Query("SELECT COUNT(b) FROM Bill b WHERE FUNCTION('DATE', b.createdDate) = :date")
    int countBillsByDate(LocalDate date);

    List<Bill> findByCustomer(Customer currentUser);

}
