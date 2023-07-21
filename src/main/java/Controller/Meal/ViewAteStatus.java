package Controller.Meal;

import Dao.ClassDAO;
import Dao.MealDAO;
import Dao.StudentDAO;
import Entity.AteStatusEntity;
import Entity.ClassEntity;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ateStatus", value = "/ateStatus")
public class ViewAteStatus extends HttpServlet {
    private String message;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        ClassDAO classDAO = new ClassDAO();
        ClassEntity aClass = classDAO.getClassById(Integer.parseInt(request.getParameter("classId")));

        StudentDAO studentDAO = new StudentDAO();
        MealDAO mealDAO = new MealDAO();
        List<AteStatusEntity> list = mealDAO.getAllAteStatusByClassId(aClass.getClassId());
        request.setAttribute("list", list);
        request.setAttribute("stuDAO", studentDAO);
        request.setAttribute("mealDAO", mealDAO);
        request.setAttribute("class", aClass);

        Object object = session.getAttribute("account");
//        User u = (User) object;
        request.getRequestDispatcher("pages/meal/ateStatus.jsp").forward(request, response);



    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        processRequest(request, response);

    }


    public void destroy() {
    }
}