package Controller.Parent;

import Dao.userDAO;
import Entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "parent", value = "/parent")
public class ViewParent extends HttpServlet {
    private String message;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        userDAO userDAO = new userDAO();
        List<Users> list = userDAO.listParents();
        int count = userDAO.sumOfParent();
        request.setAttribute("list", list);
        request.setAttribute("count", count);
        Object object = session.getAttribute("account");
//        User u = (User) object;
        request.getRequestDispatcher("pages/parent/parent.jsp").forward(request, response);



    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        processRequest(request, response);

    }


    public void destroy() {
    }
}