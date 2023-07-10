package Dao;

import Entity.Activity;
import Entity.ClassEntity;
import Entity.ClassActivity;
import Entity.ClassActivityPK;
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

            ClassActivity ca = new ClassActivity();
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

            ClassActivityPK pk = new ClassActivityPK();
            pk.setClassId(classEntity.getClassId());
            pk.setActivityId(activity.getActivityId());

            ClassActivity ca = entityManager.find(ClassActivity.class, pk);
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
