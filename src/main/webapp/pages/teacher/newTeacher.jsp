<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Adding a new Teacher</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.0/css/boxicons.min.css"
          integrity="sha512-pVCM5+SN2+qwj36KonHToF2p1oIvoU3bsqxphdOIWMYmgr4ZqD3t5DjKvvetKhXGc/ZG5REYTT6ltKfExEei/Q=="
          crossorigin="anonymous" referrerpolicy="no-referrer">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css"
          integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc=" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css" />
</head>

<body class="bg-light">
<jsp:include page="../../components/header.jsp"/>

<%--Back--%>
<div class="container pt-3">
    <a href="teacher" class="size-3">
        <div class="arrow" style=""></div>
    </a>
</div>

<%--Main Body--%>
<div class="container" style="margin-top: 40px">
    <div class="row align-items-center">
        <div class="col-md-6">
            <div class="mb-4">
                <h5 class="card-title">
                    Add a new Teacher.
                </h5>
            </div>
        </div>
    </div>
    <form action="NewTeacher" method="post">


        <div class="col">
            <div class="col-lg-16">
                <div class="">

                    <div class="form-row input-group mb-3 d-flex">

                        <label class="input-group-text" for="name">Enter Teacher Name:</label>
                        <input id="name" name="name" type="text" class="form-control" placeholder="Teacher Name"
                               aria-label="Your Teacher Name"
                               aria-describedby="basic-addon2" required>
                        <span id="name-error" class="error-message"></span>

                    </div>
                    <div class="form-row input-group mb-3 d-flex">
                        <label class="input-group-text">Gender</label>
                        <input type="radio" id="true" name="gender" value="Male">
                        <label for="true">Male</label><br>
                        <input type="radio" id="false" name="gender" value="Female">
                        <label for="false">Female</label><br>
                    </div>
                    <div class="form-row input-group mb-3">
                        <label class="input-group-text" for="dob">Enter Birthday:</label>
                        <input id="dob" name="dob" type="date" class="form-control" placeholder="DOB"
                               aria-label="Your DoB"
                               aria-describedby="basic-addon2">
                    </div>

                    <div class="form-row input-group mb-3">
                        <label class="input-group-text" for="phone">Enter Phone:</label>
                        <input id="phone" name="phone" type="text" class="form-control" placeholder="Phone" aria-label="Your Phone"
                               aria-describedby="basic-addon2">
                        <span id="phone-error" class="error-message"></span>

                    </div>
                    <div class="form-row input-group mb-3">
                        <label class="input-group-text" for="email">Enter Email:</label>
                        <input id="email" name="email" type="text" class="form-control" placeholder="Email" aria-label="Your Email"
                               aria-describedby="basic-addon2">
                        <span id="email-error" class="error-message"></span>

                    </div>
                    <div class="form-row input-group mb-3">
                        <label class="input-group-text" for="address">Enter Address:</label>
                        <input id="address" name="address" type="text" class="form-control" placeholder="Address" aria-label="Your Address"
                               aria-describedby="basic-addon2">
                    </div>

                </div>
            </div>
        </div>

        <div class="col-md pt-3">
            <div class="d-flex align-items-center justify-content-end gap mb-3">
                <div>
                    <button href="teacher" data-bs-toggle="modal" class="btn btn-primary">
                        <i class="bx bx-plus me-1"></i> Cancel Change
                    </button>
                </div>
                <div>
                    <button type="submit" data-bs-toggle="modal" data-bs-target=".add-new" class="btn btn-primary">
                        <i class="bx bx-plus me-1"></i> Confirm Create Teacher
                    </button>
                </div>
            </div>
        </div>



    </form>


</div>
<jsp:include page="../../components/footer.jsp"/>
<style>
    .error-message {
        color: red;
    }
</style>
<script>
    const phoneInput = document.getElementById("phone");
    const phoneError = document.getElementById("phone-error");
    const form = document.querySelector("form");

    form.addEventListener("submit", function(event) {
        const phone = phoneInput.value;
        const validPhonePattern = /^\d{10}$/; // Pattern to match a 10-digit phone number

        if (!validPhonePattern.test(phone)) {
            phoneError.textContent = "Please enter a valid 10-digit phone number";
            event.preventDefault(); // Prevent form submission if phone number is invalid
        }
    });
    const nameInput = document.getElementById("name");
    const nameError = document.getElementById("name-error");
    form.addEventListener("submit", function(event) {
        const name = nameInput.value.trim();
        const validNamePattern = /^[^\s]+$/;

        if (name === "") {
            nameError.textContent = "Name is required";
            event.preventDefault();
        } else if (!validNamePattern.test(name)) {
            nameError.textContent = "Please enter a valid name";
            event.preventDefault();
        } else {
            nameError.textContent = "";
        }
    });
    form.addEventListener("submit", function(event) {
        const name = nameInput.value;
        const validNamePattern = /^[a-zA-Z ]+$/; // Pattern to match only alphabets and spaces

        if (!validNamePattern.test(name)) {
            nameError.textContent = "Please enter a valid name using only alphabets and spaces";
            event.preventDefault();
        }
    });
    const emailInput = document.getElementById("email");
    const emailError = document.getElementById("email-error");
    form.addEventListener("submit", function(event) {
        const email = emailInput.value;
        const validEmailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // Pattern to match a valid email address

        if (!validEmailPattern.test(email)) {
            emailError.textContent = "Please enter a valid email address";
            event.preventDefault(); // Prevent form submission if email is invalid
        }
    });
</script>
</body>

</html>