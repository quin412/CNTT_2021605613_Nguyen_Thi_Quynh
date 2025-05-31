<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Thông tin giỏ hàng</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
    <link href="/client/css/style.css" rel="stylesheet">
</head>
<style>
    input[type=number]::-webkit-inner-spin-button,
    input[type=number]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }
    input[type=number] {
        -moz-appearance: textfield;
    }
</style>
<body>

<div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>

<jsp:include page="../layout/header.jsp"/>

<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="mb-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/" class="text-primary">Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Chi Tiết Giỏ Hàng</li>
                </ol>
            </nav>
        </div>

        <div class="row">
            <!-- Bảng sản phẩm -->
            <div class="col-8">
                <div class="table-responsive">
                    <table class="table bg-light rounded" style="table-layout: fixed">
                        <thead>
                        <tr>
                            <th style="width: 50%">Sản phẩm</th>
                            <th style="width: 20%">Đơn giá</th>
                            <th style="width: 20%">Số lượng</th>
                            <th style="width: 10%">Xóa</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${ empty cartDetails }">
                            <tr>
                                <td colspan="6">Không có sản phẩm trong giỏ hàng</td>
                            </tr>
                        </c:if>
                        <c:forEach var="cartDetail" items="${cartDetails}" varStatus="status">
                            <tr>
                                <td>
                                <div class="d-flex align-items-center">
                                    <img src="/images/products/${cartDetail.product.images[0].url}" style="width: 80px; height: 80px;" class="img-fluid rounded-circle me-1" alt="">

                                    <div>
                                        <a href="/product/${cartDetail.product.productId}" class="text-primary" target="_blank">${cartDetail.product.name}</a>
                                    </div>
                                </div>
                                </td>
                                <td>
                                    <fmt:formatNumber type="number" value="${cartDetail.product.finalPrice}"/> đ
                                </td>
                                <td>
                                    <div class="input-group quantity" style="width: 100px;">
                                        <div class="input-group-btn">
                                            <button class="btn btn-sm btn-minus rounded-circle bg-light border"><i class="fa fa-minus"></i></button>
                                        </div>
                                        <input type="number" id="inputField"
                                               class="form-control form-control-sm text-center border-0"
                                               value="${cartDetail.quantity <= cartDetail.product.quantity ? cartDetail.quantity : cartDetail.product.quantity}"
                                               min="1"
                                               max="${cartDetail.product.quantity}"
                                               data-cart-detail-id="${cartDetail.id}"
                                               data-cart-detail-price="${cartDetail.product.finalPrice}"
                                               data-cart-detail-index="${status.index}">
                                        <div class="input-group-btn">
                                            <button class="btn btn-sm btn-plus rounded-circle bg-light border"><i class="fa fa-plus"></i></button>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <form method="post" action="/delete-cart-product/${cartDetail.id}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <button class="btn btn-md rounded-circle border"><i class="fa fa-trash"></i></button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Thông tin đơn hàng -->
            <div class="col-4">
                <c:if test="${not empty cartDetails}">
                    <div class="bg-light rounded">
                        <div class="p-4">
                            <h1 class="fs-4 mb-4 text-center">Thông Tin Đơn Hàng</h1>
                            <div class="d-flex justify-content-between mb-4">
                                <h5 class="mb-0 me-4">Tạm tính:</h5>
                                <p class="mb-0" data-cart-total-price="${totalPrice}">
                                    <fmt:formatNumber type="number" value="${totalPrice}"/> đ
                                </p>
                            </div>
                            <div class="d-flex justify-content-between">
                                <h5 class="mb-0 me-4">Phí vận chuyển</h5>
                                <p class="mb-0">30,000 đ</p>
                            </div>
                        </div>
                        <div class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                            <h5 class="mb-0 ps-4 me-4">Cần thanh toán</h5>
                            <p class="mb-0 pe-4" data-cart-total-price-free="${totalPrice+30000}">
                                <fmt:formatNumber type="number" value="${totalPrice+30000}"/> đ
                            </p>
                        </div>
                        <form:form action="/confirm-checkout" method="post" modelAttribute="cart" id="submitConfirm">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <div style="display: none;">
                                <c:forEach var="cartDetail" items="${cart.cartDetails}" varStatus="status">
                                    <div class="mb-3">
                                        <form:input type="text" path="cartDetails[${status.index}].id" value="${cartDetail.id}" />
                                        <form:input type="text" path="cartDetails[${status.index}].quantity" value="${cartDetail.quantity}" />
                                    </div>
                                </c:forEach>
                            </div>
                           <div class="d-flex justify-content-center">
                               <button id="btn-confirm"
                                       class="btn btn-danger rounded-pill px-4 py-3 text-white text-uppercase mb-4">Mua Ngay
                               </button>
                           </div>
                        </form:form>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/client/lib/easing/easing.min.js"></script>
<script src="/client/lib/waypoints/waypoints.min.js"></script>
<script src="/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
<script src="/client/js/main.js"></script>

<script>
    document.querySelectorAll("input[type='number']").forEach(function (input) {
        input.addEventListener("input", function () {
            const max = parseInt(this.max, 10);
            const value = parseInt(this.value, 10);
            if (value > max) this.value = max;
            const index = this.getAttribute("data-cart-detail-index");
            const el = document.getElementById(`cartDetails${index}.quantity`);
            if (el) $(el).val(this.value);
            const price = parseFloat(this.getAttribute("data-cart-detail-price"));
            const id = this.getAttribute("data-cart-detail-id");
            const priceElement = $(`p[data-cart-detail-id='${id}']`);
            if (priceElement.length) {
                const newPrice = price * this.value;
                priceElement.text(formatCurrency(newPrice.toFixed(2)) + " đ");
            }
            let totalPrice = 0;
            document.querySelectorAll("input[type='number']").forEach(function (input) {
                const itemPrice = parseFloat(input.getAttribute("data-cart-detail-price"));
                const itemQuantity = parseInt(input.value, 10) || 0;
                totalPrice += itemPrice * itemQuantity;
            });
            const totalPriceElement = $(`p[data-cart-total-price]`);
            const totalPriceElement2 = $(`p[data-cart-total-price-free]`);
            if (totalPriceElement.length) {
                $(totalPriceElement[0]).text(formatCurrency(totalPrice.toFixed(2)) + " đ");
                $(totalPriceElement2[0]).text(formatCurrency((totalPrice + 30000).toFixed(2)) + " đ");
                $(totalPriceElement[0]).attr("data-cart-total-price", totalPrice);
                $(totalPriceElement2[0]).attr("data-cart-total-price-free", totalPrice + 30000);
            }
        });
    });
    document.querySelectorAll(".btn-plus, .btn-minus").forEach(function (btn) {
        btn.addEventListener("click", function () {
            const input = this.closest(".quantity").querySelector("input[type='number']");
            const step = this.classList.contains("btn-plus") ? 0 : -1;
            let value = parseInt(input.value, 10) || 0;
            const max = parseInt(input.max, 10);
            const min = parseInt(input.min, 10);

            value += step;
            if (value > max) value = max;
            if (value < min) value = min;
            input.value = value;
            input.dispatchEvent(new Event("input")); // <-- kích hoạt lại logic cập nhật
        });
    });

    function formatCurrency(value) {
        const formatter = new Intl.NumberFormat('vi-VN', {
            style: 'decimal',
            minimumFractionDigits: 0,
        });
        let formatted = formatter.format(value);
        return formatted.replace(/\./g, ',');
    }

    document.getElementById("submitConfirm").addEventListener("submit", function (event) {
        event.preventDefault();
        event.target.submit();
    });
</script>
</body>
</html>
