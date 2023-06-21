<%--
  Created by IntelliJ IDEA.
  User: Le Vu
  Date: 19/06/2023
  Time: 08:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Footer</title>
    <style>
        /* CSS styles for the footer */
        footer {
            background-color: #f2f2f2;
            padding: 20px;
            text-align: center;



        }
        .footer-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .footer-links li {
            display: inline-block;
            margin-right: 10px;
        }

        .footer-links li a {
            color: #333;
            text-decoration: none;
        }
    </style>
</head>

<body>
<footer class="footer">
    <div class="container justify-content-between align-text-center">
        <p>&copy; 2023 AsterGarten Kindergaten</p>
        <ul class="footer-links">
            <li><a href="#">About</a></li>
            <li><a href="#">Contact</a></li>
        </ul>
    </div>
</footer>

</body>
</html>
