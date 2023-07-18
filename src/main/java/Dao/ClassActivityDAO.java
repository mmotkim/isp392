package Dao;

import Entity.Activity;
import Entity.ClassActivity;
import Utils.HibernateUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.sql.Date;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ClassActivityDAO {

    public boolean addActivityToClass(int classId, int activityId, Date date) {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction trans = entityManager.getTransaction();
        boolean state = true;
        try {
            trans.begin();

            ClassActivityDAO caDAO = new ClassActivityDAO();
            ClassActivity classActivity = new ClassActivity();
            classActivity.setActivityId(activityId);
            classActivity.setClassId(classId);
            classActivity.setDate(date);
            classActivity.setSlot(1);

            ClassActivity caCheck = entityManager.find(ClassActivity.class, classActivity);
            for (int i = 1; i <= 7 ; i++) {
                if (caCheck.getSlot() == classActivity.getSlot()){
                    classActivity.setSlot(i + 1);
                }
                if (i == 7){
                    state = false;
                    entityManager.close();
                    trans.commit();
                    return state;
                }
            }

            entityManager.persist(classActivity);
            trans.commit();
        } finally {
            entityManager.close();
        }
        return state;
    }

    public void removeActivityFromClass(int id) {
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

    public void rescheduleSlot(int id, int slot) {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();


            ClassActivity selected = entityManager.find(ClassActivity.class, id);
            TypedQuery<ClassActivity> query = entityManager.createQuery("FROM ClassActivity WHERE classId = :classId AND activityId = :activityId AND date = :date", ClassActivity.class);
            query.setParameter("classId", selected.getClassId());
            query.setParameter("activityId", selected.getActivityId());
            query.setParameter("date", selected.getDate());
            List<ClassActivity> slotList = query.getResultList();
            int selectdSlot = selected.getSlot();

            selected.setSlot(slot);

            //replace slot with duplicated entry
            for (ClassActivity ca : slotList){
                if (ca.getSlot() == slot){
                    ca.setSlot(selectdSlot);
                    selected.setSlot(slot);
                }
            }


            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }

    }

    public Map<ClassActivity, List<Activity>> getActivitiesForWeek(int classId, LocalDate start, LocalDate end) {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        Map<ClassActivity, List<Activity>> activitiesMap = new HashMap<>();

        TypedQuery<ClassActivity> query = entityManager.createQuery(
                "SELECT ca FROM ClassActivity ca WHERE ca.classId = :classId AND ca.date BETWEEN :start AND :end ORDER BY slot",
                ClassActivity.class
        );
        System.out.println(start);
        System.out.println(start.toString());
        System.out.println(end.toString());
        System.out.println(end);
        query.setParameter("classId", classId);
        query.setParameter("start", start);
        query.setParameter("end", end);

        List<ClassActivity> classActivities = query.getResultList();

        for (ClassActivity classActivity : classActivities) {
            LocalDate date = classActivity.getDate().toLocalDate();

            Activity activity = entityManager.find(Activity.class, classActivity.getActivityId());

                activitiesMap.computeIfAbsent(classActivity, k -> new ArrayList<>()).add(activity);
        }


        return activitiesMap;

    }

    public ArrayList<LocalDate> getDatesOfWeek(LocalDate date) {
        ArrayList<LocalDate> datesOfWeek = new ArrayList<>();

        // Calculate the starting date of the week (Monday)
        LocalDate startDate = date;
        while (startDate.getDayOfWeek() != DayOfWeek.MONDAY) {
            startDate = startDate.minusDays(1);
        }

        // Add dates of the week to the ArrayList
        for (int i = 0; i < 7; i++) {
            datesOfWeek.add(startDate);
            startDate = startDate.plusDays(1);
        }

        return datesOfWeek;
    }

//    public ClassActivity getClassActivityByAttributes(int classId, int activityId, LocalDate date) {
//        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
//        EntityTransaction transaction = entityManager.getTransaction();
//
//        TypedQuery<ClassActivity> query = entityManager.createQuery("SELECT ca FROM ClassActivity ca WHERE ca.classId = :classId AND ca.activityId = :activityId AND ca.date = :date", ClassActivity.class);
//
//        query.setParameter("classId", classId);
//        query.setParameter("activityId", activityId);
//        query.setParameter("date", date);
//
//
//
//    }

//

    public static void main(String[] args) {
        ClassActivityDAO ca = new ClassActivityDAO();
        ca.rescheduleSlot(2, 2);
    }


    public void rescheduleDate(int id, LocalDate date) {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();


            ClassActivity selected = entityManager.find(ClassActivity.class, id);

            selected.setDate(Date.valueOf(date));


            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }
}
