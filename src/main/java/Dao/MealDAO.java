package Dao;

import Entity.AteStatusEntity;
import Entity.Meal;

import Entity.Student;
import Utils.HibernateUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;


public class MealDAO {

    public int countMeals(){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        try {
            Query count = entityManager.createNativeQuery("SELECT COUNT(*) FROM Meal");

            return (int)count.getSingleResult();

        } finally {
            entityManager.close();
        }
    }
    public List<Meal> getAllMeals(){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            List<Meal> meals = entityManager.createQuery("FROM Meal ", Meal.class).getResultList();

            transaction.commit();
            return meals;

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }

    }

    public void addMeal(String meal_description, String created_date, String date){

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction trans = entityManager.getTransaction();

        try {
            trans.begin();

            Meal meal = new Meal();

            meal.setMealDescription(meal_description);
            if(created_date.isBlank() || created_date.isEmpty()) ;
            else meal.setCreatedDate(Date.valueOf(created_date));

            if(date.isBlank() || date.isEmpty()) ;
            else meal.setDate(Date.valueOf(date));

            entityManager.persist(meal);

            trans.commit();


        } finally {
            if (trans.isActive()) {
                trans.rollback();
            }
            entityManager.close();

        }
    }


    public void deleteMeal(int id){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Meal meal = entityManager.find(Meal.class, id);
            entityManager.remove(meal);

            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }

    public void updateMeal(int id, String meal_description, Date created_date, Date date){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Meal meal = entityManager.find(Meal.class, id);

            meal.setMealDescription(meal_description);
            meal.setCreatedDate(created_date);
            meal.setDate(date);

            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }

    public Meal getMealById(int id){
        ArrayList<Meal> list = new ArrayList<>();

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Meal meal = entityManager.createQuery("FROM Meal WHERE id = " + id, Meal.class).getSingleResult();

            transaction.commit();
            return meal;

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }
    public Meal getMealByDate(Date processingDate) {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Query query = entityManager.createQuery("FROM Meal WHERE date = :processingDate", Meal.class);
            query.setParameter("processingDate", processingDate);

            Meal meal = (Meal) query.getSingleResult();

            transaction.commit();
            return meal;

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();
        }
    }
    //    public void addAteStatus(int student_id, int meal_id, Date date){
    public List<AteStatusEntity> getAllAteStatus() {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            List<AteStatusEntity> ateStatus = entityManager.createQuery(
                            "SELECT ateStatus FROM AteStatusEntity ateStatus WHERE ateStatus.mealId IS NOT NULL " +
                                    "AND ateStatus.mealId IN (SELECT m.mealId FROM Meal m WHERE m.date IS NOT NULL)",
                            AteStatusEntity.class)
                    .getResultList();

            transaction.commit();
            return ateStatus;

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();
        }
    }
    public List<AteStatusEntity> getAllAteStatusByClassId(int classId) {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            List<AteStatusEntity> ateStatus = entityManager.createQuery(
                            "SELECT ateStatus FROM AteStatusEntity ateStatus JOIN Student student On ateStatus.studentId=student.studentId " +
                                    "WHERE student.classId = :classId " +
                                    "AND ateStatus.mealId IS NOT NULL " +
                                    "AND ateStatus.mealId IN (SELECT m.mealId FROM Meal m WHERE m.date IS NOT NULL)",
                            AteStatusEntity.class)
                    .setParameter("classId", classId)
                    .getResultList();

            transaction.commit();
            return ateStatus;

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();
        }
    }

//
//        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
//        EntityTransaction trans = entityManager.getTransaction();
//
//        try {
//            trans.begin();
//
//            AteStatusEntity ateStatus = new AteStatusEntity();
//            ateStatus.setStudentId(student_id);;
//            ateStatus.setMealId(meal_id);
//            ateStatus.setDate(date);
//
//            entityManager.persist(ateStatus);
//
//            trans.commit();
//
//
//        } finally {
//            if (trans.isActive()) {
//                trans.rollback();
//            }
//            entityManager.close();
//
//        }
//    }

    public AteStatusEntity getAteStatus(int stu_id, int meal_id){

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            AteStatusEntity ateStatus = entityManager.createQuery("SELECT a FROM AteStatusEntity a WHERE a.studentId = :stuId AND a.mealId = :mealId", AteStatusEntity.class)
                    .setParameter("stuId", stu_id)
                    .setParameter("mealId", meal_id)
                    .getSingleResult();
            transaction.commit();
            return ateStatus;

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }

    public void updateAteStatus(int stu_id, int meal_id, String status, String reason){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            AteStatusEntity ateStatus = entityManager.createQuery("SELECT a FROM AteStatusEntity a WHERE a.studentId = :stuId AND a.mealId = :mealId", AteStatusEntity.class)
                    .setParameter("stuId", stu_id)
                    .setParameter("mealId", meal_id)
                    .getSingleResult();
            ateStatus.setStatus(status);
            ateStatus.setReason(reason);


            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }


}
