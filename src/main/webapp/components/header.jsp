<%--
  Created by IntelliJ IDEA.
  User: mmotk
  Date: 6/16/2023
  Time: 9:15 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Header</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.0/css/boxicons.min.css"
          integrity="sha512-pVCM5+SN2+qwj36KonHToF2p1oIvoU3bsqxphdOIWMYmgr4ZqD3t5DjKvvetKhXGc/ZG5REYTT6ltKfExEei/Q=="
          crossorigin="anonymous"
          referrerpolicy="no-referrer"
    />
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css"
            integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc="
            crossorigin="anonymous"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css" />
</head>
<body>
<div class="bg-dark text-white ">
    <div class="container">
        <header class="d-flex flex-wrap align-items-center justify-content-md-between py-3 mb-4">
            <div class="logo">
                <a href="#" class="d-flex">
                    <img class="me-3" height="28" src="${pageContext.request.contextPath}/assets/logo.png"/>
                </a>
            </div>

            <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0 text-white">
                <!-- for all -->
                <li><a href="#" class="nav-link px-2 link-secondary">Home</a></li>

                <!-- for headmaster only
            <li><a href="#" class="nav-link px-2 link-light">Dashboard</a></li>
            <li><a href="#" class="nav-link px-2 link-light">Classes</a></li>
            <li><a href="#" class="nav-link px-2 link-light">Teachers</a></li>
            <li><a href="#" class="nav-link px-2 link-light">Students</a></li>
            <li><a href="#" class="nav-link px-2 link-light">Parents</a></li> -->
                <!-- for admin only -->
                <li><a href="#" class="nav-link px-2 link-light">Manager</a></li>
                <li><a href="#" class="nav-link px-2 link-light">Accounts</a></li>
            </ul>

            <div class="col-md-3 text-end">
                <span class="me-2">Logged in as: Mmotkim</span>

                <a href="#"  class="link-light me-2 dropdown-toggle text-decoration-none" id="notificationsDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="bi bi-bell"></i>
                </a>

                <button type="button" class="btn btn-outline-light me-1">
                    Login
                </button>
                <div class="dropdown-menu dropdown-menu-end" aria-labelledby="notificationsDropdown">
                    <ul class="list-group">
                        <li class="list-group-item">Notification 1</li>
                        <li class="list-group-item">Notification 2</li>
                        <li class="list-group-item">Notification 3</li>
                        <li class="list-group-item">Notification 4</li>
                        <li class="list-group-item">Notification 5</li>
                    </ul>
                </div>
            </div>
        </header>
    </div>

</div>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.js"></script>
</body>
</html>
