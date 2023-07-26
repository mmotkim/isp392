package Controller.Student;

import Dao.StudentDAO;
import Dao.userDAO;
import Entity.Student;
import Entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "student", value = "/student")
public class ViewStudent extends HttpServlet {
    private String message;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        if (session.getAttribute("acc")==null){
            response.sendRedirect("index.jsp");
            return;
        }
        else { // prevents users other than admin and headmaster from seeing
            Users u = (Users) session.getAttribute("acc");
            if (u.getRole() != 2 && u.getRole() != 1) {
                response.sendRedirect("index.jsp");
                return;
            }
        }

        userDAO userDAO = new userDAO();
        StudentDAO studentDAO = new StudentDAO();
        List<Student> list = studentDAO.getStudentList();
        int count = studentDAO.sumOfStudent();
        request.setAttribute("userDAO", userDAO);
        request.setAttribute("list", list);
        request.setAttribute("count", count);
        Object object = session.getAttribute("account");
//        User u = (User) object;
        request.getRequestDispatcher("pages/student/student.jsp").forward(request, response);



    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        processRequest(request, response);

    }


    public void destroy() {
    }
}