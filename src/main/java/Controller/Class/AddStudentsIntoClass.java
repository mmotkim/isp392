package Controller.Class;

import Dao.StudentDAO;
import Dao.userDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "AddStudentsIntoClass", value = "/AddStudentsIntoClass")
public class AddStudentsIntoClass extends HttpServlet {
    private String message;


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");try {
            HttpSession session = request.getSession();
            String classId = request.getParameter("id");

            String selectedStudentIds = request.getParameter("selectedNewStudentIds");
            String[] studentIds = selectedStudentIds.split(",");

            StudentDAO studentDAO = new StudentDAO();
            for(String stuId: studentIds){
                studentDAO.addStudentIntoClass(Integer.parseInt(stuId), Integer.parseInt(classId));        ;

            }

            response.sendRedirect("StudentInClass?classId="+classId+"&state=true");


        } catch (Exception e) {
            e.printStackTrace(); // Ghi lại lỗi ra output console
            response.sendRedirect("./404.html");
        }

    }

    public void destroy() {
    }
}