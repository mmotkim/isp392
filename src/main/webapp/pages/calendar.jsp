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
    <style>
        span {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;

            z-index: 0;
        }

        a {
            z-index: 2;
        }
    </style>
</head>

<body>

<jsp:include page="../components/header.jsp"/>
<%-- Alert--%>
<c:if test="${param.state eq 'true'}">
    <div class="alert alert-success alert-dismissible inter fade show" role="alert">
        Action completed without issues!
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>
<div class="content">
    <div class="container text-left">
        <div class="row">
            <div class="col-lg-3">
                <h2 class="mb-5 text-center"></h2>
                <form action="calendar" method="GET">
                    <div class="form-group">
                        <label class="" for="classIdSelect">Choose Class:</label>
                        <select name="classId" id="classIdSelect" type="text" class="form-select"
                                aria-label="Choose Class" aria-describedby="basic-addon2" required>
                            <option value="">Select a class</option>
                            <c:forEach items="${classes}" var="c">
                                <option value="${c.getClassId()}">${c.getClassId()} - ${c.getClassName()}
                                </option>
                            </c:forEach>


                        </select>
                    </div>
                    <div class="form-group">
                        <label for="input">Select Date</label>
                        <input name="selectedDate" value="${sd}" type="text" class="form-control" id="input"
                               placeholder="Select Date" onchange="selectDate(this.value)">
                    </div>

                    <button type="submit" class="btn btn-primary">Apply</button>
                </form>
            </div>
            <div class="col-lg-9">
                <h2 class="mb-5 text-center">Schedule</h2>
                <div class="week-list-container">
                    <table class="table week-list" id="itemTable">
                        <thead>
                        <tr>
                            <th class="col-1">Date</th>
                            <th class="col-auto">Activities</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${not empty activitiesMap}">
                            <c:forEach items="${weekdays}" var="weekday">

                                <tr>
                                    <td class="day-label">
                                        <div class="day-of-week">${weekday.getDayOfWeek()}</div>
                                        <div class="date">${weekday.toString()}</div>
                                    </td>
                                    <td class="activities">
                                        <c:forEach items="${activitiesMap}" var="entry">

                                            <c:set var="ca" value="${entry.key}"/>
                                            <c:set var="activities" value="${entry.value}"/>
                                            <c:if test="${ca.getDate().toLocalDate().equals(weekday)}">

                                                <c:forEach items="${activities}" var="activity" varStatus="loop">
                                                    <ul class="classactivities list-group activities-list py-1">
                                                        <div class="list-group-item list-group-item-action">
                                                            <div class="d-flex flex-row justify-content-between align-items-center "
                                                                 style="position: relative">
                                                                <a class=""
                                                                   style="display: block; color: inherit"
                                                                   data-bs-toggle="collapse"
                                                                   href="#${ca.getSlotId()}${loop.index}"><span></span>${activity.getName()}
                                                                </a>
                                                                <div class=" flex-end" style="">
                                                                    <!-- Collapse Icon -->
                                                                    <i class="bi bi-caret-down text-primary"
                                                                       style="font-size: 21px"></i>
                                                                </div>
                                                            </div>


                                                            <div class="collapse" id="${ca.getSlotId()}${loop.index}">
                                                                <hr class="border-1">
                                                                <div class="justify-content-between d-flex pb-1 align-items-center">
                                                                        ${activity.getDescription()}
                                                                    <div class="d-flex align-items-center">
                                                                        <a href="./EditActivity?activityId=${ca.getActivityId()}" title="Edit Activity"
                                                                           class="link-primary "><i
                                                                                class="bx bx-pencil pe-3"
                                                                                style="font-size: 18px"></i></a>
                                                                        <a href="./RemoveActivity?id=${ca.getActivityId()}"
                                                                           title="Remove Activity from Class"
                                                                           class="link-primary "><i
                                                                                class="bi bi-x-lg pe-3"
                                                                                style="font-size: 18px"></i></a>
                                                                        <a href="#" data-bs-toggle="modal"
                                                                           data-bs-target="#a${ca.getSlotId()}"
                                                                           title="Set Slot"
                                                                           class="link-primary ">
                                                                            <i class="bi bi-calendar2-week"
                                                                               style="font-size: 17px"></i></a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </ul>
                                                    <div class="modal fade" id="a${ca.getSlotId()}"
                                                         tabindex="-1"
                                                         aria-labelledby="slotModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog modal-dialog-scrollable">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="slotModalLabel">Reschedule activity for the class</h5>
                                                                    <button type="button" class="btn-close"
                                                                            data-bs-dismiss="modal"
                                                                            aria-label="Close"></button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <form id="slotForm" action="Calendar" method="post">
                                                                        <input type="hidden" name="slotId"
                                                                               id="activityId"
                                                                               value="${ca.getSlotId()}">
                                                                        <input type="date" name="dateInput" id="dateInput"
                                                                               placeholder="Enter new date"
                                                                               class="form-control">
                                                                        <input type="number" name="slot" id="slotInput"
                                                                               min="1" max="6"
                                                                               placeholder="Enter slot number (1->6)"
                                                                               class="form-control">
                                                                    </form>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary"
                                                                            data-bs-dismiss="modal">Close
                                                                    </button>
                                                                    <button type="button" class="btn btn-primary">Submit
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>


                                            </c:if>




                                        </c:forEach>
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
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.js"></script>
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

    //put already selected class in the select input
    var selectedValue = "${sc.getClassId()}"; // Replace with your actual received value
    var selectElement = document.getElementById("classIdSelect");
    selectElement.value = selectedValue;

    document.addEventListener('DOMContentLoaded', function () {
        const tableRows = Array.from(document.querySelectorAll('#itemTable tr'));

        tableRows.forEach(row => {
            const cells = row.getElementsByTagName('td');
            const isEmptyRow = Array.from(cells).every(cell => cell.textContent.trim() === '');

            if (isEmptyRow) {
                row.innerHTML = '<td colspan="3">No item for this day</td>';
            }
        });
    });
</script>
</body>

</html>