<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content="LaptopAZ"/>
            <meta name="author" content="DATN"/>
    <title>Cập nhật sản phẩm</title>
    <link href="/css/styles.css" rel="stylesheet"/>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>
</head>
<body class="sb-nav-fixed">
<jsp:include page="../layout/header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp"/>
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Quản lý sản phẩm</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin/product">Sản phẩm</a></li>
                    <li class="breadcrumb-item active">Cập nhật</li>
                </ol>
                <div class=" mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <h3>Cập nhật sản phẩm</h3>
                            <hr/>
                            <form:form class="form" action="/admin/product/update/${newProduct.productId}" method="post"
                                       modelAttribute="newProduct" enctype="multipart/form-data">

                                <div class="form-group">
                                    <label for="name">Tên sản phẩm</label>
                                    <form:input id="name" path="name" class="form-control" placeholder="Tên sản phẩm"/>
                                    <c:if test="${not empty errorName}">
                                        <div class="mt-1 text-danger align-content-center">
                                            <span>${errorName}</span>
                                        </div>
                                    </c:if>
                                </div>

                                <div class="form-group">
                                    <label for="price">Giá</label>
                                    <form:input id="price" path="price" type="number" class="form-control"
                                                placeholder="Giá sản phẩm"/>
                                    <c:if test="${not empty errorPrice}">
                                        <div class="mt-1 text-danger align-content-center">
                                            <span>${errorPrice}</span>
                                        </div>
                                    </c:if>
                                </div>

                                <div class="form-group">
                                    <label for="quantity">Số lượng</label>
                                    <form:input id="quantity" path="quantity" type="number" class="form-control"
                                                placeholder="Số lượng"/>
                                    <c:if test="${not empty errorQuantity}">
                                        <div class="mt-1 text-danger align-content-center">
                                            <span>${errorQuantity}</span>
                                        </div>
                                    </c:if>
                                </div>

                                <div class="form-group">
                                    <label for="discount">Giảm giá</label>
                                    <form:input id="discount" path="discount" type="number" step="0.01" class="form-control"
                                                placeholder="Giảm giá"/>
                                    <c:if test="${not empty errorDiscount}">
                                        <div class="mt-1 text-danger align-content-center">
                                            <span>${errorDiscount}</span>
                                        </div>
                                    </c:if>
                                </div>

                                <div class="form-group">
                                    <label for="description">Mô tả</label>
                                    <div class="mb-2">
                                        <form:textarea id="description" path="description" class="form-control" placeholder="Nhập mô tả"></form:textarea>
                                    </div>

                                    <c:if test="${not empty errorDescription}">
                                        <div class="mt-1 text-danger align-content-center">
                                            <span>${errorDescription}</span>
                                        </div>
                                    </c:if>
                                </div>


                                <div class="form-group">
                                    <label>Danh mục</label>
                                    <form:select class="form-control" path="category.name" placeholder="Danh mục">
                                        <c:forEach var="Cate" items="${categories}">
                                            <form:option value="${Cate.name}">
                                                ${Cate.name}
                                            </form:option>
                                        </c:forEach>
                                    </form:select>
                                </div>

                                <div class="form-floating mb-3">
                                    <c:forEach var="imageIndex" begin="0" end="2">
                                        <input type="file" name="imageFiles" accept="image/*"
                                               class="form-control mb-2"/>
                                    </c:forEach>
                                    <c:if test="${not empty errorImage}">
                                        <div class="mt-1 text-danger align-content-center">
                                            <span class="">${errorImage}</span>
                                        </div>
                                    </c:if>
                                </div>

                                <button type="submit" class="btn btn-primary">Cập nhật sản phẩm</button>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp"/>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
<script>
    ClassicEditor
        .create(document.querySelector('#description'))
        .catch(error => {
            console.error(error);
        });
</script>
</body>
</html>
