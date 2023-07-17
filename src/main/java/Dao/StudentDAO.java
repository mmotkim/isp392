package Dao;

import Utils.HibernateUtils;
import jakarta.persistence.*;
import Entity.Student;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
    EntityManager entityManager = entityManagerFactory.createEntityManager();
    EntityTransaction transaction = entityManager.getTransaction();

    public int sumOfStudent() {
        Query countStudent = entityManager.createNativeQuery("SELECT COUNT(*) FROM Student");
        return (int) countStudent.getSingleResult();
    }

    public List<Student> getStudentList() {
        List<Student> studentList = new ArrayList<Student>();
        EntityTransaction transaction = null;

        try {
            transaction = entityManager.getTransaction();
            transaction.begin();

            Query query = entityManager.createQuery("SELECT * FROM Student ", Student.class);
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

    public List<Student> getStudentListByClass(int classId) {
        List<Student> studentList = new ArrayList<Student>();
        EntityTransaction transaction = null;

        try {
            transaction = entityManager.getTransaction();
            transaction.begin();

            Query query = entityManager.createQuery("FROM Student WHERE classId = " + classId, Student.class);
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

    public List<Student> ListStudent() {
        ArrayList<Student> list = new ArrayList<>();
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        List account = new ArrayList<Student>();
        try {
            transaction.begin();

            Query query = entityManager.createNativeQuery("SELECT * FROM Student", Student.class);
            account = query.getResultList();

            transaction.commit();

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
        return account;

    }

    public Student StudentProfile(int id) {

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            TypedQuery<Student> query = entityManager.createQuery("select u from Student u  WHERE u.id= :id   ", Student.class);
            Student student = query
                    .setParameter("id", id)
                    .getSingleResult();
            transaction.commit();
            return student;

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }


}
