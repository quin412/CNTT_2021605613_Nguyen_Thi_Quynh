<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Lịch sử mua hàng</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
            rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
          rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


    <!-- Customized Bootstrap Stylesheet -->
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="/client/css/style.css" rel="stylesheet">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <style>
        .star-rating {
            display: flex;
            gap: 5px;
            cursor: pointer;
        }

        .star-rating .bi-star {
            font-size: 2rem;
            color: #ddd;
        }

        .star-rating .bi-star.selected {
            color: gold;
        }
    </style>
</head>

<body>

<!-- Spinner Start -->
<div id="spinner"
     class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
<!-- Spinner End -->

<jsp:include page="../layout/header.jsp"/>

<!-- Cart Page Start -->
<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="mb-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/">Home</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Lịch sử mua hàng</li>
                </ol>
            </nav>
        </div>

        <div class="table-responsive">
            <c:if test="${empty orders}">
                <div class="text-center fs-4 text-muted">Bạn chưa có đơn hàng nào</div>
            </c:if>

            <c:forEach var="order" items="${orders}">
                <div class="card shadow-sm rounded-3 mb-4">
                    <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
                        <div><i class="fas fa-receipt me-2"></i>Đơn hàng ngày ${order.createdDate}</div>
                        <div><strong>Tổng: </strong>
                            <fmt:formatNumber type="number" value="${order.total}"/> đ
                        </div>
                    </div>

                    <div class="card-body">
                        <c:forEach var="orderDetail" items="${order.billDetails}">
                            <div class="row align-items-center border-bottom py-3">
                                <div class="col-md-2 col-4">
                                    <img src="/images/products/${orderDetail.product.images[0].url}"
                                         class="img-fluid rounded" alt="Sản phẩm">
                                </div>
                                <div class="col-lg col-8">
                                    <h6 class="mb-1">
                                        <a href="/product/${orderDetail.product.productId}" class="text-dark"
                                           target="_blank">${orderDetail.product.name}</a>
                                    </h6>
                                    <small>Số lượng: ${orderDetail.quantity}</small> <br>
                                    <small>Đơn giá:
                                        <fmt:formatNumber type="number" value="${orderDetail.price}"/> đ
                                    </small> <br>
                                    <small>Thành tiền:
                                        <fmt:formatNumber type="number"
                                                          value="${orderDetail.price * orderDetail.quantity}"/> đ
                                    </small>
                                </div>
                                <div class="col-md-3 text-end">
                                    <c:if test="${order.status == 'COMPLETED' && orderDetail.feedback == false}">
                                        <a class="btn btn-sm btn-outline-primary"
                                           data-bs-toggle="modal"
                                           data-bs-target="#feedback-modal"
                                           onclick="giveFeedback(${orderDetail.id})">Đánh giá</a>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>

                        <div class="mt-3 d-flex justify-content-between align-items-center">
                            <div>
                                <strong>Trạng thái:</strong>
                                <span class="badge
                                    <c:choose>
                                        <c:when test="${order.status == 'COMPLETED'}">bg-success</c:when>
                                        <c:when test="${order.status == 'WAITING'}">bg-warning text-dark</c:when>
                                        <c:when test="${order.status == 'PENDING'}">bg-info</c:when>
                                        <c:when test="${order.status == 'CANCELLED' || order.status == 'REJECTED'}">bg-danger</c:when>
                                        <c:otherwise>bg-secondary</c:otherwise>
                                    </c:choose>">
                                    <c:choose>
                                        <c:when test="${order.status == 'PENDING'}">Đang giao hàng</c:when>
                                        <c:when test="${order.status == 'WAITING'}">Chờ xác nhận</c:when>
                                        <c:when test="${order.status == 'CONFIRMED'}">Đã xác nhận</c:when>
                                        <c:when test="${order.status == 'COMPLETED'}">Đã giao</c:when>
                                        <c:when test="${order.status == 'CANCELLED'}">Hủy</c:when>
                                        <c:when test="${order.status == 'REJECTED'}">Từ chối</c:when>
                                    </c:choose>
                                </span>
                            </div>
                            <div>
                                <c:if test="${order.status == 'WAITING'}">
                                    <form method="post" action="/cancel-bill/${order.billId}" style="display: inline-block;">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <button class="btn btn-sm btn-outline-danger">Hủy đơn</button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        </div>

    </div>
</div>
<!-- Cart Page End -->

<div class="modal fade" id="feedback-modal" tabindex="-1" aria-labelledby="feedbackModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="feedbackModalLabel">Đánh giá</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="feedback-form">

                    <div class="mb-3">
                        <label for="feedback-content" class="form-label">Nội dung *</label>
                        <input type="text" class="form-control" id="feedback-content" name="feedback-content" required>
                    </div>
                    <div class="mb-3 ">
                        <label class="form-label ">Đánh giá sao *</label>
                        <div class="star-rating d-flex justify-content-center " id="star-rating">
                            <i class="bi bi-star" data="1"></i>
                            <i class="bi bi-star" data="2"></i>
                            <i class="bi bi-star" data="3"></i>
                            <i class="bi bi-star" data="4"></i>
                            <i class="bi bi-star" data="5"></i>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary text-white">Gửi đánh giá</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<jsp:include page="../layout/footer.jsp"/>


<!-- Back to Top -->
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
        class="fa fa-arrow-up"></i></a>


<!-- JavaScript Libraries -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/client/lib/easing/easing.min.js"></script>
<script src="/client/lib/waypoints/waypoints.min.js"></script>
<script src="/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>

<!-- Template Javascript -->
<script src="/client/js/main.js"></script>
<script>
    let selectedRating = 0;
    let currentBillId = null;

    function giveFeedback(billId) {
        currentBillId = billId;
        $('#feedback-modal').modal('show');
    }

    $(document).ready(function () {
        $('#star-rating i').on('click', function () {
            selectedRating = $(this).attr('data');
            $('#star-rating i').removeClass('selected');
            $(this).prevAll().addBack().addClass('selected');
        });

        $('#feedback-form').on('submit', function (e) {
            e.preventDefault();

            const feedbackContent = $('#feedback-content').val();
            const feedbackData = {
                content: feedbackContent,
                rate: selectedRating,
                billDetaiId: currentBillId
            };
            const token = $("meta[name='_csrf']").attr("content");
            const header = $("meta[name='_csrf_header']").attr("content");

            $.ajax({
                type: 'POST',
                url: `${window.location.origin}/api/give-feedback`,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(header, token);
                },
                contentType: 'application/json',
                data: JSON.stringify(feedbackData),
                success: function (response) {

                    $('#feedback-modal').modal('hide');
                    location.reload();
                },
                error: function (error) {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra. Vui lòng thử lại.');
                }
            });
        });
    });
</script>
</body>

</html>