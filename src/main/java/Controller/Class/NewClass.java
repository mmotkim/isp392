package Controller.Class;

import Dao.ActivityDAO;
import Dao.ClassDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "NewClass", value = "/NewClass")
public class NewClass extends HttpServlet {
    private String message;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();

            request.getRequestDispatcher("pages/class/newClass.jsp").forward(request, response);


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
        try {
            HttpSession session = request.getSession();

                String name = request.getParameter("name");
                String level = request.getParameter("level");
                String quantity = request.getParameter("quantity");

            ClassDAO classDAO = new ClassDAO();
            classDAO.addClass(name,Integer.parseInt(level) ,Integer.parseInt(quantity));



            response.sendRedirect("class?state=true");
        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    public void destroy() {
    }
}