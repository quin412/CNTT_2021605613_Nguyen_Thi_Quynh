<%@ page import="java.time.LocalDate" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="layoutSidenav_nav">
    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        <div class="sb-sidenav-menu">
            <div class="nav">
                <div class="sb-sidenav-menu-heading">Các chức năng</div>
                <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                    <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                    Thống kê
                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                </a>
                <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                    <nav class="sb-sidenav-menu-nested nav">
                        <a class="nav-link" href="/admin">Thống kê tổng quát</a>
                        <%
                            String month = LocalDate.now().getMonth()+"";
                            String year = LocalDate.now().getYear() + "";
                        %>
                        <a class="nav-link" href="/admin/month/<%=LocalDate.now().getMonth().getValue()+""%>/<%=LocalDate.now().getYear()+""%>">Thống kê tháng</a>
                        <a class="nav-link" href="/admin/day/<%=LocalDate.now()+""%>">Thống kê ngày</a>
                    </nav>
                </div>

                <a class="nav-link" href="/admin/user">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Tài khoản
                </a>

                <a class="nav-link" href="/admin/category">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Danh mục
                </a>

                <a class="nav-link" href="/admin/product">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Sản phẩm
                </a>

                <a class="nav-link" href="/admin/order">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Đơn hàng
                </a>
                <a class="nav-link" href="/admin/confirm-order">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Xác nhận đơn hàng
                </a>
            </div>
        </div>
        <div class="sb-sidenav-footer">
            <div class="small">Logged in as:</div>
            <%=request.getUserPrincipal().getName()%>
        </div>
    </nav>
</div>