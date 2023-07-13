<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
        <title>Adding a new Activity</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.0/css/boxicons.min.css"
              integrity="sha512-pVCM5+SN2+qwj36KonHToF2p1oIvoU3bsqxphdOIWMYmgr4ZqD3t5DjKvvetKhXGc/ZG5REYTT6ltKfExEei/Q=="
              crossorigin="anonymous" referrerpolicy="no-referrer">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css"
              integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc=" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css"/>
    </head>

    <body class="bg-light">
        <jsp:include page="../../components/header.jsp"/>

        <%--Back--%>
        <div class="container pt-3">
            <a href="activity" class="size-3">
                <div class="arrow" style=""></div>
            </a>
        </div>

        <%--Main Body--%>
        <div class="container" style="margin-top: 40px">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <div class="mb-4">
                        <h5 class="card-title">
                            <!-- Tong so luong Activity -->
                            1. Add a new Activity.
                        </h5>
                    </div>
                </div>

            </div>
            <form action="NewActivity" method="post">

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group mb-3">
                            <label class="" for="name">Enter Activity Name:</label>
                            <input name="name" id="name" type="text" class="form-control" placeholder="Activity Name"
                                   aria-label="Your Activity Name"
                                   aria-describedby="basic-addon2" maxlength="100"  required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group mb-3">
                            <label class="" for="type">Choose Activity Type:</label>
                            <select name="type" id="type" type="text" class="form-select"
                                    aria-label="Choose Activity Type"
                                    aria-describedby="basic-addon2" required>

                                <option value="">Choose an activity type</option>
                                <option value="entertainment">Entertainment</option>
                                <option value="meal">Meal</option>
                                <option value="study">Study</option>
                                <option value="skills">Skills</option>
                            </select>
                        </div>

                    </div>
                </div>

                <div class="row py-2">
                    <div class="col-md-6">
                        <div class="form-group mb-3">
                            <label class="" for="description">Enter Activity Description:</label>
                            <input name="description" id="description" type="text" class="form-control"
                                   placeholder="Activity Description" aria-label="Your Activity Description"
                                   aria-describedby="basic-addon2" maxlength="1000">
                        </div>
                    </div>
                </div>

                <div class="row align-items-center py-3">
                    <div class="col-md-6">
                        <div class="mb-4">
                            <h5 class="card-title">
                                <!-- Tong so luong Activity -->
                                2. Assign the activity to a class,... or leave it empty for now.
                            </h5>
                        </div>
                    </div>
                </div>
                <div>
                    <div class="search-box mt-3 pt-3">
                        <input type="text" id="search-input" class="form-control" placeholder="Search by Name">
                    </div>
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th class="col-auto">Select</th>
                                <th class="col-auto">Number</th>
                                <th class="col-auto">Class Name</th>
                                <th class="col-auto">Class Level</th>
                                <th class="col-auto">Student Quantity</th>
                            </tr>
                        </thead>
                        <tbody id="records-list">
                            <c:forEach var="t" items="${list2}">
                                <tr>
                                    <td class="select-cell">
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input">
                                        </div>
                                    </td>
                                    <td>${t.getClassId()}</td>
                                    <td>${t.getClassName()}</td>
                                    <td>${t.getLevel()}</td>
                                    <td>${t.getStudentQuantity()}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="col-md pt-3">
                    <div class="d-flex  align-items-center justify-content-end gap mb-3">
                        <div>
                            <!-- Them Activity -->
                            <button type="submit" data-bs-toggle="modal" data-bs-target=".add-new"
                                    class=" btn btn-primary"><i
                                    class="bx bx-plus me-1 "></i> Confirm Create Activity
                            </button>
                        </div>
                    </div>
                </div>

                <input type="hidden" name="selectedIds" id="selectedIdsInput">
            </form>


        </div>
        <jsp:include page="../../components/footer.jsp"/>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const searchInput = document.getElementById('search-input');
                const recordsList = document.getElementById('records-list').getElementsByTagName('tr');
                const selectedRecords = new Set();

                searchInput.addEventListener('input', function () {
                    const searchTerm = searchInput.value.trim().toLowerCase();
                    for (let i = 0; i < recordsList.length; i++) {
                        const name = recordsList[i].getElementsByTagName('td')[2].textContent.toLowerCase();
                        recordsList[i].style.display = name.includes(searchTerm) ? 'table-row' : 'none';
                    }
                });

                const selectCheckboxes = document.querySelectorAll('.select-cell input[type="checkbox"]');
                for (let i = 0; i < selectCheckboxes.length; i++) {
                    selectCheckboxes[i].addEventListener('click', function (event) {
                        event.stopPropagation();
                        const record = this.closest('tr');
                        const id = record.getElementsByTagName('td')[1].textContent;
                        handleRecordSelection(id, this.checked);
                    });
                }

                const selectCells = document.getElementsByClassName('select-cell');
                for (let i = 0; i < selectCells.length; i++) {
                    selectCells[i].addEventListener('click', function () {
                        const checkbox = this.querySelector('input[type="checkbox"]');
                        checkbox.checked = !checkbox.checked;
                        const record = this.closest('tr');
                        const id = record.getElementsByTagName('td')[1].textContent;
                        handleRecordSelection(id, checkbox.checked);

                    });
                }

                function handleRecordSelection(id, isChecked) {
                    if (isChecked) {
                        selectedRecords.add(id);
                        saveRecords(selectedRecords);
                    } else {
                        selectedRecords.delete(id);
                        saveRecords(selectedRecords);
                    }
                }

                function saveRecords(selectedRecords) {
                    document.getElementById('selectedIdsInput').value = Array.from(selectedRecords).join(',');
                }
            });

        </script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.js"></script>
    </body>

</html>