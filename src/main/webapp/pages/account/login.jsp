<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Adding a new meal</title>
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


<div class="container pt-3">
    <a href="home" class="size-3">
        <div class="arrow" style=""></div>
    </a>
</div>


<div class="container" style="margin-top: 40px">
    
    <div class="row align-items-center py-3 text-center">
        <h4>
            Welcome back.
        </h4>
    </div>

    <form action="Login" method="post">
        <div class="row d-flex justify-content-center align-items-center">
            <div class="col-md-6 col-lg-4">
                <div class=" p-0">
                    <div class="form-floating mb-3">
                        <input name="username" id="username" type="text" class="form-control" placeholder="User Name" required>
                        <label class="" for="username">Your Username</label>
                    </div>
                    <div class="form-floating  mb-3">
                        <input name="password" id="pass" type="password" class="form-control" placeholder="Password" aria-label="Password"
                               aria-describedby="basic-addon2" required>
                        <label class="" for="pass">Your Password</label>
                    </div>
                </div>
                <div class="d-flex  align-items-center justify-content-end gap mb-3">
                    <div>
                        <button type="submit" class=" btn btn-primary">
                            Login</button>
                    </div>
                </div>
            </div>
                    
            
        </div>

        <div class="col-md pt-3">
            
        </div>
    </form>


</div>
<jsp:include page="../../components/footer.jsp"/>

</body>

</html>