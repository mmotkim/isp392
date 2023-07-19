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
    <title>Activity</title>
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
        .sortable-title {
            cursor: pointer;
        }

        .sortable-title::after {
            display: inline-block;
            content: '';
            width: 0.5em;
            height: 0.5em;
            border-left: 0.3em solid transparent;
            border-right: 0.3em solid transparent;
            border-bottom: 0.5em solid;
            vertical-align: middle;
            margin-left: 0.3em;
            opacity: 0.5;
        }

        .sortable-title.asc::after {
            border-bottom: none;
            border-top: 0.5em solid;
            opacity: 1;
        }

        .sortable-title.desc::after {
            border-bottom: 0.5em solid;
            border-top: none;
            opacity: 1;
            transform: rotate(180deg);
        }
    </style>
</head>
<body class="bg-light">
<jsp:include page="../../components/header.jsp"/>
<div class="">
    <div class="container">
        <div class="row align-items-center">
            <%--    Alert--%>
            <c:if test="${param.state eq 'true'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    Action completed without issues!
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <div class="col-md-6">
                <div class="mb-4">
                    <h5 class="card-title">
                        <!-- Tong so luong Activity -->
                        Activity List <span class="text-muted fw-normal ms-2"> ${count} </span>
                    </h5>
                </div>
            </div>
            <div class="col-md-6">
                <div class="d-flex flex-wrap align-items-center justify-content-end gap-2 mb-3">
                    <div>
                        <!-- Them Activity -->
                        <a href="NewActivity" class="btn btn-primary px-4 py-2"
                        ><i class="bx bx-plus me-1"></i> Add New</a
                        >
                    </div>
                </div>
            </div>
        </div>
        <%--        Search--%>
        <div class="d-flex align-items-center my-2" style="height: 3rem">
          <span class="search-icon pe-1" style="cursor: pointer">
            <i class="bi bi-search"></i>
          </span>
            <input id="searchInput" type="text" class="form-control ml-2"
                   placeholder="Search by Title, Description or Type">
        </div>
        <div class="row">
            <div class="col-lg-16">
                <div class="table-responsive">
                    <table class="table table-light table-nowrap align-middle table-borderless table-hover">
                        <thead>
                        <tr>
                            <th class="sortable-title col-3" onclick="sortTable(0)" scope="col" style="width: 100px">Number</th>
                            <th class="sortable-title col-auto" onclick="sortTable(1)" scope="col">Name</th>
                            <th class="col-auto" scope="col">Description</th>
                            <th class="sortable-title col-auto" onclick="sortTable(3)" scope="col">Type</th>
                            <th class="col-auto" scope="col">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="t" items="${list}">
                            <dialog id="d${t.getActivityId()}">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title text-danger">Confirm Deletion</h5>
                                            <button type="button" class="btn-close"
                                                    onclick="d${t.getActivityId()}.close()"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p>Are you sure you want to delete Activity <span
                                                    class="text-muted">( ID: ${t.getActivityId()})</span></p>
                                        </div>
                                        <div class="modal-footer">
                                            <button class="btn btn-secondary" onclick="d${t.getActivityId()}.close()">
                                                Cancel
                                            </button>
                                            <a href="./DeleteActivity?id=${t.getActivityId()}" class="btn btn-primary"
                                               onclick="d${t.getActivityId()}.close()">
                                                Delete
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </dialog>

                            <tr>
                                <!-- ID -->
                                <td>${t.getActivityId()}</td>
                                <!-- Name -->
                                <td>${t.getName()}</td>
                                <!-- Description -->
                                <td>${t.getDescription()}</td>
                                <td>${t.getType()}</td>

                                <td class="justify-content-between ml-2">
                                    <ul class="list-inline mb-0">
                                        <li class="list-inline-item">
                                            <!-- Edit -->
                                            <a
                                                    href="./EditActivity?activityId=${t.getActivityId()}"

                                                    title="Edit"
                                                    class="px-2 text-primary"
                                            ><i class="bx bx-pencil font-size-18"></i
                                            ></a>
                                        </li>
                                        <li class="list-inline-item">
                                            <!-- Delete -->
                                            <a
                                                    href="#"
                                                    onclick="d${t.getActivityId()}.showModal();"
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
                                                <a class="dropdown-item" href="#">Action</a
                                                ><a class="dropdown-item" href="#"
                                            >Another action</a
                                            ><a class="dropdown-item" href="#"
                                            >Something else here</a
                                            >
                                            </div>
                                        </li>
                                    </ul>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="row g-0 align-items-center pb-4">
            <div class="col-sm-6">
                <div><p class="mb-sm-0">Showing 1 to 10 of ${count} entries</p></div>
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
                        <%--                        <li class="page-item"><a href="#" class="page-link">2</a></li>--%>
                        <%--                        <li class="page-item"><a href="#" class="page-link">3</a></li>--%>
                        <%--                        <li class="page-item"><a href="#" class="page-link">4</a></li>--%>
                        <%--                        <li class="page-item"><a href="#" class="page-link">5</a></li>--%>
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
</div>

<jsp:include page="../../components/footer.jsp"/>


<script>
    document.addEventListener('DOMContentLoaded', function () {
        var searchInput = document.getElementById('searchInput');
        var searchIcon = document.querySelector('.search-icon');
        searchIcon.addEventListener('click', function () {
            searchInput.classList.toggle('active');
        });

        searchInput.addEventListener('input', function () {
            var searchText = searchInput.value.toLowerCase();
            var tableRows = document.querySelectorAll('table tbody tr');
            tableRows.forEach(function (row) {
                var title = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
                var description = row.querySelector('td:nth-child(3)').textContent.toLowerCase();
                var type = row.querySelector('td:nth-child(4)').textContent.toLowerCase();
                if (title.includes(searchText) || activity.includes(searchText) || type.includes(searchText)) {
                    row.style.display = 'table-row';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    });

    function sortTable(columnIndex) {
        var table = document.querySelector('table');
        var tbody = table.tBodies[0];
        var rows = Array.from(tbody.querySelectorAll('tr'));

        rows.sort(function (a, b) {
            var aValue = a.cells[columnIndex].textContent;
            var bValue = b.cells[columnIndex].textContent;
            if (columnIndex === 0) {
                return aValue - bValue;
            } else if (columnIndex === 2) {
                return new Date(aValue) - new Date(bValue);
            } else {
                return aValue.localeCompare(bValue);
            }
        });

        if (table.classList.contains('asc')) {
            rows.reverse();
            table.classList.remove('asc');
            table.classList.add('desc');
        } else {
            table.classList.remove('desc');
            table.classList.add('asc');
        }

        rows.forEach(function (row) {
            tbody.appendChild(row);
        });
    }

</script>

<script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.js"></script>

</body>

</html>

