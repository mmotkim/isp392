package Dao;

import Entity.Activity;
import Entity.ClassEntity;
import Entity.Classactivity;
import Entity.ClassactivityPK;
import Utils.HibernateUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.sql.Date;

public class ClassActivityDAO {

    public void addActivityToClass(ClassEntity classEntity, Activity activity, Date date){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction trans = entityManager.getTransaction();

        try {
            trans.begin();

            Classactivity ca = new Classactivity();
            ca.setClassId(classEntity.getClassId());
            ca.setActivityId(activity.getActivityId());
            ca.setDate(date);
            entityManager.persist(ca);


            trans.commit();


        } finally {
            if (trans.isActive()) {
                trans.rollback();
            }
            entityManager.close();

        }
    }

    public void removeActivityFromClass(ClassEntity classEntity, Activity activity){
        EntityManager entityManager = HibernateUtils.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            ClassactivityPK pk = new ClassactivityPK();
            pk.setClassId(classEntity.getClassId());
            pk.setActivityId(activity.getActivityId());

            Classactivity ca = entityManager.find(Classactivity.class, pk);
            entityManager.remove(ca);

            transaction.commit();


        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            entityManager.close();

        }
    }


}
