package Controller.Class;

import Dao.ClassDAO;
import Dao.StudentDAO;
import Entity.Student;
import Entity.ClassEntity;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "EditClass", value = "/EditClass")
public class EditClass extends HttpServlet {
    private String message;


    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            ClassDAO classDAO = new ClassDAO();
            ClassEntity aClass = classDAO.getClassById(Integer.parseInt(request.getParameter("classId")));
            StudentDAO studentDAO = new StudentDAO();
            List<Student> listS = studentDAO.getStudentListByClass(aClass.getClassId());
            request.setAttribute("aClass", aClass);
            request.setAttribute("listS", listS);
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
            name = name.trim();
            StringBuilder result = new StringBuilder();
            boolean capitalizeNextChar = true;

            for (char c : name.toCharArray()) {
                if (Character.isWhitespace(c)) {
                    result.append(" ");
                    capitalizeNextChar = true;
                } else if (capitalizeNextChar) {
                    result.append(Character.toUpperCase(c));
                    capitalizeNextChar = false;
                } else {
                    result.append(Character.toLowerCase(c));
                }
            }
            name = result.toString();

            String level = request.getParameter("level");

            ClassDAO classDAO = new ClassDAO();

            classDAO.updateClass(id,name,Integer.parseInt(level));


            response.sendRedirect("./class?state=true");

        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    public void destroy() {
    }
}