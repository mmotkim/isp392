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
    <title>Student</title>
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
                    Student List <span class="text-muted fw-normal ms-2"> ${count} </span>
                </h5>
            </div>
        </div>
        <div class="col-md-6">
            <div class="d-flex flex-wrap align-items-center justify-content-end gap-2 mb-3">
                <div>
                    <a href="NewStudent" class="btn btn-primary px-4 py-2"
                    ><i class="bx bx-plus me-1"></i> Add New Student</a
                    >
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-16">
            <!-- Search -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <div class="input-group">
      <span class="input-group-text">
        <i class="bi bi-search"></i>
      </span>
                        <input id="searchInput" type="text" class="form-control" placeholder="Search by Name or Parent Name">
                    </div>
                </div>
            </div>
            <!-- Sort -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="sortSelect" class="form-label">Sort by:</label>
                    <select id="sortSelect" class="form-select">
                        <option value="nameAsc">Name (Ascending)</option>
                        <option value="nameDesc">Name (Descending)</option>
                        <option value="parentAsc">Parent Name (Ascending)</option>
                        <option value="parentDesc">Parent Name (Descending)</option>
                        <option value="dobAsc">DoB (Ascending)</option>
                        <option value="dobDesc">DoB (Descending)</option>
                    </select>
                </div>
            </div>

            <!-- Table -->

            <div class="table-responsive">
                <table class="table table-light table-nowrap align-middle table-borderless table-hover">
                    <thead>
                    <tr>
                        <th scope="col" style="width: 50px">ID</th>
                        <th scope="col">Name</th>
                        <th scope="col">Gender</th>
                        <th scope="col">DoB</th>
                        <th scope="col">Parent</th>
                        <th scope="col">isActive</th>
                        <th scope="col">Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="t" items="${list}">
                        <dialog id="d${t.getStudentId()}">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title text-danger">Confirm Deletion</h5>
                                        <button type="button" class="btn-close"
                                                onclick="d${t.getStudentId()}.close()"></button>
                                    </div>
                                    <div class="modal-body">
                                        <p>Are you sure you want to delete Student <span
                                                class="text-muted">( ID: ${t.getStudentId()})</span></p>
                                    </div>
                                    <div class="modal-footer">
                                        <button class="btn btn-secondary" onclick="d${t.getStudentId()}.close()">Cancel</button>
                                        <a href="./DeleteStudent?id=${t.getStudentId()}" class="btn btn-primary"
                                           onclick="d.close()">
                                            Delete
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </dialog>

                        <tr>
                            <!-- ID -->
                            <td>${t.getStudentId()}</td>
                            <!-- Name -->
                            <td>${t.getStudentName()}</td>
                            <td>${t.getGender()? "Male" : "Female"}</td>
                            <td>${t.getDob()}</td>
                            <td>${userDAO.getFullNameByUserId(t.getParentId())}</td>
                            <td>${t.getActive() ? "Active" : "Inactive"}</td>

                            <td class="justify-content-between ml-2">
                                <ul class="list-inline mb-0">
                                    <li class="list-inline-item">
                                        <!-- Edit -->
                                        <a
                                                href="./EditStudent?id=${t.getStudentId()}"

                                                title="Edit"
                                                class="px-2 text-primary"
                                        ><i class="bx bx-pencil font-size-18"></i
                                        ></a>
                                    </li>
                                    <li class="list-inline-item">
                                        <!-- Delete -->
                                        <a
                                                href="#"
                                                onclick="d${t.getStudentId()}.showModal();"
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
                                        >Something else here</a>
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
    // Get all table rows
    const tableRows = document.querySelectorAll('.table tbody tr');

    // Get the search input element
    const searchInput = document.getElementById('searchInput');

    // Handle input event on search input
    searchInput.addEventListener('input', () => {
        const searchText = searchInput.value.toLowerCase();

        // Filter table rows based on search text
        tableRows.forEach(row => {
            const nameColumn = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
            const parentColumn = row.querySelector('td:nth-child(5)').textContent.toLowerCase();

            if (nameColumn.includes(searchText) || parentColumn.includes(searchText)) {
                row.style.display = 'table-row';
            } else {
                row.style.display = 'none';
            }
        });
    });
</script>
<script>
    // Get the sort select element
    const sortSelect = document.getElementById('sortSelect');

    // Handle change event on sort select
    sortSelect.addEventListener('change', () => {
        const sortValue = sortSelect.value;

        // Sort table rows based on selected option
        tableRows.forEach(row => {
            const nameColumn = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
            const parentColumn = row.querySelector('td:nth-child(5)').textContent.toLowerCase();
            const dobColumn = row.querySelector('td:nth-child(4)').textContent.toLowerCase();

            row.style.display = 'table-row';
            if (sortValue === 'nameAsc') {
                row.setAttribute('data-sort-value', nameColumn);
            } else if (sortValue === 'nameDesc') {
                row.setAttribute('data-sort-value', nameColumn);
            } else if (sortValue === 'parentAsc') {
                row.setAttribute('data-sort-value', parentColumn);
            } else if (sortValue === 'parentDesc') {
                row.setAttribute('data-sort-value', parentColumn);
            } else if (sortValue === 'dobAsc') {
                row.setAttribute('data-sort-value', dobColumn);
            } else if (sortValue === 'dobDesc') {
                row.setAttribute('data-sort-value', dobColumn);
            }
        });

        // Sort the table rows
        const sortedRows = Array.from(tableRows);
        if (sortValue === 'nameAsc' || sortValue === 'parentAsc' || sortValue === 'dobAsc') {
            sortedRows.sort((a, b) => {
                const valueA = a.getAttribute('data-sort-value');
                const valueB = b.getAttribute('data-sort-value');
                return valueA.localeCompare(valueB);
            });
        } else if (sortValue === 'nameDesc' || sortValue === 'parentDesc' || sortValue === 'dobDesc') {
            sortedRows.sort((a, b) => {
                const valueA = a.getAttribute('data-sort-value');
                const valueB = b.getAttribute('data-sort-value');
                return valueB.localeCompare(valueA);
            });
        }

        // Reorder the table rows
        const tbody = document.querySelector('.table tbody');
        tbody.innerHTML = '';
        sortedRows.forEach(row => {
            tbody.appendChild(row);
        });
    });
</script>
<script src="../../assets/js/bootstrap.bundle.js"></script>
</body>

</html>

