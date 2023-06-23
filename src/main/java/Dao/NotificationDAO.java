package Dao;

import Entity.Notification;
import Utils.HibernateUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;


public class NotificationDAO {

    public int countNotifications(){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
       try {
            Query count = entityManager.createNativeQuery("SELECT COUNT(*) FROM notification");

            return (int)count.getSingleResult();

        } finally {
            entityManager.close();
        }
    }
    public List<Notification> getAllNotifications(){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            List<Notification> notifications = entityManager.createQuery("FROM Notification ", Notification.class).getResultList();

            transaction.commit();
            return notifications;

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }

    }

    public void addNotification(String title, String description, Date createdDate, Date processingDate, Date endDate){

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction trans = entityManager.getTransaction();

        try {
            trans.begin();

            Notification notification = new Notification();

            notification.setTitle(title);
            notification.setDescription(description);
            notification.setCreatedDate(createdDate);
            notification.setProcessingDate(processingDate);
            notification.setEndDate(endDate);


            entityManager.persist(notification);

            trans.commit();


        } finally {
            if (trans.isActive()) {
                trans.rollback();
            }
            entityManager.close();

        }
    }

    public void addNotificationWithActivity(String title, String description, Date createdDate, Date processingDate, Date endDate, boolean isActivity, int activityId){

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction trans = entityManager.getTransaction();

        try {
            trans.begin();

            Notification notification = new Notification();

            notification.setTitle(title);
            notification.setDescription(description);
            notification.setCreatedDate(createdDate);
            notification.setProcessingDate(processingDate);
            notification.setEndDate(endDate);
            notification.setActivity(isActivity);
            notification.setActivityId(activityId);

            entityManager.persist(notification);

            trans.commit();


        } finally {
            if (trans.isActive()) {
                trans.rollback();
            }
            entityManager.close();

        }
    }

    public void deleteNotification(int id){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Notification notification = entityManager.find(Notification.class, id);
            entityManager.remove(notification);

            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }

    public void updateNotification(int id, String title, String description, Date processingDate, Date endDate){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Notification notification = entityManager.find(Notification.class, id);

            notification.setTitle(title);
            notification.setDescription(description);
            notification.setProcessingDate(processingDate);
            notification.setEndDate(endDate);


            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }

    public void updateNotificationWithActivity(int id, String title, String description , Date processingDate, Date endDate, boolean isActivity, int activityId){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Notification notification = entityManager.find(Notification.class, id);

            notification.setTitle(title);
            notification.setDescription(description);

            notification.setProcessingDate(processingDate);
            notification.setEndDate(endDate);
            notification.setActivity(isActivity);
            notification.setActivityId(activityId);


            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }

    public void updateNotificationRemovedActivity(int id, String title, String description, Date processingDate, Date endDate){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Notification notification = entityManager.find(Notification.class, id);

            notification.setTitle(title);
            notification.setDescription(description);

            notification.setProcessingDate(processingDate);
            notification.setEndDate(endDate);
            notification.setActivity(null);
            notification.setActivityId(null);


            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }
    public Notification getNotification(int id){
        ArrayList<Notification> list = new ArrayList<>();

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Notification notification = entityManager.createQuery("FROM Notification WHERE id = " + id, Notification.class).getSingleResult();

            transaction.commit();
            return notification;

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }

}
