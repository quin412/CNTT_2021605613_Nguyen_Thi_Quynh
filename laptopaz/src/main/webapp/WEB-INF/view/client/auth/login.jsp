<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>Đăng nhập</title>
    <link href="/client/lib/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="/client/css/style.css" rel="stylesheet">
    <link href="/client/css/usermanage.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" crossorigin="anonymous"></script>

    <style>
        .position-relative .eye-icon {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            cursor: pointer;
        }
    </style>
</head>

<body class="imgbanner position-relative">
    <c:if test="${not empty success}">
        <div id="PasswordAuthentication" class="position-absolute w-100">
            <main>
                <div class="container-fluid">
                    <div class="row justify-content-center">
                        <div class="col-lg-5 w-50 ">
                            <div class="card shadow-lg border-0 bg-dark rounded-lg w-50">
                                <div class="card-body">
                                    <div class="text-center text-light"><i class="fa-solid fa-circle-check fa-2x"></i></div>
                                    <p class="text-light text-center">Mật khẩu đã được thiết lập lại thành công</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </c:if>
    <div id="layoutAuthentication">
    <div id="layoutAuthentication_content">
        <main>
            <div class="container mt-5">
                <div class="row justify-content-center">
                    <div class="col-lg-5">
                        <div class="card shadow-lg border-0 rounded-lg mt-5">
                            <div class="card-header">
                                <h3 class="text-center font-weight-light my-4">Đăng nhập</h3>
                            </div>
                            <div class="card-body">
                                <form method="post" action="/login">
                                    <div class="form-floating mb-3">
                                        <input class="form-control" type="email"
                                               placeholder="name@example.com" name="username"/>
                                        <label>Email </label>
                                    </div>
                                    <div class="form-floating mb-3 position-relative">
                                        <input class="form-control" type="password"
                                               placeholder="Password" name="password" id="password"/>
                                        <label>Mật khẩu</label>
                                        <span class="eye-icon" id="togglePassword">
                                            <i class="fa fa-eye-slash"></i>
                                        </span>
                                    </div>
                                    <div class="row mb-4">
                                        <div class="col-md-6 d-flex justify-content-center">
                                            <div class="form-check mb-3 mb-md-0">
                                                <input class="form-check-input" type="checkbox" value="true"
                                                       id="loginCheck" name="remember-me"/>
                                                <label class="form-check-label" for="loginCheck"> Lưu thông tin </label>
                                            </div>
                                        </div>
                                        <div class="col-md-6 d-flex justify-content-center">
                                            <a href="/forget" class="text-danger">Quên mật khẩu?</a>
                                        </div>
                                    </div>
                                    <div>
                                        <input type="hidden" name="${_csrf.parameterName}"
                                               value="${_csrf.token}"/>
                                    </div>
                                    <c:if test="${param.error != null}">
                                        <div class="my-2" style="color: red;">Sai tên đăng nhập hoặc mật khẩu.
                                        </div>
                                    </c:if>
                                    <div class="mt-4 mb-0">
                                        <div class="d-grid">
                                            <button class="btn btn-danger btn-block">
                                                Đăng nhập
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="card-footer text-center py-3">
                                <div class="small"><a href="/register" class="text-danger">Bạn chưa có tài khoản? Đăng ký!</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<script
        src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
<script src="/client/lib/bootstrap/bootstrap.bundle.min.js"></script>
<script src="/js/scripts.js"></script>
<script>
    $(document).ready(function () {
        $('#togglePassword').click(function () {
            const passwordField = $('#password');
            const passwordFieldType = passwordField.attr('type');
            const toggleIcon = $(this).find('i');

            if (passwordFieldType === 'password') {
                passwordField.attr('type', 'text');
                toggleIcon.removeClass('fa-eye-slash').addClass('fa-eye');
            } else {
                passwordField.attr('type', 'password');
                toggleIcon.removeClass('fa-eye').addClass('fa-eye-slash');
            }
        });
        $("#PasswordAuthentication").delay(3000).fadeOut("slow");
    });
</script>
</body>

</html>
