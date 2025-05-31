<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="LaptopAZ"/>
            <meta name="author" content="DATN"/>
    <title>Sản phẩm</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>

<body class="sb-nav-fixed">
<jsp:include page="../layout/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp" />
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <div class="mt-3">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <div class="d-flex justify-content-between">
                                <h3>Bảng sản phẩm</h3>
                                <a href="/admin/product/create" class="btn btn-primary">Thêm sản phẩm</a>
                            </div>
                            <hr />
                            <table class=" table table-bordered table-hover table-striped">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tên</th>
                                    <th>Giá</th>
                                    <th>Số lượng</th>
                                    <th>Hành động</th>

                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="product" items="${products}">

                                    <tr>
                                        <th>${product.productId}</th>

                                        <td>${product.name}</td>
                                        <td><span><fmt:formatNumber type="number" value="${product.price}"/></span></td>
                                        <td>${product.quantity}</td>
                                       <td style="display: flex; justify-content: flex-start; gap: 10px;">
                                           <a href="/admin/product/${product.productId}"
                                              class="btn btn-success shadow-sm p-2 d-flex align-items-center justify-content-center">
                                               <i class="fas fa-eye fa-lg"></i>
                                           </a>
                                           <a href="/admin/product/update/${product.productId}"
                                              class="btn btn-warning shadow-sm p-2 d-flex align-items-center justify-content-center">
                                               <i class="fas fa-edit fa-lg"></i>
                                           </a>
                                           <a href="/admin/product/delete/${product.productId}"
                                              class="btn btn-danger shadow-sm p-2 d-flex align-items-center justify-content-center">
                                               <i class="fas fa-trash-alt fa-lg"></i>
                                           </a>
                                       </td>

                                    </tr>

                                </c:forEach>

                                </tbody>
                            </table>

                        </div>

                    </div>

                </div>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp" />
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>

</body>

</html>