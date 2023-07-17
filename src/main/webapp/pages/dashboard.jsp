<%--
  Created by IntelliJ IDEA.
  User: Le Vu
  Date: 19/06/2023
  Time: 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dash Board</title>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>
<body>
<jsp:include page="../components/header.jsp"/>

<div class="container">
  <section>
    <h2>Attendance Chart For June</h2>
    <canvas id="attendanceChart"></canvas>
    <script>
      var ctx = document.getElementById('attendanceChart').getContext('2d');
      var attendanceChart = new Chart(ctx, {
        type: 'bar',
        data: {
          labels: ['HS001', 'HS002', 'HS003', 'HS004', 'HS005'],
          datasets: [{
            label: 'Số ngày đi học',
            data: [20, 22, 18, 20, 19],
            backgroundColor: 'rgba(75, 192, 192, 0.8)',
            borderColor: 'rgba(75, 192, 192, 1)',
            borderWidth: 1
          }]
        },
        options: {
          scales: {
            y: {
              beginAtZero: true
            }
          }
        }
      });
    </script>
  </section>
</div>
<jsp:include page="../components/footer.jsp"/>

</body>
</html>
