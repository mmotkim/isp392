package Controller.Teacher;

import Dao.userDAO;
import Entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "EditTeacher", value = "/EditTeacher")
public class EditTeacher extends HttpServlet {
    private String message;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            userDAO userDAO = new userDAO();
            Users teacher = userDAO.getUserById(Integer.parseInt(request.getParameter("id")));
            request.setAttribute("a", teacher);
            request.getRequestDispatcher("pages/teacher/editTeacher.jsp").forward(request, response);


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
            int id = Integer.parseInt(request.getParameter("id")) ;

            String name = request.getParameter("name");
            name =name.trim();
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
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            Boolean active;
            String activeValue = request.getParameter("active");
            if (activeValue.equals("Yes")) active=true; else active = false;


            userDAO teacherDAO = new userDAO();
//            teacherDAO.updateParent(id,name,gender,DoB,phone, email,address,active);
            response.sendRedirect("teacher?state=true");
        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    public void destroy() {
    }
}