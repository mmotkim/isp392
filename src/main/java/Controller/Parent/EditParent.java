package Controller.Parent;

import Dao.userDAO;
import Entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "EditParent", value = "/EditParent")
public class EditParent extends HttpServlet {
    private String message;


    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            userDAO userDAO = new userDAO();
            Users user = userDAO.getUserById(Integer.parseInt(request.getParameter("id")));
            request.setAttribute("a", user);
            request.getRequestDispatcher("pages/parent/editParent.jsp").forward(request, response);


        } catch (Exception e) {
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();

            int id = Integer.parseInt(request.getParameter("parentId")) ;
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
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            Boolean active;
            String activeValue = request.getParameter("active");
            if (activeValue.equals("Yes")) active=true; else active = false;

            userDAO userDAO = new userDAO();
//            userDAO.updateUser(id,name,gender,DoB,phone,email,address,active);


            response.sendRedirect("./parent?state=true");
        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    public void destroy() {
    }
}