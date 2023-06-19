package Dao;

import jakarta.persistence.*;
import Entity.Student;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
    EntityManager entityManager = entityManagerFactory.createEntityManager();
    EntityTransaction transaction = entityManager.getTransaction();

    public int sumOfStudent(){
        Query countStudent = entityManager.createNativeQuery("SELECT COUNT(*) FROM Student");
        return (int) countStudent.getSingleResult();
    }
    public List<Student> getStudentList() {
        List<Student> studentList = new ArrayList<Student>();
        EntityTransaction transaction = null;

        try {
            transaction = entityManager.getTransaction();
            transaction.begin();

            Query query = entityManager.createQuery("SELECT s FROM Student s");
            studentList = query.getResultList();

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

        return studentList;
    }

}
