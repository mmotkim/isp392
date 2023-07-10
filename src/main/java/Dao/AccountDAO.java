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

public class AccountDAO {


    public List<Users> ListAccount(){
        ArrayList<Users> list = new ArrayList<>();
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        List account = new ArrayList<Users>();
        try {
            transaction.begin();

            Query query = entityManager.createNativeQuery("SELECT * FROM Users", Users.class);
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
    
        public Users checkAccountExist(String email){

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction trans = entityManager.getTransaction();

        try {
            trans.begin();

            Users users = entityManager.find(Users.class, email);
            users.getEmail();

            trans.commit();


        } finally {
            if (trans.isActive()) {
                trans.rollback();
            }
            entityManager.close();

        }
            return null;
        }
   public Users Login(String email, String pass){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        ArrayList<Users> list = new ArrayList<>();
        try {
            transaction.begin();

            Users user = entityManager.createQuery("SELECT * FROM Users WHERE [email] = " + email + " AND [password] = " + pass+"", Users.class).getSingleResult();

            transaction.commit();
            return user;

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }

    }

    public Users checkPass(String email, String pass){

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction trans = entityManager.getTransaction();

        try {
            trans.begin();

            Users users = entityManager.find(Users.class, email);

            users.getPassword();
            entityManager.persist(users);
            trans.commit();


        } finally {
            if (trans.isActive()) {
                trans.rollback();
            }
            entityManager.close();

        }
        return null;
    }
    public void changePass(String email, String pass){

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction trans = entityManager.getTransaction();

        try {
            trans.begin();

            Users users = entityManager.find(Users.class, email);

            users.setPassword(pass);
            entityManager.persist(users);
            trans.commit();

        } finally {
            if (trans.isActive()) {
                trans.rollback();
            }
            entityManager.close();

        }
    }
    
    
    
      public static void main(String[] args) {
//       Dao.AccountDAO dao = new Dao.AccountDAO();
//        List<Users> list = dao.ListAccount();
//        for (Users o : list) {
//            System.out.println(o.toString());
//        }
        AccountDAO dao = new AccountDAO();
        Users a = dao.checkAccountExist("hainkhe160778@fpt.edu.vn");
        System.out.println(a.toString());
    }
}