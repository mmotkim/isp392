package Controller;

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
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "Calendar", value = "/calendar")
public class Calendar extends HttpServlet {
    private String message;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

            HttpSession session = request.getSession();
            ClassDAO classDAO = new ClassDAO();
            ClassActivityDAO caDAO = new ClassActivityDAO();
            List<ClassEntity> list = classDAO.getAllClasses();
            System.out.println(request.getParameter("selectedDate"));
            System.out.println(request.getParameter("classId"));


            if (request.getParameter("selectedDate") != null && request.getParameter("classId") != null){
                String selectedDateString = request.getParameter("selectedDate");
                int classId = Integer.parseInt(request.getParameter("classId"));

                LocalDate selectedDate = LocalDate.parse(selectedDateString);

                LocalDate startOfWeek = selectedDate.with(DayOfWeek.SUNDAY);
                LocalDate endOfWeek = startOfWeek.plusDays(6);

                Map<LocalDate, List<Activity>> activitiesMap = caDAO.getActivitiesForWeek(classId, startOfWeek, endOfWeek);

                request.setAttribute("activitiesMap", activitiesMap);
                request.setAttribute("startOfWeek", startOfWeek.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")));
                request.setAttribute("endOfWeek", endOfWeek.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")));


                request.setAttribute("classes", list);
                request.getRequestDispatcher("pages/calendar.jsp").forward(request, response);
            }
            else {
                request.setAttribute("classes", list);
                request.getRequestDispatcher("pages/calendar.jsp").forward(request, response);
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
//            HttpSession session = request.getSession();
//            ActivityDAO activityDAO = new ActivityDAO();
//            ClassActivityDAO caDAO = new ClassActivityDAO();
//            ClassDAO classDAO = new ClassDAO();
//
//            String name = request.getParameter("name").trim();
//            String description = request.getParameter("description").trim();
//            String type = request.getParameter("type").trim();
//
//            activityDAO.addActivity(name, description, type);
//            String selectedIds = request.getParameter("selectedIds");
//            if (selectedIds != null && !selectedIds.isEmpty()) {
//                String[] ids = selectedIds.split(",");
//                for (String id : ids) {
//                    int idNum = Integer.parseInt(id);
//                    Date today = Date.valueOf(LocalDate.now());
//                    caDAO.addActivityToClass(idNum, activityDAO.getLast().getActivityId(), today);
//                }
//            }


            response.sendRedirect("calendar");
        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    public void destroy() {
    }
}