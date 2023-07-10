package Controller.Meal;

import Dao.MealDAO;
import Entity.Meal;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "EditMeal", value = "/EditMeal")
public class EditMeal extends HttpServlet {
    private String message;


    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            MealDAO mealDAO = new MealDAO();
            Meal meal = mealDAO.getMealById(Integer.parseInt(request.getParameter("id")));
            request.setAttribute("a", meal);
            request.getRequestDispatcher("pages/meal/editMeal.jsp").forward(request, response);


        } catch (Exception e) {
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();

            int id = Integer.parseInt(request.getParameter("id")) ;
            String description = request.getParameter("description");
            String create_date = request.getParameter("create_date");
            String date = request.getParameter("date");

            MealDAO mealDAO = new MealDAO();
            mealDAO.updateMeal(id,description, Date.valueOf(create_date),Date.valueOf(date));



            response.sendRedirect("meal?state=true");
        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    public void destroy() {
    }
}