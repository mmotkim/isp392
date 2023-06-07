<%--
  Created by IntelliJ IDEA.
  User: mmotk
  Date: 6/7/2023
  Time: 5:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>Header</title>
</head>
<body>
<div class="bg-dark text-white">

    <div class="container">
        <header class=" d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4 border-bottom">
            <a href="/" class="d-flex align-items-left text-white text-decoration-none">
                <a href="#" class="bi me-2">Kindergarten</a>
            </a>

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
                <button type="button" class="btn btn-outline-light me-2">Login</button>
            </div>
        </header>
    </div>
</div>
</body>
</html>
