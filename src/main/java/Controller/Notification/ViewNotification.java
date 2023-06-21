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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "notification", value = "/notification")
public class ViewNotification extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        NotificationDAO notificationDAO = new NotificationDAO();
        ActivityDAO activityDAO = new ActivityDAO();

        List<Entity.Notification> list = notificationDAO.getAllNotifications();
        Map<Notification, String> map = new HashMap<>();
        for (Notification notif : list){
            if (notif.getActivityId()!=null){
                String actName = activityDAO.getActivity(notif.getActivityId()).getName();
                map.put(notif, actName);
            } else {
                map.put(notif, "");
            }
        }


        int count = notificationDAO.countNotifications();


        request.setAttribute("map", map);
        request.setAttribute("count", count);

        Object object = session.getAttribute("account");
//        User u = (User) object;
        request.getRequestDispatcher("pages/notification/notification.jsp").forward(request, response);



    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        processRequest(request, response);

    }


    public void destroy() {
    }

}