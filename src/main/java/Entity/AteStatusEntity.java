package Entity;

import jakarta.persistence.*;

@Entity
@Table(name = "atestatus", schema = "dbo", catalog = "ISP392_IS1701")
public class AteStatusEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "student_id", nullable = false)
    private int studentId;
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "meal_id", nullable = false)
    private int mealId;
    @Basic
    @Column(name = "status", nullable = true, length = 50)
    private String status;
    @Basic
    @Column(name = "Reason", nullable = true, length = 500)
    private String reason;

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getMealId() {
        return mealId;
    }

    public void setMealId(int mealId) {
        this.mealId = mealId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        AteStatusEntity that = (AteStatusEntity) o;

        if (studentId != that.studentId) return false;
        if (mealId != that.mealId) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;
        if (reason != null ? !reason.equals(that.reason) : that.reason != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = studentId;
        result = 31 * result + mealId;
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (reason != null ? reason.hashCode() : 0);
        return result;
    }
}
