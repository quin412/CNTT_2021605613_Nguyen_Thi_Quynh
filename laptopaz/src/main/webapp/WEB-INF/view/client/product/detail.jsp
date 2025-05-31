<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title> ${product.name} </title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

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
    <style>
        .page-link.disabled {
            color: var(--bs-pagination-disabled-color);
            pointer-events: none;
            background-color: var(--bs-pagination-disabled-bg);
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
        .product-description {
            white-space: pre-wrap;
            font-family: 'Segoe UI', Arial, sans-serif;
            font-size: 1rem;
            line-height: 1.6;
            overflow: hidden;
            transition: max-height 0.3s ease;
        }

        /* Chỉ hiện 5 dòng đầu */
        .product-description.collapsed {
            display: -webkit-box;
            -webkit-line-clamp: 5;
            -webkit-box-orient: vertical;
            max-height: 8em; /* tùy theo line-height */
            overflow: hidden;
        }

        /* Khi mở rộng */
        .product-description.expanded {
            max-height: none;
            -webkit-line-clamp: unset;
        }
    </style>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css" rel="stylesheet">
</head>

<body>

<!-- Spinner Start -->
<div id="spinner"
     class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
<!-- Spinner End -->

<jsp:include page="../layout/header.jsp"/>

<!-- Single Product Start -->
<div class="container-fluid py-5 ">
    <div class="container py-5">
        <div class="row g-4 mb-5">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/" class="text-primary">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Chi Tiết Sản Phẩm
                        </li>
                    </ol>
                </nav>
            </div>
            <div ><h5 class="fw-bold"> ${product.name}</h5></div>
            <div class="col-lg-8 col-xl-8">
                <div class="row g-4">
                    <div class="col-lg-6 text-center">
                        <div class="border rounded">
                            <div id="carouselId" class="carousel slide position-relative" data-bs-ride="carousel">
                                <div class="carousel-inner" role="listbox">
                                    <c:forEach var="image" items="${product.images}" varStatus="status">
                                        <div class="carousel-item ${status.first ? 'active' : ''}">
                                            <img src="/images/products/${image.url}"
                                                 class="img-fluid bg-secondary rounded" alt="Slide ${status.index + 1}">
                                        </div>
                                    </c:forEach>
                                </div>
                                <button class="carousel-control-prev bg-primary" type="button" data-bs-target="#carouselId"
                                        data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Previous</span>
                                </button>
                                <button class="carousel-control-next bg-primary" type="button" data-bs-target="#carouselId"
                                        data-bs-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Next</span>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">

                        <p class="mb-3">Thương hiệu: ${product.category.name}</p>
                        <p class="mb-3">Số lượng còn lại: ${product.quantity}</p>
                        <div class="product-price mb-3">
                            <h5 class="original-price"><fmt:formatNumber type="number"
                                                                         value="${product.price}"/> đ</h5>
                            <h5 class="discounted-price"><fmt:formatNumber type="number"
                                                                           value="${product.price - (product.discount * product.price / 100)}"/>đ</h5>
                        </div>
                        <div class="d-flex mb-3">
                            <c:set var="fullStars" value="${rate div 1}"/>
                            <c:set var="halfStar" value="${rate % 1 > 0 ? 1 : 0}"/>
                            <c:set var="emptyStars" value="${5 - fullStars - halfStar}"/>

                            <c:forEach var="i" begin="1" end="${fullStars}">
                                <i class="fa fa-star text-secondary"></i>
                            </c:forEach>

                            <!-- Half star -->
                            <c:if test="${halfStar == 1}">
                                <i class="fa fa-star-half-alt text-secondary"></i>
                            </c:if>

                        </div>
                        <div class="input-group quantity mb-5" style="width: 100px;">
                            <div class="input-group-btn">
                                <button class="btn btn-sm btn-minus rounded-circle bg-light border">
                                    <i class="fa fa-minus"></i>
                                </button>
                            </div>
                            <input type="text"
                                   class="form-control form-control-sm text-center border-0" value="1"
                                   data-cart-detail-index="0" id="quantityProduct"
                            >
                            <div class="input-group-btn">
                                <button class="btn btn-sm btn-plus rounded-circle bg-light border">
                                    <i class="fa fa-plus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- <form action="/add-product-from-view-detail" method="post"
                            modelAttribute="product"> -->
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <input class="form-control d-none" type="text" value="${product.productId}"
                               name="id"/>

                        <input class="form-control d-none" type="text" name="quantity"
                               id="cartDetails0.quantity" value="1"/>
                        <button data-product-id="${product.productId}"
                                class="btnAddToCartDetail btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary">
                            <i class="fa fa-shopping-bag me-2 text-danger"></i>Thêm vào giỏ hàng
                        </button>
                        <!-- </form> -->

                    </div>
                    <div class="col-lg-12">
                        <nav>
                            <div class="nav nav-tabs mb-3">
                                <button class="nav-link active border-white border-bottom-0" type="button" role="tab"
                                        id="nav-about-tab" data-bs-toggle="tab" data-bs-target="#nav-about"
                                        aria-controls="nav-about" aria-selected="true">Mô tả
                                </button>

                            </div>
                        </nav>
                        <div class="tab-content">
                            <div class="tab-pane active ps-2" id="nav-about" role="tabpanel"
                                 aria-labelledby="nav-about-tab">
                               <div class="tab-content">
                                   <div class="tab-pane active ps-2" id="nav-about" role="tabpanel" aria-labelledby="nav-about-tab">
                                       <pre id="descriptionText" class="product-description collapsed">${product.description}
                                       </pre>
                                       <button id="toggleBtn" class="btn btn-link p-0">Xem thêm</button>
                                   </div>
                               </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <nav>
                            <div class="nav nav-tabs mb-3">

                                <button class="nav-link active border-white border-bottom-0" type="button" role="tab"
                                        id="nav-mission-tab" data-bs-toggle="tab" data-bs-target="#nav-mission"
                                        aria-controls="nav-mission" aria-selected="false">Đánh giá
                                </button>
                            </div>
                        </nav>
                        <div class="tab-content mb-5">

                            <div class="tab-pane active" id="nav-mission" role="tabpanel"
                                 aria-labelledby="nav-mission-tab">
                                <c:forEach var="feedback" items="${feedbacks}">
                                    <div class="d-flex me-2 row">
                                        <img src="/images/avatar.webp" class="img-fluid rounded-circle p-3 col-2"
                                             style="width: 100px; height: 100px;" alt="">
                                        <div class="col-10">
                                            <p class="mb-2" style="font-size: 14px;">
                                                <fmt:formatDate value="${feedback.getCreateDate()}"
                                                                pattern="dd/MM/yyyy"/>
                                            </p>
                                            <div class="d-flex justify-content-between">
                                                <h5>${feedback.createBy}</h5>
                                                <div class="d-flex mb-3 ">
                                                    <c:forEach var="i" begin="1" end="${feedback.rate}">
                                                        <i class="fa fa-star text-secondary"></i>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <p>${feedback.content} </p>
                                        </div>
                                    </div>
                                    <hr>
                                </c:forEach>

                                <c:if test="${totalPages > 0}">
                                    <div class="pagination d-flex justify-content-center mt-5">
                                        <li class="page-item">
                                            <a class="${1 eq currentPage ? 'disabled page-link' : 'page-link'}"
                                               href="/product/${product.productId}?pageNum=${currentPage - 1}" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                        <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                            <li class="page-item">
                                                <a class="${(loop.index+1 ) eq (currentPage) ? 'active page-link' : 'page-link'}"
                                                   href="/product/${product.productId}?pageNum=${loop.index + 1}">
                                                        ${loop.index + 1}
                                                </a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item">
                                            <a class="${totalPages eq currentPage ? 'disabled page-link' : 'page-link'}"
                                               href="/product/${product.productId}?pageNum=${currentPage + 1}" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </div>
                                </c:if>

                            </div>

                        </div>
                    </div>

                </div>
            </div>
            <div class="col-lg-4 col-xl-4">
                <div class="row fruite">

                        <div class="mb-4 p-2 border rounded shadow-sm" style="background-color: #f8f9fa;">
                            <h6 style="color: red; text-align:center;">YÊN TÂM MUA SẮM TẠI LAPTOP AZ</h6>
                            <ul class="list-unstyled fruite-categorie" style="line-height: 1.8;">
                                <li style="margin-bottom: 6px;">✔ Chất lượng sản phẩm là hàng đầu</li>
                                <li style="margin-bottom: 6px;">✔ Dùng test máy 15 ngày đầu lỗi 1 đổi 1</li>
                                <li style="margin-bottom: 6px;">✔ Hỗ trợ và hậu mãi sau bán hàng tốt nhất</li>
                                <li style="margin-bottom: 6px;">✔ Trả góp ưu đãi lãi suất qua thẻ visa</li>
                                <li style="margin-bottom: 6px;">✔ Giao hàng miễn phí toàn quốc nhanh nhất</li>
                            </ul>
                        </div>
                </div>
                <div class="row fruite promotion-box border border-success rounded p-2 mb-4">
                    <div class="d-flex align-items-center justify-content-center text-center mb-2">
                        <i class="fa fa-gift text-success me-2"></i>
                        <span class="badge bg-success text-white px-3 py-1 rounded-pill" style="font-size: 16px;">QUÀ TẶNG/KHUYẾN MẠI</span>
                    </div>
                    <ul class="list-unstyled mb-0">
                        <li><i class="fa fa-check-square text-success me-2"></i> Tặng Windows 11 bản quyền theo máy</li>
                        <li><i class="fa fa-check-square text-success me-2"></i> Miễn phí cân màu màn hình công nghệ cao</li>
                        <li><i class="fa fa-check-square text-success me-2"></i> Balo thời trang</li>
                        <li><i class="fa fa-check-square text-success me-2"></i> Chuột không dây + Bàn di cao cấp</li>
                        <li><i class="fa fa-check-square text-success me-2"></i> Tặng gói cài đặt, bảo dưỡng, vệ sinh máy trọn đời</li>
                        <li><i class="fa fa-check-square text-success me-2"></i> Tặng Voucher giảm giá cho lần mua tiếp theo</li>
                    </ul>
                </div>

            </div>

        </div>

        <!-- Sản phẩm đề xuất -->
        <div class="container mt-5">
            <h3 class="mb-4">Sản phẩm tương tự</h3>
            <div class="row g-4">
                <c:if test="${empty relatedProducts}">
                    <div class="col-12">
                        <p>Không có sản phẩm tương tự.</p>
                    </div>
                </c:if>
                <c:forEach var="product" items="${relatedProducts}" varStatus="loop">
                    <c:if test="${loop.index < 4}">
                        <div class="col-md-12 col-lg-3">
                            <div class="rounded bg-white position-relative fruite-item shadow-lg rounded-bottom product-card">
                                <div class="fruite-img">
                                    <img src="/images/products/${product.images[0].url}" class="img-fluid w-100 rounded-top" alt="">
                                </div>
                                <div class="text-white bg-danger px-3 py-1 position-absolute"
                                     style="top: -1px; right: -1px; border-radius: 50%;">
                                    -<fmt:formatNumber type="number" value="${product.discount}"/>%
                                </div>
                                <div class="p-4 product-details text-center">
                                    <h4 style="font-size: 15px;">
                                        <a href="/product/${product.productId}" class="text-dark">${product.name}</a>
                                    </h4>
                                    <div class="product-price">
                                        <span class="original-price"><fmt:formatNumber type="number"
                                                                                       value="${product.price}"/> đ</span>
                                        <span class="discounted-price"><fmt:formatNumber type="number"
                                                                                         value="${product.price - (product.discount * product.price / 100)}"/> đ</span>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<!-- Single Product End -->

<jsp:include page="../layout/footer.jsp"/>


<!-- Back to Top -->
<a href="#" class="btn btn-danger border-3 border-danger rounded-circle back-to-top"><i
        class="fa fa-arrow-up"></i></a>


<!-- JavaScript Libraries -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/client/lib/easing/easing.min.js"></script>
<script src="/client/lib/waypoints/waypoints.min.js"></script>
<script src="/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

<script src="/client/js/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const desc = document.getElementById('descriptionText');
        const btn = document.getElementById('toggleBtn');

        btn.addEventListener('click', function () {
            desc.classList.toggle('collapsed');
            desc.classList.toggle('expanded');
            btn.textContent = desc.classList.contains('expanded') ? 'Thu gọn' : 'Xem thêm';
        });
    });
</script>

</body>

</html>