package Controller.Class;

import Dao.ActivityDAO;
import Dao.ClassDAO;
import Entity.ClassEntity;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "class", value = "/class")
public class ViewClass extends HttpServlet {
    private String message;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        ClassDAO classDAO = new ClassDAO();
        List<ClassEntity> list = classDAO.getAllClasses();
        int count = classDAO.sumOfClasses();
        request.setAttribute("list", list);
        request.setAttribute("count", count);
        Object object = session.getAttribute("account");
//        User u = (User) object;
        request.getRequestDispatcher("pages/class/class.jsp").forward(request, response);



    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        processRequest(request, response);

    }


    public void destroy() {
    }
}