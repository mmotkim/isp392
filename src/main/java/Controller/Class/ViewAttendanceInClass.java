package Controller.Class;

import Dao.ClassDAO;
import Dao.StudentDAO;
import Dao.userDAO;
import Entity.Attendance;
import Entity.ClassEntity;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "attendance", value = "/attendance")
public class ViewAttendanceInClass extends HttpServlet {
    private String message;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        ClassDAO classDAO = new ClassDAO();
        ClassEntity aClass = classDAO.getClassById(Integer.parseInt(request.getParameter("classId")));

        StudentDAO studentDAO = new StudentDAO();
        userDAO userDAO = new userDAO();
        List<Attendance> list = classDAO.getAllAttendanceByClassId(aClass.getClassId());
        request.setAttribute("list", list);
        request.setAttribute("stuDAO", studentDAO);
        request.setAttribute("userDAO", userDAO);
        request.setAttribute("classId", aClass.getClassId());

        Object object = session.getAttribute("account");
//        User u = (User) object;
        request.getRequestDispatcher("pages/class/attendanceInClass.jsp").forward(request, response);



    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        processRequest(request, response);

    }


    public void destroy() {
    }
}