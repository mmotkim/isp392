package Controller.Activity;

import Dao.ActivityDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

    @WebServlet(name = "DeleteActivity", value = "/DeleteActivity")
public class DeleteActivity extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            if (session.getAttribute("acc")==null){
                response.sendRedirect("index.jsp");
                return;
            }
            ActivityDAO activityDAO = new ActivityDAO();
            activityDAO.deleteActivity(Integer.parseInt(request.getParameter("id")))        ;

            response.sendRedirect("activity?state=true");


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

    }

    public void destroy() {
    }
}