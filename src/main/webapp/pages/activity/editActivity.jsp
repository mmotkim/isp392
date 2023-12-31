<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>Edit Activity</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.0/css/boxicons.min.css"
        integrity="sha512-pVCM5+SN2+qwj36KonHToF2p1oIvoU3bsqxphdOIWMYmgr4ZqD3t5DjKvvetKhXGc/ZG5REYTT6ltKfExEei/Q=="
        crossorigin="anonymous" referrerpolicy="no-referrer">
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css"
        integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc=" crossorigin="anonymous">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css">
</head>

<jsp:include page="../../components/header.jsp"/>

<body class="bg-light">
<div class="container pt-3">
  <a href="activity" class="size-3">
    <div class="arrow" style=""></div>
  </a>
</div>



<div class="container" style="margin-top: 40px">

  <form action="EditActivity" method="post">

    <div class="row align-items-center">
      <div class="col-md-6">
        <div class="mb-4">
          <h5 class="card-title text-primary">
            <!-- Tong so luong Activity -->
            1. Edit Activity Details. <span class="text-muted">(Activity ID: ${a.getActivityId()})</span>
          </h5>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-md-6">
        <div class="form-group mb-3">
          <label class="" for="name">Enter Activity Name:</label>
          <input name="name" id="name" type="text" class="form-control" placeholder="Activity Name"
                 aria-label="Your Activity Name"
                 aria-describedby="basic-addon2"
                 value = "${a.getName()}" required>
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group mb-3">
          <label class="" for="type">Choose Activity Type:</label>
          <select name="type" id="type" type="text" class="form-select"
                  aria-label="Choose Activity Type"
                  aria-describedby="basic-addon2" maxlength="100" required>

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
                 aria-describedby="basic-addon2"
                 maxlength="1000"
                 value="${a.getDescription()}">
        </div>
      </div>
    </div>


    <div class="row align-items-center py-3">
      <div class="col-md-6">
        <div class="mb-4">
          <h5 class="card-title text-primary">
            <!-- Tong so luong Activity -->
            2. Reassign the activity to classes,... or leave it for now.
          </h5>
        </div>
      </div>
    </div>
    <div>
      <div class="search-box pb-3">
        <h5 class="Title pb-2">
          Class list
        </h5>
        <input type="text" id="search-input" class="form-control" placeholder="Search by Class Name or Teachers Name">
      </div>

      <div class="table-container">
        <table class="table table-hover mt-2">
          <thead>
          <tr>
            <th class="col-auto">Select</th>
            <th class="col-auto">Name</th>
            <th class="col-auto">Level</th>
            <th class="col-auto">Student Quantity</th>
            <th class="col-auto">Teachers in charge</th>
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
    </div>

    <input value="${a.getActivityId()}" name="activityId" type="hidden">

    <!-- Confirm Button -->
    <div class="col-md pt-3">
      <div class="d-flex  align-items-center justify-content-end gap mb-3">
        <div>
          <!-- Edit Activity -->
          <button type="submit" data-bs-toggle="modal" data-bs-target=".add-new" class=" btn btn-primary px-4 py-2"><i
                  class="bi bi-check-lg me-1 "></i> Confirm Edit Activity</button>
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

  var selectedValue = "${a.getType()}"; // Replace with your actual received value

  var selectElement = document.getElementById("type");
  selectElement.value = selectedValue;
</script>

<style>
  .table-container{
    max-height: 200px;
    overflow-y: auto;
  }
</style>

<script src="../../assets/js/bootstrap.bundle.js"></script>
</body>

</html>