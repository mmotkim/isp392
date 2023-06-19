<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Adding a new Activity</title>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.0/css/boxicons.min.css"
      integrity="sha512-pVCM5+SN2+qwj36KonHToF2p1oIvoU3bsqxphdOIWMYmgr4ZqD3t5DjKvvetKhXGc/ZG5REYTT6ltKfExEei/Q=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css" integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc=" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css" />
  </head>

  <body class="bg-light">
    <jsp:include page="../../components/header.jsp" />

    <!-- Back -->
    <div class="container pt-3">
      <a href="notification" class="size-3">
        <div class="arrow"></div>
      </a>
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
        <div class="col">
          <div class="col-lg-16">
            <div class="">
              <!-- Ten lop -->
              <div class="form-row input-group mb-3 d-flex">
                <label class="input-group-text" for="name">Enter Notification Title:</label>
                <input name="title" id="name" type="text" class="form-control" placeholder="Notification Name" aria-label="Your Notification Name" aria-describedby="basic-addon2" required />
              </div>
              <div class="form-row input-group mb-3">
                <label class="input-group-text" for="description">Enter Notification Description:</label>
                <input name="description" id="description" type="text" class="form-control" placeholder="Notification Description" aria-label="Your Notification Description" aria-describedby="basic-addon2" />
              </div>
              <div class="form-row input-group mb-3 d-flex">
                <label class="input-group-text" for="process">Enter Start Date:</label>
                <input name="process" id="process" type="date" onchange="TDate()" class="form-control" placeholder="Notification Start Date" aria-label="Your Notification Start Date" aria-describedby="basic-addon2" required />
              </div>
              <div class="form-row input-group mb-3 d-flex">
                <label class="input-group-text" for="end">Enter End Date:</label>
                <input name="end" id="end" type="date" onchange="TDate()" class="form-control" placeholder="Notification End Date" aria-label="Your Notification End Date" aria-describedby="basic-addon2" required />
              </div>

              <input name="created" id="created" type="hidden" >
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
          <div class="search-box mt-3 pt-3">
            <input type="text" id="search-input" class="form-control" placeholder="Search by Name" />
          </div>
          <table class="table table-hover">
            <thead>
            <tr>
              <th class="col-1">Select</th>
              <th class="col-auto">Name</th>
              <th class="col-auto">Description</th>
              <th class="col-auto">Type</th>
            </tr>
            </thead>
            <tbody id="records-list">
            <tr>
              <td class="select-cell col-auto">
                <div class="form-check">
                  <input type="radio" class="form-check-input" />
                </div>
              </td>
              <td>Option 1</td>
              <td>Description 1</td>
              <td>Type 1</td>
            </tr>
            <tr>
              <td class="select-cell">
                <div class="form-check">
                  <input type="radio" class="form-check-input" />
                </div>
              </td>
              <td>Option 1</td>
              <td>Description 1</td>
              <td>Type 1</td>
            </tr>
            </tbody>
          </table>
        </div>

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

    <script>
      document.getElementById("created").valueAsDate = new Date();

      document.addEventListener('DOMContentLoaded', function() {
        const searchInput = document.getElementById('search-input');
        const recordsList = document.getElementById('records-list').getElementsByTagName('tr');
        let selectedRecord = null;

        searchInput.addEventListener('input', function() {
          const searchTerm = searchInput.value.trim().toLowerCase();
          for (let i = 0; i < recordsList.length; i++) {
            const name = recordsList[i].getElementsByTagName('td')[1].textContent.toLowerCase();
            const description = recordsList[i].getElementsByTagName('td')[2].textContent.toLowerCase();
            const shouldDisplay = name.includes(searchTerm) || description.includes(searchTerm);
            recordsList[i].style.display = shouldDisplay ? 'table-row' : 'none';
          }
        });

        const selectRadios = document.querySelectorAll('.select-cell input[type="radio"]');
        for (let i = 0; i < selectRadios.length; i++) {
          selectRadios[i].addEventListener('click', function() {
            const record = this.closest('tr');
            selectedRecord = record;
            deselectOtherRadios(record);
          });
        }

        const selectCells = document.getElementsByClassName('select-cell');
        for (let i = 0; i < selectCells.length; i++) {
          selectCells[i].addEventListener('click', function() {
            const radio = this.querySelector('input[type="radio"]');
            radio.checked = true;
            const record = this.closest('tr');
            selectedRecord = record;
            deselectOtherRadios(record);
          });
        }

        function deselectOtherRadios(currentRecord) {
          for (let i = 0; i < selectRadios.length; i++) {
            const record = selectRadios[i].closest('tr');
            if (record !== currentRecord) {
              selectRadios[i].checked = false;
            }
          }
        }
      });

      function TDate(){
        var start = document.getElementById("process").value;
        var end = document.getElementById("end").value;

        if (new Date(start).getTime() > new Date(end).getTime()){
          alert("Notification End date must be later than start date");
          return false;
        }
        return true;
      }
    </script>
  </body>
</html>
