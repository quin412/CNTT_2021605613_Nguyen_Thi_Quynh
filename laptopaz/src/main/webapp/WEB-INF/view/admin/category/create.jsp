<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="LaptopAZ" />
    <meta name="author" content="DATN" />
    <title>Tạo danh mục</title>
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
                <h1 class="mt-4">Quản lý danh mục</h1>
                <div class="mt-5">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item"><a href="/admin/category">Quay lại</a></li>
                                <li class="breadcrumb-item active">Tạo danh mục</li>
                            </ol>
                            <hr />
                            <form:form class="form p-3" action="/admin/category/create" method="post" modelAttribute="newCate">
                                <!-- Name input -->
                                <div class="form-floating mb-3">
                                    <form:input class="form-control" path="name" placeholder="Tên danh mục"/>
                                    <c:if test="${not empty error}">
                                        <div class="mt-1 text-danger align-content-center">
                                            <span class="">${error}</span>
                                        </div>
                                    </c:if>
                                    <label>Tên</label>
                                </div>
                                <div class="d-flex justify-content-center">
                                    <button class="btn btn-primary btn-block mb-3">Tạo</button>
                                </div>
                            </form:form>

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