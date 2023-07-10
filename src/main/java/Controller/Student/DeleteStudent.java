package Controller.Student;

import Dao.userDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "DeleteStudent", value = "/DeleteStudent")
public class DeleteStudent extends HttpServlet {
private String message;

protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try {
        HttpSession session = request.getSession();
        userDAO userDAO = new userDAO();
        userDAO.deleteParent(Integer.parseInt(request.getParameter("id")));        ;

        response.sendRedirect("parent");


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