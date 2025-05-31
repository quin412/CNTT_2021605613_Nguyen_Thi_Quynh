<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tài khoản</title>

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
    <link href="/client/lib/bootstrap/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="/client/css/style.css" rel="stylesheet">
    <link href="/client/css/usermanage.css" rel="stylesheet">

    <meta name="_csrf" content="${_csrf.token}"/>
    <!-- default header name is X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}"/>


    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css"
          rel="stylesheet">
</head>
<body>

<!-- Spinner Start -->
<div id="spinner"
     class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
<!-- Spinner End -->
    <jsp:include page="../layout/header.jsp"/>

    <div class="container-fluid fruite py-5 imgbanner">
        <div class="container pt-5 mt-4">
            <div class="tab-class text-center ">
                <div class="row g-4">
                    <div class="col-lg-4 text-start">
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="/">Quay lại</a></li>
                            <li class="breadcrumb-item active">Quản lý tài khoản</li>
                        </ol>
                    </div>
                    <div class="col-lg-8 text-end">
                        <ul class="nav nav-pills d-inline-flex text-center mb-5">
                            <li class="nav-item">
                                <a class="d-flex m-2 py-2 bg-primary rounded-pill active" href="/client/user/changepassword">
                                    <span style="width: 130px;font-weight: bold;">Đổi mật khẩu</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                 <c:if test="${not empty update}">
                   <div class="alert alert-success alert-dismissible fade show d-flex align-items-center" role="alert">
                     <svg xmlns="http://www.w3.org/2000/svg" style="width: 24px; height: 24px; margin-right: 10px; flex-shrink: 0;" fill="currentColor" class="bi bi-check-circle-fill" viewBox="0 0 16 16">
                       <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM6.97 11.03a.75.75 0 0 0 1.07 0l3.992-3.992a.75.75 0 0 0-1.06-1.06L7.5 9.439 6.03 7.97a.75.75 0 1 0-1.06 1.06l2 2z"/>
                     </svg>
                     <div>
                       <strong>${update}</strong>
                     </div>
                     <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                   </div>
                 </c:if>
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-body">
                                <form:form action="/client/user/update" method="post" modelAttribute="newCustomer">
                                    <table class="table">
                                        <tbody>
                                        <tr>
                                            <th class="title-width">Email</th>
                                            <td><label class="form-control">${customer.email}</label></td>
                                        </tr>
                                        <tr>
                                            <th class="title-width">Tên</th>
                                            <td><form:input path="name" class="form-control" type="text" value="${customer.name}"/></td>
                                        </tr>
                                        <tr>
                                            <th class="title-width">Địa chỉ</th>
                                            <td><form:input path="address" class="form-control" type="text" value="${customer.address}"/></td>
                                        </tr>
                                        <tr>
                                            <th class="title-width">Số điện thoại</th>
                                            <td><form:input path="phone" class="form-control" type="text" value="${customer.phone}"/></td>
                                        </tr>
                                        <tr>
                                            <th class="title-width">Ngày sinh</th>
                                            <td>
                                                <form:input path="dob" class="form-control" type="date" value="${not empty date ? date : ''}"/>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <button class="btn btn-secondary py-2 rounded-pill text-white active" type="submit">Cập nhật</button>
                                </form:form>
                            </div>
                        </div>
                    </div>
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


<script src="/client/js/main.js"></script>
<script
        src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
</body>

</html>