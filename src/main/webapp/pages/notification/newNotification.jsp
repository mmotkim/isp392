<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Adding a new Notification</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.0/css/boxicons.min.css" integrity="sha512-pVCM5+SN2+qwj36KonHToF2p1oIvoU3bsqxphdOIWMYmgr4ZqD3t5DjKvvetKhXGc/ZG5REYTT6ltKfExEei/Q==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css" integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc=" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css" />
  </head>
  <style>
    .bottom-left-alert {
      position: fixed;
      bottom: 10px;
      left: 10px;
    }

    .bottom-left-alert .alert {
      position: relative;
      left: 0;
    }
  </style>

  <body class="bg-light">
    <jsp:include page="../../components/header.jsp" />

    <!-- Back -->
    <div class="container pt-3">
      <a href="notification" class="size-3">
        <div class="arrow"></div>
      </a>
    </div>

    <div class="bottom-left-alert">
      <%--Alert--%>
      <div id="dateErrorAlert" class="alert alert-dismissible alert-danger fade" role="alert">
        The End Date must be later than the Start Date. Please select valid dates.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    </div>

    <!-- Main body -->
    <div class="container" style="margin-top: 40px">
      <div class="row align-items-center">
        <div class="col-md-6">
          <div class="mb-4">
            <h5 class="card-title">
              <!-- Tong so luong Notification -->
              1. Add a new Notification.
            </h5>
          </div>
        </div>
      </div>
      <form action="NewNotification" method="post">
        <div class="row py-2">
          <div class="col-lg-6">
            <div class="form-group">
              <label for="title">Enter Notification Title:</label>
              <input maxlength="100" name="title" id="title" type="text" value="${n.getTitle()}" class="form-control" placeholder="Notification Name" aria-label="Your Notification Name" aria-describedby="basic-addon2" required />
            </div>
          </div>
          <div class="col-lg-6">
            <div class="form-group">
              <label for="description">Enter Notification Description:</label>
              <input maxlength="250" name="description" id="description" type="text" value="${n.getDescription()}" class="form-control" placeholder="Notification Description" aria-label="Your Notification Description" aria-describedby="basic-addon2" />
            </div>
          </div>
        </div>
        <div class="row py-2">
          <div class="col-lg-6">
            <div class="form-group">
              <label for="process">Enter Start Date:</label>
              <input name="process" id="process" type="date" value="${n.getProcessingDate()}" onchange="TDate()" class="form-control" placeholder="Notification Start Date" aria-label="Your Notification Start Date" aria-describedby="basic-addon2" required />
            </div>
          </div>
          <div class="col-lg-6">
            <div class="form-group">
              <label for="end">Enter End Date:</label>
              <input name="end" id="end" type="date" value="${n.getEndDate()}" onchange="TDate()" class="form-control" placeholder="Notification End Date" aria-label="Your Notification End Date" aria-describedby="basic-addon2" required />
            </div>
          </div>
        </div>

        <div class="row align-items-center py-3">
          <div class="col-md-6">
            <div class="mb-4">
              <h5 class="card-title">
                <!-- Tong so luong Notification -->
                2. Assign the notification to an activity (one only),... or leave it empty for now.
              </h5>
            </div>
          </div>
        </div>
        <div>
          <div class="search-box pb-3">
            <h5 class="Title pb-2">Activity list <span class="text-muted">(${count2})</span></h5>
            <input type="text" id="search-input" class="form-control" placeholder="Search by Activity Name or Activity Type" />
          </div>
          <table class="table table-hover">
            <thead>
              <tr>
                <th class="col-1">Select</th>
                <th class="col-auto">ID</th>
                <th class="col-auto">Name</th>
                <th class="col-auto">Description</th>
                <th class="col-auto">Type</th>
              </tr>
            </thead>
            <tbody id="records-list">
              <c:forEach var="t" items="${list2}">
                <tr>
                  <td class="select-cell">
                    <div class="form-check"><input type="radio" class="form-check-input" ${(n.getActivityId() == t.getActivityId()) ? 'checked' : ''}></div>
                  </td>
                  <td>${t.getActivityId()}</td>
                  <td>${t.getName()}</td>
                  <td>${t.getDescription()}</td>
                  <td>${t.getType()}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
        <%-- Input for activity--%>
        <input type="hidden" id="activityId" name="activityId" />

        <div class="col-md pt-3">
          <div class="d-flex align-items-center justify-content-end gap mb-3">
            <div>
              <!-- Them Notification -->
              <button type="submit" data-bs-toggle="modal" data-bs-target=".add-new" class="btn btn-primary"><i class="bx bx-plus me-1"></i> Confirm Create Notification</button>
            </div>
          </div>
        </div>
      </form>
    </div>
    <jsp:include page="../../components/footer.jsp" />

    <script>
      document.addEventListener("DOMContentLoaded", function () {
        const searchInput = document.getElementById("search-input");
        const recordsList = document.getElementById("records-list").getElementsByTagName("tr");
        let selectedRecord = null;

        searchInput.addEventListener("input", function () {
          const searchTerm = searchInput.value.trim().toLowerCase();
          for (let i = 0; i < recordsList.length; i++) {
            const name = recordsList[i].getElementsByTagName("td")[2].textContent.toLowerCase();
            const type = recordsList[i].getElementsByTagName("td")[4].textContent.toLowerCase();
            const shouldDisplay = name.includes(searchTerm) || type.includes(searchTerm);
            recordsList[i].style.display = shouldDisplay ? "table-row" : "none";
          }
        });

        const selectRadios = document.querySelectorAll('.select-cell input[type="radio"]');
        for (let i = 0; i < selectRadios.length; i++) {
          selectRadios[i].addEventListener("click", function () {
            const record = this.closest("tr");
            selectedRecord = record;
            deselectOtherRadios(record);
            setActivityId(selectedRecord);
            console.log(selectedRecord);
          });
        }

        const selectCells = document.getElementsByClassName("select-cell");
        for (let i = 0; i < selectCells.length; i++) {
          selectCells[i].addEventListener("click", function () {
            const radio = this.querySelector('input[type="radio"]');
            radio.checked = true;
            const record = this.closest("tr");
            selectedRecord = record;
            deselectOtherRadios(record);
            setActivityId(selectedRecord);
            console.log(selectedRecord);
          });
        }

        function deselectOtherRadios(currentRecord) {
          for (let i = 0; i < selectRadios.length; i++) {
            const record = selectRadios[i].closest("tr");
            if (record !== currentRecord) {
              selectRadios[i].checked = false;
            }
          }
        }
      });

      function setActivityId(selectedRecord) {
        if (selectedRecord) {
          document.getElementById("activityId").value = selectedRecord.getElementsByTagName("td")[1].textContent;
        }
      }

      function TDate() {
        var start = document.getElementById("process").value;
        var end = document.getElementById("end").value;
        const alertElement = document.getElementById("dateErrorAlert");

        if (new Date(start).getTime() > new Date(end).getTime()) {
          alertElement.classList.add("show");
          if (document.activeElement === document.getElementById("end")) {
            document.getElementById("end").value = "";
          } else {
            document.getElementById("process").value = "";
          }
          return false;
        }
        alertElement.classList.remove("show");
        return true;
      }
    </script>
    <script src="../../assets/js/bootstrap.bundle.js"></script>
  </body>
</html>
