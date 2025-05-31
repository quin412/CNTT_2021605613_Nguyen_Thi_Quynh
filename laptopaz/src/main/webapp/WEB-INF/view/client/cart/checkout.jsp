<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Thanh toán</title>
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
</head>
<style>
    input[type=number]::-webkit-inner-spin-button,
    input[type=number]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }

    input[type=number] {
        -moz-appearance: textfield; /* Ẩn spinner trên Firefox */
    }

    .center-btn-container {
        text-align: center; /* Căn giữa nội dung bên trong */
    }

    .center-btn {
        display: inline-block; /* Đảm bảo button có thể căn giữa */
        margin: 0 auto; /* Căn giữa button theo chiều ngang */
    }
</style>
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
                    <li class="breadcrumb-item active" aria-current="page">Thông tin thanh toán</li>
                </ol>
            </nav>
        </div>

        <div class="table-responsive">
            <table class="table" style="table-layout: fixed">
                <thead>
                <tr>
                    <th scope="col" style="width: 70%">Sản phẩm</th>
                    <th scope="col" style="width: 20%">Đơn giá</th>
                    <th scope="col" style="width: 10%">Số lượng</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${ empty cartDetails}">
                    <tr>
                        <td colspan="6">
                            Không có sản phẩm trong giỏ hàng
                        </td>
                    </tr>
                </c:if>
                <c:forEach var="cartDetail" items="${cartDetails}">
                    <tr>
                       <td class="d-flex align-items-center">
                                <img src="/images/products/${cartDetail.product.images[0].url}"
                                     class="img-fluid me-1 rounded-circle"
                                     style="width: 80px; height: 80px;" alt="">
                            <div>
                                <a href="/product/${cartDetail.product.productId}" class="text-primary me-1" target="_blank">
                                        ${cartDetail.product.name}
                                </a>
                            </div>
                        </td>
                        <td>
                            <p class="mb-0 mt-4">
                                <fmt:formatNumber type="number" value="${cartDetail.product.finalPrice}"/> đ
                            </p>
                        </td>
                        <td>
                            <div class="input-group quantity mt-4" style="width: 100px;">
                                <input type="text"
                                       class="form-control form-control-sm text-center border-0"
                                       value="${cartDetail.quantity}">
                            </div>
                        </td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
        </div>
        <c:if test="${not empty cartDetails}">
            <form:form id="formSubmit" action="/place-order" method="post" modelAttribute="cart">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <div class="mt-5 row g-4 justify-content-start">
                    <div class="col-12 col-md-6">
                        <div class="p-4 ">
                            <h5>Thông Tin Người Nhận
                            </h5>
                            <div class="row">
                                <div class="col-12 form-group mb-3">
                                    <label>Tên người nhận</label>
                                    <input class="form-control mt-1" name="receiverName"
                                           value="${currentUser.name}" required/>
                                </div>
                                <div class="col-12 form-group mb-3">
                                    <label>Địa chỉ người nhận</label>
                                    <input class="form-control mt-1" name="receiverAddress"
                                           value="${currentUser.address}" required/>
                                </div>
                                <div class="col-12 form-group mb-3">
                                    <label>Số điện thoại</label>
                                    <input class="form-control mt-1" id="receiverPhone"
                                           name="receiverPhone" type="tel"
                                           value="${currentUser.phone}" required/>
                                    <label id="phoneError" class="text-danger mt-1">
                                </div>
                                <div class="mt-4">
                                    <i class="fas fa-arrow-left"></i>
                                    <a href="/cart" class="text-primary">Quay lại giỏ hàng</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6">
                        <div class="bg-light rounded">
                            <div class="p-4">
                                <h1 class="display-6 mb-4 text-center">Thông Tin Thanh Toán</span>
                                </h1>
                                <div class="d-flex justify-content-between">
                                    <h5 class="mb-0 me-4 mb-3">Tổng tiền</h5>
                                    <div class="">
                                    <p class="mb-0" data-cart-total-price="${totalPrice}" id="totalPriceDisplay">
                                    <fmt:formatNumber type="number" value="${totalPrice}"/> đ
                                    </p>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <h5 class="mb-0 me-4">Phí vận chuyển</h5>
                                    <div class="">
                                        <p class="mb-0">30,000 đ</p>
                                    </div>
                                </div>
                                <div class="mt-3 d-flex justify-content-between">
                                    <h5 class="mb-0 me-4">Hình thức thanh toán</h5>
                                    <div class="">
                                        <select class="form-select form-select-sm" name="paymentMethod"
                                                id="paymentMethod">
                                            <option value="COD">Thanh toán khi nhận hàng (COD)</option>
                                            <option value="BANK">Chuyển khoản</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div
                                    class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                <h5 class="mb-0 ps-4 me-4">Thanh toán</h5>
                                <p class="mb-0 pe-4" data-cart-total-price="${totalPrice+30000}" id="totalPriceDisplay">
                                    <fmt:formatNumber type="number" value="${totalPrice+30000}"/> đ
                                </p>
                            </div>
                            <div>
                                <div id="bankDetails" class="col-12 form-group mb-3 ps-4 pe-4" style="display: none;">
                                    <label for="bankId">Ngân hàng</label>
                                    <input type="text" id="bankId" class="form-control" readonly/>

                                    <label for="accountNo" class="mt-2">Số tài khoản</label>
                                    <input type="text" id="accountNo" class="form-control" readonly/>

                                    <label for="accountName" class="mt-2">Tên chủ tài khoản</label>
                                    <input type="text" id="accountName" class="form-control" readonly/>

                                    <label for="amountBank" class="mt-2">Số tiền (VND)</label>
                                    <input type="text" id="amountBank" class="form-control" readonly/>

                                    <label for="descriptionBank" class="mt-2">Nội dung chuyển khoaản</label>
                                    <input type="text" id="descriptionBank" class="form-control" readonly/>
                                </div>

                                <!-- Mã QR -->
                                <div id="qrCodeContainer" class="mt-3 text-center" style="display: none;">
                                    <h6 class="mb-3">Mã QR Thanh toán Chuyển khoản</h6>
                                    <img id="qrImage" src="" alt="Mã QR" class="img-fluid mx-auto d-block"/>
                                    <p class="mb-1">Quét mã để thực hiện thanh toán chuyển khoản.</p>
                                    <p>Vui lòng nhập đúng số tiền thanh toán.</p>
                                </div>
                            </div>

                            <div class="center-btn-container">
                                <button id="confirmPaymentBtn" onclick=""
                                        class="btn btn-success rounded-pill px-4 py-3 text-white text-uppercase mb-4 ms-4 ">Xác nhận thanh toán
                                </button>
                            </div>

                        </div>
                    </div>
                </div>
            </form:form>
        </c:if>

    </div>
</div>
<!-- Cart Page End -->


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
<!-- Thêm jQuery -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<!-- Thêm jquery-toast-plugin -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>

<!-- Template Javascript -->
<script src="/client/js/main.js"></script>

<script>
    document.getElementById("formSubmit").addEventListener("submit", async function (event) {
        event.preventDefault();
        if (document.getElementById('paymentMethod').value === 'BANK') {
            try {
                const Api_key = "AK_CS.eac199c0be6711ef9cf3ed0b3d7702f1.lzTXPJcinuXYR4MfEyNVqiJFUO9nobnhMhCLyuibn1E8mv2LOCPQ82g9hP3jm2dlmJP8qHWk"
                const api_get = "https://oauth.casso.vn/v2/transactions?pageSize=100"
                const response = await fetch(api_get, {
                    headers: {
                        Authorization: `apikey ` + Api_key,
                        "Content-Type": "application/json",
                    },
                })
                const data = await response.json();
                const lastPaid = data.data.records[data.data.records.length - 1];
                const lastPrice = lastPaid["amount"];
                const totalPriceElement = document.getElementById('totalPriceDisplay');

                // Lấy giá trị của thuộc tính `data-cart-total-price`
                const totalPrice = totalPriceElement.dataset.cartTotalPrice;
                if (lastPrice == totalPrice) {
                    event.target.submit();
                } else {
                    $.toast({
                        heading: 'Thanh toán',
                        text: 'Thanh toán không thành công',
                        position: 'top-right',
                        icon: 'error'
                    })
                }
            } catch (e) {
                $.toast({
                    heading: 'Thanh toán',
                    text: 'Thanh toán không thành công',
                    position: 'top-right',
                    icon: 'error'
                })
            }
        }
    });
    document.getElementById("formSubmit").addEventListener("submit", function (event) {
        event.preventDefault();
        const phoneInput = document.getElementById("receiverPhone");
        const phoneError = document.getElementById("phoneError");
        const phoneRegex = /^[0-9]{10}$/; // Ví dụ: kiểm tra số điện thoại 10 chữ số

        if (!phoneRegex.test(phoneInput.value)) {
            // Nếu số điện thoại không hợp lệ
            phoneError.style.display = "block"; // Hiển thị lỗi
            phoneError.textContent = "Vui lòng nhập đủ số điện thoại.";
            phoneInput.focus(); // Đưa con trỏ đến ô số điện thoại
        } else {
            phoneError.style.display = "none";// Ẩn thông báo lỗi nếu hợp lệ
            event.target.submit();
        }
    });
</script>
<script>
    const input = document.getElementById('receiverPhone');
    input.addEventListener('keydown', function (event) {
        // Kiểm tra nếu người dùng nhập một ký tự không phải là số
        if (!/[0-9]/.test(event.key) && event.key !== 'Backspace' && event.key !== 'Delete' && event.key !== 'ArrowLeft' && event.key !== 'ArrowRight') {
            event.preventDefault();  // Ngừng hành động mặc định nếu không phải số
        }
    });
</script>
<script>
    // Lấy thông tin thanh toán từ server (backend)
    function fetchPaymentInfo() {
        fetch(`checkout/payment-info`)
            .then(response => response.json())
            .then(data => {
                if (data) {
                    const totalPriceElement = document.getElementById('totalPriceDisplay');

                    // Lấy giá trị của thuộc tính `data-cart-total-price`
                    const totalPrice = totalPriceElement.dataset.cartTotalPrice;
                    // console.log(totalPrice);
                    // Cập nhật các trường thông tin
                    document.getElementById('bankId').value = "VIETCOMBANK";
                    document.getElementById('accountNo').value = data.accountNo;
                    document.getElementById('amountBank').value = new Intl.NumberFormat('vi-VN').format(totalPrice);
                    document.getElementById('descriptionBank').value = data.description;
                    document.getElementById('accountName').value = data.accountName;
                    var encodedDescription = encodeURIComponent(data.description);
                    var encodedAccountName = encodeURIComponent(data.accountName);
                    var qrCodeUrl = `https://img.vietqr.io/image/` + data.bankId + `-` + data.accountNo + `-compact2.png?amount=` + totalPrice + `&addInfo=` + encodedDescription + `&accountName=` + encodedAccountName;
                    document.getElementById('qrImage').src = qrCodeUrl;
                }

            })
            .catch(error => console.error('Error fetching payment info:', error));
    }

    // function fetchPaymentInfo() {


    // Tạo mã QR
    //
    // }
    // Hàm để tạo mã QR
    <%--function generateQRCode(bankId, accountNo, amount, description, accountName) {--%>
    <%--    // Tạo URL mã QR với các tham số thay thế--%>
    <%--    var qrCodeUrl = `https://img.vietqr.io/image/${bankId}-${accountNo}-compact2.png?amount=${amount}&addInfo=${description}&accountName=${accountName}`;--%>

    <%--    // Cập nhật URL mã QR vào thẻ <img>--%>
    <%--    document.getElementById('qrImage').src = qrCodeUrl;--%>
    <%--}--%>

    // Hàm xử lý khi chọn hình thức thanh toán
    document.getElementById('paymentMethod').addEventListener('change', function () {
        var paymentMethod = this.value;
        var bankDetails = document.getElementById('bankDetails');
        var qrCodeContainer = document.getElementById('qrCodeContainer');
        const confirmPaymentBtn = document.getElementById('confirmPaymentBtn');

        if (paymentMethod === 'BANK') {
            bankDetails.style.display = 'block';
            qrCodeContainer.style.display = 'block';
            fetchPaymentInfo(); // Thay thế 12345 bằng ID đơn hàng thực tế

            confirmPaymentBtn.classList.add('center-btn');
        } else {
            bankDetails.style.display = 'none';
            qrCodeContainer.style.display = 'none';
            confirmPaymentBtn.classList.remove('center-btn');
        }
    });

    // Gọi hàm xử lý khi trang được tải, kiểm tra nếu đã chọn "Chuyển khoản"
    document.addEventListener('DOMContentLoaded', function () {
        if (document.getElementById('paymentMethod').value === 'BANK') {
            document.getElementById('bankDetails').style.display = 'block';
            document.getElementById('qrCodeContainer').style.display = 'block';
            fetchPaymentInfo();// Thay thế 12345 bằng ID đơn hàng thực tế
        }
    });
</script>
</body>

</html>