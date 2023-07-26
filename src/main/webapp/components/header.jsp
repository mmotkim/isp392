<%--
  Created by IntelliJ IDEA.
  User: mmotk
  Date: 6/16/2023
  Time: 9:15 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
    <style>
        .list-group-item:hover .overflow-ellipsis {
            -webkit-line-clamp: unset;
        }

        .list-group-item .overflow-ellipsis {
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 1;
            overflow: hidden;
            text-overflow: ellipsis;
            transition: -webkit-line-clamp 0.3s;
        }
    </style>
</head>
<body>
<div class="bg-dark text-white ">
    <div class="container">
        <header class="row d-flex flex-wrap align-items-center justify-content-md-between py-4">
            <div class="logo col-auto">
                <a href="#" class="d-flex">
                    <img class="me-3" height="28" src="${pageContext.request.contextPath}/assets/logo.png"/>
                </a>
            </div>

            <ul class="nav col-auto mb-2 text-center justify-content-center mb-md-0 text-white">
                <!-- for all -->
                <li><a href="home" class="nav-link px-2  ${fn:contains(pageContext.request.requestURI, '/index') ? 'link-secondary' : 'link-light'}">Home</a></li>

                <!-- for headmaster only
            <li><a href="#" class="nav-link px-2 link-light">Dashboard</a></li>
            <li><a href="#" class="nav-link px-2 link-light">Classes</a></li>
            <li><a href="#" class="nav-link px-2 link-light">Teachers</a></li>
            <li><a href="#" class="nav-link px-2 link-light">Students</a></li>
            <li><a href="#" class="nav-link px-2 link-light">Parents</a></li> -->
<c:if test="${sessionScope['acc']!=null}">

<c:if test="${sessionScope['acc'].getRole() == 1 || sessionScope['acc'].getRole() == 2 }">

                <li class="nav-item dropdown">
                    <a class="nav-link px-2    ${pageContext.request.contextPath == '/index' ? 'link-secondary' : 'link-light'} dropdown-toggle" href="#" id="managerDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Manager
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="managerDropdown">
                        <li><a class="dropdown-item ${fn:contains(pageContext.request.requestURI, '/notification') ? 'link-primary' : ''}" href="notification">Notifications</a></li>
                        <li><a class="dropdown-item ${fn:contains(pageContext.request.requestURI, '/activity') ? 'link-primary' : ''}" href="activity">Activity</a></li>
                        <li><a class="dropdown-item ${fn:contains(pageContext.request.requestURI, '/class') ? 'link-primary' : ''}" href="class">Classes</a></li>
                        <li><a class="dropdown-item ${fn:contains(pageContext.request.requestURI, '/teacher') ? 'link-primary' : ''}" href="teacher">Teachers</a></li>
                        <li><a class="dropdown-item ${fn:contains(pageContext.request.requestURI, '/student') ? 'link-primary' : ''}" href="student">Students</a></li>
                        <li><a class="dropdown-item ${fn:contains(pageContext.request.requestURI, '/parent') ? 'link-primary' : ''}" href="parent">Parents</a></li>
                        <li><a class="dropdown-item " href="meal">Meal</a></li>
                    </ul>
                </li>

                <li><a href="ListAccount" class="nav-link px-2 ${pageContext.request.contextPath eq '/ListAccount' ? 'link-secondary' : 'link-light'}">Accounts</a></li>
                </c:if>

                <li><a  class="nav-link px-2 ${pageContext.request.contextPath eq '/calendar' ? 'link-secondary' : 'link-light'}" href="calendar">Calendar</a></li>
</c:if>
            </ul>

            <div class="col text-end">
                <div class="d-flex justify-content-end align-items-center text-end">
                    <c:if test="${sessionScope['acc']!=null}">

                        <div class="me-2">Logged in as: ${acc.getFullname()}</div>
                    <a href="#"  class="link-light me-2 dropdown-toggle text-decoration-none" id="notificationsDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="bi bi-bell"></i>
                    </a>

                    <div class="dropdown-menu dropdown-menu-end" aria-labelledby="notificationsDropdown">
                        <c:forEach var="t" items="${notifs}">
                            <ul class="list-group">
                                <a href="./EditNotification?notificationId=${t.key.getNotificationId()}" class="list-group-item list-group-item-action"
                                ><div class="d-flex w-100 justify-content-between">
                                    <h5 class="mb-1 me-2">${t.key.getTitle()}</h5>
                                    <small>${t.key.getProcessingDate()}</small>
                                </div>
                                    <p class="mb-1 overflow-ellipsis" style="max-width: 300px">${t.key.getDescription()}</p>
                                    <small>
                                        <c:if test="${t.value.equals(null)}">
                                            No activity attached
                                        </c:if>
                                        <c:if test="${t.value != null}">
                                            ${t.value}
                                        </c:if>
                                        <span class="alert-warning"></span>
                                    </small>
                                </a>
                            </ul>
                        </c:forEach>
                    </div>
                        <a href="LogoutControl">
                            <button type="button"  class="btn btn-outline-light me-1">
                                Logout
                            </button>
                        </a>
                    </c:if>
                    <c:if test="${sessionScope['acc']==null}">
                    <a href="Login">
                        <button type="button"  class="btn btn-outline-light me-1">
                            Login
                        </button>

                    </a>
                    </c:if>
                </div>
            </div>
        </header>
    </div>

</div>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.js"></script>
</body>
</html>
