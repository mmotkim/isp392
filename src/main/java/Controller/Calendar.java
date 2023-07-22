package Controller;

import Dao.ActivityDAO;
import Dao.ClassActivityDAO;
import Dao.ClassDAO;
import Entity.Activity;
import Entity.ClassActivity;
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
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
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

                //selected parameters
                ClassEntity selectedClass = classDAO.getClassById(classId);
                request.setAttribute("sc", selectedClass);
                request.setAttribute("sd", selectedDateString);
                LocalDate selectedDate = LocalDate.parse(selectedDateString);

                LocalDate startOfWeek = selectedDate.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
                LocalDate endOfWeek = selectedDate.with(TemporalAdjusters.nextOrSame(DayOfWeek.SUNDAY));

                Map<ClassActivity, List<Activity>> activitiesMap = caDAO.getActivitiesForWeek(classId, startOfWeek, endOfWeek);

                ArrayList<LocalDate> weekdays = caDAO.getDatesOfWeek(startOfWeek);
                request.setAttribute("activitiesMap", activitiesMap);
                request.setAttribute("weekdays", weekdays);
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
        String state = "true";
        try {
            HttpSession session = request.getSession();
            ActivityDAO activityDAO = new ActivityDAO();
            ClassActivityDAO caDAO = new ClassActivityDAO();
            ClassDAO classDAO = new ClassDAO();

            int slotId = Integer.parseInt(request.getParameter("slotId"));
            String slot = request.getParameter("slot");

            String date = request.getParameter("dateInput");

            if (!date.isEmpty()) {
                if (caDAO.isScheduleValid(slotId, Integer.parseInt(slot), LocalDate.parse(date))){
                    caDAO.rescheduleDate(slotId, LocalDate.parse(date));
                    state = "true";
                }

                else {
                    state = "false";
                    response.sendRedirect("calendar?state=" + state);
                    return;
                }
            };
            if (!slot.isEmpty()) caDAO.rescheduleSlot(slotId, Integer.parseInt(slot));



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




            response.sendRedirect("calendar?state=" + state);
        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    public void destroy() {
    }
}