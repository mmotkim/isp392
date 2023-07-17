<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Student Profile</title>
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
    <a href="ViewStudent" class="size-3">
        <div class="arrow" style=""></div>
    </a>
</div>



<div class="container" style="margin-top: 40px">

    <form action="EditParent" method="post">

        <div class="row align-items-center">
            <div class="col-md-6">
                <div class="mb-4">
                    <h5 class="card-title text-primary">
                        Student Profile <span class="text-muted">(Student ID: ${s1.getStudentId()})</span>
                    </h5>
                </div>
            </div>
        </div>


        <div class="col">
            <div class="col-lg-16">
                <div class="">
                    <input name="id" id="id" type="hidden" value="${s1.getStudentId()}">

                    <div class="form-row input-group mb-3 d-flex">

                        <label class="input-group-text">Studenr Name:</label>
                        <li id="name" name="name"  class="form-control"  aria-label=""
                               aria-describedby="basic-addon2"  >${s1.getStudentName()}</li>
                    </div>
<%--                    <div class="form-row input-group mb-3 d-flex">--%>
<%--                        <label class="input-group-text">Gender</label>--%>
<%--                        <li id="Class" name="Class"  class="form-control" placeholder="Class" aria-label="Your Class"--%>
<%--                            aria-describedby="basic-addon2" >${s1.()}</li>--%>
<%--                    </div>--%>
                    <div class="form-row input-group mb-3 d-flex">
                        <label class="input-group-text">Gender</label>
                        <li id="gender" name="gender"  class="form-control" placeholder="gender" aria-label="Your gender"
                            aria-describedby="basic-addon2" >${s1.getGender().equals(1) ? "Male" : "Female"}</li>
                    </div>
                    <div class="form-row input-group mb-3">
                        <label class="input-group-text">Enter Birthday:</label>
                        <li id="dob" name="dob"  class="form-control" placeholder="DOB" aria-label="Your DoB"
                               aria-describedby="basic-addon2" >${s1.getDob()}</li>
                    </div>

                    <div class="form-row input-group mb-3">
                        <label class="input-group-text">Enter Address:</label>
                        <li id="address" name="address"  class="form-control" placeholder="Address" aria-label="Your Address"
                               aria-describedby="basic-addon2">${s1.getAddress()}</li>
                    </div>

                    <div class="form-row input-group mb-3 d-flex">
                        <label class="input-group-text">Active</label>
                        <li id="Active" name="Active"  class="form-control" placeholder="Active" aria-label="Your Active"
                            aria-describedby="basic-addon2" >${s1.isActive().equals(1) ? "Active" : "Inactive"}</li>
                    </div>


                </div>
            </div>
        </div>

        <!-- Confirm Button -->



    </form>


</div>
<jsp:include page="../../components/footer.jsp"/>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const searchInput = document.getElementById('search-input');
        const recordsList = document.getElementById('records-list').getElementsByTagName('tr');
        const selectedRecords = new Set();

        searchInput.addEventListener('input', function() {
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
            selectCheckboxes[i].addEventListener('click', function(event) {
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
            selectCells[i].addEventListener('click', function() {
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
    .table-container{
        max-height: 200px;
        overflow-y: auto;
    }
</style>
</body>

</html>