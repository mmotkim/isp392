package Controller.Teacher;

import Dao.userDAO;
import Entity.Users;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Properties;
import java.util.Random;

@WebServlet(name = "NewTeacher", value = "/NewTeacher")
public class NewTeacher extends HttpServlet {
    private String message;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();

            request.getRequestDispatcher("pages/teacher/newTeacher.jsp").forward(request, response);


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
            name =name.trim();
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

            Boolean gender;
            String genderValue = request.getParameter("gender");
            if (genderValue.equals("Male")) gender=true; else gender = false;
            String DoB = request.getParameter("dob");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");


            userDAO teacherDAO = new userDAO();
            teacherDAO.addUser(name,gender,DoB,phone,email,address.trim(),3);
            Users teacher = teacherDAO.listTeachers().get(teacherDAO.sumOfTeacher()-1);
            String username = teacher.getUsername();
            String pass = teacher.getPassword();
//            sendEmail(email,username, pass);

            response.sendRedirect("teacher?state=true");
        } catch (Exception e) {
            response.sendRedirect("./404.html");

        }
    }

    private void sendEmail(String email,String username, String password) {
        // Thông tin tài khoản Gmail của người gửi
        final String senderEmail = "xuanhalison2002@gmail.com";
        final String senderPassword = "25102002halison";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Authenticator authenticator = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        };
        Session session = Session.getInstance(props, authenticator);

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));

            message.setSubject("Register to system");
            message.setText("Your username is: " + username + "\nYour password is: " + password);

            // Gửi email
            Transport.send(message);

            System.out.println("Email sent successfully.");
        } catch (Exception e) {
            System.out.println("Error sending email: " + e.getMessage());
        }
    }
    public void destroy() {
    }
}