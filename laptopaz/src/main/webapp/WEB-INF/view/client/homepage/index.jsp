<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ</title>

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
          rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/client/lib/bootstrap/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="/client/css/style.css" rel="stylesheet">

    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css" rel="stylesheet">
    <style>
        .page-link.disabled {
            color: var(--bs-pagination-disabled-color);
            pointer-events: none;
            background-color: var(--bs-pagination-disabled-bg);
        }

        .product-card {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15); /* hiệu ứng nổi */
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .product-card:hover {
            transform: translateY(-5px); /* nổi lên khi hover */
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
        }

        .product-card .product-details {
            flex-grow: 1;
        }

        .product-card .add-to-cart {
            text-align: center;
            margin-top: auto;
            padding-bottom: 20px; /* Adjust this value to move the button higher */
        }

        .product-price {
            text-align: center;
        }

        .product-price .original-price {
            text-decoration: line-through;
            color: grey;
            display: block;
        }

        .product-price .discounted-price {
            color: red;
            display: block;
        }

        .search-filter {
            margin-bottom: 30px;
        }

        .search-filter .form-group {
            margin-bottom: 20px;
        }

        .abovepage {
            position: fixed; /* Stays fixed as the page scrolls */
            bottom: 80px; /* Places it above the "Back to Top" button */
            right: 20px; /* Aligns it to the right */
            z-index: 1050; /* Ensures it appears above other elements, including "Back to Top" */
            padding: 10px; /* Adds padding inside the widget */
        }

        .product-primary {
            background-image: url('/images/z5579353903011_379d9c2c33c4d57a6462d51bd1e4af87.jpg');
            margin: 5px 0;
            background-color: rgba(255, 255, 255, 0.95);
                border-radius: 15px;
                box-shadow: 0 8px 40px rgba(0, 0, 0, 0.2);
                padding: 20px;

            background-size: 100% 100%;
            background-repeat: no-repeat;
        }

        .group-title{
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: baseline;
            margin: 0 0 30px;
        }

        .group-left {
            margin: 0;
            color: #FFF;
            font-size: 50px;
            font-style: italic;
            font-weight: 700;
            line-height: 50px;
            text-transform: uppercase;
            display: flex        ;
            align-items: baseline;
        }

         .btn-view {
            color: #FFF;
            font-size: 14px;
            font-weight: 400;
            text-decoration-line: underline;
            text-transform: uppercase;
        }
        .messenger-floating {
            position: fixed;
            bottom: 140px;
            right: 20px;
            z-index: 1050;
            padding: 10px;
        }
        .product-title {
            font-size: 36px;
            font-weight: bold;
            color: red;
            text-align: center;
            text-transform: uppercase;
            text-decoration: underline;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3); /* Bóng đổ nhẹ */
            letter-spacing: 2px; /* Khoảng cách giữa các chữ */
            margin-bottom: 20px;
        }
        @media (min-width: 992px) {
        .custom-col-5 {
            width: 20%;
            float: left;
            padding: 0 10px;
            box-sizing: border-box;
        }
        }
        .fruite-img img {
            object-fit: cover;
            width: 100%;
            height: 100%;
        }

        .pagination {
            display: flex;
            justify-content: center; /* Căn giữa các số trang */
            flex-wrap: nowrap; /* Không cho phép các phần tử phân trang xuống dòng */
            list-style: none; /* Loại bỏ dấu chấm của danh sách */
            padding: 0;
            margin: 0;
        }

        .pagination .page-item {
            margin: 0 5px; /* Thêm khoảng cách giữa các trang */
        }

        .page-link {
            display: block;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 5px;
            background-color: white;
            color: #007bff;
            transition: background-color 0.3s ease;
        }

        .page-link:hover {
            background-color: #f1f1f1;
            color: #000;
        }

        .page-item.active .page-link {
            background-color: #f1f1f1;
            color: #000;
        }

        .page-item.disabled .page-link {
            background-color: #fff;
            color: #007bff;
        }
        .flash-sale-card {
            border: 3px solid #ff0000;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(255, 0, 0, 0.2);
            overflow: hidden;
            transition: transform 0.2s ease-in-out;
        }
        .flash-sale-card:hover {
            transform: scale(1.02);
            box-shadow: 0 0 12px rgba(255, 0, 0, 0.4);
        }
        .product-price {
            margin-top: 8px;
        }
        .product-price .original-price {
            text-decoration: line-through;
            color: #888;
            margin-right: 5px;
        }
        .product-price .discounted-price {
            font-weight: bold;
            color: #e60000;
        }


    </style>
</head>

<body>
<!-- Spinner Start -->
<div id="spinner"
     class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
<!-- Spinner End -->

<jsp:include page="../layout/header.jsp"/>
<jsp:include page="../layout/banner.jsp"/>

<div class="container">
    <!-- KHUNG SẢN PHẨM BÁN CHẠY -->
    <div class="flash-sale-section border border-danger rounded p-3 mb-5 shadow-sm">
        <div class="d-flex justify-content-between align-items-center bg-danger text-white px-3 py-2 rounded-top">
            <h5 class="mb-0 fw-bold">
                <i class="fas fa-bolt me-2 text-white"></i> <span class="text-white">SẢN PHẨM BÁN CHẠY</span>
            </h5>
            <a href="#" class="text-white text-decoration-underline">Xem thêm khuyến mãi</a>
        </div>

        <div class="row g-3 mt-2">
            <c:forEach var="product" items="${recommend_products}">
                <div class="custom-col-5">
                    <div class="bg-white rounded position-relative fruite-item product-card h-100 p-2 border">
                        <div class="fruite-img">
                            <img src="/images/products/${product.images[0].url}" class="img-fluid w-100 rounded-top" alt="">
                        </div>
                        <div class="text-white bg-danger px-2 py-1 position-absolute"
                             style="top: -1px; right: -1px; border-radius: 50%;">
                            -<fmt:formatNumber type="number" value="${product.discount}"/>%
                        </div>
                        <div class="product-details text-center mt-2">
                            <h6 style="font-size: 15px;">
                                <a href="/product/${product.productId}" class="text-decoration-none text-dark">${product.name}</a>
                            </h6>
                            <div class="product-price">
                                <span class="original-price text-muted text-decoration-line-through me-1">
                                    <fmt:formatNumber type="number" value="${product.price}"/> đ
                                </span>
                                <span class="discounted-price text-danger fw-bold">
                                    <fmt:formatNumber type="number" value="${product.price - (product.discount * product.price / 100)}"/> đ
                                </span>
                            </div>
                        </div>
                        <div class="add-to-cart text-center mt-2">
                            <form action="/add-product-to-cart/${product.productId}" method="post">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button class="btn btn-outline-danger btn-sm rounded-pill">
                                    <i class="fa fa-shopping-bag me-1"></i> Thêm vào giỏ hàng
                                </button>
                                <a href="/product/${product.productId}" class="btn btn-outline-secondary btn-sm rounded-pill mt-1">
                                    <i class="fa fa-eye me-1"></i> Chi tiết
                                </a>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>


     <div class="row">
         <!-- Sidebar Filter -->
         <div class="col-md-2">
             <form id="searchFilterForm" class="bg-light p-3 rounded shadow-sm">
                 <h6 class="mb-3">Bộ lọc sản phẩm</h6>
                 <!-- Danh mục -->
                 <div class="form-group mb-3">
                     <label for="category">Danh mục</label>
                     <select class="form-select" id="category" name="category">
                         <option value=" ">Danh mục</option>
                         <c:forEach var="category" items="${categories}">
                             <option value="${category.name}"
                                     <c:if test="${category.name == param.category}">selected</c:if>>${category.name}</option>
                         </c:forEach>
                     </select>
                 </div>

                 <!-- Sắp xếp theo giá -->
                 <div class="form-group mb-3">
                     <label class="form-label">Sắp xếp theo giá</label>
                     <div class="form-check">
                         <input class="form-check-input" type="radio" name="sortBy" id="sortDefault" value=" "
                                <c:if test="${param.sortBy == ' '}">checked</c:if>>
                         <label class="form-check-label" for="sortDefault">Mặc định</label>
                     </div>
                     <div class="form-check">
                         <input class="form-check-input" type="radio" name="sortBy" id="sortAsc" value="asc"
                                <c:if test="${param.sortBy == 'asc'}">checked</c:if>>
                         <label class="form-check-label" for="sortAsc">Tăng dần</label>
                     </div>
                     <div class="form-check">
                         <input class="form-check-input" type="radio" name="sortBy" id="sortDesc" value="desc"
                                <c:if test="${param.sortBy == 'desc'}">checked</c:if>>
                         <label class="form-check-label" for="sortDesc">Giảm dần</label>
                     </div>
                 </div>

                 <!-- Khoảng giá -->
                 <div class="form-group mb-3">
                     <label class="form-label">Khoảng giá</label>
                     <div class="form-check">
                         <input class="form-check-input" type="radio" name="price" id="priceDefault" value=" "
                                <c:if test="${param.price == ' '}">checked</c:if>>
                         <label class="form-check-label" for="priceDefault">Mặc định</label>
                     </div>
                     <div class="form-check">
                         <input class="form-check-input" type="radio" name="price" id="price1" value="duoi-10-trieu"
                                <c:if test="${param.price == 'duoi-10-trieu'}">checked</c:if>>
                         <label class="form-check-label" for="price1">Dưới 10 triệu</label>
                     </div>
                     <div class="form-check">
                         <input class="form-check-input" type="radio" name="price" id="price2" value="10-15-trieu"
                                <c:if test="${param.price == '10-15-trieu'}">checked</c:if>>
                         <label class="form-check-label" for="price2">Từ 10–15 triệu</label>
                     </div>
                     <div class="form-check">
                         <input class="form-check-input" type="radio" name="price" id="price3" value="15-20-trieu"
                                <c:if test="${param.price == '15-20-trieu'}">checked</c:if>>
                         <label class="form-check-label" for="price3">Từ 15–20 triệu</label>
                     </div>
                     <div class="form-check">
                         <input class="form-check-input" type="radio" name="price" id="price4" value="tren-20-trieu"
                                <c:if test="${param.price == 'tren-20-trieu'}">checked</c:if>>
                         <label class="form-check-label" for="price4">Trên 20 triệu</label>
                     </div>
                 </div>
                 <button type="submit" class="btn btn-primary w-100">Tìm kiếm</button>
             </form>
         </div>
        <!-- Product List -->
        <div class="col-md-10">
            <div class="row g-4">
                <c:if test="${totalPages == 0}">
                    <div>Không tìm thấy sản phẩm</div>
                </c:if>
                <c:forEach var="product" items="${products}">
                    <div class="col-md-12 col-lg-3">
                        <div class="bg-white rounded position-relative fruite-item product-card h-100 p-2 border">
                            <div class="fruite-img">
                                <img src="/images/products/${product.images[0].url}" class="img-fluid w-100 rounded-top" alt="">
                            </div>
                            <div class="text-white bg-danger px-2 py-1 position-absolute"
                                 style="top: -1px; right: -1px; border-radius: 50%;">
                                -<fmt:formatNumber type="number" value="${product.discount}"/>%
                            </div>
                            <div class="product-details text-center mt-2">
                                <h6 style="font-size: 15px;">
                                    <a href="/product/${product.productId}" class="text-decoration-none text-dark">${product.name}</a>
                                </h6>
                                <div class="product-price">
                                    <span class="original-price text-muted text-decoration-line-through me-1">
                                        <fmt:formatNumber type="number" value="${product.price}"/> đ
                                    </span>
                                    <span class="discounted-price text-danger fw-bold">
                                        <fmt:formatNumber type="number" value="${product.price - (product.discount * product.price / 100)}"/> đ
                                    </span>
                                </div>
                            </div>
                            <div class="add-to-cart text-center mt-2">
                                <form action="/add-product-to-cart/${product.productId}" method="post">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button class="btn btn-outline-danger btn-sm rounded-pill">
                                        <i class="fa fa-shopping-bag me-1"></i> Thêm vào giỏ hàng
                                    </button>
                                    <a href="/product/${product.productId}" class="btn btn-outline-secondary btn-sm rounded-pill mt-1">
                                        <i class="fa fa-eye me-1"></i> Chi tiết
                                    </a>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <c:if test="${totalPages > 0}">
                <div class="pagination d-flex justify-content-center mt-5">
                    <ul class="pagination flex-row">
                        <li class="page-item">
                            <a class="${1 eq currentPage ? 'disabled page-link' : 'page-link'}"
                               href="/home?pageNum=${currentPage - 1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i eq currentPage ? 'active' : ''}">
                                <a class="page-link" href="/home?pageNum=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item">
                            <a class="${totalPages eq currentPage ? 'disabled page-link' : 'page-link'}"
                               href="/home?pageNum=${currentPage + 1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </c:if>
        </div>
        <div>
            <jsp:include page="../layout/chatbotWidget.jsp"/>
        </div>
    </div>
</div>
<div class="">
<a href="https://m.me/657435530778911" target="_blank" class="messenger-floating">
    <img src="/images/messenger-icon.svg" alt="Messenger" width="50">
</a>
</div>
<div class="abovepage">
    <jsp:include page="../layout/chatbotWidget.jsp"/>
</div>
<div class="container-fluid">
<jsp:include page="../layout/footer.jsp"/>
</div>
<!-- Back to Top -->
<a href="#" class="btn btn-danger py-3 fs-4 rounded-circle back-to-top"><i class="bi bi-arrow-up"></i></a>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/client/lib/easing/easing.min.js"></script>
<script src="/client/lib/waypoints/waypoints.min.js"></script>
<script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="/client/lib/counterup/counterup.min.js"></script>
<script src="/client/lib/parallax/parallax.min.js"></script>
<script src="/client/lib/lightbox/js/lightbox.min.js"></script>

<!-- Template Javascript -->
<script src="/client/js/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="/client/js/main.js"></script>
<script>
    // Add your custom JavaScript here if needed
</script>
</body>
</html>
