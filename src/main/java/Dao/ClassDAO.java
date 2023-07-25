package Dao;

import Utils.HibernateUtils;
import jakarta.persistence.*;
import Entity.ClassEntity;
import Entity.*;
import org.hibernate.query.NativeQuery;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class ClassDAO {
    public ClassDAO() {
    }

    public int sumOfClasses(){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        Query countClasses = entityManager.createNativeQuery("SELECT COUNT(*) FROM class");
        return (int) countClasses.getSingleResult();
    }
    public List<ClassEntity> getAllClasses(){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            List<ClassEntity> classes = entityManager.createQuery("FROM ClassEntity ", ClassEntity.class).getResultList();

            transaction.commit();
            return classes;

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }

    }

    public void addClass(String name, int level, int quantity){

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction trans = entityManager.getTransaction();

        try {
            trans.begin();

            ClassEntity newClass = new ClassEntity();
            newClass.setClassName(name);
            newClass.setLevel(level);
            newClass.setStudentQuantity(quantity);

            entityManager.persist(newClass);

            trans.commit();


        } finally {
            if (trans.isActive()) {
                trans.rollback();
            }
            entityManager.close();

        }
    }

    public void deleteClass(int id){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            ClassEntity aClass = entityManager.find(ClassEntity.class, id);
            entityManager.remove(aClass);

            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }

    public void updateClass(int id, String name, int level){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            ClassEntity upClass = entityManager.find(ClassEntity.class, id);
            upClass.setClassName(name);
            upClass.setLevel(level);

            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }

        public ClassEntity getClassById(int id){
        ArrayList<ClassEntity> list = new ArrayList<>();

        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            ClassEntity getClass = entityManager.createQuery("FROM ClassEntity WHERE id = " + id, ClassEntity.class).getSingleResult();

            transaction.commit();
            return getClass;

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }
        public List<Attendance> getAllAttendanceByClassId(int classId) {
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            List<Attendance> attendance = entityManager.createQuery(
                            "SELECT attendance FROM Attendance attendance JOIN Student student On attendance.studentId=student.studentId " +
                                    "WHERE student.classId = :classId ",
                            Attendance.class)
                    .setParameter("classId", classId)
                    .getResultList();

            transaction.commit();
            return attendance;

        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();
        }
    }

    public void setPresent (int id){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Attendance attendance = entityManager.createQuery("SELECT a FROM Attendance a WHERE a.id = :id", Attendance.class)
                    .setParameter("id", id)
                    .getSingleResult();
            attendance.setStatus(true);

            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }
    public void setAbsent (int studentId, Date date){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Attendance attendance = entityManager.createQuery("SELECT a FROM Attendance a WHERE a.studentId = :stuId AND a.date = :date", Attendance.class)
                    .setParameter("stuId", studentId)
                    .setParameter("date", date)
                    .getSingleResult();
            attendance.setStatus(false);

            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }
    public void setAttendance (int id, Boolean atten){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Attendance attendance = entityManager.createQuery("SELECT a FROM Attendance a WHERE a.id = :id", Attendance.class)
                    .setParameter("id", id)
                    .getSingleResult();
            attendance.setStatus(atten);

            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }

    public void addAttendanceList(Date date){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction trans = entityManager.getTransaction();

        try {
            trans.begin();
            StudentDAO stuDao = new StudentDAO();
            List<Student> litS = stuDao.getListActiveStudents();
            for(Student s: litS){
                Attendance atten = new Attendance();
                atten.setStudentId(s.getStudentId());
                atten.setDate(date);
                entityManager.persist(atten);
            }


            trans.commit();


        } finally {
            if (trans.isActive()) {
                trans.rollback();
            }
            entityManager.close();

        }
    }



}
