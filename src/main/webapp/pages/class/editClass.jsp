<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <title>Edit class</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.0/css/boxicons.min.css"
          integrity="sha512-pVCM5+SN2+qwj36KonHToF2p1oIvoU3bsqxphdOIWMYmgr4ZqD3t5DjKvvetKhXGc/ZG5REYTT6ltKfExEei/Q=="
          crossorigin="anonymous" referrerpolicy="no-referrer">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css"
          integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc=" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css"/>
</head>

<body>
<jsp:include page="../../components/header.jsp"/>

<%--Back--%>
<div class="container pt-3">
    <a href="class" class="size-3">
        <div class="arrow" style=""></div>
    </a>
</div>

<%--Main Body--%>
<div class="container" style="padding-top: 30px">
    <form action="EditClass" method="post">

        <div class="row align-items-center">
            <div class="col-md-6">
                <div class="mb-4">
                    <h5 class="card-title">
                        <!-- ID Class -->
                        Edit class <span class="text-muted">(ID: ${aClass.getClassId()} )</span>
                    </h5>

                </div>
            </div>

        </div>
        <div class="col">
            <div class="col-lg-16">
                <div class="">
                    <div class="form-row input-group mb-3 d-flex">

                        <label class="input-group-text" for="name">Enter Class Name:</label>
                        <input name="name" id="name" type="text" class="form-control" value="${aClass.getClassName()}"
                               aria-label="Your Class Name"
                               aria-describedby="basic-addon2" required>
                    </div>
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="level">Choose Class Level:</label>
                        <select name="level" id="level" type="text" class="form-select"
                                placeholder="${aClass.getLevel()}" aria-label="Choose Class Level"
                                aria-describedby="basic-addon2" required>

                            <option value="${aClass.getLevel()}">${aClass.getLevel()}</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 pt-3">
            <div class="mb-6">
                <h5 class="card-title">
                    Students in class
                </h5>
                <h6 class="card-title text-muted pt-5" style="font-style: oblique">
                    [Student Quantity: ${aClass.getStudentQuantity()} ]
                </h6>
                <h6 class="card-title text-muted pt-5" style="font-style: oblique">
                    [Student List]
                    <div class="table-responsive">
                        <table class="table table-light table-nowrap align-middle table-borderless table-hover">
                            <thead>
                            <tr>
                                <th scope="col" style="width: 50px">ID</th>
                                <th scope="col">Name</th>
                                <th scope="col">DoB</th>
                                <th scope="col">Gender</th>
                                <th scope="col">Address</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="t" items="${listS}">
                                <tr>
                                    <!-- ID -->
                                    <td>${t.getStudentId()}</td>
                                    <!-- Name -->
                                    <td>${t.getStudentName()}</td>
                                    <td>${t.getDob()}</td>
                                    <td>${t.getGender().equals(1) ? "Male" : "Female"}</td>
                                    <td>${t.getAddress()}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                </h6>
            </div>
        </div>
        <input name="classId" id="classId" type="hidden" value="${aClass.getClassId()}">
        <div class="col-md pt-3">
            <div class="d-flex  align-items-center justify-content-end gap mb-3">
                <div>
                    <button href="class" data-bs-toggle="modal" class=" btn btn-primary"><i
                            class="bx bx-plus me-1 "></i> Cancel Changes
                    </button>
                </div>
                <div>
                <button type="submit" data-bs-toggle="modal" data-bs-target=".add-new" class=" btn btn-primary"><i
                        class="bx bx-plus me-1 "></i> Confirm Changes
                </button>
            </div>
            </div>
        </div>


    </form>
</div>
<jsp:include page="../../components/footer.jsp"/>

</body>

</html>