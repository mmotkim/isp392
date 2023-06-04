package Dao;

import jakarta.persistence.*;

public class Classes {
    EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
    EntityManager entityManager = entityManagerFactory.createEntityManager();
    EntityTransaction transaction = entityManager.getTransaction();

    public int sumOfClasses(){
        Query countClasses = entityManager.createNativeQuery("SELECT COUNT(*) FROM class");
        return (int) countClasses.getSingleResult();
    }
}
