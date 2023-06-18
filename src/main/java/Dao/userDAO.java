package Dao;

import Utils.HibernateUtils;
import jakarta.persistence.*;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import Entity.*;

public class userDAO {

    public int sumOfUser() {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        Query countUser = entityManager.createNativeQuery("SELECT COUNT(*) FROM Users");
        return ((Number) countUser.getSingleResult()).intValue();
    }
    public int sumOfParent() {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        Query countParent = entityManager.createNativeQuery("SELECT COUNT(*) FROM Users where [Role]=4");
        return ((Number) countParent.getSingleResult()).intValue();
    }
    public int sumOfTeacher() {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        Query count = entityManager.createNativeQuery("SELECT COUNT(*) FROM Users where [Role]=3");
        return ((Number) count.getSingleResult()).intValue();
    }
    public int sumOfAdmin() {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        Query count = entityManager.createNativeQuery("SELECT COUNT(*) FROM Users where [Role]=2");
        return ((Number) count.getSingleResult()).intValue();
    }
    public List<Users> listTeachers() {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        List teachers = new ArrayList<Users>();

        try {
            transaction = entityManager.getTransaction();
            transaction.begin();

            Query query = entityManager.createNativeQuery("SELECT * FROM Users where [Role]=3", Users.class);
            teachers = query.getResultList();

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            entityManager.close();

        }

        return teachers;
    }
    public List<Users> listParents() {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        List parents = new ArrayList<Users>();

        try {
            transaction = entityManager.getTransaction();
            transaction.begin();

            Query query = entityManager.createNativeQuery("SELECT * FROM Users where [Role]=4", Users.class);
            parents = query.getResultList();

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            entityManager.close();

        }

        return parents;
    }
    public Users getUserById(int id){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        ArrayList<Users> list = new ArrayList<>();


        try {
            transaction.begin();

            Users user = entityManager.createQuery("FROM Users WHERE id = " + id, Users.class).getSingleResult();

            transaction.commit();
            return user;

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();


        }
    }
    public void updateParent(int id, String name, Boolean gender, String DoB, String phone, String email, String address, Boolean active){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();

            Users user = entityManager.find(Users.class, id);
            user.setFullname(name);
            user.setGender(gender);
            //format yyyy-mm-dd
            user.setDob(Date.valueOf(DoB));
            user.setPhone(phone);
            user.setEmail(email);
            user.setAddress(address);
            user.setActive(active);
            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }
    public void deleteParent(int id){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();

            Users user = entityManager.find(Users.class, id);
            entityManager.remove(user);

            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }

}
