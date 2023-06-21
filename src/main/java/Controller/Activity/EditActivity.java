package Controller.Activity;

import Dao.ActivityDAO;
import Entity.Activity;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "EditActivity", value = "/EditActivity")
public class EditActivity extends HttpServlet {


    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            ActivityDAO activityDAO = new ActivityDAO();
            Activity activity = activityDAO.getActivity(Integer.parseInt(request.getParameter("activityId")));
            request.setAttribute("a", activity);
            request.getRequestDispatcher("pages/activity/editActivity.jsp").forward(request, response);


        } catch (Exception e) {
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();

                int id = Integer.parseInt(request.getParameter("activityId")) ;
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                String type = request.getParameter("type");

            ActivityDAO activityDAO = new ActivityDAO();
            activityDAO.updateActivity(id,name,description,type);



            response.sendRedirect("./activity?state=true");
        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    public void destroy() {
    }
}