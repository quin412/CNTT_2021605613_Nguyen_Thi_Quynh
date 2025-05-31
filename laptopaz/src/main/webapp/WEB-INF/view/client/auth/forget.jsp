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
    <title>Xác nhận</title>
    <link href="/client/lib/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="/client/css/style.css" rel="stylesheet">
    <link href="/client/css/forget.css" rel="stylesheet">
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
        .invalid-feedback {
            display: block;
            color: red;
        }
    </style>
</head>

<body class="imgbanner position-relative">



        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-5">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header">
                                        <h3 class="text-center font-weight-light my-4">Quên mật khẩu</h3>
                                    </div>
                                    <div class="card-body">

                                        <form:form class="form p-3" action="/forget" method="post" modelAttribute="registerUser">


                                            <div class="form-floating mb-3">
                                                <form:input class="form-control" path="email" placeholder="Email"/>
                                                <form:errors path="email" cssClass="invalid-feedback"/>
                                                <label>Email</label>
                                            </div>

                                            <div class="d-flex justify-content-center">
                                                <button class="btn btn-danger btn-block mb-3">Tiếp theo</button>
                                            </div>
                                        </form:form>
                                    </div>
                                    <div class="card-footer text-center py-3">
                                        <div class="small"><a class="text-danger" href="/login">Bạn đã có tài khoản! Đăng nhập</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>



<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
<script src="/client/lib/bootstrap/bootstrap.bundle.min.js"></script>
<script src="/js/scripts.js"></script>
<script src="/client/js/main.js"></script>
</body>

</html>
