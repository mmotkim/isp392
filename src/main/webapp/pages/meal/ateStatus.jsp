<%--
  Created by IntelliJ IDEA.
  User: Le Vu
  Date: 18/07/2023
  Time: 19:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Ate Status</title>

    <!-- CSS Libraries -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.0/css/boxicons.min.css" integrity="sha512-pVCM5+SN2+qwj36KonHToF2p1oIvoU3bsqxphdOIWMYmgr4ZqD3t5DjKvvetKhXGc/ZG5REYTT6ltKfExEei/Q==" crossorigin="anonymous" referrerpolicy="no-referrer">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css" integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc=" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css" />
</head>
<body class="bg-light">
<jsp:include page="../../components/header.jsp"/>

<%--Back--%>
<div class="container pt-3">
    <a href="class" class="size-3">
        <div class="arrow" style=""></div>
    </a>
</div>

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
                <h5 class="card-title">Ate Status List</h5>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="input-group mb-3">
                <input type="date" id="filterDate" class="form-control" placeholder="Filter by Date">
            </div>
        </div>
        <div class="col-lg-16">
            <div class="table-responsive">
                <table class="table table-light table-nowrap align-middle table-borderless table-hover">
                    <thead>
                    <tr>
                        <th scope="col">Student</th>
                        <th scope="col">Meal</th>
                        <th scope="col">Status</th>
                        <th scope="col">Reason</th>
                        <th scope="col">Date</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="t" items="${list}">
                        <tr>
                            <td>${stuDAO.getStudentById(t.getStudentId()).getStudentName()}</td>
                            <td>${mealDAO.getMealById(t.getMealId()).getMealDescription()}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${t.getStatus() eq 'finished'}">Finished</c:when>
                                    <c:when test="${t.getStatus() eq 'more-than-half'}">More than half</c:when>
                                    <c:when test="${t.getStatus() eq 'half'}">Half</c:when>
                                    <c:when test="${t.getStatus() eq 'less'}">Less</c:when>
                                    <c:when test="${t.getStatus() eq 'did-not-eat'}">Did not eat</c:when>
                                    <c:otherwise>Unknown</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${t.getReason()}</td>
                            <td>${mealDAO.getMealById(t.getMealId()).getDate()}</td>
                            <c:if test="${sessionScope.acc.role == 1}">

                            <td class="justify-content-between ml-2">
                                <ul class="list-inline mb-0">
                                    <li class="list-inline-item">
                                        <!-- Edit -->
                                        <a href="./EditAteStatus?stuId=${t.getStudentId()}&mealId=${t.getMealId()}" title="Edit" class="px-2 text-primary">
                                            <i class="bx bx-pencil font-size-18"></i>
                                        </a>
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
            <div>
                <p class="mb-sm-0">Showing 1 to 10 of 57 entries</p>
            </div>
        </div>
        <div class="col-sm-6">
            <div class="float-sm-end">
                <ul class="pagination mb-sm-0">
                    <li class="page-item disabled">
                        <a href="#" class="page-link">
                            <i class="mdi mdi-chevron-left"></i>
                        </a>
                    </li>
                    <li class="page-item active">
                        <a href="#" class="page-link">1</a>
                    </li>
                    <li class="page-item"><a href="#" class="page-link">2</a></li>
                    <li class="page-item"><a href="#" class="page-link">3</a></li>
                    <li class="page-item"><a href="#" class="page-link">4</a></li>
                    <li class="page-item"><a href="#" class="page-link">5</a></li>
                    <li class="page-item">
                        <a href="#" class="page-link">
                            <i class="mdi mdi-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../../components/footer.jsp" />
<script>
    const filterDateInput = document.getElementById('filterDate');
    const tableRows = document.querySelectorAll('.table tbody tr');

    filterDateInput.addEventListener('change', () => {
        const filterDate = filterDateInput.value;

        tableRows.forEach(row => {
            const rowDate = row.querySelector('td:nth-child(5)').textContent; // Chỉnh số cột tương ứng với cột ngày

            if (rowDate === filterDate) {
                row.style.display = ''; // Hiển thị hàng
            } else {
                row.style.display = 'none'; // Ẩn hàng
            }
        });
    });
</script>
</body>
</html>
