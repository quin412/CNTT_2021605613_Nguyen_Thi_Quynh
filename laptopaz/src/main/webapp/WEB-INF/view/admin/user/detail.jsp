<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="DATN" />
        <meta name="author" content="DATN" />
    <title>Thông tin tài khoản</title>
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
                <h1 class="mt-4">Thông tin tài khoản</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin/user">Quay lại</a></li>
                    <li class="breadcrumb-item active">Khách hàng</li>
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
                                                    <td><span>${userview.customerId}</span></td>
                                                </tr>
                                                <tr>
                                                    <th class="title-width1">Email</th>
                                                    <td><span>${userview.email}</span></td>
                                                </tr>
                                                <tr>
                                                    <th class="title-width1">Tên</th>
                                                    <td><span>${userview.name}</span></td>
                                                </tr>
                                                <tr>
                                                    <th class="title-width1">Địa chỉ</th>
                                                    <td><span>${userview.address}</span></td>
                                                </tr>
                                                <tr>
                                                    <th class="title-width1">Số điện thoại</th>
                                                    <td><span>${userview.phone}</span></td>
                                                </tr>
                                                <tr>
                                                    <th class="title-width1">Ngày sinh</th>
                                                    <td><span>${userview.dob}</span></td>
                                                </tr>
                                                <tr>
                                                    <th class="title-width1">Vai trò</th>
                                                    <td><span>${userview.role.roleName}</span></td>
                                                </tr>


                                            </table>
                                        </div>

                                </div>
                            </div>



                    </div>

                </div>
                <div class="row">

                    <div class="col-lg-7 text-end">
                        <ul class="nav nav-pills d-inline-flex text-center mb-5">
                            <li class="nav-item">

                                <a class="text-decoration-none d-flex m-2 py-2 bg-danger rounded-pill active" href="/admin/user/delete/${userview.customerId}">
                                    <span class="text-light" style="width: 130px;">Xóa</span>
                                </a>
                            </li>
                        </ul>
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