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

@WebServlet(name = "EditStudent", value = "/EditStudent")
public class EditStudent extends HttpServlet {
    private String message;


    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            StudentDAO studentDAO = new StudentDAO();
            Student student = studentDAO.getStudentById(Integer.parseInt(request.getParameter("id")));
            request.setAttribute("a", student);
            request.getRequestDispatcher("pages/student/editStudent.jsp").forward(request, response);


        } catch (Exception e) {
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();

            int id = Integer.parseInt(request.getParameter("id")) ;
            String name = request.getParameter("name");
            Boolean gender;
            String genderValue = request.getParameter("gender");
            if (genderValue.equals("Male")) gender=true; else gender = false;
            String DoB = request.getParameter("dob");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            Boolean active;
            String activeValue = request.getParameter("active");
            if (activeValue.equals("Yes")) active=true; else active = false;

            userDAO userDAO = new userDAO();
            userDAO.updateParent(id,name,gender,DoB,phone,email,address,active);


            response.sendRedirect("./student?state=true");
        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    public void destroy() {
    }
}