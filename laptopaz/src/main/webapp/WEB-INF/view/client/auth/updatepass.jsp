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
    <title>Thay đổi mật khẩu</title>
    <link href="/client/lib/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="/client/css/style.css" rel="stylesheet">
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
        .invalid-feedback {
            display: block;
            color: red;
        }
    </style>
</head>

<body class="bg-primary">
<div id="layoutAuthentication">
    <div id="layoutAuthentication_content">
        <main>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5">
                        <div class="card shadow-lg border-0 rounded-lg mt-5">
                            <div class="card-header">
                                <h3 class="text-center font-weight-light my-4">Xác thực mật khẩu mới</h3>
                            </div>
                            <div class="card-body">

                                <form:form class="form p-3" action="/forget/confirmed/updatepass" method="post" modelAttribute="registerUser">
                                    <div class="form-floating mb-3 position-relative">
                                        <form:password class="form-control" path="password" placeholder="Password" id="password"/>
                                        <form:errors path="password" cssClass="invalid-feedback"/>
                                        <label>Mật khẩu</label>
                                        <span class="eye-icon" id="togglePasswordRe">
                                            <i class="fa fa-eye-slash"></i>
                                        </span>
                                    </div>
                                    <!-- Repeat Password input -->
                                    <div class="form-floating mb-3">
                                        <form:password class="form-control" path="rePassword" placeholder="Nhập lại mật khẩu"/>
                                        <form:errors path="rePassword" cssClass="invalid-feedback"/>
                                        <label>Nhập lại mật khẩu</label>

                                    </div>
                                    <!-- Submit button -->
                                    <div class="d-flex justify-content-center">
                                        <button class="btn btn-primary btn-block mb-3">Xác thực</button>
                                    </div>
                                </form:form>
                            </div>
                            <div class="card-footer text-center py-3">
                                <div class="small"><a href="/forget">Quay lại</a></div>
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
    $('#togglePasswordRe').click(function () {
        const passwordRegister = $('#password');
        const passwordRepeatRegister = $('#rePassword');
        const passwordFieldType = passwordRegister.attr('type');
        const toggleIcon = $(this).find('i');

        if (passwordFieldType === 'password') {
            passwordRegister.attr('type', 'text');
            passwordRepeatRegister.attr('type', 'text');
            toggleIcon.removeClass('fa-eye-slash').addClass('fa-eye');
        } else {
            passwordRegister.attr('type', 'password');
            passwordRepeatRegister.attr('type', 'password');
            toggleIcon.removeClass('fa-eye').addClass('fa-eye-slash');
        }
    });
</script>
</body>

</html>
