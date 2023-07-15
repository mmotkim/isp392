/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

/**
 *
 * @author Admin
 */
import Entity.Users;
import Utils.HibernateUtils;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

public class TeacherDAO {


    public List<Users> ListTeacher(){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        List account = new ArrayList<Users>();
        try {
            transaction.begin();

            Query query = entityManager.createNativeQuery("SELECT * FROM Users u where u.role = 3 ", Users.class);
            account = query.getResultList();

            transaction.commit();

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
        return account;

    }
    public Users Teacher(int id){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        ArrayList<Users> list = new ArrayList<>();
        try {
            transaction.begin();

//            Users user = entityManager.createQuery("SELECT * FROM Users WHERE [email]  " + email + " AND [password] = " + pass+"", Users.class).getSingleResult();
            TypedQuery<Users> query = entityManager.createQuery("SELECT u FROM Users u WHERE u.userId= :id ",Users.class);
            Users user = query
                    .setParameter("id", id)
                    .getSingleResult();
            transaction.commit();
            return user;

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }

    }



    public static void main(String[] args) {
        Dao.TeacherDAO dao = new Dao.TeacherDAO();
        List<Users> list = dao.ListTeacher();
        for (Users o : list) {
            System.out.println(o.toString());
        }
//        AccountDAO dao = new AccountDAO();
//        Users a = dao.Login("ngai@gmail.com","12345");
//        Users b = dao.Teacher(1);
//
//        if(b == null){
//            System.out.println("null");
//        }else {
//        System.out.println(b);
//    }
    }
}
