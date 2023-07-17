package Dao;

import Entity.Activity;
import Utils.HibernateUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;

import java.util.ArrayList;
import java.util.List;


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

    public void addActivity(String name, String description, String type){

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction trans = entityManager.getTransaction();
        
        try {
            trans.begin();
            
            Activity activity = new Activity();
            activity.setName(name);
            activity.setDescription(description);
            activity.setType(type);

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

    public void updateActivity(int id, String name, String description, String type){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Activity activity = entityManager.find(Activity.class, id);
            activity.setName(name);
            activity.setDescription(description);
            activity.setType(type);

            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }

    public Activity getActivity(int id){
        ArrayList<Activity> list = new ArrayList<>();

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Activity activity = entityManager.createQuery("FROM Activity WHERE id = " + id, Activity.class).getSingleResult();

            transaction.commit();
            return activity;

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }

    public Activity getLast(){


        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            String jpql = "SELECT a FROM Activity a ORDER BY a.activityId DESC";
            Activity activity = entityManager.createQuery(jpql, Activity.class).setMaxResults(1).getSingleResult();

            transaction.commit();
            return activity;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        finally {
            entityManager.close();
        }
    }

}
