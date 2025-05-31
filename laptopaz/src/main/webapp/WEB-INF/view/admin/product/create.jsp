<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="DATN" />
        <meta name="author" content="DATN" />
    <title>Tạo sản phẩm</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>
</head>

<body class="sb-nav-fixed">
<jsp:include page="../layout/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp" />
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Quản lý sản phẩm</h1>
                <div class="mt-5">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item"><a href="/admin/product">Quay lại</a></li>
                                <li class="breadcrumb-item active">Tạo sản phẩm</li>
                            </ol>
                            <hr />
                            <form:form class="form p-3" action="/admin/product/create" method="post" modelAttribute="newProduct" enctype="multipart/form-data">
                                <!-- Name input -->
                                <div class="form-floating mb-3">
                                    <form:input class="form-control" path="name" placeholder="Tên sản phẩm" value="${savedProduct.name != null ? savedProduct.name : ''}"/>
                                    <c:if test="${not empty errorName}">
                                        <div class="mt-1 text-danger align-content-center">
                                            <span class="">${errorName}</span>
                                        </div>
                                    </c:if>
                                    <label>Tên sản phẩm</label>
                                </div>
                                <--Mô tả-->
                                <div class="form-floating mb-3">
                                    <form:textarea id="description" class="form-control" path="description" placeholder="Mô tả"></form:textarea>
                                    <c:if test="${not empty errorDescription}">
                                        <div class="mt-1 text-danger align-content-center">
                                            <span class="">${errorDescription}</span>
                                        </div>
                                    </c:if>
                                </div>

                                <div class="form-floating mb-3">
                                    <form:input class="form-control" path="price" type="number"  placeholder="Giá" value="${savedProduct.price != null ? savedProduct.price : ''}"/>
                                    <c:if test="${not empty errorPrice}">
                                        <div class="mt-1 text-danger align-content-center">
                                            <span class="">${errorPrice}</span>
                                        </div>
                                    </c:if>
                                    <label>Giá</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <form:input class="form-control" path="discount" type="number" step="0.01" placeholder="Giảm giá" value="${savedProduct.discount != null ? savedProduct.discount : ''}"/>
                                    <c:if test="${not empty errorDiscount}">
                                        <div class="mt-1 text-danger align-content-center">
                                            <span class="">${errorDiscount}</span>
                                        </div>
                                    </c:if>
                                    <label>Giảm giá</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <form:input class="form-control" path="quantity"  type="number"  placeholder="Số lượng" value="${savedProduct.quantity != null ? savedProduct.quantity : ''}"/>
                                    <c:if test="${not empty errorQuantity}">
                                        <div class="mt-1 text-danger align-content-center">
                                            <span class="">${errorQuantity}</span>
                                        </div>
                                    </c:if>
                                    <label>Số lượng</label>
                                </div>
                                <label class="form-label mb-3">Chọn hình ảnh</label>
                                <div class="form-floating mb-3">
                                    <c:forEach var="imageIndex" begin="0" end="2">
                                        <input type="file" name="imageFiles" accept="image/*" class="form-control mb-2"/> <!-- Đây là trường nhập hình ảnh -->
                                    </c:forEach>
                                    <c:if test="${not empty errorImage}">
                                        <div class="mt-1 text-danger align-content-center">
                                            <span class="">${errorImage}</span>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="form-floating mb-3">
                                    <form:select class="form-control" path="category.name" placeholder="Danh mục">
                                        <c:forEach var="Cate" items="${categories}">
                                            <form:option value="${Cate.name}">
                                                ${Cate.name}
                                            </form:option>
                                        </c:forEach>
                                    </form:select>

                                    <label>Danh mục</label>
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
<script>
    ClassicEditor
        .create(document.querySelector('#description'))
        .catch(error => {
            console.error(error);
        });
</script>
</body>

</html>