package Dao;

import Entity.Meal;
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

    public void addMeal(String meal_description, Date created_date, Date date){

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction trans = entityManager.getTransaction();

        try {
            trans.begin();

            Meal meal = new Meal();

            meal.setMealDescription(meal_description);
            meal.setCreatedDate(created_date);
            meal.setDate(date);

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

}
