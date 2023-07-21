package Controller.Class;

import Dao.ClassDAO;
import Dao.StudentDAO;
import Entity.Attendance;
import Entity.Student;
import Entity.ClassEntity;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.util.Enumeration;
import java.util.List;

@WebServlet(name = "EditAttendanceInClass", value = "/EditAttendanceInClass")
public class EditAttendanceInClass extends HttpServlet {
    private String message;


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            String classId = request.getParameter("classId");
            ClassDAO classDAO = new ClassDAO();
            Enumeration<String> parameterNames = request.getParameterNames();
            while (parameterNames.hasMoreElements()) {
                String paramName = parameterNames.nextElement();
                if (paramName.startsWith("status_")) {
                    // Get the date and studentId from the paramName
                    String[] tokens = paramName.split("_");
                    String dateStr = tokens[1];
                    int studentId = Integer.parseInt(tokens[2]);

                    // Get the attendance status (true or false) from the checkbox value
                    boolean status = !Boolean.parseBoolean(request.getParameter(paramName));
//                    boolean status = request.getParameter(paramName) != null;

                    classDAO.setAttendance(studentId,Date.valueOf(dateStr),status);

                    // Update the attendance record in the data store with the new status and reason
                    // Example: attendanceDAO.updateAttendance(classId, dateStr, studentId, status, reason);
                }
            }
            response.sendRedirect("./attendance?classId=" + classId + "&state=true");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("./404.html");
        }
    }

    public void destroy() {
    }
}