package Dao;

import jakarta.persistence.*;

public class activity {
    EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
    EntityManager entityManager = entityManagerFactory.createEntityManager();
    EntityTransaction transaction = entityManager.getTransaction();

    public int sumOfActivity(){
        Query countActivity = entityManager.createNativeQuery("SELECT COUNT(*) FROM activity");
        return (int) countActivity.getSingleResult();
    }

}
