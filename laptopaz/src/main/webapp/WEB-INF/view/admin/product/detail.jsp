<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="LaptopAZ"/>
            <meta name="author" content="DATN"/>
    <title>Thông tin sản phẩm</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <link href="/admin/css/detail.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>

<body class="sb-nav-fixed">
<jsp:include page="../layout/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp" />
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Thông tin sản phẩm</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin/product">Quay lại</a></li>
                    <li class="breadcrumb-item active">Sản phẩm</li>
                </ol>
                <div class="mt-5">
                    <div class="row">


                        <hr />

                        <div class="col-md-8 offset-md-2">
                            <div class="card">
                                <div class="card-body">
                                    <table class="table table-hover">

                                        <tr>
                                            <th class="title-width1">ID</th>
                                            <td><span>${product.productId}</span></td>
                                        </tr>
                                        <tr>
                                            <th class="title-width1">Tên</th>
                                            <td><span>${product.name}</span></td>
                                        </tr>
                                        <tr>
                                            <th class="title-width1">Mô tả</th>
                                            <td><span>${product.description}</span></td>
                                        </tr>
                                        <tr>
                                            <th class="title-width1">Giá</th>
                                            <td><span>${product.price}</span></td>
                                        </tr>
                                        <tr>
                                            <th class="title-width1">Giảm giá</th>
                                            <td><span>${product.discount}</span></td>
                                        </tr>
                                        <tr>
                                            <th class="title-width1">Số lượng</th>
                                            <td><span>${product.quantity}</span></td>
                                        </tr>

                                        <tr>
                                            <th class="title-width1">Danh mục</th>
                                            <td><span>${product.category.name}</span></td>
                                        </tr>

                                        <tr>
                                            <th class="title-width1">Hình ảnh</th>
                                            <td>
                                                <c:forEach items="${product.images}" var="image">
                                                    <img src="/images/products/${image.url}" alt="Product Image" style="width: 100px; height: auto;"/><br />
                                                </c:forEach>
                                            </td>
                                        </tr>

                                    </table>
                                </div>

                            </div>
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