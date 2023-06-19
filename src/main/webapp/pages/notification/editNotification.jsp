<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>Edit Notification</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.0/css/boxicons.min.css"
        integrity="sha512-pVCM5+SN2+qwj36KonHToF2p1oIvoU3bsqxphdOIWMYmgr4ZqD3t5DjKvvetKhXGc/ZG5REYTT6ltKfExEei/Q=="
        crossorigin="anonymous" referrerpolicy="no-referrer">
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css"
        integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc=" crossorigin="anonymous">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css">
</head>
<jsp:include page="../../components/header.jsp" />

<body class="bg-light">
<div class="container pt-3">
  <a href="notification" class="size-3">
    <div class="arrow" style=""></div>
  </a>
</div>



<div class="container" style="margin-top: 40px">

  <form action="EditNotification" method="post">

    <div class="row align-items-center">
      <div class="col-md-6">
        <div class="mb-4">
          <h5 class="card-title text-primary">
            <!-- Tong so luong Notification -->
            1. Edit Notification Details. <span class="text-muted">(Notification ID: )</span>
          </h5>
        </div>
      </div>
    </div>


    <div class="col">
      <div class="col-lg-16">
        <div class="">
          <!-- Ten lop -->
          <div class="form-row input-group mb-3 d-flex">
            <label class="input-group-text" for="title">Enter Notification Title:</label>
            <input name="title" id="title" type="text" value="${n.getTitle()}" class="form-control" placeholder="Notification Name" aria-label="Your Notification Name" aria-describedby="basic-addon2" required />
          </div>
          <div class="form-row input-group mb-3">
            <label class="input-group-text" for="description">Enter Notification Description:</label>
            <input name="description" id="description" type="text" value="${n.getDescription()}" class="form-control" placeholder="Notification Description" aria-label="Your Notification Description" aria-describedby="basic-addon2" />
          </div>
          <div class="form-row input-group mb-3 d-flex">
            <label class="input-group-text" for="process">Enter Start Date:</label>
            <input name="process" id="process" type="date" value="${n.getProcessingDate()}" onchange="TDate()" class="form-control" placeholder="Notification Start Date" aria-label="Your Notification Start Date" aria-describedby="basic-addon2" required />
          </div>
          <div class="form-row input-group mb-3 d-flex">
            <label class="input-group-text" for="end">Enter End Date:</label>
            <input name="end" id="end" type="date" value="${n.getEndDate()}" onchange="TDate()" class="form-control" placeholder="Notification End Date" aria-label="Your Notification End Date" aria-describedby="basic-addon2" required />
          </div>


        </div>
      </div>
    </div>

    <div class="row align-items-center py-3">
      <div class="col-md-6">
        <div class="mb-4">
          <h5 class="card-title text-primary">
            <!-- Tong so luong Notification -->
            2. Reassign the notification to an activity,... or leave it for now.
          </h5>
        </div>
      </div>
    </div>
    <div>
      <div class="search-box pb-3">
        <h5 class="Title pb-2">
          Activity list <span class="text-muted">(${count2})</span>
        </h5>
        <input type="text" id="search-input" class="form-control" placeholder="Search by Activity Name or Activity Type">
      </div>

      <div class="table-container">
        <table class="table table-hover mt-2">
          <thead>
          <tr>
            <th class="col-auto">Select</th>
            <th class="col-auto">Name</th>
            <th class="col-auto">Description</th>
            <th class="col-auto">Type</th>
          </tr>
          </thead>
          <tbody id="records-list">
          <c:forEach var="t" items="${list2}">
          <tr>
            <td class="select-cell">
              <div class="form-check">
                <input type="checkbox" class="form-check-input" ${(n.getActivityId() == t.getActivityId()) ? 'checked' : ''}>
              </div>
            </td>
            <td>${t.getActivityId()}</td>
            <td>${t.getDescription()}</td>
            <td>${t.getType()}</td>
          </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </div>

    <input value="${n.getNotificationId()}" name="notificationId" type="hidden">

    <!-- Confirm Button -->
    <div class="col-md pt-3">
      <div class="d-flex  align-items-center justify-content-end gap mb-3">
        <div>
          <!-- Edit Notification -->
          <button type="submit" data-bs-toggle="modal" data-bs-target=".add-new" class=" btn btn-primary px-4 py-2"><i
                  class="bi bi-check-lg me-1 "></i> Confirm Edit Notification</button>
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