<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Navbar start -->
<header>
<div class="container-fluid fixed-top no-padding">
    <div class="container">
        <nav class="navbar navbar-light bg-white navbar-expand-xl">
            <a href="/" class="navbar-brand">
                <h2 class="text-primary display-5" style="font-family: 'Century Gothic', sans-serif; font-weight:bold">Laptop<span style= "color: red">AZ</span></h2>
            </a>

            <div class="collapse navbar-collapse bg-white justify-content-between me-4" id="navbarCollapse">
                <div class="mx-auto mt-2">
                    <form class="search-container" method="get" action="/home">
                        <input class="form-control search-input border-danger" type="search" placeholder="Bạn cần tìm gì?" name="name"
                               aria-label="Search" value="${searchName}">
                        <button class="btn-search btn border border-danger btn-md-square bg-white">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                </div>
                <div class="d-flex m-3 me-0">
                    <c:if test="${not empty pageContext.request.userPrincipal}">
                        <a href="/cart" class="position-relative me-4 my-auto text-primary">
                            <i class="fa fa-shopping-bag fa-2x"></i>
                            <span
                                    class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                    style="top: -5px; left: 15px; height: 20px; min-width: 20px;" id="sumCart">
                                    ${sessionScope.sum}
                            </span>
                        </a>
                        <div class="dropdown my-auto">
                            <a href="#" class="dropdown" role="button" id="dropdownMenuLink"
                               data-bs-toggle="dropdown" aria-expanded="false" data-bs-toggle="dropdown"
                               aria-expanded="false">
                                <i class="fas fa-user fa-2x text-primary"></i>
                            </a>

                            <ul class="dropdown-menu dropdown-menu-end p-4" aria-labelledby="dropdownMenuLink">
                                <li class="d-flex align-items-center flex-column" style="min-width: 300px;">
                                    <div class="text-center my-3">
                                        <c:out value="${sessionScope.fullname}"/>
                                    </div>
                                </li>

                                <li><a class="dropdown-item" href="/client/user">Tài khoản</a></li>

                                <li><a class="dropdown-item" href="/order-history">Lịch sử mua hàng</a></li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li>
                                    <form method="post" action="/logout">
                                        <input type="hidden" name="${_csrf.parameterName}"
                                               value="${_csrf.token}"/>
                                        <button class="dropdown-item">Đăng xuất</button>
                                    </form>
                                </li>
                            </ul>
                        </div>
                    </c:if>
                    <c:if test="${empty pageContext.request.userPrincipal}">
                        <a href="/login" class="a-login position-relative me-4 my-auto text-primary">
                            Đăng nhập
                        </a>
                    </c:if>
                </div>
            </div>
        </nav>
    </div>
</div>
</header>

<style>
    .search-container {
        display: flex;
        align-items: center;
        width: 100%;
        max-width: 500px; /* Điều chỉnh theo nhu cầu */
    }

    .search-input {
        width: 350px;
        max-width: 100%;
        height: 40px; /* Đảm bảo chiều cao đồng đều */
        border-radius: 50px 0 0 50px;
        border-right: none;
        padding: 10px 15px;
        font-size: 16px;
        flex: 1;
    }

    .btn-search {
        height: 40px; /* Đặt cùng chiều cao với input */
        width: 80px; /* Giữ kích thước phù hợp */
        border-radius: 0 50px 50px 0;
        border-left: none;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 0; /* Xóa padding để tránh kích thước bị lệch */
        font-size: 18px;
    }

    .btn-search i {
        line-height: 1;
    }

    @media (max-width: 768px) {
        .search-input {
            width: 200px;
        }
    }


    .position-relative .position-absolute {
        top: 50%;
        transform: translateY(-50%);
    }
    .no-padding {
        padding-left: 0 !important;
        padding-right: 0 !important;
    }

</style>
