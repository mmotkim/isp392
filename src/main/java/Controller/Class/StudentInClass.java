package Controller.Class;

import Dao.ClassDAO;
import Dao.StudentDAO;
import Entity.Student;
import Entity.ClassEntity;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "StudentInClass", value = "/StudentInClass")
public class StudentInClass extends HttpServlet {
    private String message;


    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            ClassDAO classDAO = new ClassDAO();
            ClassEntity aClass = classDAO.getClassById(Integer.parseInt(request.getParameter("classId")));
            StudentDAO studentDAO = new StudentDAO();
            List<Student> listS = studentDAO.getStudentListByClass(aClass.getClassId());
            List<Student> listPending = studentDAO.getStudentListWithNullClassId();
            request.setAttribute("aClass", aClass);
            request.setAttribute("listS", listS);
            request.setAttribute("listPending", listPending);

            request.getRequestDispatcher("pages/class/studentInClass.jsp").forward(request, response);


        } catch (Exception e) {
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    }

    public void destroy() {
    }
}