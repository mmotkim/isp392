/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import Entity.Users;
import Utils.HibernateUtils;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

public class AccountDAO {

    public int count(){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        try {
            Query count = entityManager.createNativeQuery("SELECT COUNT(*) FROM Users");

            return (int)count.getSingleResult();

        } finally {
            entityManager.close();
        }
    }

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

            Users user = entityManager.createQuery(
                            "SELECT u from Users u WHERE u.email  like :email", Users.class).
                    setParameter("email", email).getSingleResult();
            user.getEmail();

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

//            Users user = entityManager.createQuery("SELECT * FROM Users WHERE [email]  " + email + " AND [password] = " + pass+"", Users.class).getSingleResult();
            TypedQuery<Users> query = entityManager.createQuery("SELECT u FROM Users u WHERE u.email= :email AND u.password = :pass",Users.class);
            Users user = query
                    .setParameter("email", email)
                    .setParameter("pass", pass)
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

    public Users checkPass(String email, String pass){

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction trans = entityManager.getTransaction();

        try {
            trans.begin();

            TypedQuery<Users> query = entityManager.createQuery("SELECT u FROM Users u WHERE u.password = :pass",Users.class);
            Users user = query
                    .setParameter("pass", pass)
                    .getSingleResult();
            user.getPassword();
            entityManager.persist(user);
            trans.commit();


        } finally {
            if (trans.isActive()) {
                trans.rollback();
            }
            entityManager.close();

        }
        return null;
    }
    public Users changePass(String email, String newpassword){

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            TypedQuery<Users> query = entityManager.createQuery("UPDATE  Users u set u.password = :pass WHERE u.email= :email   ",Users.class);
            Users user = query
                    .setParameter("email", email)
                    .setParameter("pass", newpassword)
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
    public void changePass2(String email, String newpassword){

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Users users = entityManager.find(Users.class, email);

            users.setPassword(newpassword);
            transaction.commit();

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }
    public Users newaccount(String email, String pass){

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction trans = entityManager.getTransaction();

        try {
            trans.begin();

            Users user = new Users();
            user.setEmail(email);
            user.setPassword(pass);

            entityManager.persist(user);

            trans.commit();


        } finally {
            if (trans.isActive()) {
                trans.rollback();
            }
            entityManager.close();

        }
        return null;
    }
    
    
    public static void main(String[] args) {
       Dao.AccountDAO dao = new Dao.AccountDAO();
        List<Users> list = dao.ListAccount();
        for (Users o : list) {
            System.out.println(o.toString());
        }
//        AccountDAO dao = new AccountDAO();
//        Users a = dao.Login("ngai@gmail.com","12345");
//        Users b = dao.changePass("ngai1@gmailcom","haiconvit");
//          String a = "ngai1@gmailcom";
//          String b = "haiconvit";
//        dao.changePass2(a,b);
//        if(b == null){
//            System.out.println("null");
//        }else {
//        System.out.println(b);
//    }
    }
}
