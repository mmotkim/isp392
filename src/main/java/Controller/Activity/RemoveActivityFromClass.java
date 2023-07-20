package Controller.Activity;

import Dao.ClassActivityDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "RemoveActivityFromClass", value = "/RemoveActivityFromClass")
public class RemoveActivityFromClass {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            ClassActivityDAO caDAO = new ClassActivityDAO();
            caDAO.removeActivityFromClass(Integer.parseInt(request.getParameter("id")));

            response.sendRedirect("calendar?state=true");


        } catch (Exception e) {
        }

    }
}
