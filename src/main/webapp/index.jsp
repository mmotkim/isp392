<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css">

</head>
<body>
<jsp:include page="components/header.jsp"/>

<h1><%= "Welcome!" %>
</h1>
<br/>
<jsp:include page="components/footer.jsp"/>

</body>
</html>