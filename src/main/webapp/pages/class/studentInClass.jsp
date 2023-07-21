<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <title>Add Student Into a Class</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.0/css/boxicons.min.css"
        integrity="sha512-pVCM5+SN2+qwj36KonHToF2p1oIvoU3bsqxphdOIWMYmgr4ZqD3t5DjKvvetKhXGc/ZG5REYTT6ltKfExEei/Q=="
        crossorigin="anonymous" referrerpolicy="no-referrer">
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css"
        integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc=" crossorigin="anonymous">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css"/>

</head>

<body>
<jsp:include page="../../components/header.jsp"/>

<div class="container pt-3">
  <a href="class" class="size-3">
    <div class="arrow"></div>
  </a>
</div>

<div class="container" style="padding-top: 30px">
  <c:if test="${param.state eq 'true'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
      Action completed without issues!
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
  </c:if>

  <form action="DeleteStudentFromClass" method="post">
    <div class="col-md-6 pt-3">
      <h5 class="card-title">
        Students in class ${aClass.getClassName()}
      </h5>
      <h6>
        [Student Quantity: ${aClass.getStudentQuantity()}]
      </h6>
      <h6 class="card-title text-muted pt-5" style="font-style: oblique">
        [Student List]
        <!-- Search -->
        <div class="d-flex align-items-center my-2" style="height: 3rem">
  <span class="search-icon pe-1" style="cursor: pointer">
    <i class="bi bi-search"></i>
  </span>
          <input id="deleteSearchInput" type="text" class="form-control ml-2" placeholder="Search by Name">
        </div>

        <div>
          <label for="deleteSortTable">Sort by:</label>
          <select id="deleteSortTable">
            <option value="deleteName" data-sort-direction="asc">Name (Ascending)</option>
            <option value="deleteName" data-sort-direction="desc">Name (Descending)</option>
            <option value="deleteDob" data-sort-direction="asc">DoB (Ascending)</option>
            <option value="deleteDob" data-sort-direction="desc">DoB (Descending)</option>
          </select>
        </div>
        <!-- Table -->
        <div class="table-responsive">
          <table class="table table-light table-nowrap align-middle table-borderless table-hover">
            <thead>
            <tr>
              <th scope="col" style="width: 50px">
                <input type="checkbox" id="select-all-delete-checkbox">
              </th>
              <th scope="col">Name</th>
              <th scope="col">DoB</th>
              <th scope="col">Gender</th>
            </tr>
            </thead>
            <tbody id="deleteStudentTableBody">
            <c:forEach var="student" items="${listS}">
              <tr>
                <td>
                  <input type="checkbox" name="selectedDeleteStudents" value="${student.getStudentId()}">
                </td>
                <td>${student.getStudentName()}</td>
                <td>${student.getDob()}</td>
                <td>${student.getGender() ? "Male" : "Female"}</td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </h6>
    </div>
    <input name="classId" id="classId" type="hidden" value="${aClass.getClassId()}">
    <input type="hidden" name="selectedDeleteStudentIds">
    <div class="col-md pt-3">
      <div class="d-flex align-items-center justify-content-end gap mb-3">
        <div>
          <button href="class" data-bs-toggle="modal" class="btn btn-primary">
            <i class="bx bx-plus me-1"></i> Cancel Changes
          </button>
        </div>
        <div style="padding: 10px 10px"></div>
        <div>
          <button type="submit" data-bs-toggle="modal" data-bs-target=".add-new" class="btn btn-primary">
            <i class="bx bx-plus me-1"></i> Delete
          </button>
        </div>
      </div>
    </div>
  </form>
  <form action="AddStudentsIntoClass" method="post">
    <div class="row align-items-center">
      <div class="col-md-6">
        <div class="mb-4">
          <h5 class="card-title">
            Add Student Into Class <span class="text-muted">[${aClass.getClassName()}]</span>
          </h5>
        </div>
      </div>
    </div>
    <div class="col-md-6 pt-3">
      <h5 class="card-title">
        Students in pending list
      </h5>
      <h6 class="card-title text-muted pt-5" style="font-style: oblique">
        [Student List]

        <%--        Search--%>
        <div class="d-flex align-items-center my-2" style="height: 3rem">
          <span class="search-icon pe-1" style="cursor: pointer">
            <i class="bi bi-search"></i>
          </span>
          <input id="searchInput" type="text" class="form-control ml-2"
                 placeholder="Search by Name">
        </div>

        <div>
          <label for="sortTable">Sort by:</label>
          <select id="sortTable">
            <option value="name" data-sort-direction="asc">Name (Ascending)</option>
            <option value="name" data-sort-direction="desc">Name (Descending)</option>
            <option value="dob" data-sort-direction="asc">DoB (Ascending)</option>
            <option value="dob" data-sort-direction="desc">DoB (Descending)</option>
          </select>
        </div>

        <!--Table-->
        <div class="table-responsive">
          <table class="table table-light table-nowrap align-middle table-borderless table-hover">
            <thead>
            <tr>
              <th scope="col" style="width: 50px">
                <input type="checkbox" id="select-all-checkbox">
              </th>
              <th scope="col">Name</th>
              <th scope="col">DoB</th>
              <th scope="col">Gender</th>
            </tr>
            </thead>
            <tbody id="studentTableBody">
            <c:forEach var="student" items="${listPending}">
              <tr>
                <td>
                  <input type="checkbox" name="selectedStudents" value="${student.getStudentId()}">
                </td>
                <td>${student.getStudentName()}</td>
                <td>${student.getDob()}</td>
                <td>${student.getGender() ? "Male" : "Female"}</td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </h6>
    </div>
    <input name="id" id="id" type="hidden" value="${aClass.getClassId()}">
    <input type="hidden" name="selectedNewStudentIds">
    <div class="col-md pt-3">
      <div class="d-flex align-items-center justify-content-end gap mb-3">
        <div>
          <button href="class" data-bs-toggle="modal" class="btn btn-primary">
            <i class="bx bx-plus me-1"></i> Cancel Changes
          </button>
        </div>
        <div style="padding: 10px 10px"></div>
        <div>
          <button type="submit" data-bs-toggle="modal" data-bs-target=".add-new" class="btn btn-primary">
            <i class="bx bx-plus me-1"></i> Add
          </button>
        </div>
      </div>
    </div>
  </form>
</div>
<script>
  // Lấy danh sách tất cả các sinh viên từ server-side
  let allStudents = [
    <c:forEach var="student" items="${listPending}">
    {
      id: ${student.getStudentId()},
      name: "${student.getStudentName()}",
      dob: "${student.getDob()}",
      gender: "${student.getGender() ? 'Male' : 'Female'}"
    },
    </c:forEach>
  ];

  // Lấy phần tử input tìm kiếm
  const searchInput = document.getElementById('searchInput');

  // Xử lý sự kiện khi nhập liệu vào input tìm kiếm
  searchInput.addEventListener('input', () => {
    const searchText = searchInput.value.trim().toLowerCase();

    // Lọc danh sách sinh viên dựa trên từ khóa tìm kiếm
    const filteredStudents = allStudents.filter(student => student.name.toLowerCase().includes(searchText));

    // Hiển thị chỉ các hàng chứa sinh viên đã lọc, ẩn các hàng còn lại
    const tableRows = document.querySelectorAll('form[action="AddStudentsIntoClass"] tbody tr');
    tableRows.forEach(row => {
      const studentName = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
      row.style.display = filteredStudents.some(student => student.name.toLowerCase() === studentName) ? 'table-row' : 'none';
    });
  });
</script>

<jsp:include page="../../components/footer.jsp"/>
<script>
  const sortTableSelect = document.getElementById('sortTable');
  const tableBody = document.getElementById('studentTableBody');
  const tableRows = Array.from(tableBody.getElementsByTagName('tr'));

  sortTableSelect.addEventListener('change', () => {
    const sortBy = sortTableSelect.value;
    const sortDirection = sortTableSelect.options[sortTableSelect.selectedIndex].getAttribute('data-sort-direction');

    if (sortBy === 'name') {
      tableRows.sort((a, b) => {
        const cellA = a.querySelector(`td:nth-child(2)`).textContent.trim();
        const cellB = b.querySelector(`td:nth-child(2)`).textContent.trim();
        return sortDirection === 'asc' ? cellA.localeCompare(cellB) : cellB.localeCompare(cellA);
      });
    } else if (sortBy === 'dob') {
      tableRows.sort((a, b) => {
        const cellA = a.querySelector(`td:nth-child(3)`).textContent.trim();
        const cellB = b.querySelector(`td:nth-child(3)`).textContent.trim();
        return sortDirection === 'asc' ? cellA.localeCompare(cellB) : cellB.localeCompare(cellA);
      });
    }

    tableRows.forEach(row => tableBody.appendChild(row));
  });
</script>
<script>
  // Lấy danh sách tất cả các sinh viên từ server-side
  let deleteAllStudents = [
    <c:forEach var="student" items="${listS}">
    {
      id: ${student.getStudentId()},
      name: "${student.getStudentName()}",
      dob: "${student.getDob()}",
      gender: "${student.getGender() ? 'Male' : 'Female'}"
    },
    </c:forEach>
  ];

  // Lấy phần tử input tìm kiếm
  const deleteSearchInput = document.getElementById('deleteSearchInput');

  // Xử lý sự kiện khi nhập liệu vào input tìm kiếm
  deleteSearchInput.addEventListener('input', () => {
    const searchText = deleteSearchInput.value.trim().toLowerCase();

    // Lọc danh sách sinh viên dựa trên từ khóa tìm kiếm
    const deleteFilteredStudents = deleteAllStudents.filter(student => student.name.toLowerCase().includes(searchText));

    // Hiển thị chỉ các hàng chứa sinh viên đã lọc, ẩn các hàng còn lại
    const deleteTableRows = document.querySelectorAll('form[action="DeleteStudentFromClass"] tbody tr');
    deleteTableRows.forEach(row => {
      const studentName = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
      row.style.display = deleteFilteredStudents.some(student => student.name.toLowerCase() === studentName) ? 'table-row' : 'none';
    });
  });
  const deleteSortTableSelect = document.getElementById('deleteSortTable');
  const deleteTableBody = document.getElementById('deleteStudentTableBody');
  const deleteTableRows = Array.from(deleteTableBody.getElementsByTagName('tr'));

  deleteSortTableSelect.addEventListener('change', () => {
    const deleteSortBy = deleteSortTableSelect.value;
    const deleteSortDirection = deleteSortTableSelect.options[deleteSortTableSelect.selectedIndex].getAttribute('data-sort-direction');

    if (deleteSortBy === 'deleteName') {
      deleteTableRows.sort((a, b) => {
        const cellA = a.querySelector(`td:nth-child(2)`).textContent.trim();
        const cellB = b.querySelector(`td:nth-child(2)`).textContent.trim();
        return deleteSortDirection === 'asc' ? cellA.localeCompare(cellB) : cellB.localeCompare(cellA);
      });
    } else if (deleteSortBy === 'deleteDob') {
      deleteTableRows.sort((a, b) => {
        const cellA = a.querySelector(`td:nth-child(3)`).textContent.trim();
        const cellB = b.querySelector(`td:nth-child(3)`).textContent.trim();
        return deleteSortDirection === 'asc' ? cellA.localeCompare(cellB) : cellB.localeCompare(cellA);
      });
    }

    deleteTableRows.forEach(row => deleteTableBody.appendChild(row));
  });
</script>

<script>
  const deleteCheckboxes = document.querySelectorAll('form[action="DeleteStudentFromClass"] input[name="selectedDeleteStudents"]');
  const addCheckboxes = document.querySelectorAll('form[action="AddStudentsIntoClass"] input[name="selectedStudents"]');
  const deleteSelectAllCheckbox = document.getElementById('select-all-delete-checkbox');
  const addSelectAllCheckbox = document.getElementById('select-all-checkbox');

  deleteSelectAllCheckbox.addEventListener('change', () => {
    const isChecked = deleteSelectAllCheckbox.checked;

    deleteCheckboxes.forEach(checkbox => {
      checkbox.checked = isChecked;
    });
  });

  addSelectAllCheckbox.addEventListener('change', () => {
    const isChecked = addSelectAllCheckbox.checked;

    addCheckboxes.forEach(checkbox => {
      checkbox.checked = isChecked;
    });
  });

  const deleteForm = document.querySelector('form[action="DeleteStudentFromClass"]');

  deleteForm.addEventListener('submit', (event) => {
    event.preventDefault();

    const selectedDeleteStudentIds = Array.from(deleteCheckboxes)
            .filter(checkbox => checkbox.checked)
            .map(checkbox => checkbox.value);

    const selectedDeleteStudentIdsInput = deleteForm.querySelector('input[name="selectedDeleteStudentIds"]');
    selectedDeleteStudentIdsInput.value = selectedDeleteStudentIds.join(',');

    deleteForm.submit();
  });

  const addForm = document.querySelector('form[action="AddStudentsIntoClass"]');

  addForm.addEventListener('submit', (event) => {
    event.preventDefault();

    const selectedStudentIds = Array.from(addCheckboxes)
            .filter(checkbox => checkbox.checked)
            .map(checkbox => checkbox.value);

    const selectedStudentIdsInput = addForm.querySelector('input[name="selectedNewStudentIds"]');
    selectedStudentIdsInput.value = selectedStudentIds.join(',');

    addForm.submit();
  });


</script>

</body>

</html>
