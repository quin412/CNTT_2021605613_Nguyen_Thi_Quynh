<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content="DATN" />
    <meta name="author" content="DATN" />
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>Thông tin đơn hàng</title>
    <link href="/css/styles.css" rel="stylesheet"/>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body class="sb-nav-fixed">
<jsp:include page="../layout/header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp"/>
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-2">Chi tiết đơn hàng</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin/order" class="nav-link">Đơn hàng</a></li>
                    <li class="breadcrumb-item active">Chi tiết đơn hàng</li>
                </ol>

                <div class="mt-1">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <div class="d-flex justify-content-between">
                                <h3>Mã đơn hàng: ${order.billId}</h3>
                            </div>
                            <hr/>
                            <div class="d-flex justify-content-between">
                                <p>Người nhận hàng: ${order.receiverName}</p>
                            </div>
                            <div class="d-flex justify-content-between">
                                <p>Số điện thoại : ${order.receiverPhone}</p>
                            </div>
                            <div class="d-flex justify-content-between">
                                <p>Địa chỉ nhận hàng: ${order.receiverAddress}</p>
                            </div>
                            <div class="d-flex justify-content-between">
                                <p>Trạng thái:
                                    <br>
                                    <select id="orderStatus" name="orderStatus" class="form-select mt-2 mb-2" onchange="changeStatus(${order.billId})">
                                        <c:if test="${order.status == 'WAITING'}">
                                            <option value="WAITING" selected>Chờ xác nhận</option>
                                            <option value="REJECTED">Từ chối</option>
                                            <option value="CONFIRMED">Xác nhận</option>
                                        </c:if>
                                        <c:if test="${order.status == 'PENDING'}">
                                            <option value="COMPLETED">Giao hàng thành công</option>
                                            <option value="PENDING" selected>Đang giao hàng</option>
                                        </c:if>
                                        <c:if test="${order.status == 'CONFIRMED'}">
                                            <option value="CONFIRMED" selected>Đã xác nhận</option>
                                            <option value="PENDING">Đang giao hàng</option>
                                            <option value="CANCELLED">Đã hủy</option>
                                        </c:if>
                                        <c:if test="${order.status == 'CANCELLED'}">
                                            <option value="CANCELLED" selected>Đã hủy</option>
                                        </c:if>
                                        <c:if test="${order.status == 'COMPLETED'}">
                                            <option value="COMPLETED" selected>Giao hàng thành công</option>
                                        </c:if>
                                        <c:if test="${order.status == 'REJECTED'}">
                                            <option value="REJECTED" selected>Từ chối</option>
                                        </c:if>
                                    </select>
                                </p>
                            </div>

                            <div class="d-flex justify-content-between">
                                <p>Hình thức thanh toán:
                                    <c:if test="${order.paymentMethod == 'COD'}">
                                        Thanh toán khi nhận hàng
                                    </c:if>
                                    <c:if test="${order.paymentMethod == 'BANK'}">
                                        Thanh toán trực tuyến
                                    </c:if>
                                </p>
                            </div>
                            <div class="d-flex justify-content-between">
                                <p>Người đặt hàng: ${order.customer.name} </p>
                            </div>
                            <div class="d-flex justify-content-between">
                                <p>Ngày đặt hàng: <fmt:formatDate value="${order.getCreatedAt()}" pattern="yyyy-MM-dd HH:mm:ss" /> </p>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead>
                                    <tr>
                                        <th scope="col">Hình ảnh</th>
                                        <th scope="col">Tên sản phẩm</th>
                                        <th scope="col">Giá</th>
                                        <th scope="col">Số lượng</th>
                                        <th scope="col">Tổng</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${empty order.billDetails}">
                                        <tr>
                                            <td colspan="5">Không có sản phẩm trong đơn hàng này.</td>
                                        </tr>
                                    </c:if>

                                    <c:forEach var="orderDetail" items="${order.billDetails}">
                                        <tr>
                                            <th scope="row">
                                                <div class="d-flex align-items-center">
                                                    <img src="/images/products/${orderDetail.product.images[0].url}"
                                                         class="img-fluid me-5 rounded-circle"
                                                         style="width: 80px; height: 80px;" alt="Ảnh sản phẩm">
                                                </div>
                                            </th>
                                            <td>
                                                <p class="mb-0 mt-4">
                                                        ${orderDetail.product.name}
                                                </p>
                                            </td>
                                            <td>
                                                <p class="mb-0 mt-4">
                                                    <fmt:formatNumber type="number" value="${orderDetail.price}"/> đ
                                                </p>
                                            </td>
                                            <td>
                                                <div class="input-group quantity mt-4" style="width: 100px;">
                                                    <input type="text"
                                                           class="form-control form-control-sm text-center border-0"
                                                           value="${orderDetail.quantity}" readonly>
                                                </div>
                                            </td>
                                            <td>
                                                <p class="mb-0 mt-4">
                                                    <fmt:formatNumber type="number"
                                                                      value="${orderDetail.price * orderDetail.quantity}"/>
                                                    đ
                                                </p>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="d-flex justify-content-between">
                                <p>Phí ship:  <fmt:formatNumber type="number" value="${order.feeShip}"/> đ </p>
                            </div>
                            <div class="d-flex justify-content-between">
                                <p class="text-danger">Tổng tiền:  <fmt:formatNumber type="number" value="${order.total}"/> đ </p>
                            </div>

                            <a href="/admin/order" class="btn btn-success mt-3">Quay lại đơn hàng</a>

                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp"/>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>

<script>
    function changeStatus(billId) {
        const token = $("meta[name='_csrf']").attr("content");
        const header = $("meta[name='_csrf_header']").attr("content");
        var status = $('#orderStatus').val();
        $.ajax({
            url: '/admin/update-bill-status',
            type: 'POST',
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            contentType: 'application/json',
            data: JSON.stringify({
                billId: billId,
                status: status
            }),
            success: function(response) {
                $.toast({
                    heading: 'Cập nhật trạng thái',
                    text: 'Cập nhật trạng thái thành công',
                    position: 'top-right',
                    icon: 'sucess'
                });
               // location.reload(); // Reload the page to reflect the updated status
            },
            error: function(error) {
                console.error('Error updating status:', error);
                alert('Cập nhật trạng thái đơn hàng thất bại');
            }
        });
    }
</script>
</body>
</html>
