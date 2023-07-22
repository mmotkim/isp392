package Controller.User;

import Dao.ActivityDAO;
import Dao.userDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "NewUser", value = "/NewUser")
public class NewUser extends HttpServlet {
    private String message;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();

            request.getRequestDispatcher("pages/user/newUser.jsp").forward(request, response);


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
            ActivityDAO activityDAO = new ActivityDAO();
            userDAO u = new userDAO();

            String state = "true";

            String name = request.getParameter("name").trim();
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

            String dob = request.getParameter("dob").trim();
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");

            int role = Integer.parseInt(request.getParameter("role"));

            u.addUser(name, gender, dob, phone, email, address, role);

            response.sendRedirect("ViewAccount?state=" + state);
        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    public void destroy() {
    }
}