package Dao;

import Utils.HibernateUtils;
import jakarta.persistence.*;
import Entity.Student;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {


    public int sumOfStudent(){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        Query countStudent = entityManager.createNativeQuery("SELECT COUNT(*) FROM Student");
        return (int) countStudent.getSingleResult();
    }
    public List<Student> getStudentList() {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        List<Student> studentList = new ArrayList<Student>();

        try {
            transaction = entityManager.getTransaction();
            transaction.begin();

            Query query = entityManager.createQuery("SELECT s FROM Student s");
            studentList = query.getResultList();

            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }

        return studentList;
    }
    public List<Student> getStudentListByClass(int classId) {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        List<Student> studentList = new ArrayList<Student>();

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
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }

        return studentList;
    }
    public void updateStudent(int id, String name, Boolean gender, String DoB, Boolean active, int classId){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();

            Student student = entityManager.find(Student.class, id);
            student.setStudentName(name);
            student.setGender(gender);
            student.setDob(Date.valueOf(DoB));
            student.setActive(active);
            student.setClassId(classId);
            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }
    public void deleteStudent(int id){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();

            Student student = entityManager.find(Student.class, id);
            entityManager.remove(student);

            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }
    public void addStudent(String name, Boolean gender, String DoB, Boolean active, int parentId, int classId){

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction trans = entityManager.getTransaction();
        try {
            trans.begin();

            Student student = new Student();
            student.setStudentName(name);
            student.setGender(gender);
            student.setDob(Date.valueOf(DoB));
            student.setActive(active);
            student.setParentId(parentId);
            student.setClassId(classId);
            entityManager.persist(student);

            trans.commit();


        } finally {
            if (trans.isActive()) {
                trans.rollback();
            }
            entityManager.close();

        }
    }

    public Student getStudentById(int id) {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        ArrayList<Student> list = new ArrayList<>();


        try {
            transaction.begin();

            Student student = entityManager.createQuery("FROM Student WHERE id = " + id, Student.class).getSingleResult();

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
