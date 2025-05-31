<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Hero Start -->
<div class="container-fluid hero-header no-padding">
    <div class="container py-3">
        <div class="row g-4 align-items-stretch">
            <!-- Danh mục -->
            <div class="col-lg-2 col-md-3 col-sm-12">
                <div class="category-box shadow-sm rounded-3 px-3 py-1">
                    <h4 class="text-center mb-4">Danh mục</h4>
                    <ul class="category-list list-unstyled">
                    <li class="category-item">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <a href="/home?category=+" class="text-primary fw-bold category-link">Tất cả sản phẩm</a>
                                    </div>
                                </li>
                        <c:forEach var="category" items="${categories}">
                            <li class="category-item">
                                <div class="d-flex justify-content-between align-items-center">
                                    <a href="/home?category=${category.name}" class="text-primary fw-bold category-link">${category.name}</a>
                                    <span class="badge bg-danger rounded-pill">${category.products.size()}</span>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>

            <!-- Carousel -->
            <div class="col-lg-8 col-md-8 col-sm-12">
                <div id="carouselId" class="carousel slide position-relative" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active" onclick="window.location.href='http://localhost:8181/product/14';" style="cursor: pointer;">
                            <img src="/client/img/2.jpg" class="img-fluid w-100 rounded-3" alt="Slide 1">
                        </div>
                        <div class="carousel-item" onclick="window.location.href='http://localhost:8181/product/13';" style="cursor: pointer;">
                            <img src="/client/img/3.jpg" class="img-fluid w-100 rounded-3" alt="Slide 2">
                        </div>
                        <div class="carousel-item" onclick="window.location.href='http://localhost:8181/product/8';" style="cursor: pointer;">
                            <img src="/client/img/4.jpg" class="img-fluid w-100 rounded-3" alt="Slide 3">
                        </div>
                        <div class="carousel-item" onclick="window.location.href='http://localhost:8181/product/8';" style="cursor: pointer;">
                            <img src="/client/img/5.jpg" class="img-fluid w-100 rounded-3" alt="Slide 4">
                        </div>
                        <div class="carousel-item" onclick="window.location.href='http://localhost:8181/product/16';" style="cursor: pointer;">
                            <img src="/client/img/6.jpg" class="img-fluid w-100 rounded-3" alt="Slide 5">
                        </div>
                        <div class="carousel-item" onclick="window.location.href='http://localhost:8181/product/17';" style="cursor: pointer;">
                            <img src="/client/img/7.jpg" class="img-fluid w-100 rounded-3" alt="Slide 6">
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselId" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselId" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </div>

            <!-- Hai banner nhỏ bên phải -->
            <div class="col-lg-2 col-md-4 col-sm-12 d-flex flex-column gap-3">
                <div class="banner-box rounded-3 overflow-hidden">
                    <a href="#"><img src="/client/img/banner-right-1.jpg" class="img-fluid w-100" alt="Hướng dẫn mua hàng"></a>
                </div>
                <div class="banner-box rounded-3 overflow-hidden">
                    <a href="#"><img src="/client/img/banner-right-2.png" class="img-fluid w-100" alt="Cảm nhận khách hàng"></a>
                </div>
                <div class="banner-box rounded-3 overflow-hidden">
                    <a href="#"><img src="/client/img/banner-right-3.png" class="img-fluid w-100" alt="Cảm nhận khách hàng"></a>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- CSS -->
<style>
    .category-box {
        background-color: #f8f9fa;
        border: 1px solid #dee2e6;
        border-radius: 15px;
        padding: 20px;
        transition: all 0.3s ease;
        overflow-y: auto; /* Thêm dòng này để cuộn nội dung khi danh mục quá dài */
        max-height: 400px; /* Giới hạn chiều cao của danh mục */
    }

    .category-box:hover {
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    .category-list {
        list-style: none;
        padding-left: 0;
        margin-bottom: 0;
    }

    .category-item {
        display: block; /* Đảm bảo mỗi mục là một dòng */
        transition: transform 0.3s ease, background-color 0.3s ease;
        margin-bottom: 10px; /* Khoảng cách giữa các mục */
    }

    .category-item:hover {
        transform: scale(1.05);
        background-color: #f1f1f1;
    }

    .category-link {
        text-decoration: none;
        color: #495057;
        display: block; /* Làm cho liên kết chiếm toàn bộ dòng */
    }

    .category-link:hover {
        color: #007bff;
        text-decoration: underline;
    }

    .category-box h4 {
        font-size: 18px;
        color: #495057;
    }

    .fruite-categorie li {
        margin-bottom: 10px;
    }

    .carousel-inner img {
        border-radius: 15px;
    }

    .banner-box img {
        border-radius: 15px;
    }

    .badge {
        font-size: 0.875rem;
    }
    .carousel-control-prev,
    .carousel-control-next {
        background-color: #6c757d; /* Màu nền xám */
        border-radius: 50%; /* Để các nút có dạng tròn */
        opacity: 0.3;
        transition: opacity 0.3s ease;
    }

    .carousel-control-prev:hover,
    .carousel-control-next:hover {
        opacity: 1;
    }
    .no-padding {
        padding-left: 0 !important;
        padding-right: 0 !important;
    }

</style>
