package Controller.Notification;

import Dao.ActivityDAO;
import Dao.NotificationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "NewNotification", value = "/NewNotification")
public class NewNotification extends HttpServlet {



    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            ActivityDAO activityDAO = new ActivityDAO();
            HttpSession session = request.getSession();

            int count2 = activityDAO.countActivities();
            List<Entity.Activity> list2 = activityDAO.getAllActivities();
            request.setAttribute("list2", list2);
            request.setAttribute("count2", count2);
            request.getRequestDispatcher("pages/notification/newNotification.jsp").forward(request, response);


        } catch (Exception e) {
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            NotificationDAO notificationDAO = new NotificationDAO();
            DateTimeFormatter inputDateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            HttpSession session = request.getSession();

            String title = request.getParameter("title");
            String description = request.getParameter("description");

            LocalDate processDate = LocalDate.parse(request.getParameter("process"), inputDateFormat);
            LocalDate endDate = LocalDate.parse(request.getParameter("end"), inputDateFormat);

            Date created = Date.valueOf(LocalDate.now());
            Date process = Date.valueOf(processDate);
            Date end = Date.valueOf(endDate);



            if (request.getParameter("activityId").equals("")) {
                notificationDAO.addNotification(title.trim(), description.trim(), created, process, end);
            }
            else if (request.getParameter("activityId") != null){
                boolean isActivity = true;
                int activityId = Integer.parseInt(request.getParameter("activityId"));
                notificationDAO.addNotificationWithActivity(title, description, created, process, end, isActivity, activityId);
            }

            response.sendRedirect("notification?state=true");
        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    public void destroy() {
    }
}