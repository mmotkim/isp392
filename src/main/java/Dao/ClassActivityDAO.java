package Dao;

import Entity.Activity;
import Entity.ClassActivity;
import Utils.HibernateUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.sql.Array;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ClassActivityDAO {

    public void addActivityToClass(int classId, int activityId, Date date) {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction trans = entityManager.getTransaction();
        try {
            trans.begin();

            ClassActivity classActivity = new ClassActivity();
            classActivity.setActivityId(activityId);
            classActivity.setClassId(classId);
            classActivity.setDate(date);


            entityManager.persist(classActivity);
            trans.commit();
        } finally {
            entityManager.close();
        }
    }

    public void removeActivityFromClass(int id){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            ClassActivity classActivity = entityManager.find(ClassActivity.class, id);

            entityManager.remove(classActivity);

            transaction.commit();

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }

    public void setSlot(int id, int slot){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            ClassActivity ca = entityManager.find(ClassActivity.class, id);

            ca.setSlot(slot);

            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }

    }

    public Map<LocalDate, List<Activity>> getActivitiesForWeek(int classId, LocalDate start, LocalDate end){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        Map<LocalDate, List<Activity>> activitiesMap = new HashMap<>();

        TypedQuery<ClassActivity> query = entityManager.createQuery(
                "SELECT ca FROM ClassActivity ca WHERE ca.classId = :classId AND ca.date BETWEEN :start AND :end",
                ClassActivity.class
        );
        query.setParameter("classId", classId);
        query.setParameter("start", start);
        query.setParameter("end", end);

        List<ClassActivity> classActivities = query.getResultList();

        for (ClassActivity classActivity : classActivities) {
            LocalDate date = classActivity.getDate().toLocalDate();
            Activity activity = entityManager.find(Activity.class, classActivity.getActivityId());

            activitiesMap.computeIfAbsent(date, k -> new ArrayList<>()).add(activity);
        }

        return activitiesMap;

    }


}
