package Controller.Account;

import Dao.AccountDAO;
import Entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "Login", value = "/Login")
public class Login extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();

            request.getRequestDispatcher("pages/account/login.jsp").forward(request, response);


        } catch (Exception e) {
        }


    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try{
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            AccountDAO accDao = new AccountDAO();
            Users a = accDao.login(username, password);
            if (a == null) {
                request.setAttribute("mess", "Wrong user or password!!!");
                request.getRequestDispatcher("pages/account/login.jsp").forward(request, response);
            } else if (!a.getActive()) {
                request.setAttribute("mess", "This account is deactivated now!");
                request.getRequestDispatcher("pages/account/login.jsp").forward(request, response);
            } else {
//            request.getRequestDispatcher("Home").forward(request, response);
                HttpSession session = request.getSession();
                session.setAttribute("acc", a);
//            session.setMaxInactiveInterval(10000);
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } catch (Exception e){

        }



    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
