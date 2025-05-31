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
    <title>Tài khoản</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <link href="/admin/css/show.css" rel="stylesheet"/>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>

<body class="sb-nav-fixed">
<jsp:include page="../layout/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp" />
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <div class="mt-5">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <div class="d-flex justify-content-between">
                                <h3>Tài khoản</h3>
                                <form:form action="/admin/user" method="post" modelAttribute="newUser">
                                    <div class="d-flex">
                                        <form:input path="name" class="form-control" placeholder="Tên người dùng"/>
                                        <button class="btn btn-outline-secondary ms-1">Tìm</button>
                                    </div>
                                </form:form>
                                <div style="width: 20%"></div>
                            </div>
                            <hr />
                            <table class="table table-bordered table-hover table-striped my-3" style="width: 80%; margin: 0 auto;">
                                <thead class="table-dark">
                                    <tr>
                                        <th class="text-center">ID</th>
                                        <th class="text-center">Email</th>
                                        <th class="text-center">Tên</th>
                                        <th class="text-center">Vai trò</th>
                                        <th class="text-center">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${empty users}">
                                        <tr>
                                            <td colspan="5" class="text-center">Không có người dùng nào.</td>
                                        </tr>
                                    </c:if>
                                    <c:forEach var="user" items="${users}">
                                        <tr>
                                            <td>${user.customerId}</td>
                                            <td>${user.email}</td>
                                            <td>${user.name}</td>
                                            <td>${user.role.roleName}</td>
                                            <td class="text-center d-flex justify-content-center">
                                                <a href="/admin/user/${user.customerId}" class="btn btn-success btn-sm ms-1 me-1">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <a href="/admin/user/delete/${user.customerId}" class="btn btn-danger btn-sm">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item">
                                        <a class="${1 eq currentPage ? 'disabled page-link' : 'page-link'}"
                                           href="/admin/user?page=${currentPage - 1}"
                                           aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <c:if test="${totalPages > 0}">
                                        <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                            <li class="page-item">
                                                <a class="${(loop.index + 1) eq currentPage ? 'active page-link' : 'page-link'}"
                                                   href="/admin/user?page=${loop.index + 1}">
                                                        ${loop.index + 1}
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </c:if>
                                    <li class="page-item">
                                        <a class="${totalPages eq currentPage ? 'disabled page-link' : 'page-link'}"
                                           href="/admin/user?page=${currentPage + 1}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
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