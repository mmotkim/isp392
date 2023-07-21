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


        try {
            transaction = entityManager.getTransaction();
            transaction.begin();

            List<Student> studentList = entityManager.createQuery("FROM Student ", Student.class).getResultList();

            transaction.commit();
            return studentList;
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }

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
    public List<Student> getStudentListWithNullClassId() {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        List<Student> studentList = new ArrayList<>();

        try {
            transaction = entityManager.getTransaction();
            transaction.begin();

            String queryString = "FROM Student WHERE classId IS NULL";
            TypedQuery<Student> query = entityManager.createQuery(queryString, Student.class);
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
    public List<Student> getListActiveStudents() {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        List<Student> studentList = new ArrayList<Student>();

        try {
            transaction = entityManager.getTransaction();
            transaction.begin();

            Query query = entityManager.createQuery("FROM Student WHERE isActive = " + true, Student.class);
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

//public List<Student> getStudentListByClass(Integer classId) {
//    EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
//    EntityTransaction transaction = entityManager.getTransaction();
//    List<Student> studentList = new ArrayList<>();
//
//    try {
//        transaction = entityManager.getTransaction();
//        transaction.begin();
//
//        String queryString = "FROM Student WHERE classId = :classId OR classId IS NULL";
//        TypedQuery<Student> query = entityManager.createQuery(queryString, Student.class);
//        query.setParameter("classId", classId);
//        studentList = query.getResultList();
//
//        transaction.commit();
//    } catch (Exception e) {
//        if (transaction != null) {
//            transaction.rollback();
//        }
//        e.printStackTrace();
//    } finally {
//        if (transaction.isActive()) {
//            transaction.rollback();
//        }
//        entityManager.close();
//    }
//
//    return studentList;
//}

    public void updateStudent(int id, String name, Boolean gender, String DoB, Boolean active){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();

            Student student = entityManager.find(Student.class, id);
            student.setStudentName(name);
            student.setGender(gender);
            student.setDob(Date.valueOf(DoB));
            student.setActive(active);
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
    public void deleteStudentFromClass(int id){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();

            Student student = entityManager.find(Student.class, id);
            student.setClassId(null);
            entityManager.persist(student);
            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }
    public void addStudentIntoClass(int id, int class_id){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();

            Student student = entityManager.find(Student.class, id);
            student.setClassId(class_id);
            entityManager.persist(student);
            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }

    public void addStudent(String name, Boolean gender, String DoB, Boolean active, int parentId){

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

    public static void main(String[] args) {
        StudentDAO s = new StudentDAO();
        s.addStudent("test", true, "2023-12-10", true, 30);
    }

}
