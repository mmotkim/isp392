<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>Adding a new Activity</title>
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


    <div class="col">
      <div class="col-lg-16">
        <div class="">
          <!-- Ten lop -->
          <div class="form-row input-group mb-3 d-flex">

            <label class="input-group-text" for="name">Enter Activity Name:</label>
            <input name="name" id="name" type="text" class="form-control" placeholder="Activity Name" aria-label="Your Activity Name"
                   aria-describedby="basic-addon2" required>
          </div>
          <div class="form-row input-group mb-3">
            <label class="input-group-text" for="description">Enter Activity Description:</label>
            <input name="description" id="description" type="text" class="form-control" placeholder="Activity Description" aria-label="Your Activity Description"
                   aria-describedby="basic-addon2">
          </div>

          <div class="input-group mb-3">
            <label class="input-group-text" for="type">Choose Activity Type:</label>
            <select name="type" id="type" type="text" class="form-select" placeholder="Activity Description" aria-label="Choose Activity Type"
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
    <div >
      <div class="search-box mt-3 pt-3">
        <input type="text" id="search-input" class="form-control" placeholder="Search by Name">
      </div>
      <table class="table table-hover">
        <thead>
        <tr>
          <th class="col-auto">Select</th>
          <th class="col-auto">Name</th>
          <th class="col-auto">Description</th>
        </tr>
        </thead>
        <tbody id="records-list">
        <tr>
          <td class="select-cell">
            <div class="form-check">
              <input type="checkbox" class="form-check-input">
            </div>
          </td>
          <td>Option 1</td>
          <td>Description 1</td>
        </tr>
        </tbody>
      </table>
    </div>

    <div class="col-md pt-3">
      <div class="d-flex  align-items-center justify-content-end gap mb-3">
        <div>
          <!-- Them Activity -->
          <button type="submit" data-bs-toggle="modal" data-bs-target=".add-new" class=" btn btn-primary"><i
                  class="bx bx-plus me-1 "></i> Confirm Create Activity</button>
        </div>
      </div>
    </div>


  </form>


</div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('search-input');
    const recordsList = document.getElementById('records-list').getElementsByTagName('tr');
    const selectedRecords = new Set();

    searchInput.addEventListener('input', function() {
      const searchTerm = searchInput.value.trim().toLowerCase();
      for (let i = 0; i < recordsList.length; i++) {
        const name = recordsList[i].getElementsByTagName('td')[1].textContent.toLowerCase();
        recordsList[i].style.display = name.includes(searchTerm) ? 'table-row' : 'none';
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
</body>

</html>