
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calendar #4</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/rome.css">
</head>
<body>

<jsp:include page="../components/header.jsp"/>
<div class="content">
    <div class="container text-left">
        <div class="row">
            <div class="col-lg-3">
                <h2 class="mb-5 text-center">Calendar #4</h2>
                <form action="calendar" method="GET">
                    <div class="form-group">
                        <label class="" for="classId">Choose Class:</label>
                        <select name="classId" id="classId" type="text" class="form-select"
                                aria-label="Choose Class"
                                aria-describedby="basic-addon2" required>
                            <option value="">Class</option>
                            <c:forEach items="${classes}" var="c">
                                <option value="${c.getClassId()}">${c.getClassId()} - ${c.getClassName()}</option>
                            </c:forEach>


                        </select>
                    </div>
                    <div class="form-group">
                        <label for="input">Select Date</label>
                        <input name="selectedDate" type="text" class="form-control" id="input" placeholder="Select Date" onchange="selectDate(this.value)">
                    </div>

                    <button type="submit" class="btn btn-primary">Apply</button>
                </form>
            </div>
            <div class="col-lg-9">
                <h2 class="mb-5 text-center">Activities Table</h2>
                <div class="week-list-container">
                    <table class="table week-list">
                        <thead>
                        <tr>
                            <th>Days</th>
                            <th>Activities</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${not empty activitiesMap}">
                            <c:forEach items="${activitiesMap}" var="entry">
                                <c:set var="day" value="${entry.key}" />
                                <c:set var="activities" value="${entry.value}" />
                                <tr>
                                    <td class="day-label">
                                        <div class="day-of-week">${day.key}</div>
                                        <div class="date">${day.value}</div>
                                    </td>
                                    <td class="activities">
                                        <ul class="activities-list">
                                            <c:forEach items="${activities}" var="activity">
                                                <li>${activity.name}</li>
                                            </c:forEach>
                                        </ul>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty activitiesMap}">
                            <tr>
                                <td colspan="2">No activities available for the selected week.</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="${pageContext.request.contextPath}/assets/js/rome.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>

<script>
    const picker = rome("#input", {
        time: false,
        dateValidator: rome.val.beforeEq(rome.dt.add(rome.dt.now(), 1, "month")),
        weekStart: 0,
        autoClose: true,
        dayFormat: "D",
        monthFormat: "MMMM",
        inputFormat: "DD/MM/YYYY",
        styles: {
            container: "rome-container",
            date: "rome-date",
            next: "rome-next",
            prev: "rome-prev",
            week: "rome-week",
            selected: "rome-selected",
            unavailable: "rome-unavailable",
            dayOutOfMonth: "rome-day-out-of-month",
            weekdays: "rome-weekdays",
            month: "rome-month",
            year: "rome-year",
            time: "rome-time",
            dayDisabled: "rome-day-disabled",
        },
    });

    picker.on("data", function (value) {
        const selectedDate = new Date(value);
        const weekStart = new Date(selectedDate.setDate(selectedDate.getDate() - selectedDate.getDay()));
        const weekEnd = new Date(selectedDate.setDate(selectedDate.getDate() + 6));
        const weekStartLabel = weekStart.getDate() + "/" + (weekStart.getMonth() + 1);
        const weekEndLabel = weekEnd.getDate() + "/" + (weekEnd.getMonth() + 1);
        $(".week-list-container").find(".date").text(weekStartLabel + " - " + weekEndLabel);
        // Perform any additional logic or AJAX request here if needed
    });

    function selectDate(date) {
        window.location.href = 'calendar?selectedDate=' + date + "&classId=1";
    }
</script>
</body>
</html>
