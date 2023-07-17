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
            userDAO userDAO = new userDAO();
            request.setAttribute("userDAO", userDAO);

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

            name = name.trim();
            StringBuilder result = new StringBuilder();
            boolean capitalizeNextChar = true;

            for (char c : name.toCharArray()) {
                if (Character.isWhitespace(c)) {
                    result.append(" ");
                    capitalizeNextChar = true;
                } else if (capitalizeNextChar) {
                    result.append(Character.toUpperCase(c));
                    capitalizeNextChar = false;
                } else {
                    result.append(Character.toLowerCase(c));
                }
            }
            name = result.toString();

            Boolean gender;
            String genderValue = request.getParameter("gender");
            if (genderValue.equals("Male")) gender=true; else gender = false;
            String DoB = request.getParameter("dob");

            Boolean active;
            String activeValue = request.getParameter("active");
            if (activeValue.equals("Yes")) active=true; else active = false;

            StudentDAO studentDao = new StudentDAO();
            studentDao.updateStudent(id,name,gender,DoB,active);


            response.sendRedirect("./student?state=true");
        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    public void destroy() {
    }
}