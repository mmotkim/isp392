package Controller.Activity;

import Dao.ActivityDAO;
import Dao.ClassActivityDAO;
import Dao.ClassDAO;
import Dao.NotificationDAO;
import Entity.ClassEntity;
import Entity.Activity;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "NewActivity", value = "/NewActivity")
public class NewActivity extends HttpServlet {
    private String message;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            ClassDAO classDAO = new ClassDAO();
            List<ClassEntity> list = classDAO.getAllClasses();
            int count = classDAO.sumOfClasses();

            request.setAttribute("list2", list);
            request.getRequestDispatcher("pages/activity/newActivity.jsp").forward(request, response);


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
            ClassActivityDAO caDAO = new ClassActivityDAO();
            ClassDAO classDAO = new ClassDAO();

            String name = request.getParameter("name").trim();
            String description = request.getParameter("description").trim();
            String type = request.getParameter("type").trim();

            activityDAO.addActivity(name, description, type);
            String selectedIds = request.getParameter("selectedIds");
            if (selectedIds != null && !selectedIds.isEmpty()) {
                String[] ids = selectedIds.split(",");
                for (String id : ids) {
                    int idNum = Integer.parseInt(id);
                    Date today = Date.valueOf(LocalDate.now());
                    caDAO.addActivityToClass(idNum, activityDAO.getLast().getActivityId(), today);
                }
            }


            response.sendRedirect("activity?state=true");
        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    public void destroy() {
    }
}