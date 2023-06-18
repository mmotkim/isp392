<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Adding a new meal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.0/css/boxicons.min.css"
          integrity="sha512-pVCM5+SN2+qwj36KonHToF2p1oIvoU3bsqxphdOIWMYmgr4ZqD3t5DjKvvetKhXGc/ZG5REYTT6ltKfExEei/Q=="
          crossorigin="anonymous" referrerpolicy="no-referrer">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css"
          integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc=" crossorigin="anonymous">
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

<%--Main Body--%>
<div class="container" style="margin-top: 40px">
    <div class="row align-items-center">
        <div class="col-md-6">
            <div class="mb-4">
                <h5 class="card-title">
                    Add a new Meal
                </h5>
            </div>
        </div>

    </div>
    <form action="NewMeal" method="post">


        <div class="col">
            <div class="col-lg-16">
                <div class="">
                    <div class="form-row input-group mb-3 d-flex">

                        <label class="input-group-text" for="description">Enter Meal Description:</label>
                        <input name="description" id="description" type="text" class="form-control" placeholder="Description" aria-label="Your Meal Description"
                               aria-describedby="basic-addon2" required>
                    </div>
                    <div class="form-row input-group mb-3">
                        <label class="input-group-text" for="create_date">Enter Create Date</label>
                        <input name="create_date" id="create_date" type="text" class="form-control" placeholder="Create Date" aria-label="Your Create Date"
                               aria-describedby="basic-addon2">
                    </div>
                    <div class="form-row input-group mb-3">
                        <label class="input-group-text" for="date">Enter Create Date</label>
                        <input name="date" id="date" type="text" class="form-control" placeholder="Date" aria-label="Your Date"
                               aria-describedby="basic-addon2">
                    </div>


                </div>
            </div>
        </div>

        <div class="col-md pt-3">
            <div class="d-flex  align-items-center justify-content-end gap mb-3">
                <div>
                    <button type="submit" data-bs-toggle="modal" data-bs-target=".add-new" class=" btn btn-primary"><i
                            class="bx bx-plus me-1 "></i> Confirm Create Class</button>
                </div>
            </div>
        </div>


    </form>


</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const searchInput = document.getElementById('search-input');
        const recordsList = document.getElementById('records-list').getElementsByTagName('tr');
        const selectedRecords = new Set();

        searchInput.addEventListener('input', function () {
            const searchTerm = searchInput.value.trim().toLowerCase();
            for (let i = 0; i < recordsList.length; i++) {
                const name = recordsList[i].getElementsByTagName('td')[1].textContent.toLowerCase();
                recordsList[i].style.display = name.includes(searchTerm) ? 'table-row' : 'none';
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
</body>

</html>