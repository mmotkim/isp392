package Controller.Activity;

import Dao.ActivityDAO;
import Dao.ClassActivityDAO;
import Dao.ClassDAO;
import Entity.Activity;
import Entity.ClassEntity;
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

@WebServlet(name = "EditActivity", value = "/EditActivity")
public class EditActivity extends HttpServlet {


    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            ActivityDAO activityDAO = new ActivityDAO();
            Activity activity = activityDAO.getActivity(Integer.parseInt(request.getParameter("activityId")));
            ClassDAO classDAO = new ClassDAO();
            List<ClassEntity> list = classDAO.getAllClasses();
            int count = classDAO.sumOfClasses();

            request.setAttribute("list2", list);

            request.setAttribute("a", activity);
            request.getRequestDispatcher("pages/activity/editActivity.jsp").forward(request, response);


        } catch (Exception e) {
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        boolean state = true;
        try {

            HttpSession session = request.getSession();

                int activityId = Integer.parseInt(request.getParameter("activityId")) ;
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                String type = request.getParameter("type");

            ActivityDAO activityDAO = new ActivityDAO();
            ClassActivityDAO caDAO = new ClassActivityDAO();

            activityDAO.updateActivity(activityId,name,description,type);

            String selectedIds = request.getParameter("selectedIds");
            if (selectedIds != null && !selectedIds.isEmpty()) {
                String[] ids = selectedIds.split(",");
                for (String id : ids) {
                    int idNum = Integer.parseInt(id);
                    Date today = Date.valueOf(LocalDate.now());
                    if (!caDAO.addActivityToClass(idNum, activityDAO.getLast().getActivityId(), today)){
                        state = false;
                    };
                }
            }



            response.sendRedirect("./activity?state=" + state);
        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    public void destroy() {
    }
}