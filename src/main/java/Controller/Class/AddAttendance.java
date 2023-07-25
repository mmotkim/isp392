package Controller.Class;

import Dao.ClassDAO;
import Dao.StudentDAO;
import Dao.userDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "AddAttendance", value = "/AddAttendance")
public class AddAttendance extends HttpServlet {
    private String message;


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");try {
            HttpSession session = request.getSession();
            String date = request.getParameter("date");
            ClassDAO classDAO =new ClassDAO();
            classDAO.addAttendanceList(Date.valueOf(date));

            response.sendRedirect("class?state=true");


        } catch (Exception e) {
            e.printStackTrace(); // Ghi lại lỗi ra output console
            response.sendRedirect("./404.html");
        }

    }

    public void destroy() {
    }
}