package Controller.Meal;

import Dao.ClassDAO;
import Dao.MealDAO;
import Dao.StudentDAO;
import Entity.AteStatusEntity;
import Entity.Meal;
import Entity.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "EditAteStatus", value = "/EditAteStatus")
public class EditAteStatus extends HttpServlet {
    private String message;


    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            MealDAO mealDAO = new MealDAO();
            StudentDAO stuDao = new StudentDAO();
            ClassDAO classdao = new ClassDAO();

            int stuId = Integer.parseInt(request.getParameter("stuId"));
            int mealId = Integer.parseInt(request.getParameter("mealId"));
            Meal meal = mealDAO.getMealById(mealId);
            AteStatusEntity ateStatus = mealDAO.getAteStatus(stuId,mealId);

            int classId = stuDao.getStudentById(stuId).getClassId();
            request.setAttribute("classId", classId);
            request.setAttribute("a", ateStatus);
            request.setAttribute("meal", meal);
            request.getRequestDispatcher("pages/meal/editAteStatus.jsp").forward(request, response);


        } catch (Exception e) {
            e.printStackTrace(); // Ghi lại lỗi ra output console

        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            StudentDAO stuDAO = new StudentDAO();
            int stuId = Integer.parseInt(request.getParameter("stuId"));
            int mealId = Integer.parseInt(request.getParameter("mealId"));
            String status = request.getParameter("status");
            String reason = request.getParameter("reason");
            int classId= stuDAO.getStudentById(stuId).getClassId();
            MealDAO mealDAO = new MealDAO();
            mealDAO.updateAteStatus(stuId,mealId,status,reason);


            response.sendRedirect("ateStatus?classId="+classId+"&state=true");
        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    public void destroy() {
    }
}