import Dao.ActivityDAO;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "activity", value = "/activity")
public class Activity extends HttpServlet {
    private String message;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        ActivityDAO activityDAO = new ActivityDAO();
        List<Entity.Activity> list = activityDAO.getAllActivities();
        request.setAttribute("list", list);
        Object object = session.getAttribute("account");
//        User u = (User) object;
        request.getRequestDispatcher("activity.jsp").forward(request, response);


    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        processRequest(request, response);

    }


    public void destroy() {
    }
}