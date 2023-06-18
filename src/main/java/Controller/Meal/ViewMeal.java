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
import java.util.List;

@WebServlet(name = "meal", value = "/meal")
public class ViewMeal extends HttpServlet {
    private String message;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        MealDAO mealDAO = new MealDAO();
        List<Meal> list = mealDAO.getAllMeals();
        int count = mealDAO.countMeals();
        request.setAttribute("list", list);
        request.setAttribute("count", count);
        Object object = session.getAttribute("account");
//        User u = (User) object;
        request.getRequestDispatcher("pages/meal/meal.jsp").forward(request, response);



    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        processRequest(request, response);

    }


    public void destroy() {
    }
}