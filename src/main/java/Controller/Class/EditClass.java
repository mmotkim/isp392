package Controller.Class;

import Dao.ActivityDAO;
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

@WebServlet(name = "EditClass", value = "/EditClass")
public class EditClass extends HttpServlet {
    private String message;


    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            ClassDAO classDAO = new ClassDAO();
            ClassEntity aClass = classDAO.getClassById(Integer.parseInt(request.getParameter("classId")));
            request.setAttribute("aClass", aClass);
            request.getRequestDispatcher("pages/class/editClass.jsp").forward(request, response);


        } catch (Exception e) {
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();

                int id = Integer.parseInt(request.getParameter("classId")) ;
            String name = request.getParameter("name");
            String level = request.getParameter("level");
            String quantity = request.getParameter("quantity");

            ClassDAO classDAO = new ClassDAO();

            classDAO.updateClass(id,name,Integer.parseInt(level) ,Integer.parseInt(quantity));


            response.sendRedirect("./class");
        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    public void destroy() {
    }
}