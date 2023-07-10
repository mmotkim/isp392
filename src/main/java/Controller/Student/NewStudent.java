package Controller.Student;

import Dao.ClassDAO;
import Dao.StudentDAO;
import Dao.userDAO;
import Entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.hibernate.annotations.Parent;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "NewStudent", value = "/NewStudent")
public class NewStudent extends HttpServlet {
    private String message;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();

            request.getRequestDispatcher("pages/student/newStudent.jsp").forward(request, response);


        } catch (Exception e) {
        }

    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        processRequest(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();

            String name = request.getParameter("name");
            Boolean gender;
            String genderValue = request.getParameter("gender");
            if (genderValue.equals("Male")) gender=true; else gender = false;
            String DoB = request.getParameter("dob");



            String parentName = request.getParameter("parentName");
            Boolean genderParent;
            String genderParentValue = request.getParameter("genderParent");
            if (genderParentValue.equals("Male")) genderParent=true; else genderParent = false;
            String dobParent = request.getParameter("dobParent");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");


            StudentDAO studentDAO = new StudentDAO();
            userDAO parentDAO = new userDAO();
            parentDAO.addUser(parentName,genderParent,dobParent,phone,email,address,4);

            List<Users> listUser = new ArrayList<>();
            listUser = parentDAO.listUsers();
            int parentId = listUser.get(listUser.size()-1).getUserId();
            studentDAO.addStudent(name,gender,DoB,true,parentId,2);

            response.sendRedirect("student");
        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    public void destroy() {
    }
}