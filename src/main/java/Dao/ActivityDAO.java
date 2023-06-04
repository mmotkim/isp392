package Dao;

import jakarta.persistence.*;
import Entity.Activity

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ActivityDAO {
    EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");
    EntityManager entityManager = entityManagerFactory.createEntityManager();
    EntityTransaction transaction = entityManager.getTransaction();

    public int sumOfActivity(){
        Query countActivity = entityManager.createNativeQuery("SELECT COUNT(*) FROM activity");
        return (int) countActivity.getSingleResult();
    }

    public ArrayList<Activity> addActivityList(){
        ArrayList<Activity> list = new ArrayList<>();
        String sql = "select * from [Activity]";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                list.add(new User(rs.getInt(1), rs.getInt(2) ,rs.getString(3), rs.getString(4), rs.getString(5)));
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

}
