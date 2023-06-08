<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.0/css/boxicons.min.css"
          integrity="sha512-pVCM5+SN2+qwj36KonHToF2p1oIvoU3bsqxphdOIWMYmgr4ZqD3t5DjKvvetKhXGc/ZG5REYTT6ltKfExEei/Q=="
          crossorigin="anonymous" referrerpolicy="no-referrer">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css"
          integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc=" crossorigin="anonymous">
    <link rel="stylesheet" href="css/bootstrap.css">
</head>
<body>

<jsp:include page="components/header.jsp"/>

<div class="container" style="padding-top: 30px">
    <div class="row align-items-center">
        <div class="col-md-6">
            <div class="mb-4">
                <h5 class="card-title">
                    <!-- Tong so luong Activity -->
                    Activity List <span class="text-muted fw-normal ms-2">(2)</span>
                </h5>
            </div>
        </div>
        <div class="col-md-6">
            <div
                    class="d-flex flex-wrap align-items-center justify-content-end gap-2 mb-3"
            >
                <div>
                    <ul class="nav nav-pills">
                        <!--    <li class="nav-item">
                      <a
                              aria-current="page"
                              href="#"
                              class="router-link-active router-link-exact-active nav-link active"
                              data-bs-toggle="tooltip"
                              data-bs-placement="top"
                              title=""
                              data-bs-original-title="List"
                              aria-label="List"
                      >
                        <i class="bx bx-list-ul"></i>
                      </a>
                    </li>
                    <li class="nav-item">
                      <a href="#" class="nav-link" data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Grid" aria-label="Grid"><i class="bx bx-grid-alt"></i></a>
                    </li> -->
                    </ul>
                </div>
                <div>
                    <!-- Them Activity -->
                    <a
                            href="NewActivity"

                            class="btn btn-primary"
                    ><i class="bx bx-plus me-1"></i> Add New</a
                    >
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-16">
            <div class="">
                <div class="table-responsive">
                    <table
                            class="table table-nowrap align-middle table-borderless"
                    >
                        <thead>
                        <tr>
                            <th scope="col" style="width: 50px">ID</th>
                            <th scope="col">Name</th>
                            <th scope="col">Description</th>
                            <th scope="col">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="t" items="${list}">
                            <tr>
                                <!-- ID -->
                                <td>${t.getActivityId()}</td>
                                <!-- Name -->
                                <td>${t.getName()}</td>
                                <!-- Description -->
                                <td>${t.getDescription()}</td>

                                <td class="justify-content-between ml-2">
                                    <ul class="list-inline mb-0">
                                        <li class="list-inline-item">
                                            <!-- Edit -->
                                            <a
                                                    href="javascript:void(0);"
                                                    data-bs-toggle="tooltip"
                                                    data-bs-placement="top"
                                                    title="Edit"
                                                    class="px-4 text-primary"
                                            ><i class="bx bx-pencil font-size-18"></i
                                            ></a>
                                        </li>
                                        <li class="list-inline-item">

                                            <a
                                                    href="#"
                                                    data-href="./DeleteActivity?id=${t.getActivityId()}"
                                                data-bs-toggle="modal"
                                                data-bs-target="#confirm-delete"
                                                title="Delete"
                                                class="px-4 text-danger"
                                                ><i class="bx bx-trash-alt font-size-18"></i
                                                ></a>

                                        </li>
                                        <!-- Other actions -->
                                        <li class=" list-inline-item dropdown ">
                                            <a
                                                    class="text-muted dropdown-toggle font-size-18 "
                                                    href="#"
                                                    role="button"
                                                    data-bs-toggle="dropdown"
                                                    aria-haspopup="true"
                                            ><i class="bx bx-dots-vertical-rounded"></i
                                            ></a>
                                            <div class="dropdown-menu dropdown-menu-end">
                                                <a class="dropdown-item" href="#">Action</a
                                                ><a class="dropdown-item" href="#">Another action</a
                                            ><a class="dropdown-item" href="#"
                                            >Something else here</a
                                            >
                                            </div>
                                        </li>
                                    </ul>
                                </td>
                            </tr>

                            <%--                            modal--%>
                            <div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog"
                                 aria-labelledby="exampleModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            gay
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                Close
                                            </button>
                                            <button type="button" class="btn btn-primary" href="./DeleteActivity?id=${t.getActivityId()}">Save changes</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="row g-0 align-items-center pb-4">
        <div class="col-sm-6">
            <div><p class="mb-sm-0">Showing 1 to 10 of 57 entries</p></div>
        </div>
        <div class="col-sm-6">
            <div class="float-sm-end">
                <ul class="pagination mb-sm-0">
                    <li class="page-item disabled">
                        <a href="#" class="page-link"
                        ><i class="mdi mdi-chevron-left"></i
                        ></a>
                    </li>
                    <li class="page-item active">
                        <a href="#" class="page-link">1</a>
                    </li>
                    <li class="page-item"><a href="#" class="page-link">2</a></li>
                    <li class="page-item"><a href="#" class="page-link">3</a></li>
                    <li class="page-item"><a href="#" class="page-link">4</a></li>
                    <li class="page-item"><a href="#" class="page-link">5</a></li>
                    <li class="page-item">
                        <a href="#" class="page-link"
                        ><i class="mdi mdi-chevron-right"></i
                        ></a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<script>
    // $('#confirm-delete').on('show.bs.modal', function(e) {
    //     $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
    // });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>
