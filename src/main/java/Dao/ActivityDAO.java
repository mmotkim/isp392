package Dao;

import Entity.Activity;
import Utils.HibernateUtils;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

import static Utils.HibernateUtils.*;


public class ActivityDAO {

    public int countActivities(){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
       try {
            Query count = entityManager.createNativeQuery("SELECT COUNT(*) FROM activity");

            return (int)count.getSingleResult();

        } finally {
            entityManager.close();
        }
    }
    public List<Activity> getAllActivities(){
        ArrayList<Activity> list = new ArrayList<>();

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            List<Activity> activities = entityManager.createQuery("FROM Activity ", Activity.class).getResultList();

            transaction.commit();
            return activities;

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }

    }

    public void addActivity(String name, String description){

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction trans = entityManager.getTransaction();
        
        try {
            trans.begin();
            
            Activity activity = new Activity();

            activity.setName(name);
            activity.setDescription(description);

            entityManager.persist(activity);
            
            trans.commit();


        } finally {
            if (trans.isActive()) {
                trans.rollback();
            }
            entityManager.close();

        }
    }


    public void deleteActivity(int id){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Activity activity = entityManager.find(Activity.class, id);
            entityManager.remove(activity);

            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }

    public void updateActivity(int id, String name, String description){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Activity activity = entityManager.find(Activity.class, id);
            activity.setName(name);
            activity.setDescription(description);

            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }



}
