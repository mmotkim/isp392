package Entity;
import jakarta.persistence.*;

import java.sql.Date;

@Entity
@IdClass(ClassActivityPK.class)

public class ClassActivity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "class_id", nullable = false)
    private int classId;
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "activity_id", nullable = false)
    private int activityId;
    @Basic
    @Column(name = "date", nullable = true)
    private Date date;

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public int getActivityId() {
        return activityId;
    }

    public void setActivityId(int activityId) {
        this.activityId = activityId;
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

        ClassActivity that = (ClassActivity) o;

        if (classId != that.classId) return false;
        if (activityId != that.activityId) return false;
        if (date != null ? !date.equals(that.date) : that.date != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = classId;
        result = 31 * result + activityId;
        result = 31 * result + (date != null ? date.hashCode() : 0);
        return result;
    }

}
