package Controller.Class;

import Dao.ClassDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.util.Enumeration;

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
            String[] ids = request.getParameterValues("id");
            String[] statuses = request.getParameterValues("statuses");
            String[] reasons = request.getParameterValues("reason");
            for (int i = 0; i < ids.length; i++) {
                String id = ids[i];
                String status = statuses[i];
                String reason = reasons[i];
                classDAO.setAttendance(Integer.parseInt(id),Boolean.parseBoolean(status), reason);
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