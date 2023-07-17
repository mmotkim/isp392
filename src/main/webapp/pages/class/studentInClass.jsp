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
            <tbody>
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
            <tbody>
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
<jsp:include page="../../components/footer.jsp"/>
<script>
  // Lấy tất cả các checkbox trong form DeleteStudentFromClass
  const deleteCheckboxes = document.querySelectorAll('form[action="DeleteStudentFromClass"] input[name="selectedDeleteStudents"]');

  // Lấy tất cả các checkbox trong form AddStudentsIntoClass
  const addCheckboxes = document.querySelectorAll('form[action="AddStudentsIntoClass"] input[name="selectedStudents"]');

  // Lấy checkbox ở đầu trong form DeleteStudentFromClass
  const deleteSelectAllCheckbox = document.getElementById('select-all-delete-checkbox');

  // Lấy checkbox ở đầu trong form AddStudentIntoClass
  const addSelectAllCheckbox = document.getElementById('select-all-checkbox');

  // Thiết lập sự kiện thay đổi cho checkbox ở đầu trong form DeleteStudentFromClass
  deleteSelectAllCheckbox.addEventListener('change', () => {
    const isChecked = deleteSelectAllCheckbox.checked;

    // Đặt trạng thái tích cho tất cả các checkbox trong form DeleteStudentFromClass
    deleteCheckboxes.forEach(checkbox => {
      checkbox.checked = isChecked;
    });
  });

  // Thiết lập sự kiện thay đổi cho checkbox ở đầu trong form AddStudentIntoClass
  addSelectAllCheckbox.addEventListener('change', () => {
    const isChecked = addSelectAllCheckbox.checked;

    // Đặt trạng thái tích cho tất cả các checkbox trong form AddStudentIntoClass
    addCheckboxes.forEach(checkbox => {
      checkbox.checked = isChecked;
    });
  });

  // Lấy form DeleteStudentFromClass
  const deleteForm = document.querySelector('form[action="DeleteStudentFromClass"]');

  // Xử lý sự kiện nút Delete được nhấn trong form DeleteStudentFromClass
  deleteForm.addEventListener('submit', (event) => {
    event.preventDefault();

    // Lấy danh sách sinh viên được chọn trong form DeleteStudentFromClass
    const selectedDeleteStudentIds = Array.from(deleteCheckboxes)
            .filter(checkbox => checkbox.checked)
            .map(checkbox => checkbox.value);

    // Gán danh sách sinh viên được chọn vào input hidden trong form DeleteStudentFromClass
    const selectedDeleteStudentIdsInput = deleteForm.querySelector('input[name="selectedDeleteStudentIds"]');
    selectedDeleteStudentIdsInput.value = selectedDeleteStudentIds.join(',');

    // Gửi form DeleteStudentFromClass
    deleteForm.submit();
  });

  // Lấy form AddStudentIntoClass
  const addForm = document.querySelector('form[action="AddStudentsIntoClass"]');

  // Xử lý sự kiện nút Add được nhấn trong form AddStudentsIntoClass
  addForm.addEventListener('submit', (event) => {
    event.preventDefault();

    // Lấy danh sách sinh viên được chọn trong form AddStudentsIntoClass
    const selectedStudentIds = Array.from(addCheckboxes)
            .filter(checkbox => checkbox.checked)
            .map(checkbox => checkbox.value);

    // Gán danh sách sinh viên được chọn vào input hidden trong form AddStudentsIntoClass
    const selectedStudentIdsInput = addForm.querySelector('input[name="selectedNewStudentIds"]');
    selectedStudentIdsInput.value = selectedStudentIds.join(',');

    // Gửi form AddStudentsIntoClass
    addForm.submit();
  });
</script>

</body>

</html>
