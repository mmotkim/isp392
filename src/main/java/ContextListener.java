import Dao.ActivityDAO;
import Dao.NotificationDAO;
import Entity.Notification;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        // Retrieve data from a source (e.g., database)
        NotificationDAO notificationDAO = new NotificationDAO();
        ActivityDAO activityDAO = new ActivityDAO();

        List<Entity.Notification> list = notificationDAO.getActiveNotifications();
        Map<Notification, String> map = new HashMap<>();
        for (Notification notif : list){
            if (notif.getActivityId()!=null){
                String actName = activityDAO.getActivity(notif.getActivityId()).getName();
                map.put(notif, actName);
            } else {
                map.put(notif, "");
            }
        }
        System.out.println(list.toString());
        System.out.println(map.toString());

        int count = notificationDAO.countNotifications();

        //store data
        ServletContext servletContext = servletContextEvent.getServletContext();
        servletContext.setAttribute("notifs", map);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        // Perform cleanup or additional actions if needed
    }
}
