package Controller.Meal;

import Dao.MealDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "DeleteMeal", value = "/DeleteMeal")
public class DeleteMeal extends HttpServlet {
private String message;

protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try {
        HttpSession session = request.getSession();
        MealDAO mealDAO = new MealDAO();
        mealDAO.deleteMeal(Integer.parseInt(request.getParameter("id")));        ;

        response.sendRedirect("meal");


    } catch (Exception e) {
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

}

public void destroy() {
}
}