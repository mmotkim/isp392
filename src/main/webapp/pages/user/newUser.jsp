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
    <a href="ListAccount" class="size-3">
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
                    1. Add a new User.
                </h5>
            </div>
        </div>

    </div>
    <form action="NewUser" method="post">

        <div class="row">
            <div class="col-md-6">
                <div class="form-group mb-3">
                    <label class="" for="name">Enter Full Name:</label>
                    <input name="name" id="name" type="text" class="form-control" placeholder="Activity Name"
                           aria-label="User Full Name"
                           aria-describedby="basic-addon2" maxlength="50">
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group mb-3">
                    <label>Gender</label><br>
                    <input type="radio" id="true" name="gender" value="Male">
                    <label for="true">Male</label><br>
                    <input type="radio" id="false" name="gender" value="Female">
                    <label for="false">Female</label><br>
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group mb-3">
                    <label class="" for="email">Enter Email:</label>
                    <input id="email" name="email" type="text" class="form-control" placeholder="Email"
                           aria-label="Your Email"
                           aria-describedby="basic-addon2" required>
                    <span id="email-error" class="error-message"></span>
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group mb-3">
                    <label class="" for="address">Enter Address:</label>
                    <input id="address" name="address" type="text" class="form-control" placeholder="Address"
                           aria-label="Your Address"
                           aria-describedby="basic-addon2">
                </div>
            </div>

        </div>

        <div class="row py-2">

            <div class="col-md-6">
                <div class="form-group mb-3">
                    <label class="" for="dob">Enter Birthday:</label>
                    <input id="dob" name="dob" type="date" class="form-control" placeholder="DOB"
                           aria-label="Your DoB"
                           aria-describedby="basic-addon2">
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group mb-3">
                    <label class="" for="phone">Enter Phone:</label>
                    <input id="phone" name="phone" type="text" class="form-control" placeholder="Phone"
                           aria-label="Your Phone"
                           aria-describedby="basic-addon2">
                    <span id="phone-error" class="error-message"></span>
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group mb-3">
                    <label class="" for="role">Choose User Role:</label>
                    <select name="role" id="role" type="text" class="form-select"
                            aria-label="Choose Activity Type"
                            aria-describedby="basic-addon2" required>

                        <option value="">Choose a role</option>
                        <option value="1">Headmaster</option>
                        <option value="2">Admin</option>
                        <option value="3">Teacher</option>
                        <option value="4">Parent</option>
                    </select>
                </div>
            </div>


        </div>

        <div class="col-md pt-3">
            <div class="d-flex  align-items-center justify-content-end gap mb-3">
                <div>
                    <!-- Them Activity -->
                    <button type="submit" data-bs-toggle="modal" data-bs-target=".add-new"
                            class=" btn btn-primary"><i
                            class="bx bx-plus me-1 "></i> Confirm Create User
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