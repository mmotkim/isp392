package Dao;

import jakarta.persistence.*;

public class meal {
    EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
    EntityManager entityManager = entityManagerFactory.createEntityManager();
    EntityTransaction transaction = entityManager.getTransaction();

    public int sumOfMeal(){
        Query countMeal = entityManager.createNativeQuery("SELECT COUNT(*) FROM Meal");
        return (int) countMeal.getSingleResult();
    }
}
