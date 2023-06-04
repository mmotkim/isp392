package Entity;

import jakarta.persistence.*;

import java.sql.Date;

@Entity
public class Meal {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "meal_id")
    private int mealId;
    @Basic
    @Column(name = "meal_description")
    private String mealDescription;
    @Basic
    @Column(name = "created_date")
    private Date createdDate;
    @Basic
    @Column(name = "date")
    private Date date;

    public int getMealId() {
        return mealId;
    }

    public void setMealId(int mealId) {
        this.mealId = mealId;
    }

    public String getMealDescription() {
        return mealDescription;
    }

    public void setMealDescription(String mealDescription) {
        this.mealDescription = mealDescription;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Meal meal = (Meal) o;

        if (mealId != meal.mealId) return false;
        if (mealDescription != null ? !mealDescription.equals(meal.mealDescription) : meal.mealDescription != null)
            return false;
        if (createdDate != null ? !createdDate.equals(meal.createdDate) : meal.createdDate != null) return false;
        if (date != null ? !date.equals(meal.date) : meal.date != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = mealId;
        result = 31 * result + (mealDescription != null ? mealDescription.hashCode() : 0);
        result = 31 * result + (createdDate != null ? createdDate.hashCode() : 0);
        result = 31 * result + (date != null ? date.hashCode() : 0);
        return result;
    }
}
