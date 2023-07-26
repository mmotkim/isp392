<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <link href="assets/css/index.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css"
          integrity="sha512-tT8dPfN1dNkCz3L0Dba0KuPFEmzQhrvztnqecwEIpM3JNMI+2bcldq6dzvGDE1NCa+8J1VRTrk4Qjzn5f7HDA=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="assets/css/signin.css" rel="stylesheet" />
</head>

<body>
<div id="container">
    <jsp:include page="../../components/header.jsp"/>
    <div id="content">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title text-center mb-4">Forgot Password</h5>
                            <form action="ForgotPassword" method="post">
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email<span style="color: red;">*</span></label>
                                    <input type="email" name="email" class="form-control" id="email" required>
                                </div>
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </div>
                            </form>
                            <div class="alert alert-danger mt-3" role="alert" style="${empty mess ? 'display: none;' : ''}">
                                ${mess}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="height: 80px;"></div>
    <jsp:include page="../../components/footer.jsp"/>
</div>
</body>

</html>
