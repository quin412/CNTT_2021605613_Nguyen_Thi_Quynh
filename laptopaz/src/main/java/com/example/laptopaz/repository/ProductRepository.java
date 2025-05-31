package com.example.laptopaz.repository;

import com.example.laptopaz.domain.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long>, JpaSpecificationExecutor<Product> {

    @Query("SELECT COUNT(p) FROM Product p")
    int countProducts();

    @Modifying
    @Query("UPDATE Product p SET p.category = null WHERE p.category.categoryId = :categoryId")
    void updateCategoryToNull(@Param("categoryId") long categoryId);

    @Query("SELECT p FROM Product p WHERE p.productId=?1")
    Optional<Product> findByProductId(Long id);

    @Override

    @Query(value = "SELECT p.* FROM products p WHERE p.is_deleted = false", nativeQuery = true)
    List<Product> findAll();

    Product findProductByProductId(long productId);

    Product save(Product product);

    boolean existsByName(String name);

    @Transactional
    @Modifying
    void deleteProductByProductId(long productId);

    @Query(value = """
                SELECT p.product_id, p.name, c.name AS category_name, p.price, 
                       COALESCE(SUM(bd.quantity), 0) AS total_sales
                FROM products p
                JOIN categories c ON p.category_id = c.category_id
                LEFT JOIN bill_detail bd ON p.product_id = bd.product_id
                GROUP BY p.product_id, p.name, c.name, p.price
                ORDER BY CASE WHEN :orderBy = 'ASC' THEN total_sales END ASC,
                         CASE WHEN :orderBy = 'DESC' THEN total_sales END DESC
            """, nativeQuery = true)
    List<Object[]> findAllProductsWithSales(@Param("orderBy") String orderBy);

    @Query("SELECT COUNT(p) FROM Product p WHERE FUNCTION('MONTH', p.createdDate) = :month AND FUNCTION('YEAR', p.createdDate) = :year")
    int countProductsByMonthAndYear(@Param("month") int month, @Param("year") int year);

    @Transactional
    @Modifying
    @Query(value = "UPDATE products c set c.is_deleted = true WHERE  c.product_id = ?1", nativeQuery = true)
    void deleteProduct(long id);

    @Query(value = """
            SELECT 
                p.product_id AS productId, 
                p.name AS name, 
                c.name AS categoryName, 
                p.price AS price, 
                SUM(bd.quantity) AS totalSales
            FROM 
                products p 
            JOIN 
                categories c ON p.category_id = c.category_id 
            LEFT JOIN 
                bill_detail bd ON p.product_id = bd.product_id 
            LEFT JOIN 
                bills b ON bd.bill_id = b.bill_id 
            WHERE 
                MONTH(b.created_date) = :month AND YEAR(b.created_date) = :year 
            GROUP BY 
                p.product_id, p.name, c.name, p.price 
            ORDER BY CASE WHEN :sortDirection = 'ASC' THEN totalsales END ASC,
                     CASE WHEN :sortDirection = 'DESC' THEN totalsales END DESC
            """, nativeQuery = true)
    List<Object[]> getProductSalesByMonth(
            @Param("month") int month,
            @Param("year") int year,
            @Param("sortDirection") String sortDirection
    );

    @Query("SELECT COUNT(p) FROM Product p WHERE FUNCTION('DATE', p.createdDate) = :date")
    int countProductsByDate(LocalDate date);

    @Query(value = """
            SELECT 
                p.product_id AS productId,
                p.name AS productName,
                c.name AS categoryName,
                p.price AS price,
                SUM(bd.quantity) AS totalsales
            FROM 
                products p
            JOIN 
                categories c ON p.category_id = c.category_id
            LEFT JOIN 
                bill_detail bd ON p.product_id = bd.product_id
            LEFT JOIN 
                bills b ON bd.bill_id = b.bill_id
            WHERE 
                DATE(b.created_date) = :selectedDate
            GROUP BY 
                p.product_id, p.name, c.name, p.price
            ORDER BY CASE WHEN :orderBy = 'ASC' THEN totalsales END ASC,
                     CASE WHEN :orderBy = 'DESC' THEN totalsales END DESC
            """, nativeQuery = true)
    List<Object[]> findProductsByDate(
            @Param("selectedDate") LocalDate selectedDate,
            @Param("orderBy") String orderBy
    );

    @Query(value = """
                SELECT p.* FROM products p
                LEFT JOIN bill_detail bd ON p.product_id = bd.product_id
                GROUP BY p.product_id
                ORDER BY SUM(bd.quantity) DESC
            """,
            countQuery = """
                        SELECT COUNT(DISTINCT p.product_id) FROM products p
                        LEFT JOIN bill_detail bd ON p.product_id = bd.product_id
                    """,
            nativeQuery = true)
    Page<Product> findTopSellingProducts(Pageable pageable);

    @Query(value = """
                SELECT 
                    p.product_id AS product_id,
                    p.name AS name,
                    c.name AS category_name,
                    p.price AS price,
                    COALESCE(SUM(bd.quantity), 0) AS total_sales
                FROM products p
                LEFT JOIN categories c ON p.category_id = c.category_id
                LEFT JOIN bill_detail bd ON p.product_id = bd.product_id
                GROUP BY p.product_id, p.name, c.name, p.price
                HAVING COALESCE(SUM(bd.quantity), 0) <= 1
            """, nativeQuery = true)
    List<Object[]> findLowSellingProducts();


    @Query("SELECT p FROM Product p WHERE p.category.categoryId = :categoryId " +
            "AND p.price BETWEEN :minPrice AND :maxPrice " +
            "AND p.productId <> :excludeProductId")
    List<Product> findSimilar(@Param("categoryId") Long categoryId,
                              @Param("minPrice") double minPrice,
                              @Param("maxPrice") double maxPrice,
                              @Param("excludeProductId") Long excludeProductId);

}
