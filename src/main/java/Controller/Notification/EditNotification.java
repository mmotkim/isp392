package Controller.Notification;

import Dao.ActivityDAO;
import Dao.NotificationDAO;
import Entity.Notification;
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

@WebServlet(name = "EditNotification", value = "/EditNotification")
public class EditNotification extends HttpServlet {
    private String message;


    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            NotificationDAO notificationDAO = new NotificationDAO();
            ActivityDAO activityDAO = new ActivityDAO();

            Notification notification = notificationDAO.getNotification(Integer.parseInt(request.getParameter("notificationId")));
            request.setAttribute("n", notification);
            int count2 = activityDAO.countActivities();
            List<Entity.Activity> list2 = activityDAO.getAllActivities();
            request.setAttribute("list2", list2);
            request.setAttribute("count2", count2);
            request.getRequestDispatcher("pages/notification/editNotification.jsp").forward(request, response);


        } catch (Exception e) {
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            DateTimeFormatter inputDateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            int id = Integer.parseInt(request.getParameter("notificationId"));

            String title = request.getParameter("title");
            String description = request.getParameter("description");

            LocalDate processDate = LocalDate.parse(request.getParameter("process"), inputDateFormat);
            LocalDate endDate = LocalDate.parse(request.getParameter("end"), inputDateFormat);

            Date process = Date.valueOf(processDate);
            Date end = Date.valueOf(endDate);

            NotificationDAO notificationDAO = new NotificationDAO();

            if (request.getParameter("isActivity") == null) {
                notificationDAO.updateNotification(id, title, description, process, end);
            }
//            else if (request.getParameter("isActivity") != null){
//                boolean isActivity = Boolean.parseBoolean(request.getParameter("isActivity"));
//                int activityId = Integer.parseInt(request.getParameter("activityId"));
//                notificationDAO.updateNotificationWithActivity(id, title, description, created, process, end, isActivity, activityId);
//            }


            response.sendRedirect("./notification");
        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    public void destroy() {
    }
}