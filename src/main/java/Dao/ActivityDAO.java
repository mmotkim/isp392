package Dao;

import Utils.HibernateUtils;
import Entity.Activity;
import jakarta.persistence.*;
import org.hibernate.Session;

import java.util.ArrayList;
import java.util.List;

public class ActivityDAO {




    public List<Activity> getAllActivities(){
        ArrayList<Activity> list = new ArrayList<>();

        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

//            Query getAll = entityManager.createNativeQuery("SELECT * FROM Activity");
//
//            for (Activity activity : getAll.getResultList()){
//
//            }

            List<Activity> activities = entityManager.createQuery("FROM Activity ", Activity.class).getResultList();


            transaction.commit();
            return activities;

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();
            entityManagerFactory.close();
        }

    }

    public void addActivity(String name, String description){
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Activity activity = new Activity();
            activity.setName(name);
            activity.setDescription(description);
            entityManager.persist(activity);

            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();
            entityManagerFactory.close();
        }
    }

}
