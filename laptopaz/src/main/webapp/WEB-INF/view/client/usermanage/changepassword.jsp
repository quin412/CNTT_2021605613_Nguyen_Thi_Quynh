<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thay đổi mật khẩu</title>

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
    <div class="container py-5 mt-4">
        <div class="tab-class text-center ">

            <div class="row g-4">

                <ol class="breadcrumb ms-3 mb-4">
                    <li class="breadcrumb-item"><a href="/client/user">Quay lại</a></li>
                    <li class="breadcrumb-item active">Đổi mật khẩu</li>
                </ol>

            </div>
            <c:if test="${not empty update}">
                <div class="alert alert-danger text-info align-content-center">
                    <h4 class="">${update}</h4>
                </div>
            </c:if>
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-body">
                        <div class="card-body">
                            <form:form action="/client/user/changepassword" method="post" modelAttribute="newPass">
                                <table class="table">
                                    <tbody>
                                    <tr>
                                        <th class="title-width">Nhập mật khẩu cũ</th>
                                        <td><form:input path="password" class="form-control" type="text"/>
                                            <c:if test="${not empty errorOld}">
                                                <div class="mt-1 text-danger align-content-center">
                                                    <span class="">${errorOld}</span>
                                                </div>
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="title-width">Nhập mật khẩu mới</th>
                                        <td><form:input path="newpassword" class="form-control" type="text"/>
                                            <c:if test="${not empty errorNew}">
                                                <div class="mt-1 text-danger align-content-center">
                                                    <span class="">${errorNew}</span>
                                                </div>
                                            </c:if>
                                            <form:errors path="newpassword" cssClass="invalid-feedback"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="title-width">Nhập lại mật khẩu mới</th>
                                        <td><form:input path="confirmpassword" class="form-control" type="text"/>
                                            <c:if test="${not empty errorConfirm}">
                                                <div class="mt-1 text-danger align-content-center">
                                                    <span class="">${errorConfirm}</span>
                                                </div>
                                            </c:if>
                                            <form:errors path="confirmpassword" cssClass="invalid-feedback"/>
                                        </td>
                                    </tr>

                                    </tbody>
                                </table>
                                <button class="btn btn-warning py-2 rounded-pill text-light active" type="submit">Đổi mật khẩu</button>
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