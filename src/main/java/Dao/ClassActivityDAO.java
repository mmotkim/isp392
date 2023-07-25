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
import java.util.*;

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


            TypedQuery<ClassActivity> query = entityManager.createQuery("FROM ClassActivity WHERE classId = :classId AND date = :date", ClassActivity.class);
            query.setParameter("classId", classActivity.getClassId());
            query.setParameter("date", classActivity.getDate());

            List<ClassActivity> slotList = query.getResultList();
            for (int i = 0; i < slotList.size() ; i++) {
                if (slotList.get(i).getSlot() == classActivity.getSlot()){
                    classActivity.setSlot(classActivity.getSlot()+1);
                }
                else if (i == 5){
                    state = false;
                    entityManager.close();
                    trans.commit();
                    return state;
                }
                else break;
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
            int selectedSlot = selected.getSlot();

            TypedQuery<ClassActivity> query = entityManager.createQuery("FROM ClassActivity WHERE classId = :classId AND date = :date AND slot = :slot", ClassActivity.class).setMaxResults(1);
            query.setParameter("classId", selected.getClassId());
            query.setParameter("date", selected.getDate());
            query.setParameter("slot", slot);

            ClassActivity other = query.getResultList()
                    .stream()
                    .findFirst()
                    .orElse(null);

            if (other != null){
                selected.setSlot(slot);
                other.setSlot(selectedSlot);

                entityManager.persist(selected);
                entityManager.persist(other);

            }
            else {
                selected.setSlot(slot);
                entityManager.persist(selected);
            }


            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }

    }

//    public void rescheduleSlot(int id, int slot) {
//        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
//        EntityTransaction transaction = entityManager.getTransaction();
//
//        try {
//            transaction.begin();
//
//
//            ClassActivity selected = entityManager.find(ClassActivity.class, id);
//            int selectedSlot = selected.getSlot();
//
//            TypedQuery<ClassActivity> query = entityManager.createQuery("FROM ClassActivity WHERE classId = :classId AND date = :date", ClassActivity.class);
//            query.setParameter("classId", selected.getClassId());
//            query.setParameter("date", selected.getDate());
//            List<ClassActivity> slotList = query.getResultList();
//
//            selected.setSlot(slot);
//
//            //replace slot with duplicated entry
//            for (ClassActivity ca : slotList){
//                if (ca.getSlot() == slot){
//                    ca.setSlot(selectedSlot);
//                    selected.setSlot(slot);
//                }
//            }
//
//
//            transaction.commit();
//        } finally {
//            if (transaction.isActive()) {
//                transaction.rollback();
//            }
//            entityManager.close();
//
//        }
//
//    }

    public Map<ClassActivity, List<Activity>> getActivitiesForWeek(int classId, LocalDate start, LocalDate end) {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        LinkedHashMap<ClassActivity, List<Activity>> activitiesMap = new LinkedHashMap<>();

        TypedQuery<ClassActivity> query = entityManager.createQuery(
                "SELECT ca FROM ClassActivity ca WHERE ca.classId = :classId AND ca.date BETWEEN :start AND :end ORDER BY slot asc",
                ClassActivity.class
        );
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

    public boolean     isScheduleValid(int id, int slot, LocalDate date){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();


            ClassActivity selected = entityManager.find(ClassActivity.class, id);

            TypedQuery<ClassActivity> query = entityManager.createQuery("FROM ClassActivity WHERE classId = :classId AND date = :date AND slot = :slot", ClassActivity.class).setMaxResults(1);
            query.setParameter("classId", selected.getClassId());
            query.setParameter("date", date);
            query.setParameter("slot", slot);

            ClassActivity other = query.getResultList()
                    .stream()
                    .findFirst()
                    .orElse(null);

            if (other != null){
                entityManager.close();
                return false;

            }

            else {

                entityManager.close();
                return true;
            }
    }
}
