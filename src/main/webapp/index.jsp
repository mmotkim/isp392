<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>HomePage - Astergarten Kindergaten</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css">
    <style>
        /* CSS styles for the homepage */
        .banner {
            background-color: #333;
            color: #fff;
            padding: 50px;
            text-align: center;
        }

        .banner h1 {
            font-size: 36px;
            margin-bottom: 20px;
        }

        .banner p {
            font-size: 18px;
        }

        .content {
            padding: 50px;
            text-align: center;
        }

        .content h2 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .content p {
            font-size: 16px;
            margin-bottom: 30px;
        }

        .content .btn {
            display: inline-block;
            background-color: #333;
            color: #fff;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .content .btn:hover {
            background-color: #555;
        }

        .programs {
            background-color: #fff;
            padding: 50px;
            text-align: center;
        }

        .programs h2 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .programs p {
            font-size: 16px;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
<jsp:include page="components/header.jsp"/>

<section class="banner">
    <h1>Chào mừng đến với Trường Mầm non Astergarten</h1>
    <p>Giáo dục và chăm sóc trẻ em từ 2 đến 5 tuổi</p>
</section>

<section class="content">
    <h2>Về chúng tôi</h2>
    <p>Trường Mầm non ABC cam kết mang đến môi trường giáo dục an toàn, thân thiện và phát triển toàn diện cho trẻ em từ 2 đến 6 tuổi. Chúng tôi tập trung vào việc xây dựng nền tảng vững chắc cho sự phát triển toàn diện của trẻ, từ khả năng học tập, kỹ năng xã hội, cho đến sức khỏe và sự tự tin.</p>
</section>

<section class="programs">
    <h2>Chương trình học</h2>
    <p>Chúng tôi cung cấp các chương trình học đa dạng và phù hợp với từng độ tuổi của trẻ. Chương trình giáo dục của chúng tôi tập trung vào việc khám phá, tò mò và phát triển tư duy sáng tạo của trẻ. Chúng tôi đảm bảo trẻ em được tham gia vào các hoạt động học tập bổ ích và thú vị.</p>
</section>

<jsp:include page="components/footer.jsp"/>

</body>
</html>