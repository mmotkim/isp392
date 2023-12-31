<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <title>Class</title>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css"/>
    <style>
        body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        .container {
            min-height: 100%;
            display: flex;
            flex-direction: column;
        }

    </style>
</head>
<body class="bg-light">
<jsp:include page="../../components/header.jsp"/>

<div class="container">
    <div class="row align-items-center">
        <c:if test="${param.state eq 'true'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Action completed without issues!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <div class="col-md-6">
            <div class="mb-4">
                <h5 class="card-title">
                    Class List <span class="text-muted fw-normal ms-2"> ${count} </span>
                </h5>
            </div>
        </div>
        <div class="col-md-6">
            <div class="d-flex flex-wrap align-items-center justify-content-end gap-2 mb-3">
                <div>
                    <!-- Them Class -->
                    <a href="NewClass" class="btn btn-primary px-4 py-2"
                    ><i class="bx bx-plus me-1"></i> Add New Class</a
                    >
                </div>
            </div>
            <div>
                <form action="AddAttendance" method="post">
                    <div class="d-flex align-items-center justify-content-between">
                        <div class="input-group">
                            <input name="date" type="date" id="date" class="form-control" placeholder="Date" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Add Attendance</button>
                    </div>

                </form>
            </div>

        </div>
    </div>
    <div class="row">
        <div class="col-lg-16">
            <div class="table-responsive">
                <table class="table table-light table-nowrap align-middle table-borderless table-hover">
                    <thead>
                    <tr>
                        <th scope="col" style="width: 50px">ID</th>
                        <th scope="col">Name</th>
                        <th scope="col">Level</th>
                        <th scope="col">Quantity</th>
                        <th scope="col">Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="t" items="${list}">
                        <dialog id="d${t.getClassId()}">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title text-danger">Confirm Deletion</h5>
                                        <button type="button" class="btn-close"
                                                onclick="d${t.getClassId()}.close()"></button>
                                    </div>
                                    <div class="modal-body">
                                        <p>Are you sure you want to delete Class <span
                                                class="text-muted">( ID: ${t.getClassId()})</span></p>
                                    </div>
                                    <div class="modal-footer">
                                        <button class="btn btn-secondary" onclick="d${t.getClassId()}.close()">
                                            Cancel
                                        </button>
                                        <a href="./DeleteClass?id=${t.getClassId()}" class="btn btn-primary"
                                           onclick="d${t.getClassId()}.close()">
                                            Delete
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </dialog>
                        <tr>
                            <!-- ID -->
                            <td>${t.getClassId()}</td>
                            <!-- Name -->
                            <td>${t.getClassName()}</td>
                            <td>${t.getLevel()}</td>
                            <td>${t.getStudentQuantity()}</td>
                            <c:if test="${sessionScope.acc.role == 1}">

                            <td class="justify-content-between ml-2">
                                <ul class="list-inline mb-0">
                                    <li class="list-inline-item">
                                        <!-- Edit -->
                                        <a
                                                href="./EditClass?classId=${t.getClassId()}"

                                                title="Edit"
                                                class="px-2 text-primary"
                                        ><i class="bx bx-pencil font-size-18"></i
                                        ></a>
                                    </li>
                                    <li class="list-inline-item">
                                        <!-- Delete -->
                                        <a
                                            <%--                                                href="#confirmModal"--%>
                                                href="#"
                                                onclick="d${t.getClassId()}.showModal();"
                                                title="Delete"
                                                class="px-2 text-danger"
                                        ><i class="bx bx-trash-alt font-size-18"></i
                                        ></a>
                                    </li>
                                    <!-- Other actions -->
                                    <li class="list-inline-item dropdown">
                                        <a
                                                class="text-muted dropdown-toggle font-size-18"
                                                href="#"
                                                role="button"
                                                data-bs-toggle="dropdown"
                                                aria-haspopup="true"
                                        ><i class="bx bx-dots-vertical-rounded"></i
                                        ></a>
                                        <div class="dropdown-menu dropdown-menu-end">
                                            <a class="dropdown-item" href="./StudentInClass?classId=${t.getClassId()}">Student in class</a
                                            ><a class="dropdown-item" href="./ateStatus?classId=${t.getClassId()}"
                                        >Ate Status In Class</a
                                        ><a class="dropdown-item" href="./attendance?classId=${t.getClassId()}"
                                        >Attendance In Class</a
                                        >
                                        </div>
                                    </li>
                                </ul>
                            </td>
                            </c:if>
                            <c:if test="${sessionScope.acc.role == 2}">
                                <td class="justify-content-between ml-2">
                                    <ul class="list-inline mb-0">
                                        <li class="list-inline-item">
                                            <a
                                                    href="./StudentInClass?classId=${t.getClassId()}"

                                                    title="Student in class"
                                                    class="px-2 text-primary"
                                            ><i class="bx bx-show font-size-18"></i></a>
                                        </li>
                                        <li class="list-inline-item dropdown">
                                            <a
                                                    class="text-muted dropdown-toggle font-size-18"
                                                    href="#"
                                                    role="button"
                                                    data-bs-toggle="dropdown"
                                                    aria-haspopup="true"
                                            ><i class="bx bx-dots-vertical-rounded"></i
                                            ></a>
                                            <div class="dropdown-menu dropdown-menu-end">
                                                <a class="dropdown-item" href="./ateStatus?classId=${t.getClassId()}"
                                            >Ate Status In Class</a
                                            ><a class="dropdown-item" href="./attendance?classId=${t.getClassId()}"
                                            >Attendance In Class</a>
                                            </div>
                                        </li>
                                    </ul>
                                </td>

                            </c:if>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="row g-0 align-items-center pb-4">
        <div class="col-sm-6">
            <div><p class="mb-sm-0">Showing 1 to 10 of 57 entries</p></div>
        </div>
        <div class="col-sm-6">
            <div class="float-sm-end">
                <ul class="pagination mb-sm-0">
                    <li class="page-item disabled">
                        <a href="#" class="page-link"
                        ><i class="mdi mdi-chevron-left"></i
                        ></a>
                    </li>
                    <li class="page-item active">
                        <a href="#" class="page-link">1</a>
                    </li>
                    <li class="page-item"><a href="#" class="page-link">2</a></li>
                    <li class="page-item"><a href="#" class="page-link">3</a></li>
                    <li class="page-item"><a href="#" class="page-link">4</a></li>
                    <li class="page-item"><a href="#" class="page-link">5</a></li>
                    <li class="page-item">
                        <a href="#" class="page-link"
                        ><i class="mdi mdi-chevron-right"></i
                        ></a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>


<jsp:include page="../../components/footer.jsp"/>

<script>
    $(document).ready(function () {
        $("#confirmModal").modal("show");
    });
</script>
<script src="../../assets/js/bootstrap.bundle.js"></script>
</body>

</html>

