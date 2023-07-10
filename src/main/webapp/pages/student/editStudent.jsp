<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <title>Edit Student</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.0/css/boxicons.min.css"
          integrity="sha512-pVCM5+SN2+qwj36KonHToF2p1oIvoU3bsqxphdOIWMYmgr4ZqD3t5DjKvvetKhXGc/ZG5REYTT6ltKfExEei/Q=="
          crossorigin="anonymous" referrerpolicy="no-referrer">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css"
          integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc=" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css">
</head>

<body class="bg-light">
<jsp:include page="../../components/header.jsp"/>

<div class="container pt-3">
    <a href="student" class="size-3">
        <div class="arrow" style=""></div>
    </a>
</div>


<div class="container" style="margin-top: 40px">

    <form action="EditStudent" method="post">

        <div class="row align-items-center">
            <div class="col-md-6">
                <div class="mb-4">
                    <h5 class="card-title text-primary">
                        Edit Student Details. <span class="text-muted">(Student ID: ${a.getUserId()})</span>
                    </h5>
                </div>
            </div>
        </div>
        <div class="col">
            <div class="col-lg-16">
                <div class="">
                    <input name="id" id="id" type="hidden" value="${a.getStudentId()}">

                    <div class="form-row input-group mb-3 d-flex">

                        <label class="input-group-text" for="name">Enter Student Name:</label>
                        <input id="name" name="name" type="text" class="form-control" placeholder="Parent Name"
                               aria-label="Your Parent Name"
                               aria-describedby="basic-addon2" value="${a.getStudentName()}" required>
                    </div>
                    <div class="form-row input-group mb-3 d-flex">
                        <label class="input-group-text">Gender</label>
                        <input type="radio" id="true" name="gender" value="Male">
                        <label for="true">Male</label><br>
                        <input type="radio" id="false" name="gender" value="Female">
                        <label for="false">Female</label><br>
                    </div>
                    <div class="form-row input-group mb-3">
                        <label class="input-group-text" for="dob">Enter Birthday:</label>
                        <input id="dob" name="dob" type="text" class="form-control" placeholder="DOB"
                               aria-label="Your DoB"
                               aria-describedby="basic-addon2" value="${a.getDob()}">
                    </div>

                    <div class="form-row input-group mb-3 d-flex">
                        <label class="input-group-text">Active</label>
                        <input type="radio" id="true1" name="active" value="Yes">
                        <label for="true1">Active</label><br>
                        <input type="radio" id="false1" name="active" value="No">
                        <label for="false1">Inactive</label><br>
                    </div>


                </div>
            </div>
        </div>
        <div class="col-md-6 pt-3">
            <h5 class="card-title">
                Other Informations:
            </h5>
            <h6 class="card-title text-muted pt-5" style="font-style: oblique">
                Parent: ${a.getParentId()}
            </h6>
            <h6>
                Class: ${a.getClassId()}
            </h6>
        </div>
        <!-- Confirm Button -->
        <div class="col-md pt-3">
            <div class="d-flex  align-items-center justify-content-end gap mb-3">
                <div>
                    <button href="student" data-bs-toggle="modal" class=" btn btn-primary"><i
                            class="bx bx-plus me-1 "></i> Cancel Change
                    </button>
                </div>
                <div>
                    <button type="submit" data-bs-toggle="modal" data-bs-target=".add-new"
                            class=" btn btn-primary px-4 py-2"><i
                            class="bi bi-check-lg me-1 "></i> Confirm Edit Student
                    </button>
                </div>
            </div>
        </div>


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
                const name = recordsList[i].getElementsByTagName('td')[1].textContent.toLowerCase();
                const teachers = recordsList[i].getElementsByTagName('td')[4].textContent.toLowerCase();
                const shouldDisplay = name.includes(searchTerm) || teachers.includes(searchTerm);
                recordsList[i].style.display = shouldDisplay ? 'table-row' : 'none';
            }
        });

        const selectCheckboxes = document.querySelectorAll('.select-cell input[type="checkbox"]');
        for (let i = 0; i < selectCheckboxes.length; i++) {
            selectCheckboxes[i].addEventListener('click', function (event) {
                event.stopPropagation();
                const record = this.closest('tr');
                if (this.checked) {
                    selectedRecords.add(record);
                } else {
                    selectedRecords.delete(record);
                }
            });
        }

        const selectCells = document.getElementsByClassName('select-cell');
        for (let i = 0; i < selectCells.length; i++) {
            selectCells[i].addEventListener('click', function () {
                const checkbox = this.querySelector('input[type="checkbox"]');
                checkbox.checked = !checkbox.checked;
                const record = this.closest('tr');
                if (checkbox.checked) {
                    selectedRecords.add(record);
                } else {
                    selectedRecords.delete(record);
                }
            });
        }
    });
</script>

<style>
    .table-container {
        max-height: 200px;
        overflow-y: auto;
    }
</style>
</body>

</html>