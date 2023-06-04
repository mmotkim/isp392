<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>Edit activity</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.0/css/boxicons.min.css"
    integrity="sha512-pVCM5+SN2+qwj36KonHToF2p1oIvoU3bsqxphdOIWMYmgr4ZqD3t5DjKvvetKhXGc/ZG5REYTT6ltKfExEei/Q=="
    crossorigin="anonymous" referrerpolicy="no-referrer">
  <link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css"
    integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc=" crossorigin="anonymous">
  <link rel="stylesheet" href="css/bootstrap.css">
</head>

<body>
  <div class="container" style="padding-top: 30px">
    <div class="row align-items-center">
      <div class="col-md-6">
        <div class="mb-4">
          <h5 class="card-title">
            <!-- ID Class -->
            Edit activity <span class="text-muted">(ID: )</span>
          </h5>

        </div>
      </div>
      
    </div>
    <div class="col">
      <div class="col-lg-16">
        <div class="">
          <!-- Ten lop -->
          <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="Activity Name" aria-label="Activity Name"
              aria-describedby="basic-addon2">
          </div>

          


        </div>
      </div>
    </div>
    

    <div class="col-md pt-3">
      <div class="d-flex  align-items-center justify-content-end gap mb-3">
        
        <div>
          <!-- Them activity -->
          <a href="#" data-bs-toggle="modal" data-bs-target=".add-new" class=" btn btn-primary"><i
              class="bx bx-plus me-1 "></i> Confirm Changes</a>
        </div>
      </div>
    </div>

    
   
  </div>
</body>

</html>