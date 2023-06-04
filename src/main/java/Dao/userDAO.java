package Dao;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

public class userDAO {
    EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
    EntityManager entityManager = entityManagerFactory.createEntityManager();

    public int sumOfUser() {
        Query countUser = entityManager.createNativeQuery("SELECT COUNT(*) FROM Users");
        return ((Number) countUser.getSingleResult()).intValue();
    }

    public List<Users> listTeachers() {
        List teachers = new ArrayList<Entity.Users>();
        EntityTransaction transaction = null;

        try {
            transaction = entityManager.getTransaction();
            transaction.begin();

            Query query = entityManager.createNativeQuery("SELECT * FROM Users where [Role]=1", Entity.Users.class);
            teachers = query.getResultList();

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
        }

        return teachers;
    }
}
