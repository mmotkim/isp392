<%--
  Created by IntelliJ IDEA.
  User: Le Vu
  Date: 19/07/2023
  Time: 07:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>Edit Ate Status</title>
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
  <a href="ateStatus?classId=${classId}" class="size-3">
    <div class="arrow" style=""></div>
  </a>
</div>



<div class="container" style="margin-top: 40px">

  <form action="EditAteStatus" method="post">

    <div class="row align-items-center">
      <div class="col-md-6">
        <div class="mb-4">
          <h5 class="card-title text-primary">
            Edit Ate Status Details.
          </h5>
        </div>
      </div>
    </div>


    <div class="col">
      <div class="col-lg-16">
        <div class="">
          <input name="stuId" id="stuId" type="hidden" value="${a.getStudentId()}">
          <input name="mealId" id="mealId" type="hidden" value="${a.getMealId()}">

          <div class="form-row input-group mb-3 d-flex">
            <label class="input-group-text" for="status">Select Student Status:</label>
            <select name="status" id="status" class="form-select" aria-label="Student's Ate Status" required>
              <option value="" ${a.getStatus() == null ? 'selected' : ''}>Select Status</option>0
              <option value="finished" ${a.getStatus().equals("finished") ? 'selected' : ''}>Finished</option>
              <option value="more-than-half" ${a.getStatus().equals("more-than-half") ? 'selected' : ''}>More than half</option>
              <option value="half" ${a.getStatus().equals("half") ? 'selected' : ''}>Half</option>
              <option value="less" ${a.getStatus().equals("less") ? 'selected' : ''}>Less</option>
              <option value="did-not-eat" ${a.getStatus().equals("did-not-eat") ? 'selected' : ''}>Did not eat</option>
              <!-- Add more options as needed -->
            </select>
            <span id="name-error" class="error-message"></span>
          </div>

          <div class="form-row input-group mb-3">
            <label class="input-group-text" for="reason">Enter Reason</label>
            <input name="reason" id="reason" type="text" class="form-control" placeholder="Reason" aria-label="Reason"
                   aria-describedby="basic-addon2" value="${a.getReason()}">
          </div>
          <div class="form-row input-group mb-3">
            <label class="input-group-text" for="date">Date</label>
            <input name="date" id="date" type="date" class="form-control" placeholder="Date" aria-label="Date"
                   aria-describedby="basic-addon2" value="${meal.getDate()}" readonly>
          </div>

        </div>
      </div>
    </div>

    <!-- Confirm Button -->
    <div class="col-md pt-3">
      <div class="d-flex  align-items-center justify-content-end gap mb-3">
        <div>
          <button type="submit" data-bs-toggle="modal" data-bs-target=".add-new" class=" btn btn-primary px-4 py-2"><i
                  class="bi bi-check-lg me-1 "></i> Confirm Edit Ate Status</button>
        </div>
      </div>
    </div>


  </form>


</div>
<jsp:include page="../../components/footer.jsp"/>

<style>
  .table-container{
    max-height: 200px;
    overflow-y: auto;
  }
</style>
</body>

</html>
