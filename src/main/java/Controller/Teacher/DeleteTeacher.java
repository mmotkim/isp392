package Controller.Teacher;

import Dao.userDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "DeleteTeacher", value = "/DeleteTeacher")
public class DeleteTeacher extends HttpServlet {
private String message;

protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try {
        HttpSession session = request.getSession();
        userDAO teacherDAO = new userDAO();
//        teacherDAO.deleteParent(Integer.parseInt(request.getParameter("id")));        ;

        response.sendRedirect("teacher?state=true");


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