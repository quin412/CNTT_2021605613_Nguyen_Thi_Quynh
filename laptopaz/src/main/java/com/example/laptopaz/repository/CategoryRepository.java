package com.example.laptopaz.repository;

import com.example.laptopaz.domain.entity.Category;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {

    @Query("SELECT COUNT(c) FROM Category c")
    int countCategories();

    Category findCategoryByName(String name);

    List<Category> findAll();

    Category save(Category category);

    Category findCategoryByCategoryId(long id);

    Page<Category> findCategoriesByName(String name, Pageable pageable);

    @Transactional
    @Modifying
    void deleteByCategoryId(long id);

    @Query(value = """
                SELECT c.name AS name, 
                       SUM(bd.quantity * bd.price) AS category_revenue, 
                       (SUM(bd.quantity * bd.price) * 100 / (SELECT SUM(total) FROM bills)) AS market_share
                FROM categories c
                JOIN products p ON c.category_id = p.category_id
                JOIN bill_detail bd ON p.product_id = bd.product_id
                GROUP BY c.name
            """, nativeQuery = true)
    List<Object[]> getCategoryRevenueAndMarketShare();

    @Query(value = """
            WITH CategorySales AS (
                SELECT c.name, SUM(bd.price * bd.quantity) AS categoryRevenue
                FROM categories c
                LEFT JOIN products p ON c.category_id = p.category_id
                LEFT JOIN bill_detail bd ON p.product_id = bd.product_id
                LEFT JOIN bills b ON bd.bill_id = b.bill_id
                WHERE MONTH(b.created_date) = :month AND YEAR(b.created_date) = :year
                GROUP BY c.name
            ),
            TotalSales AS (
                SELECT SUM(categoryRevenue) AS totalRevenue FROM CategorySales
            )
            SELECT cs.name, cs.categoryRevenue, (cs.categoryRevenue / ts.totalRevenue) * 100 AS marketShare
            FROM CategorySales cs
            CROSS JOIN TotalSales ts;
            """, nativeQuery = true)
    List<Object[]> findCategoryMarketShares(@Param("month") int month, @Param("year") int year);

    @Query(value = """
            SELECT c.name AS categoryName, 
                   SUM(bd.quantity * bd.price) AS categoryRevenue,
                   (SUM(bd.quantity * bd.price) * 100.0 / 
                    (SELECT SUM(quantity * price) 
                     FROM bill_detail 
                     WHERE DATE(created_date) = :selectedDate)) AS marketshare
            FROM categories c 
            JOIN products p ON c.category_id = p.category_id
            JOIN bill_detail bd ON p.product_id = bd.product_id
            WHERE DATE(bd.created_date) = :selectedDate
            GROUP BY c.name
            """, nativeQuery = true)
    List<Object[]> findCategoryRevenueAndMarketShareDate(@Param("selectedDate") LocalDate selectedDate);

    @Modifying
    @Query(value = "ALTER TABLE categories AUTO_INCREMENT = 1", nativeQuery = true)
    void resetAutoIncrement();

}
